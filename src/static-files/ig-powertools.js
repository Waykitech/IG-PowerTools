/*! IG PowerTools v1.12 | (c) 2026 Waykitech | MIT License | https://github.com/Waykitech/IG-PowerTools */
var master = master || {};

master.igPowerTools = (function(master, $, undefined) {
  'use strict';

  var MODULE_NAME = 'IgPowerTools';

  var COMMAND = {
    REFRESH_SELECTED:          'REFRESH_SELECTED'
    , REFRESH_GRID:            'REFRESH_GRID'
    , SELECTED_ACTION:         'SELECTED_ACTION'
    , DEPENDENT_COLUMN_REFRESH:'DEPENDENT_COLUMN_REFRESH'
    , SPREADSHEET_PASTE:       'SPREADSHEET_PASTE'
  };

  var BUSY_CLASS = 'igpt-busy';

  var _PREFIX = '[' + MODULE_NAME + ']';

  var logger = {
    log:       function(msg, data) { apex.debug.info(_PREFIX, msg, data || ''); }
    , warning: function(msg, data) { apex.debug.warn(_PREFIX, msg, data || ''); }
    , error:   function(msg, data) { apex.debug.error(_PREFIX, msg, data || ''); }
  };

  var _resolveRegion = function(daConfig) {
    var el = daConfig && daConfig.affectedElements && daConfig.affectedElements.length
      ? daConfig.affectedElements.first()
      : null;
    var staticId = el ? el.attr('id') : null;

    if (!staticId) {
      logger.error('Could not resolve a target region. Set Affected Elements to the Interactive Grid region.');
      return null;
    }

    var region = apex.region(staticId);
    if (!region) {
      logger.error('apex.region() did not find a region for static id', staticId);
      return null;
    }

    return { id: staticId, region: region };
  };

  var _invokeIfSupported = function(region, actionName) {
    try {
      var actions = region.call('getActions');
      if (!actions || typeof actions.lookup !== 'function' || !actions.lookup(actionName)) {
        return false;
      }
      actions.invoke(actionName);
      return true;
    } catch (e) {
      logger.warning('Action "' + actionName + '" is not available on this region', e);
      return false;
    }
  };

  var _refreshFull = function(region) {
    var result = region.region.refresh();
    if (result && typeof result.then === 'function') {
      result.then(
        function() { logger.log('Grid refreshed'); }
        , function(err) { logger.error('Grid refresh failed', err); }
      );
    }
  };

  var _refreshSurgical = function(regionCtx) {
    var ok = _invokeIfSupported(regionCtx.region, 'selection-refresh');
    if (!ok) {
      logger.warning('Falling back to full grid refresh (selection-refresh unavailable or nothing selected)');
      _refreshFull(regionCtx);
    }
  };

  var _getInteractiveGridWidget = function(regionCtx) {
    try {
      return regionCtx.region.widget().interactiveGrid('getCurrentView');
    } catch (e) {
      logger.error('This region is not an editable/initialized Interactive Grid', e);
      return null;
    }
  };

  var _getSelectedRecordIds = function(regionCtx) {
    var model;
    var records;
    try {
      model = regionCtx.region.widget().interactiveGrid('getCurrentView').model;
      records = regionCtx.region.widget().interactiveGrid('getSelectedRecords');
    } catch (e) {
      logger.error('Unable to read the Interactive Grid selection', e);
      return [];
    }
    if (!records || !records.length) {
      return [];
    }
    return records.map(function(record) {
      return model.getRecordId(record);
    });
  };

  var _runSelectedAction = function(regionCtx, actionName, preserveSelection) {
    if (!actionName) {
      logger.error('SELECTED_ACTION requires a "Server action / process name" attribute value');
      return;
    }

    var ids = _getSelectedRecordIds(regionCtx);
    if (!ids.length) {
      apex.message.alert(apex.lang.getMessage('APEX.IG_POWERTOOLS.NO_SELECTION') || 'Select at least one row first.');
      return;
    }

    $('#' + regionCtx.id).addClass(BUSY_CLASS);

    apex.server.process(
      actionName
      , { x01: JSON.stringify(ids) }
      , { dataType: 'json' }
    ).done(function(data) {
      $('#' + regionCtx.id).removeClass(BUSY_CLASS);

      if (data && data.message) {
        apex.message.showPageSuccess(data.message);
      }

      if (preserveSelection) {
        _refreshSurgical(regionCtx);
      } else {
        _refreshFull(regionCtx);
      }
    }).fail(function(jqXHR) {
      $('#' + regionCtx.id).removeClass(BUSY_CLASS);
      logger.error('Server action "' + actionName + '" failed', jqXHR);
      apex.message.showErrors([{
        type: 'error'
        , location: 'page'
        , message: (jqXHR && jqXHR.responseJSON && jqXHR.responseJSON.error) || 'The server action could not be completed.'
      }]);
    });
  };

  var _runDependentColumnRefresh = function(regionCtx, actionName) {
    if (!actionName) {
      logger.error('DEPENDENT_COLUMN_REFRESH requires a "Server action / process name" attribute value');
      return;
    }

    var view = _getInteractiveGridWidget(regionCtx);
    if (!view) { return; }

    var records = regionCtx.region.widget().interactiveGrid('getSelectedRecords');
    var record = records && records.length ? records[0] : null;
    if (!record) {
      logger.warning('DEPENDENT_COLUMN_REFRESH: no current/selected row to update');
      return;
    }
    var model = view.model;
    var recordId = model.getRecordId(record);

    var rowValues = {};
    Object.keys(model.getOption('fields') || {}).forEach(function(field) {
      var value = model.getValue(record, field);
      rowValues[field] = value !== null && typeof value === 'object' && 'v' in value ? value.v : value;
    });

    var meta = model.getRecordMetadata(recordId) || {};
    if (meta.updated || meta.inserted) {
      logger.warning('DEPENDENT_COLUMN_REFRESH: row has unsaved changes; the refresh reloads it from the database, ' +
        'so the server action must persist any of them it needs to keep');
    }

    apex.server.process(
      actionName
      , { x01: JSON.stringify(recordId), x02: JSON.stringify(rowValues) }
      , { dataType: 'json' }
    ).done(function() {
      _refreshSurgical(regionCtx);
    }).fail(function(jqXHR) {
      logger.error('Server action "' + actionName + '" failed', jqXHR);
    });
  };

  var APEX_GRID_MIME = 'web application/x-apex-grid+json';

  var PASTE_MODE = { REPLACE: 'REPLACE', INSERT: 'INSERT', APPEND: 'APPEND' };

  var ITEM_SELECT_LIST = 'NATIVE_SELECT_LIST';
  var ITEM_SWITCH = 'NATIVE_YES_NO';
  var ITEM_POPUP_LOV = 'NATIVE_POPUP_LOV';
  var DATE_TYPES = ['DATE', 'TIMESTAMP', 'TIMESTAMP_TZ', 'TIMESTAMP_LTZ'];

  var MULTILINE_ITEM_TYPES = ['NATIVE_TEXTAREA'];

  var AFTER_INSERT_FALLBACK_MS = 1000;

  var LINE_MARK = '';

  var _normalizeWS = function(value) {
    return String(value).replace(/[\s ]+/g, ' ').trim();
  };

  var _joinLines = function(lines) {
    lines = lines.map(_normalizeWS);
    while (lines.length > 1 && lines[0] === '') { lines.shift(); }
    while (lines.length > 1 && lines[lines.length - 1] === '') { lines.pop(); }
    return lines.join('\n');
  };

  var _cellText = function(node) {
    return _joinLines(String(node.textContent || '').split(LINE_MARK));
  };

  var _splitDelimited = function(text) {
    text = text.replace(/\r\n?/g, '\n').replace(/\n+$/, '');
    var plain = function() {
      return text.split('\n').map(function(line) { return line.split('\t'); });
    };
    var rows = [], row = [], cell = '', i = 0, n = text.length;
    while (i < n) {
      var ch = text.charAt(i);
      if (ch === '"' && cell === '') {
        var j = i + 1, quoted = '';
        for (;;) {
          if (j >= n) { return plain(); }
          var q = text.charAt(j);
          if (q === '"' && text.charAt(j + 1) === '"') { quoted += '"'; j += 2; continue; }
          if (q === '"') { break; }
          quoted += q;
          j += 1;
        }
        var after = text.charAt(j + 1);
        if (after !== '' && after !== '\t' && after !== '\n') { return plain(); }
        cell = quoted;
        i = j + 1;
        continue;
      }
      if (ch === '\t') { row.push(cell); cell = ''; }
      else if (ch === '\n') { row.push(cell); rows.push(row); row = []; cell = ''; }
      else { cell += ch; }
      i += 1;
    }
    row.push(cell);
    rows.push(row);
    return rows;
  };

  var _readClipboardTable = function(clipboardData) {
    var html = clipboardData.getData('text/html');
    var text = clipboardData.getData('text/plain');
    var rows = null;

    if (html && html.indexOf('<table') >= 0) {
      var doc = new DOMParser().parseFromString(html.replace(/<br\b[^>]*>/gi, LINE_MARK), 'text/html');
      var tables = doc.getElementsByTagName('table');
      if (tables.length === 1) {
        rows = [];
        Array.prototype.forEach.call(tables[0].rows, function(tr) {
          var row = [];
          Array.prototype.forEach.call(tr.cells, function(td) {
            var value = _cellText(td);
            var span = parseInt(td.getAttribute('colspan'), 10) || 1;
            for (var i = 0; i < span; i++) { row.push(value); }
          });
          rows.push(row);
        });
      }
    }

    if (!rows && text && (text.indexOf('\t') >= 0 || text.indexOf('\n') >= 0)) {
      rows = _splitDelimited(text).map(function(row) {
        return row.map(function(cell) { return _joinLines(cell.split('\n')); });
      });
    }

    if (!rows || !rows.length ||
        (rows.length === 1 && rows[0].length < 2 && (rows[0][0] || '').indexOf('\n') < 0)) {
      return null;
    }

    var width = rows.reduce(function(max, row) { return Math.max(max, row.length); }, 0);
    rows.forEach(function(row) {
      while (row.length < width) { row.push(''); }
    });
    return rows;
  };

  var _resolveTargetColumns = function(grid, width) {
    var cell$ = grid.getCurrentCell();
    if (!cell$ || !cell$.length || !cell$.hasClass('a-GV-cell') || cell$.parent().hasClass('is-aggregate')) {
      return null;
    }
    if (cell$.hasClass('a-GV-selHeader')) {
      cell$ = cell$.next();
    }
    while (cell$.length && (grid._getColumnMetadata(cell$) || {}).virtual) {
      cell$ = cell$.next();
    }

    var rowCells$ = grid.lastRow$ && grid.lastRow$.index(cell$) >= 0 ? grid.lastRow$ : cell$.parent().children();
    var start = rowCells$.index(cell$);
    if (start < 0) { return null; }

    var targets = [];
    rowCells$.slice(start, start + width).each(function() {
      var col = grid._getColumnMetadata($(this));
      if (col && col.property && !col.hidden && !col.virtual) {
        targets.push(col);
      }
    });
    return targets;
  };

  var ISO_DATE_RE = /^(\d{4})-(\d{1,2})-(\d{1,2})(?:[ T](\d{1,2}):(\d{2})(?::(\d{2}))?)?$/;
  var NUMERIC_DATE_RE = /^(\d{1,2})[\/.\-](\d{1,2})[\/.\-](\d{2}|\d{4})(?:[ T,]+(\d{1,2}):(\d{2})(?::(\d{2}))?\s*([AaPp][Mm])?)?$/;

  var _buildDate = function(y, m, d, hh, mi, ss, ampm) {
    y = parseInt(y, 10);
    if (y < 100) { y += y < 50 ? 2000 : 1900; }
    m = parseInt(m, 10);
    d = parseInt(d, 10);
    hh = parseInt(hh || '0', 10);
    if (ampm) {
      ampm = ampm.toUpperCase();
      if (ampm === 'PM' && hh < 12) { hh += 12; }
      if (ampm === 'AM' && hh === 12) { hh = 0; }
    }
    var date = new Date(y, m - 1, d, hh, parseInt(mi || '0', 10), parseInt(ss || '0', 10));

    if (date.getFullYear() !== y || date.getMonth() !== m - 1 || date.getDate() !== d) {
      return null;
    }
    return date;
  };

  var _dayMonthOrder = function(mask) {
    var m = String(mask || '').toUpperCase();
    var dd = m.search(/(^|[^D])DD([^D]|$)/);
    var mm = m.search(/(^|[^M])MM([^MI]|$)/);
    if (dd < 0 || mm < 0) { return null; }
    return dd < mm ? 'DMY' : 'MDY';
  };

  var _inferColumnOrder = function(values) {
    var dmy = false, mdy = false;
    values.forEach(function(v) {
      var m = NUMERIC_DATE_RE.exec(v);
      if (!m) { return; }
      var a = parseInt(m[1], 10), b = parseInt(m[2], 10);
      if (a > 12 && b <= 12) { dmy = true; }
      if (b > 12 && a <= 12) { mdy = true; }
    });
    if (dmy && !mdy) { return 'DMY'; }
    if (mdy && !dmy) { return 'MDY'; }
    return null;
  };

  var _parseDate = function(value, order, sourceFormat) {
    var m = ISO_DATE_RE.exec(value);
    if (m) {
      return _buildDate(m[1], m[2], m[3], m[4], m[5], m[6]);
    }
    m = NUMERIC_DATE_RE.exec(value);
    if (m && order) {
      return order === 'DMY'
        ? _buildDate(m[3], m[2], m[1], m[4], m[5], m[6], m[7])
        : _buildDate(m[3], m[1], m[2], m[4], m[5], m[6], m[7]);
    }

    try {
      var parsed = apex.date.parse(value, sourceFormat);
      return parsed && apex.date.isValid(parsed) ? parsed : null;
    } catch (e) {
      return null;
    }
  };

  var _selectListResolver = function(col) {
    var options = col.elementId ? $('#' + col.elementId).find('option') : $();
    var byValue = {}, byText = {}, byValueCi = {};
    if (!options.length) { return null; }

    options.each(function() {
      var value = this.value;
      if (value === '') { return; }
      byValue[value] = value;
      byText[_normalizeWS(this.text).toLowerCase()] = value;
      byValueCi[value.toLowerCase()] = value;
    });
    return function(v) {
      if (Object.prototype.hasOwnProperty.call(byValue, v)) { return v; }
      var key = v.toLowerCase();
      if (Object.prototype.hasOwnProperty.call(byText, key)) { return byText[key]; }
      if (Object.prototype.hasOwnProperty.call(byValueCi, key)) { return byValueCi[key]; }
      return undefined;
    };
  };

  var TRUE_WORDS = ['y', 'yes', 's', 'si', 'sí', 'true', 'verdadero', '1', 'on', 'x', '✓', '✔'];
  var FALSE_WORDS = ['n', 'no', 'false', 'falso', '0', 'off'];

  var _switchResolver = function(col) {
    var el$ = col.elementId ? $('#' + col.elementId) : $();
    var inputs$ = el$.is('input') ? el$ : el$.find('input');
    var on, off, onLabel, offLabel;

    if (inputs$.length === 1 && inputs$.attr('type') === 'checkbox') {
      on = inputs$.attr('value');
      off = inputs$.attr('data-off-value');
      onLabel = inputs$.attr('data-on-label');
      offLabel = inputs$.attr('data-off-label');
    } else if (inputs$.length === 2) {
      on = inputs$.eq(0).attr('value');
      off = inputs$.eq(1).attr('value');
      onLabel = $('[for="' + inputs$.eq(0).attr('id') + '"]').text();
      offLabel = $('[for="' + inputs$.eq(1).attr('id') + '"]').text();
    }
    if (on === undefined || off === undefined) { return null; }

    var lookup = {};
    var add = function(key, value) {
      if (key !== undefined && key !== null && key !== '') {
        lookup[_normalizeWS(key).toLowerCase()] = value;
      }
    };
    TRUE_WORDS.forEach(function(w) { add(w, on); });
    FALSE_WORDS.forEach(function(w) { add(w, off); });

    add(onLabel, on);
    add(offLabel, off);
    add(on, on);
    add(off, off);

    return function(v) {
      var key = v.toLowerCase();
      return Object.prototype.hasOwnProperty.call(lookup, key) ? lookup[key] : undefined;
    };
  };

  var NUMBER_ITEM_TYPES = ['NATIVE_NUMBER_FIELD', 'NATIVE_TEXT_FIELD'];

  var _cleanNumber = function(value) {
    var v = value.replace(/[−‒–]/g, '-');
    var negative = false, percent = false;

    v = v.replace(/^[A-Z]{3}\s+|\s+[A-Z]{3}$/g, '');
    v = v.replace(/[\p{Sc}]/gu, '');
    v = v.replace(/[\s  ']/g, '');
    if (/^\(.*\)$/.test(v)) { negative = true; v = v.slice(1, -1); }
    if (/-$/.test(v)) { negative = true; v = v.slice(0, -1); }
    if (/^[+-]/.test(v)) { negative = negative !== (v[0] === '-'); v = v.slice(1); }
    if (/%$/.test(v)) { percent = true; v = v.slice(0, -1); }

    v = v.replace(/[\p{Sc}]/gu, '');

    if (!/^(\d[\d.,]*)?\.?\d*([eE][+-]?\d+)?$/.test(v) || !/\d/.test(v)) { return null; }
    return { body: v, negative: negative, percent: percent };
  };

  var _decimalEvidence = function(body) {
    var mantissa = body.replace(/[eE].*$/, '');
    var dots = (mantissa.match(/\./g) || []).length;
    var commas = (mantissa.match(/,/g) || []).length;
    if (dots && commas) { return mantissa.lastIndexOf('.') > mantissa.lastIndexOf(',') ? '.' : ','; }
    if (dots > 1) { return ','; }
    if (commas > 1) { return '.'; }
    var sep = dots ? '.' : commas ? ',' : null;
    if (sep && !/^\d{1,3}[.,]\d{3}$/.test(mantissa)) { return sep; }
    return null;
  };

  var _inferColumnDecimal = function(values) {
    var seen = {};
    values.forEach(function(v) {
      var clean = v && _cleanNumber(v);
      var ev = clean && _decimalEvidence(clean.body);
      if (ev) { seen[ev] = true; }
    });
    var keys = Object.keys(seen);
    return keys.length === 1 ? keys[0] : null;
  };

  var _parseNumber = function(value, decimalSep) {
    var clean = _cleanNumber(value);
    if (!clean) { return null; }
    var groupSep = decimalSep === ',' ? '.' : ',';
    var mantissa = clean.body.replace(/[eE].*$/, '');
    var exponent = clean.body.slice(mantissa.length);

    var intPart = mantissa.split(decimalSep)[0];
    if (intPart.indexOf(groupSep) >= 0 && !new RegExp('^\\d{1,3}(\\' + groupSep + '\\d{3})+$').test(intPart)) {
      return null;
    }
    if (mantissa.split(decimalSep).length > 2) { return null; }

    var n = Number(mantissa.split(groupSep).join('').replace(decimalSep, '.') + exponent);
    if (!isFinite(n)) { return null; }
    if (clean.percent) { n = n / 100; }
    return clean.negative ? -n : n;
  };

  var _formatNumberForSession = function(n) {
    var s = String(Number(n.toPrecision(15)));
    if (/e/i.test(s)) {
      s = n.toFixed(Math.min(20, Math.max(0, -Math.floor(Math.log10(Math.abs(n))) + 14)));
      s = s.indexOf('.') >= 0 ? s.replace(/\.?0+$/, '') : s;
    }
    return s.replace('.', apex.locale.getDecimalSeparator());
  };

  var _normalizeHeader = function(value) {
    return String(value || '')
      .normalize('NFD').replace(/[̀-ͯ]/g, '')
      .toLowerCase().replace(/[^a-z0-9]+/g, ' ').trim();
  };

  var _stripTags = function(html) {
    return new DOMParser().parseFromString(String(html || ''), 'text/html').body.textContent || '';
  };

  var _isWritableColumn = function(grid, col) {
    return !col.hidden && !col.virtual && !col.readonly && !!col.elementId &&
      !grid.model.isIdentityField(col.property);
  };

  var _matchHeaderRow = function(grid, headerRow) {
    var byKey = {};
    grid.getColumns().forEach(function(col) {
      if (col.hidden || col.virtual || !col.property) { return; }
      [col.heading && _stripTags(col.heading), col.label, col.property.replace(/_/g, ' ')].forEach(function(name) {
        var key = _normalizeHeader(name);
        if (key && !byKey[key]) { byKey[key] = col; }
      });
    });

    var used = {}, targets = [], matched = [], ignored = [];
    headerRow.forEach(function(cell) {
      var col = byKey[_normalizeHeader(cell)];
      if (col && !used[col.property]) {
        used[col.property] = true;
        if (_isWritableColumn(grid, col)) {
          targets.push(col);
          matched.push(cell);
          return;
        }
      }
      targets.push(null);
      if (cell) { ignored.push(cell); }
    });

    var recognized = Object.keys(used).length;
    return recognized >= 2 ? { targets: targets, matched: matched, ignored: ignored } : null;
  };

  var _displayLookup = function(col) {
    var el$ = col.elementId ? $('#' + col.elementId) : $();
    var map = {};
    el$.find('option').each(function() { map[this.value] = _normalizeWS(this.text); });
    var input$ = el$.is('input') ? el$ : $();
    if (input$.length && input$.attr('type') === 'checkbox') {
      map[input$.attr('value')] = input$.attr('data-on-label');
      map[input$.attr('data-off-value')] = input$.attr('data-off-label');
    }
    return function(v) {
      return Object.prototype.hasOwnProperty.call(map, v) && map[v] !== undefined ? map[v] : v;
    };
  };

  var _isCompositeField = function(model, field) {
    var limit = 50;
    for (var i = 0; i < limit; i++) {
      var rec = model.recordAt(i);
      if (!rec) { break; }
      var value = model.getValue(rec, field);
      if (value !== null && value !== undefined && value !== '') {
        return typeof value === 'object' && Object.prototype.hasOwnProperty.call(value, 'v');
      }
    }
    return false;
  };

  var _isSkippableRecord = function(model, record) {
    var meta = model.getRecordMetadata(model.getRecordId(record)) || {};
    return meta.agg || meta.deleted || !model.allowEdit(record);
  };

  var _writeViaModel = function(grid, rows, targets, rejected, options) {
    options = options || {};
    var model = grid.model;
    var startId = options.startId;
    if (!startId) {
      var cell$ = grid.getCurrentCell();
      startId = cell$ && cell$.closest('tr').attr('data-id');
    }
    var startRecord = startId ? model.getRecord(startId) : null;
    var index = startRecord ? model.indexOf(startRecord) : -1;
    var result = { written: 0, inserted: 0, stopped: false };
    if (index < 0) { return null; }

    var rejectedKeys = {};
    rejected.forEach(function(x) { rejectedKeys[(x.row - 1) + ':' + x.col] = x; });

    var displayMaps = options.displayMaps || {};
    var compositeColumns = options.compositeColumns || {};
    var columns = targets.map(function(col) {
      if (!col || !_isWritableColumn(grid, col)) { return null; }
      var lovDisplay = displayMaps[col.property];
      return {
        col: col,
        composite: !!compositeColumns[col.property] || _isCompositeField(model, col.property),
        display: lovDisplay
          ? function(v) { return Object.prototype.hasOwnProperty.call(lovDisplay, v) ? lovDisplay[v] : v; }
          : _displayLookup(col)
      };
    });

    var last = index > 0 ? model.recordAt(index - 1) : null;
    if (options.insert) {
      last = startRecord;
    }

    var suppressor = _suppressAfterInsert(grid);
    try {
      for (var r = 0; r < rows.length; r++) {
        var record = options.insert ? null : model.recordAt(index);
        while (record && _isSkippableRecord(model, record)) {
          index += 1;
          record = model.recordAt(index);
        }
        if (!record) {
          if (!model.allowAdd()) { result.stopped = true; break; }
          record = model.getRecord(model.insertNewRecord(null, last));
          result.inserted += 1;
        }
        index = model.indexOf(record) + 1;
        last = record;

        var recordId = model.getRecordId(record);
        for (var c = 0; c < columns.length; c++) {
          var target = columns[c];
          if (!target) { continue; }
          var value = rows[r][c];
          var toSet = target.composite ? { v: value, d: target.display(value) } : value;
          try {
            model.setValue(record, target.col.property, toSet);
            result.written += 1;
          } catch (e) {
            logger.warning('Could not set ' + target.col.property + ' on row ' + (r + 1), e);
          }
          if (rejectedKeys[r + ':' + c]) {
            model.setValidity('error', recordId, target.col.property, rejectedKeys[r + ':' + c].ambiguous
              ? '"' + value + '" matches more than one list entry'
              : 'Could not convert "' + value + '"');
          }
        }
      }
    } finally {
      suppressor.release(result.inserted);
    }

    return result;
  };

  var _suppressAfterInsert = function(grid) {
    var saved = grid.afterInsertCallback;
    var calls = 0;
    var expected = null;
    var restored = false;
    var suppress = function() {
      calls += 1;
      if (expected !== null && calls >= expected) { restore(); }
    };
    var restore = function() {
      if (restored) { return; }
      restored = true;
      if (grid.afterInsertCallback === suppress) {
        grid.afterInsertCallback = saved;
      }
    };
    grid.afterInsertCallback = suppress;
    return {
      release: function(inserted) {
        expected = inserted;
        if (calls >= expected) {
          restore();
          return;
        }
        setTimeout(function() {
          if (!restored) {
            logger.log('Restoring afterInsertCallback after ' + calls + ' of ' + expected + ' insert notification(s)');
            restore();
          }
        }, AFTER_INSERT_FALLBACK_MS);
      }
    };
  };

  var _resolvePopupLovs = function(ajaxIdentifier, rows, targets, columnMeta, stats) {
    var lookups = [];
    var displayMaps = {};

    targets.forEach(function(col, c) {
      if (!col || (columnMeta[col.property] || {}).itemType !== ITEM_POPUP_LOV) { return; }
      var distinct = [];
      rows.forEach(function(row) {
        if (row[c] !== '' && distinct.indexOf(row[c]) < 0) { distinct.push(row[c]); }
      });
      if (!distinct.length) { return; }

      lookups.push(
        apex.server.plugin(ajaxIdentifier, { x01: col.property, f01: distinct }, { dataType: 'json' })
          .then(function(data) {
            var values = (data && data.values) || {};
            var ambiguous = (data && data.ambiguous) || [];
            if (data && data.unsupported) {
              logger.warning('Popup LOV lookup for ' + col.property + ' not supported: ' + data.unsupported);
            }
            displayMaps[col.property] = {};
            rows.forEach(function(row, r) {
              var v = row[c];
              if (v === '') { return; }
              var hit = values[v];
              if (!hit) {
                stats.rejected.push({
                  row: r + 1, col: c, column: col.label || _stripTags(col.heading) || col.property, value: v,
                  ambiguous: ambiguous.indexOf(v) >= 0
                });
                return;
              }
              displayMaps[col.property][hit.r] = hit.d;
              if (hit.r !== v) {
                row[c] = hit.r;
                stats.converted += 1;
              }
            });
          })
      );
    });

    return Promise.all(lookups).then(function() {
      return { displayMaps: displayMaps };
    });
  };

  var _applyLineBreaks = function(rows, targets, columnMeta) {
    targets.forEach(function(col, c) {
      if (!col || MULTILINE_ITEM_TYPES.indexOf((columnMeta[col.property] || {}).itemType) >= 0) { return; }
      rows.forEach(function(row) {
        if (row[c] && row[c].indexOf('\n') >= 0) { row[c] = row[c].replace(/\n+/g, ' '); }
      });
    });
  };

  var _convertTable = function(rows, targets, columnMeta, sourceDateFormat, sourceDecimal) {
    var stats = { converted: 0, rejected: [] };
    var sourceOrder = _dayMonthOrder(sourceDateFormat);

    targets.forEach(function(col, c) {
      if (!col) { return; }
      var meta = columnMeta[col.property] || {};
      var convert = null;

      if (DATE_TYPES.indexOf(meta.dataType) >= 0) {
        var values = rows.map(function(row) { return row[c]; });
        var order = _inferColumnOrder(values) || sourceOrder;
        var mask = meta.formatMask || undefined;
        convert = function(v) {
          var date = _parseDate(v, order, sourceDateFormat);
          return date ? apex.date.format(date, mask) : undefined;
        };
      } else if (meta.itemType === ITEM_SELECT_LIST) {
        convert = _selectListResolver(col);
      } else if (meta.itemType === ITEM_SWITCH) {
        convert = _switchResolver(col);
      } else if (meta.dataType === 'NUMBER' && NUMBER_ITEM_TYPES.indexOf(meta.itemType) >= 0) {
        var decimalSep = _inferColumnDecimal(rows.map(function(row) { return row[c]; })) || sourceDecimal;
        convert = function(v) {
          var n = _parseNumber(v, decimalSep);
          return n === null ? undefined : _formatNumberForSession(n);
        };
      }
      if (!convert) { return; }

      rows.forEach(function(row, r) {
        var v = row[c];
        if (v === '') { return; }
        var out = convert(v);
        if (out === undefined) {
          stats.rejected.push({ row: r + 1, col: c, column: col.label || _stripTags(col.heading) || col.property, value: v });
        } else if (out !== v) {
          row[c] = out;
          stats.converted += 1;
        }
      });
    });
    return stats;
  };

  var _describeRejected = function(rejected) {
    return rejected.slice(0, 3).map(function(x) {
      return 'row ' + x.row + ', ' + x.column + ' "' + x.value + '"' + (x.ambiguous ? ' (ambiguous)' : '');
    }).join('; ') + (rejected.length > 3 ? '…' : '');
  };

  var _reportPaste = function(rowCount, stats, header, insert) {
    if (!header && !stats.converted && !stats.rejected.length) { return; }
    var msg = rowCount + ' row(s) ' + (insert ? 'inserted' : 'pasted') + ' · ' + stats.converted + ' value(s) converted';
    if (header) {
      msg += ' · matched by header: ' + header.matched.join(', ');
      if (header.ignored.length) {
        msg += ' · ignored: ' + header.ignored.join(', ');
      }
    }
    if (stats.rejected.length) {
      msg += ' · ' + stats.rejected.length + ' could not be converted: ' + _describeRejected(stats.rejected);
      logger.warning('Values left unconverted', stats.rejected);
    }
    apex.message.showPageSuccess(apex.util.escapeHTML(msg));
  };

  var _resolvePasteMode = function(configured, special) {
    if (configured === PASTE_MODE.INSERT || configured === PASTE_MODE.APPEND) {
      return configured;
    }
    return special ? PASTE_MODE.INSERT : PASTE_MODE.REPLACE;
  };

  var _checkCanInsert = function(grid) {
    if (grid.model.allowAdd()) { return true; }
    apex.message.clearErrors();
    apex.message.showErrors([{
      type: 'error'
      , location: 'page'
      , message: 'Nothing was pasted: this grid does not allow adding rows.'
    }]);
    return false;
  };

  var _lastDataRecord = function(model) {
    var last = null;
    model.forEach(function(record) {
      if (!(model.getRecordMetadata(model.getRecordId(record)) || {}).agg) { last = record; }
    });
    return last;
  };

  var _moveToRecordRow = function(grid, cell$, recordId) {
    var row$ = cell$.closest('tbody').children('tr').filter(function() {
      return $(this).attr('data-id') === recordId;
    });
    var target$ = row$.children().eq(cell$.index());
    if (!target$.length) { return false; }
    grid.setCurrentCell(target$);
    grid._setCurrentRow(target$[0]);
    return true;
  };

  var _finishPaste = function(grid, originalPaste, dataRows, targets, stats, header, placement, modelOptions, cfg) {
    var insert = placement.insert;
    if (cfg.rejectOnErrors && stats.rejected.length) {
      apex.message.clearErrors();
      apex.message.showErrors([{
        type: 'error'
        , location: 'page'
        , message: 'Nothing was pasted: ' + stats.rejected.length + ' value(s) could not be converted (' +
            _describeRejected(stats.rejected) + ')'
      }]);
      logger.warning('Paste rejected (all-or-nothing)', stats.rejected);
      return;
    }

    var useModel = !!(header || modelOptions);
    if (!useModel && placement.mode === PASTE_MODE.APPEND &&
        !_moveToRecordRow(grid, placement.cell$, placement.anchorId)) {
      logger.log('Append: the last loaded row is not rendered; writing through the model');
      useModel = true;
    }

    logger.log('Pasting ' + dataRows.length + ' row(s) ' + (header ? 'by header' : 'by position') +
      (insert ? ' as new rows (' + placement.mode + ')' : '') + ' into columns ' +
      targets.map(function(t) { return t ? t.property : '-'; }).join(', '),
      { stats: stats, firstRows: dataRows.slice(0, 3) });

    if (useModel) {
      var result = _writeViaModel(grid, dataRows, targets, stats.rejected,
        $.extend({ insert: insert }, modelOptions, { startId: placement.anchorId }));
      if (!result) {
        logger.error('SPREADSHEET_PASTE: could not locate the current row in the model');
        return;
      }
      if (result.stopped) {
        logger.warning('Ran out of rows and this grid does not allow adding rows; remaining rows not pasted');
      }
    } else {
      originalPaste.call(grid, {
        types: [APEX_GRID_MIME]
        , special: insert
        , asyncGetData: function() { return Promise.resolve(dataRows); }
      });
    }
    _reportPaste(dataRows.length, stats, header, insert);
  };

  var _handleSpreadsheetPaste = function(grid, asyncDataTransfer, originalPaste, cfg) {
    var types = Array.prototype.slice.call(asyncDataTransfer.types || []);
    var special = !!asyncDataTransfer.special;
    var mode = _resolvePasteMode(cfg.pasteMode, special);
    var insert = mode !== PASTE_MODE.REPLACE;
    var cell$ = grid.getCurrentCell();
    var startId = cell$ && cell$.length ? cell$.closest('tr').attr('data-id') : null;

    var placementFor = function() {
      var anchorId = startId;
      if (mode === PASTE_MODE.APPEND) {
        var last = _lastDataRecord(grid.model);
        anchorId = last ? grid.model.getRecordId(last) : startId;
      }
      return { mode: mode, insert: insert, anchorId: anchorId, cell$: cell$ };
    };

    if (types.indexOf(APEX_GRID_MIME) >= 0) {
      if (mode === PASTE_MODE.REPLACE || (mode === PASTE_MODE.INSERT && special)) {
        return originalPaste.call(grid, asyncDataTransfer);
      }
      return asyncDataTransfer.asyncGetData(APEX_GRID_MIME).then(function(gridData) {
        var single = !Array.isArray(gridData) || (gridData.length === 1 && gridData[0].length < 2);
        if (!single) {
          if (!_checkCanInsert(grid)) { return; }
          var placement = placementFor();
          if (mode === PASTE_MODE.APPEND && startId && !_moveToRecordRow(grid, cell$, placement.anchorId)) {
            logger.warning('Append: the last loaded row is not rendered; inserting below the current row');
          }
        }
        originalPaste.call(grid, {
          types: [APEX_GRID_MIME]
          , special: single ? special : true
          , asyncGetData: function() { return Promise.resolve(gridData); }
        });
      });
    }

    var read = function(type) {
      return types.indexOf(type) >= 0 ? asyncDataTransfer.asyncGetData(type) : Promise.resolve('');
    };
    var htmlP = read('text/html');
    var textP = read('text/plain');

    return Promise.all([htmlP, textP]).then(function(data) {
      var html = data[0] || '', text = data[1] || '';

      var replay = function(reason) {
        logger.log('Paste left to native grid: ' + reason);
        originalPaste.call(grid, {
          types: types.filter(function(t) { return t === 'text/html' || t === 'text/plain'; })
          , special: special
          , asyncGetData: function(type) { return Promise.resolve(type === 'text/html' ? html : text); }
        });
      };

      if (!cell$ || !cell$.length || !cell$.hasClass('a-GV-cell') || !startId) {
        return replay('current cell is not a data cell');
      }
      var rows = _readClipboardTable({ getData: function(type) { return type === 'text/html' ? html : text; } });
      if (!rows) {
        return replay('clipboard is not tabular');
      }
      if (rows.length === 1 && rows[0].length === 1) {
        var cellTargets = _resolveTargetColumns(grid, 1);
        if (!cellTargets) {
          return replay('current cell is not a data cell');
        }
        _applyLineBreaks(rows, cellTargets, cfg.columnMeta);
        logger.log('Pasting a multi-line value into ' + (cellTargets[0] ? cellTargets[0].property : '-'));
        return originalPaste.call(grid, {
          types: [APEX_GRID_MIME]
          , special: special
          , asyncGetData: function() { return Promise.resolve(rows); }
        });
      }
      if (insert && !_checkCanInsert(grid)) {
        return;
      }
      var placement = placementFor();

      var header = rows.length > 1 ? _matchHeaderRow(grid, rows[0]) : null;
      var dataRows = header ? rows.slice(1) : rows;
      var targets = header ? header.targets : _resolveTargetColumns(grid, rows[0].length);
      if (!targets) {
        return replay('current cell is not a data cell');
      }

      var stats;
      try {
        _applyLineBreaks(dataRows, targets, cfg.columnMeta);
        stats = _convertTable(dataRows, targets, cfg.columnMeta, cfg.sourceDateFormat, cfg.sourceDecimal);
      } catch (e) {
        logger.error('SPREADSHEET_PASTE: conversion failed', e);
        return replay('conversion failed');
      }

      var popupColumns = targets.filter(function(t) {
        return t && (cfg.columnMeta[t.property] || {}).itemType === ITEM_POPUP_LOV;
      });
      if (!popupColumns.length) {
        return _finishPaste(grid, originalPaste, dataRows, targets, stats, header, placement, null, cfg);
      }

      var region$ = $('#' + cfg.regionId).addClass(BUSY_CLASS);
      return _resolvePopupLovs(cfg.ajaxIdentifier, dataRows, targets, cfg.columnMeta, stats)
        .then(function(lov) {
          region$.removeClass(BUSY_CLASS);
          var compositeColumns = {};
          popupColumns.forEach(function(t) { compositeColumns[t.property] = true; });
          _finishPaste(grid, originalPaste, dataRows, targets, stats, header, placement, {
            displayMaps: lov.displayMaps,
            compositeColumns: compositeColumns
          }, cfg);
        }, function(err) {
          region$.removeClass(BUSY_CLASS);
          logger.error('SPREADSHEET_PASTE: Popup LOV lookup failed; nothing was pasted', err);
          apex.message.showErrors([{
            type: 'error'
            , location: 'page'
            , message: 'Nothing was pasted: the list of values lookup failed.'
          }]);
        });
    }).catch(function(e) {
      logger.error('SPREADSHEET_PASTE: paste failed', e);
    });
  };

  var _installPasteWrapper = function(grid, cfg) {
    if (grid._igptPaste) {
      grid._igptPaste.cfg = cfg;
      return true;
    }
    if (typeof grid._paste !== 'function' || typeof grid._getColumnMetadata !== 'function') {
      return false;
    }
    var state = { cfg: cfg, original: grid._paste };
    grid._igptPaste = state;
    grid._paste = function(asyncDataTransfer) {
      return _handleSpreadsheetPaste(this, asyncDataTransfer, state.original, state.cfg);
    };
    return true;
  };

  var _getGridView = function(regionCtx) {
    try {
      var view = regionCtx.region.widget().interactiveGrid('getViews', 'grid');
      return view && view.view$ ? view.view$.grid('instance') : null;
    } catch (e) {
      return null;
    }
  };

  var _enableSpreadsheetPaste = function(regionCtx, settings) {
    var columnMeta;
    try {
      columnMeta = settings.columnMeta ? JSON.parse(settings.columnMeta) : {};
    } catch (e) {
      logger.error('SPREADSHEET_PASTE: invalid column metadata from the server', e);
      return;
    }
    var metaCount = Object.keys(columnMeta).length;
    if (!metaCount) {
      logger.error('SPREADSHEET_PASTE: no column metadata received from the server; values will not be converted');
    }
    var cfg = {
      regionId: regionCtx.id
      , columnMeta: columnMeta
      , sourceDateFormat: settings.sourceDateFormat || 'MM/DD/YYYY'
      , sourceDecimal: settings.sourceDecimalSeparator === 'COMMA' ? ',' : '.'
      , rejectOnErrors: settings.rejectOnErrors === true
      , pasteMode: settings.pasteMode || PASTE_MODE.REPLACE
      , ajaxIdentifier: settings.ajaxIdentifier
    };

    var tryInstall = function() {
      var grid = _getGridView(regionCtx);
      if (!grid) { return false; }
      if (!_installPasteWrapper(grid, cfg)) {
        logger.error('SPREADSHEET_PASTE: private grid API not found in this APEX version; native paste left unchanged');
        return true;
      }
      logger.log('Spreadsheet paste enabled for region ' + regionCtx.id + ' (' + metaCount + ' column(s) described)');
      return true;
    };

    if (!tryInstall()) {
      regionCtx.region.widget().on('interactivegridviewchange.igptPaste', function() {
        if (tryInstall()) {
          $(this).off('interactivegridviewchange.igptPaste');
        }
      });
    }
  };

  var run = function(settings, daConfig) {
    var command = (settings && settings.command) || COMMAND.REFRESH_GRID;

    try {
      var regionCtx = _resolveRegion(daConfig);
      if (!regionCtx) { return; }

      switch (command) {
        case COMMAND.REFRESH_SELECTED:
          _refreshSurgical(regionCtx);
          break;

        case COMMAND.REFRESH_GRID:
          _refreshFull(regionCtx);
          break;

        case COMMAND.SELECTED_ACTION:
          _runSelectedAction(regionCtx, settings.actionName, settings.preserveSelection);
          break;

        case COMMAND.DEPENDENT_COLUMN_REFRESH:
          _runDependentColumnRefresh(regionCtx, settings.actionName);
          break;

        case COMMAND.SPREADSHEET_PASTE:
          _enableSpreadsheetPaste(regionCtx, settings);
          break;

        default:
          logger.warning('Unknown command, defaulting to full refresh', command);
          _refreshFull(regionCtx);
      }
    } catch (e) {
      logger.error('Unhandled error running command "' + command + '"', e);
    }
  };

  return {
    run: run
    , COMMAND: COMMAND
  };
})(master, apex.jQuery);
