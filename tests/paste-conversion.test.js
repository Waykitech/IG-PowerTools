'use strict';

const fs = require('fs');
const path = require('path');
const assert = require('assert');

const SOURCE = path.join(__dirname, '..', 'src', 'static-files', 'ig-powertools.js');
const src = fs.readFileSync(SOURCE, 'utf8');
const start = src.indexOf('  var APEX_GRID_MIME');
const end = src.indexOf('  var _getGridView = function');
assert.ok(start > 0 && end > start, 'could not locate the spreadsheet paste section in ' + SOURCE);
const section = src.slice(start, end);

let sessionDecimal = '.';
let serverCalls = [];
const messages = [];

const PEOPLE = { 'Ana Pérez': '1', 'Luis Gómez': '2', 'María José Ruiz': '3' };
const apex = {
  server: {
    plugin: (id, data) => {
      serverCalls.push({ id, data });
      const values = {};
      data.f01.forEach(v => {
        const hit = Object.keys(PEOPLE).find(d => d.toLowerCase() === v.trim().toLowerCase() || PEOPLE[d] === v);
        if (hit) { values[v] = { r: PEOPLE[hit], d: hit }; }
      });
      return Promise.resolve({ values });
    }
  },
  locale: { getDecimalSeparator: () => sessionDecimal },
  message: { showPageSuccess: msg => messages.push(msg), showErrors: () => {}, clearErrors: () => {} },
  util: { escapeHTML: s => s },
  date: {
    parse: () => null,
    isValid: () => false,

    format: (d, mask) => {
      const pad = n => String(n).padStart(2, '0');
      if (mask === 'DD/MM/YYYY') { return pad(d.getDate()) + '/' + pad(d.getMonth() + 1) + '/' + d.getFullYear(); }
      return d.toISOString();
    }
  }
};
const logger = { log() {}, warning() {}, error() {} };

const dom = {
  STATUS_ITEM: { options: [['OPEN', 'Open'], ['IN_PROGRESS', 'In Progress'], ['DONE', 'Done']] },
  BILLABLE_ITEM: { checkbox: { type: 'checkbox', value: 'Y', 'data-off-value': 'N', 'data-on-label': 'On', 'data-off-label': 'Off' } }
};
const $ = sel => {
  const id = String(sel).replace(/^#/, '');
  const node = dom[id] || {};
  const optionsObj = {
    length: node.options ? node.options.length : 0,
    each(fn) { (node.options || []).forEach(([value, text]) => fn.call({ value, text })); }
  };
  const obj = {
    length: node.options || node.checkbox ? 1 : 0,
    is: () => !!node.checkbox,
    attr: k => node.checkbox && node.checkbox[k],
    find: q => (q === 'option' ? optionsObj : obj),
    eq: () => obj,
    text: () => ''
  };
  return obj;
};
$.extend = (target, ...sources) => Object.assign(target, ...sources.filter(Boolean));

const textOf = h => String(h).replace(/<[^>]*>/g, '').replace(/&amp;/g, '&');
const DOMParser = function() {};
DOMParser.prototype.parseFromString = html => ({
  body: { textContent: textOf(html) },
  getElementsByTagName: () => (String(html).match(/<table[\s\S]*?<\/table>/gi) || []).map(t => ({
    rows: (t.match(/<tr[\s\S]*?<\/tr>/gi) || []).map(tr => ({
      cells: [...tr.matchAll(/<t[dh]([^>]*)>([\s\S]*?)<\/t[dh]>/gi)].map(m => ({
        textContent: textOf(m[2]),
        getAttribute: k => ((m[1].match(new RegExp(k + '="?(\\d+)')) || [])[1] || null)
      }))
    }))
  }))
});

const clock = {
  now: 0,
  seq: 0,
  queue: [],
  schedule(fn, ms) {
    this.queue.push({ fn, due: this.now + (ms || 0), seq: this.seq++ });
  },
  advance(ms) {
    this.now += ms;
  },
  runAll() {
    while (this.queue.length) {
      this.queue.sort((a, b) => a.due - b.due || a.seq - b.seq);
      const next = this.queue.shift();
      this.now = Math.max(this.now, next.due);
      next.fn();
    }
  }
};
const browserSetTimeout = (fn, ms) => clock.schedule(fn, ms);

const api = new Function('apex', 'logger', '$', 'DOMParser', 'setTimeout', section + `
  return {
    _readClipboardTable, _splitDelimited, _applyLineBreaks, _inferColumnOrder, _parseDate, _dayMonthOrder,
    _parseNumber, _inferColumnDecimal, _formatNumberForSession, _switchResolver,
    _matchHeaderRow, _writeViaModel, _convertTable, _resolvePopupLovs,
    _installPasteWrapper, APEX_GRID_MIME
  };`)(apex, logger, $, DOMParser, browserSetTimeout);

let passed = 0;
const test = (name, fn) => {
  try {
    fn();
    passed += 1;
  } catch (e) {
    console.error('FAIL: ' + name);
    throw e;
  }
};
const dmy = d => d && [d.getDate(), d.getMonth() + 1, d.getFullYear()].join('/');

test('mask day/month order', () => {
  assert.strictEqual(api._dayMonthOrder('MM/DD/YYYY'), 'MDY');
  assert.strictEqual(api._dayMonthOrder('DD/MM/YYYY'), 'DMY');
  assert.strictEqual(api._dayMonthOrder('DD-MON-YYYY HH24:MI'), null);
});

test('column order inferred from unambiguous values', () => {
  assert.strictEqual(api._inferColumnOrder(['9/23/2026', '10/5/2026', '2026-10-15']), 'MDY');
  assert.strictEqual(api._inferColumnOrder(['23/9/2026', '10/5/2026']), 'DMY');
  assert.strictEqual(api._inferColumnOrder(['10/5/2026', '1/2/2026']), null);
  assert.strictEqual(api._inferColumnOrder(['23/9/2026', '9/23/2026']), null);
});

test('date parsing (the silent 10/5 case)', () => {
  assert.strictEqual(dmy(api._parseDate('9/23/2026', 'MDY')), '23/9/2026');
  assert.strictEqual(dmy(api._parseDate('10/5/2026', 'MDY')), '5/10/2026');
  assert.strictEqual(dmy(api._parseDate('2026-10-15', null)), '15/10/2026');
  assert.strictEqual(dmy(api._parseDate('9/23/26', 'MDY')), '23/9/2026');
  assert.strictEqual(api._parseDate('9/23/2026 3:45 PM', 'MDY').getHours(), 15);
  assert.strictEqual(api._parseDate('2/31/2026', 'MDY'), null);
  assert.strictEqual(api._parseDate('garbage', 'MDY'), null);
});

test('text/plain fallback keeps leading empty cells and pads rows', () => {
  const cd = t => ({ getData: k => (k === 'text/plain' ? t : '') });
  assert.deepStrictEqual(api._readClipboardTable(cd('a\tb\n\tc\n')), [['a', 'b'], ['', 'c']]);
  assert.deepStrictEqual(api._readClipboardTable(cd('a\tb\r\nc')), [['a', 'b'], ['c', '']]);
  assert.strictEqual(api._readClipboardTable(cd('single')), null);
});

test('text/plain: a quoted cell keeps its line breaks (Sheets / Excel quoting)', () => {
  const cd = t => ({ getData: k => (k === 'text/plain' ? t : '') });
  assert.deepStrictEqual(api._readClipboardTable(cd('"Hola\nMundo"')), [['Hola\nMundo']]);
  assert.deepStrictEqual(api._readClipboardTable(cd('"Hola\r\nMundo"\r\n')), [['Hola\nMundo']]);
  assert.deepStrictEqual(api._readClipboardTable(cd('a\t"Hola\n  Mundo "\nb\tc\n')), [['a', 'Hola\nMundo'], ['b', 'c']]);
  assert.deepStrictEqual(api._readClipboardTable(cd('"say ""hi""\nok"\tx')), [['say "hi"\nok', 'x']]);
  assert.deepStrictEqual(api._readClipboardTable(cd('"\nHola\n\nMundo\n"\tx')), [['Hola\n\nMundo', 'x']]);
  assert.deepStrictEqual(api._readClipboardTable(cd('"a\tb"\tc')), [['a b', 'c']]);
});

test('text/plain: text that is not spreadsheet quoting is split as before', () => {
  const cd = t => ({ getData: k => (k === 'text/plain' ? t : '') });
  assert.deepStrictEqual(api._readClipboardTable(cd('Hola\nMundo')), [['Hola'], ['Mundo']]);
  assert.deepStrictEqual(api._readClipboardTable(cd('"abc" def\tx')), [['"abc" def', 'x']]);
  assert.deepStrictEqual(api._readClipboardTable(cd('"abc\tx\ny')), [['"abc', 'x'], ['y', '']]);
  assert.deepStrictEqual(api._splitDelimited('a\t\tb\n'), [['a', '', 'b']]);
});

test('text/html: <br> inside a cell is a line break, source whitespace collapses', () => {
  const cd = h => ({ getData: k => (k === 'text/html' ? h : 'ignored\tplain') });

  assert.deepStrictEqual(api._readClipboardTable(cd(
    '<google-sheets-html-origin><table><tbody><tr><td>Hola<br>Mundo</td><td>x</td></tr></tbody></table>')),
    [['Hola\nMundo', 'x']]);

  assert.deepStrictEqual(api._readClipboardTable(cd(
    '<table><tr><td class=xl65>Hola\n  there<br style=\'mso-data-placement:same-cell\' />Mundo</td></tr></table>')),
    [['Hola there\nMundo']]);
  assert.deepStrictEqual(api._readClipboardTable(cd('<table><tr><td>a</td><td>b</td></tr></table>')), [['a', 'b']]);
  assert.deepStrictEqual(api._readClipboardTable(cd('<table><tr><td colspan="2">a<br>b</td></tr></table>')), [['a\nb', 'a\nb']]);
  assert.strictEqual(api._readClipboardTable(cd('<table><tr><td>one</td></tr></table>')), null);
});

test('line breaks kept for Textarea columns only; other columns get a space', () => {
  const meta = { NOTES: { itemType: 'NATIVE_TEXTAREA' }, TASK_NAME: { itemType: 'NATIVE_TEXT_FIELD' } };
  const rows = [['Hola\nMundo', 'Hola\n\nMundo', 'a\nb'], ['x', '', 'c']];
  api._applyLineBreaks(rows, [{ property: 'NOTES' }, { property: 'TASK_NAME' }, null], meta);
  assert.deepStrictEqual(rows, [['Hola\nMundo', 'Hola Mundo', 'a\nb'], ['x', '', 'c']]);
});

test('number parsing, point decimal', () => {
  const P = api._parseNumber;
  assert.strictEqual(P('1,234.56', '.'), 1234.56);
  assert.strictEqual(P('$1,200.00', '.'), 1200);
  assert.strictEqual(P('-$1,200.50', '.'), -1200.5);
  assert.strictEqual(P('(300)', '.'), -300);
  assert.strictEqual(P('300-', '.'), -300);
  assert.strictEqual(P('15%', '.'), 0.15);
  assert.strictEqual(P('1.2E+05', '.'), 120000);
  assert.strictEqual(P('USD 10.5', '.'), 10.5);
});

test('number parsing, comma decimal', () => {
  const P = api._parseNumber;
  assert.strictEqual(P('1.234,56', ','), 1234.56);
  assert.strictEqual(P('1 234,56 €', ','), 1234.56);
  assert.strictEqual(P('1 234,5', ','), 1234.5);
  assert.strictEqual(P('0,25', ','), 0.25);
});

test('invalid numbers are rejected', () => {
  assert.strictEqual(api._parseNumber('abc', '.'), null);
  assert.strictEqual(api._parseNumber('1,23,4', '.'), null);
  assert.strictEqual(api._parseNumber('12-34', '.'), null);
});

test('column decimal separator inference', () => {
  assert.strictEqual(api._inferColumnDecimal(['1,5', '2', '1.234']), ',');
  assert.strictEqual(api._inferColumnDecimal(['1.5', '1,234']), '.');
  assert.strictEqual(api._inferColumnDecimal(['1,234', '2.345']), null);
  assert.strictEqual(api._inferColumnDecimal(['1.5', '1,5']), null);
});

test('numbers are written in the session format without grouping', () => {
  assert.strictEqual(api._formatNumberForSession(1234.56), '1234.56');
  assert.strictEqual(api._formatNumberForSession(0.1 + 0.2), '0.3');
  sessionDecimal = ',';
  assert.strictEqual(api._formatNumberForSession(1234.56), '1234,56');
  sessionDecimal = '.';
});

test('switch values', () => {
  const sw = api._switchResolver({ elementId: 'BILLABLE_ITEM' });
  assert.strictEqual(sw('TRUE'), 'Y');
  assert.strictEqual(sw('false'), 'N');
  assert.strictEqual(sw('Sí'), 'Y');
  assert.strictEqual(sw('Off'), 'N');
  assert.strictEqual(sw('maybe'), undefined);
});

const META = {
  TASK_NAME: { dataType: 'VARCHAR2', itemType: 'NATIVE_TEXT_FIELD' },
  STATUS: { dataType: 'VARCHAR2', itemType: 'NATIVE_SELECT_LIST' },
  DUE_DATE: { dataType: 'DATE', itemType: 'NATIVE_DATE_PICKER_APEX', formatMask: 'DD/MM/YYYY' },
  BUDGET: { dataType: 'NUMBER', itemType: 'NATIVE_NUMBER_FIELD', formatMask: '999G999G990D00' },
  IS_BILLABLE: { dataType: 'VARCHAR2', itemType: 'NATIVE_YES_NO' }
};

test('convertTable converts per column, reports rejects with their column index', () => {
  const rows = [['1,234.50', 'TRUE'], ['2.25', 'FALSE'], ['oops', 'maybe']];
  const targets = [{ property: 'BUDGET' }, { property: 'IS_BILLABLE', elementId: 'BILLABLE_ITEM' }];
  const stats = api._convertTable(rows, targets, META, 'MM/DD/YYYY', '.');
  assert.deepStrictEqual(rows, [['1234.5', 'Y'], ['2.25', 'N'], ['oops', 'maybe']]);
  assert.strictEqual(stats.converted, 3);
  assert.deepStrictEqual(stats.rejected.map(x => [x.row, x.col]), [[3, 0], [3, 1]]);
});

test('convertTable skips unmapped (null) targets', () => {
  const rows = [['x', '9/23/2026']];
  const stats = api._convertTable(rows, [null, { property: 'DUE_DATE' }], META, 'MM/DD/YYYY', '.');
  assert.deepStrictEqual(rows, [['x', '23/09/2026']]);
  assert.strictEqual(stats.converted, 1);
});

const COLUMNS = [
  { property: 'TASK_ID', hidden: true, elementId: 'C1' },
  { property: 'TASK_NAME', heading: 'Task', elementId: 'C2' },
  { property: 'STATUS', heading: 'Status', elementId: 'STATUS_ITEM' },
  { property: 'PRIORITY_LABEL', heading: 'Priority Label', readonly: true },
  { property: 'DUE_DATE', heading: 'Due Date', elementId: 'C4' },
  { property: 'ESTIMATE_HOURS', heading: 'Estimate (h)', elementId: 'C5' },
  { property: 'BUDGET', heading: '<span>Budget</span>', elementId: 'C6' },
  { property: 'IS_BILLABLE', heading: 'Billable', elementId: 'BILLABLE_ITEM' }
];

const makeModel = (records, opts = {}) => {
  let seq = 0;
  const data = records.map(r => Object.assign({ __id: 'r' + (++seq) }, r));
  const validity = [];
  return {
    data,
    validity,
    isIdentityField: f => f === 'TASK_ID',
    recordAt: i => data[i] || null,
    forEach: fn => data.forEach((rec, i) => fn(rec, i, rec.__id)),
    indexOf: rec => data.indexOf(rec),
    getRecord: id => data.find(r => r.__id === id) || null,
    getRecordId: rec => rec.__id,
    getRecordMetadata: id => (opts.meta && opts.meta[id]) || {},
    allowEdit: () => true,
    allowAdd: () => opts.allowAdd !== false,
    getValue: (rec, f) => rec[f],
    setValue: (rec, f, v) => { rec[f] = v; return 'SET'; },
    setValidity: (state, id, f, msg) => validity.push([state, id, f, msg]),
    insertNewRecord: (parent, after) => {
      const rec = { __id: 'new' + (++seq) };
      data.splice(after ? data.indexOf(after) + 1 : 0, 0, rec);
      return rec.__id;
    }
  };
};
const makeGrid = (model, currentId) => ({
  model,
  getColumns: () => COLUMNS,
  getCurrentCell: () => ({ closest: () => ({ attr: () => currentId }) })
});

test('header row detected by heading, label or column name; case/accents/markup ignored', () => {
  const grid = makeGrid(makeModel([]), null);
  const h = api._matchHeaderRow(grid, ['BUDGET', 'task', 'Notes', 'Priority Label', 'dué date']);
  assert.deepStrictEqual(h.targets.map(t => t && t.property), ['BUDGET', 'TASK_NAME', null, null, 'DUE_DATE']);
  assert.deepStrictEqual(h.matched, ['BUDGET', 'task', 'dué date']);
  assert.deepStrictEqual(h.ignored, ['Notes', 'Priority Label']);
});

test('ordinary data rows are not mistaken for a header', () => {
  const grid = makeGrid(makeModel([]), null);
  assert.strictEqual(api._matchHeaderRow(grid, ['Prueba A', 'Open', '2', '9/23/2026']), null);
  assert.strictEqual(api._matchHeaderRow(grid, ['Task', 'something']), null);
});

test('model writer: overwrite from current row, then insert; untouched columns kept; LOV pairs', () => {
  const model = makeModel([
    { TASK_NAME: 'old 1', STATUS: { v: 'OPEN', d: 'Open' }, BUDGET: '10', PRIORITY: '3' },
    { TASK_NAME: 'old 2', STATUS: { v: 'OPEN', d: 'Open' }, BUDGET: '20', PRIORITY: '4' }
  ]);
  const grid = makeGrid(model, 'r2');
  const targets = [COLUMNS[2], null, COLUMNS[1]];
  const rows = [['IN_PROGRESS', 'x', 'new A'], ['DONE', 'y', 'new B']];
  const res = api._writeViaModel(grid, rows, targets, []);

  assert.deepStrictEqual(res, { written: 4, inserted: 1, stopped: false });
  assert.strictEqual(model.data[0].TASK_NAME, 'old 1');
  assert.strictEqual(model.data[1].TASK_NAME, 'new A');
  assert.deepStrictEqual(model.data[1].STATUS, { v: 'IN_PROGRESS', d: 'In Progress' });
  assert.strictEqual(model.data[1].BUDGET, '20');
  assert.strictEqual(model.data[1].PRIORITY, '4');
  assert.strictEqual(model.data[2].TASK_NAME, 'new B');
  assert.deepStrictEqual(model.data[2].STATUS, { v: 'DONE', d: 'Done' });
});

test('model writer: skips aggregate rows, flags rejected cells, stops when adding is not allowed', () => {
  const model = makeModel([{ TASK_NAME: 'a' }, { TASK_NAME: 'agg' }, { TASK_NAME: 'b' }],
    { allowAdd: false, meta: { r2: { agg: true } } });
  const grid = makeGrid(model, 'r1');
  const rows = [['n1'], ['n2'], ['n3']];
  const res = api._writeViaModel(grid, rows, [COLUMNS[1]], [{ row: 2, col: 0 }]);

  assert.deepStrictEqual(model.data.map(r => r.TASK_NAME), ['n1', 'agg', 'n2']);
  assert.strictEqual(res.stopped, true);
  assert.deepStrictEqual(model.validity, [['error', 'r3', 'TASK_NAME', 'Could not convert "n2"']]);
});

const asyncTests = [];
const testAsync = (name, fn) => asyncTests.push({ name, fn });

testAsync('popup LOV: one lookup per column with distinct values; display and return values resolved', async () => {
  serverCalls = [];
  const rows = [['ana pérez', 'x'], ['2', 'y'], ['Ana Pérez', 'z'], ['Nadie', 'w'], ['', 'v']];
  const targets = [{ property: 'ASSIGNEE_ID', heading: 'Assignee' }, { property: 'TASK_NAME' }];
  const meta = { ASSIGNEE_ID: { dataType: 'NUMBER', itemType: 'NATIVE_POPUP_LOV' }, TASK_NAME: META.TASK_NAME };
  const stats = { converted: 0, rejected: [] };
  const lov = await api._resolvePopupLovs('AJAX1', rows, targets, meta, stats);

  assert.strictEqual(serverCalls.length, 1);
  assert.deepStrictEqual(serverCalls[0].data, { x01: 'ASSIGNEE_ID', f01: ['ana pérez', '2', 'Ana Pérez', 'Nadie'] });
  assert.deepStrictEqual(rows.map(r => r[0]), ['1', '2', '1', 'Nadie', '']);
  assert.deepStrictEqual(lov.displayMaps.ASSIGNEE_ID, { 1: 'Ana Pérez', 2: 'Luis Gómez' });
  assert.strictEqual(stats.converted, 2);
  assert.deepStrictEqual(stats.rejected.map(x => [x.row, x.col, x.value]), [[4, 0, 'Nadie']]);
});


const trackAfterInsert = (grid, model, notify) => {
  const original = function originalAfterInsert() { original.calls += 1; };
  original.calls = 0;
  grid.afterInsertCallback = original;
  const seenAtInsert = [];
  const insert = model.insertNewRecord;
  model.insertNewRecord = (parent, after) => {
    seenAtInsert.push(grid.afterInsertCallback);
    const id = insert(parent, after);
    notify(() => grid.afterInsertCallback && grid.afterInsertCallback());
    return id;
  };
  return { original, seenAtInsert };
};

testAsync('model writer: after-insert activation suppressed while the grid notifies synchronously, restored on return', async () => {
  const model = makeModel([{ TASK_NAME: 'a' }]);
  const grid = makeGrid(model, 'r1');
  const t = trackAfterInsert(grid, model, call => call());
  api._writeViaModel(grid, [['n1'], ['n2'], ['n3']], [COLUMNS[1]], []);

  assert.deepStrictEqual(model.data.map(r => r.TASK_NAME), ['n1', 'n2', 'n3']);
  assert.strictEqual(t.seenAtInsert.length, 2);
  assert.ok(t.seenAtInsert.every(cb => typeof cb === 'function' && cb !== t.original));
  assert.strictEqual(t.original.calls, 0);
  assert.strictEqual(grid.afterInsertCallback, t.original);
});

testAsync('model writer: deferred notifications (empty-grid path) of a slow paste are all suppressed', async () => {
  const model = makeModel([{ TASK_NAME: 'a' }]);
  const grid = makeGrid(model, 'r1');
  const t = trackAfterInsert(grid, model, call => { browserSetTimeout(call, 1); clock.advance(15); });
  const rows = Array.from({ length: 6 }, (_, i) => ['n' + i]);
  const res = api._writeViaModel(grid, rows, [COLUMNS[1]], [], { insert: true });

  assert.strictEqual(res.inserted, 6);
  assert.notStrictEqual(grid.afterInsertCallback, t.original);
  clock.runAll();
  assert.strictEqual(t.original.calls, 0);
  assert.strictEqual(grid.afterInsertCallback, t.original);
});

testAsync('model writer: after-insert hook restored by the fallback when the grid never notifies', async () => {
  const model = makeModel([{ TASK_NAME: 'a' }]);
  const grid = makeGrid(model, 'r1');
  const t = trackAfterInsert(grid, model, () => {});
  api._writeViaModel(grid, [['n1'], ['n2']], [COLUMNS[1]], []);

  assert.notStrictEqual(grid.afterInsertCallback, t.original);
  clock.advance(999);
  assert.ok(clock.queue.every(x => x.due > clock.now));
  clock.runAll();
  assert.strictEqual(grid.afterInsertCallback, t.original);
});

testAsync('popup LOV: ambiguous display values are rejected, not resolved to the first match', async () => {
  const plugin = apex.server.plugin;
  apex.server.plugin = (id, data) => Promise.resolve({ values: { 'Luis Gómez': { r: '2', d: 'Luis Gómez' } }, ambiguous: ['J. Smith'] });
  try {
    const rows = [['J. Smith'], ['Luis Gómez']];
    const targets = [{ property: 'ASSIGNEE_ID', heading: 'Assignee' }];
    const meta = { ASSIGNEE_ID: { dataType: 'NUMBER', itemType: 'NATIVE_POPUP_LOV' } };
    const stats = { converted: 0, rejected: [] };
    await api._resolvePopupLovs('AJAX1', rows, targets, meta, stats);

    assert.deepStrictEqual(rows, [['J. Smith'], ['2']]);
    assert.deepStrictEqual(stats.rejected.map(x => [x.row, x.value, x.ambiguous]), [[1, 'J. Smith', true]]);

    const model = makeModel([{}, {}]);
    api._writeViaModel(makeGrid(model, 'r1'), rows, [COLUMNS[1]], stats.rejected);
    assert.deepStrictEqual(model.validity, [['error', 'r1', 'TASK_NAME', '"J. Smith" matches more than one list entry']]);
  } finally {
    apex.server.plugin = plugin;
  }
});

testAsync('popup LOV: no server call when the paste has no Popup LOV column', async () => {
  serverCalls = [];
  await api._resolvePopupLovs('AJAX1', [['a']], [{ property: 'TASK_NAME' }], META, { converted: 0, rejected: [] });
  assert.strictEqual(serverCalls.length, 0);
});

test('model writer: LOV display maps and forced {v, d} pairs; read-only positional targets skipped', () => {
  const model = makeModel([{ TASK_NAME: 'a', ASSIGNEE_ID: '' }]);
  const grid = makeGrid(model, null);
  const assignee = { property: 'ASSIGNEE_ID', heading: 'Assignee', elementId: 'C9' };
  const res = api._writeViaModel(grid, [['1', 'ignored']], [assignee, COLUMNS[3]], [], {
    startId: 'r1',
    displayMaps: { ASSIGNEE_ID: { 1: 'Ana Pérez' } },
    compositeColumns: { ASSIGNEE_ID: true }
  });
  assert.deepStrictEqual(model.data[0].ASSIGNEE_ID, { v: '1', d: 'Ana Pérez' });
  assert.strictEqual(model.data[0].PRIORITY_LABEL, undefined);
  assert.strictEqual(res.written, 1);
});

const makePasteGrid = (model, currentId) => {
  const calls = [];
  const cell = {
    length: 1,
    hasClass: c => c === 'a-GV-cell',
    closest: () => ({ attr: () => currentId })
  };
  const grid = {
    model,
    getColumns: () => COLUMNS,
    getCurrentCell: () => cell,
    _getColumnMetadata: () => null,
    _paste: function(dt) { calls.push(dt); }
  };
  return { grid, calls };
};
const clip = (types, data, special) => ({
  types,
  special: !!special,
  asyncGetData: t => Promise.resolve(data[t] || '')
});
const CFG = { columnMeta: META, sourceDateFormat: 'MM/DD/YYYY', sourceDecimal: '.', rejectOnErrors: false, regionId: 'R1' };

test('wrapper installs once per grid instance and refreshes its settings on re-run', () => {
  const { grid } = makePasteGrid(makeModel([]), 'r1');
  const original = grid._paste;
  assert.strictEqual(api._installPasteWrapper(grid, CFG), true);
  const wrapped = grid._paste;
  assert.notStrictEqual(wrapped, original);
  assert.strictEqual(api._installPasteWrapper(grid, Object.assign({}, CFG, { rejectOnErrors: true })), true);
  assert.strictEqual(grid._paste, wrapped);
  assert.strictEqual(grid._igptPaste.cfg.rejectOnErrors, true);
  assert.strictEqual(api._installPasteWrapper({ _paste: 1 }, CFG), false);
});

testAsync('wrapper: grid-to-grid copies go straight to native paste', async () => {
  const { grid, calls } = makePasteGrid(makeModel([]), 'r1');
  api._installPasteWrapper(grid, CFG);
  const dt = clip([api.APEX_GRID_MIME], {});
  await grid._paste(dt);
  assert.strictEqual(calls.length, 1);
  assert.strictEqual(calls[0], dt);
});

testAsync('wrapper: a single value is replayed to native paste from the data already read', async () => {
  const { grid, calls } = makePasteGrid(makeModel([]), 'r1');
  api._installPasteWrapper(grid, CFG);
  let reads = 0;
  const dt = { types: ['text/plain'], special: true, asyncGetData: () => { reads += 1; return Promise.resolve('hello'); } };
  await grid._paste(dt);
  assert.strictEqual(calls.length, 1);
  assert.strictEqual(calls[0].special, true);
  assert.strictEqual(await calls[0].asyncGetData('text/plain'), 'hello');
  assert.strictEqual(reads, 1);
});

testAsync('wrapper: clipboard is read synchronously, before any await (Firefox / drag-and-drop)', async () => {
  const { grid } = makePasteGrid(makeModel([]), 'r1');
  api._installPasteWrapper(grid, CFG);
  const requested = [];
  const dt = { types: ['text/html', 'text/plain'], special: false,
    asyncGetData: t => { requested.push(t); return Promise.resolve(''); } };
  const pending = grid._paste(dt);
  assert.deepStrictEqual(requested, ['text/html', 'text/plain']);
  await pending;
});

testAsync('wrapper: Paste Insert with a header row inserts new rows below the current row', async () => {
  const model = makeModel([{ TASK_NAME: 'a' }, { TASK_NAME: 'b' }]);
  const { grid, calls } = makePasteGrid(model, 'r1');
  api._installPasteWrapper(grid, CFG);
  const text = 'Task\tBudget\nnew 1\t1,500.00\nnew 2\t2.5\n';
  await grid._paste(clip(['text/plain'], { 'text/plain': text }, true));

  assert.strictEqual(calls.length, 0);
  assert.deepStrictEqual(model.data.map(r => r.TASK_NAME), ['a', 'new 1', 'new 2', 'b']);
  assert.deepStrictEqual(model.data.map(r => r.BUDGET), [undefined, '1500', '2.5', undefined]);
});

const HEADER_PASTE = 'Task\tBudget\nnew 1\t1,500.00\nnew 2\t2.5\n';

testAsync('mode INSERT: plain Ctrl+V inserts below the current row', async () => {
  const model = makeModel([{ TASK_NAME: 'a' }, { TASK_NAME: 'b' }, { TASK_NAME: 'c' }]);
  const { grid, calls } = makePasteGrid(model, 'r1');
  api._installPasteWrapper(grid, Object.assign({}, CFG, { pasteMode: 'INSERT' }));
  messages.length = 0;
  await grid._paste(clip(['text/plain'], { 'text/plain': HEADER_PASTE }, false));

  assert.strictEqual(calls.length, 0);
  assert.deepStrictEqual(model.data.map(r => r.TASK_NAME), ['a', 'new 1', 'new 2', 'b', 'c']);
  assert.ok(/^2 row\(s\) inserted/.test(messages[0]), messages[0]);
});

testAsync('mode APPEND: rows go after the last loaded row, wherever the current cell is; aggregates skipped', async () => {
  const model = makeModel([{ TASK_NAME: 'a' }, { TASK_NAME: 'b' }, { TASK_NAME: 'total' }],
    { meta: { r3: { agg: true } } });
  const { grid } = makePasteGrid(model, 'r1');
  api._installPasteWrapper(grid, Object.assign({}, CFG, { pasteMode: 'APPEND' }));
  await grid._paste(clip(['text/plain'], { 'text/plain': HEADER_PASTE }, true));

  assert.deepStrictEqual(model.data.map(r => r.TASK_NAME), ['a', 'b', 'new 1', 'new 2', 'total']);
});

testAsync('mode REPLACE (default): Ctrl+V overwrites from the current row', async () => {
  const model = makeModel([{ TASK_NAME: 'a' }, { TASK_NAME: 'b' }]);
  const { grid } = makePasteGrid(model, 'r1');
  api._installPasteWrapper(grid, CFG);
  await grid._paste(clip(['text/plain'], { 'text/plain': HEADER_PASTE }, false));

  assert.deepStrictEqual(model.data.map(r => r.TASK_NAME), ['new 1', 'new 2']);
});

testAsync('insert modes: nothing is pasted when the grid does not allow adding rows', async () => {
  const model = makeModel([{ TASK_NAME: 'a' }], { allowAdd: false });
  const { grid, calls } = makePasteGrid(model, 'r1');
  api._installPasteWrapper(grid, Object.assign({}, CFG, { pasteMode: 'INSERT' }));
  await grid._paste(clip(['text/plain'], { 'text/plain': HEADER_PASTE }, false));

  assert.strictEqual(calls.length, 0);
  assert.deepStrictEqual(model.data.map(r => r.TASK_NAME), ['a']);
});

testAsync('insert modes: a single value still goes to the current cell', async () => {
  const { grid, calls } = makePasteGrid(makeModel([{ TASK_NAME: 'a' }]), 'r1');
  api._installPasteWrapper(grid, Object.assign({}, CFG, { pasteMode: 'INSERT' }));
  await grid._paste(clip(['text/plain'], { 'text/plain': 'hello' }, false));

  assert.strictEqual(calls.length, 1);
  assert.strictEqual(calls[0].special, false);
});

testAsync('mode INSERT: grid-to-grid copies of several cells are inserted, a single cell is not', async () => {
  const { grid, calls } = makePasteGrid(makeModel([{ TASK_NAME: 'a' }]), 'r1');
  api._installPasteWrapper(grid, Object.assign({}, CFG, { pasteMode: 'INSERT' }));
  const rows = [['x', 'y'], ['z', 'w']];
  await grid._paste(clip([api.APEX_GRID_MIME], { [api.APEX_GRID_MIME]: rows }, false));
  await grid._paste(clip([api.APEX_GRID_MIME], { [api.APEX_GRID_MIME]: [['one']] }, false));

  assert.strictEqual(calls.length, 2);
  assert.strictEqual(calls[0].special, true);
  assert.deepStrictEqual(await calls[0].asyncGetData(), rows);
  assert.strictEqual(calls[1].special, false);
});

const makeCellGrid = (model, column) => {
  const { grid, calls } = makePasteGrid(model, 'r1');
  const cellEl = {};
  const row = { hasClass: () => false, children: () => ({ index: () => 0, slice: () => ({ each: fn => fn.call(cellEl) }) }) };
  grid.getCurrentCell = () => ({ length: 1, hasClass: c => c === 'a-GV-cell', closest: () => ({ attr: () => 'r1' }), parent: () => row });
  grid._getColumnMetadata = () => column;
  return { grid, calls };
};

const MULTILINE_CLIP = { 'text/plain': '"Hola\r\nMundo"', 'text/html': '<span data-sheets-value="x">Hola<br>Mundo</span>' };

testAsync('wrapper: a single multi-line value keeps its line breaks in a Textarea column', async () => {
  const { grid, calls } = makeCellGrid(makeModel([{}]), { property: 'NOTES' });
  api._installPasteWrapper(grid, Object.assign({}, CFG, { pasteMode: 'APPEND',
    columnMeta: Object.assign({ NOTES: { dataType: 'VARCHAR2', itemType: 'NATIVE_TEXTAREA' } }, META) }));
  await grid._paste(clip(['text/html', 'text/plain'], MULTILINE_CLIP, false));

  assert.strictEqual(calls.length, 1);
  assert.deepStrictEqual(calls[0].types, [api.APEX_GRID_MIME]);
  assert.strictEqual(calls[0].special, false);
  assert.deepStrictEqual(await calls[0].asyncGetData(), [['Hola\nMundo']]);
});

testAsync('wrapper: a single multi-line value becomes one line in a text field', async () => {
  const { grid, calls } = makeCellGrid(makeModel([{}]), { property: 'TASK_NAME' });
  api._installPasteWrapper(grid, CFG);
  await grid._paste(clip(['text/html', 'text/plain'], MULTILINE_CLIP, true));

  assert.strictEqual(calls[0].special, true);
  assert.deepStrictEqual(await calls[0].asyncGetData(), [['Hola Mundo']]);
});

(async () => {
  for (const t of asyncTests) {
    try {
      await t.fn();
      passed += 1;
    } catch (e) {
      console.error('FAIL: ' + t.name);
      throw e;
    }
  }
  console.log('OK - ' + passed + ' tests passed');
})().catch(e => { console.error(e); process.exit(1); });
