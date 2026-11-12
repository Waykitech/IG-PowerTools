# IG PowerTools

A Dynamic Action plug-in for Oracle APEX 26.1 and later that adds the Interactive Grid features developers keep re-implementing by hand, as one declarative action. You don't need any page-specific JavaScript.

Its main feature is **spreadsheet paste with type conversion**. You can copy rows from Google Sheets or Excel and paste them into an editable grid. Dates, numbers, switches and list-of-values columns are converted to what each column expects, and columns can be matched by their header names, so the order of the spreadsheet doesn't matter.

| Command | What it does |
|---|---|
| Enable spreadsheet paste | Converts pasted spreadsheet data to each column's type, matches columns by header and can insert or append rows. |
| Refresh selected rows | Refreshes only the selected rows instead of the whole grid. |
| Refresh entire grid | Full refresh, Promise-aware. |
| Run server action on selected rows | Calls an AJAX Callback process with the primary keys of the selected rows. |
| Recalculate dependent columns | Sends the current row (including unsaved edits) to an AJAX Callback, then refreshes that row. |

## Requirements

- Oracle APEX **26.1 or later**. The export can't be imported into earlier versions.
- An Interactive Grid. The paste command needs an **editable** one.
- No database objects, grants or extra files: the JavaScript and CSS ship inside the plug-in.

## Compatibility

| APEX version | Status |
|---|---|
| 26.1 | Tested |
| 26.2 | Tested |

Native clipboard paste was introduced in APEX 26.1. Spreadsheet paste builds on it and relies partly on **private Interactive Grid internals** that are not part of Oracle's documented JavaScript API: `grid._paste`, `grid._getColumnMetadata`, `grid.afterInsertCallback`, `grid._setCurrentRow`, `grid.lastRow$` and APEX's internal clipboard format (`web application/x-apex-grid+json`). Oracle can change them in any release, so **regression-test the paste command after every APEX upgrade** (see [Regression checklist](#regression-checklist)). If `_paste` or `_getColumnMetadata` is missing, the plug-in logs an error and leaves the native paste untouched. The other commands use only the public API.

### When to use spreadsheet paste, and when to use Data Loading

Use IG PowerTools when users paste a manageable number of rows (tens to a few hundred) directly into an editable grid they are already working in. Use APEX **Native Data Loading** (CSV, XLSX, XML or JSON, with preview, column mapping, transformations, lookups and error handling) or a staged import process when you need large volumes, repeatable imports, reconciliation, auditability, complex transformations or controlled batch processing. The grid keeps every pasted row in the browser until the user saves, and the server still validates every row on save.

## Installation

1. In App Builder, go to **Import**.
2. Choose `dist/dynamic_action_plugin_ig_powertools.sql`, set File Type to **Plug-in**, and click Next.
3. Pick the target application and click **Install**.

To upgrade, import the new version into the same application and accept the replacement. Existing Dynamic Actions are kept.

## Commands

Each IG PowerTools action performs one command. To add one:

1. Create a Dynamic Action and add the action **IG PowerTools**.
2. Set **Affected Elements** to *Region* and select the Interactive Grid.
3. Pick a **Command** and fill in its attributes. App Builder shows only the attributes that apply to the selected command.

| Command | Typical event | Attributes | What the application provides |
|---|---|---|---|
| [Enable spreadsheet paste](#enable-spreadsheet-paste) | Page Load (once) | Source date format, Source number format, Reject paste on conversion errors, Paste mode | An editable grid |
| [Refresh selected rows](#refresh-selected-rows) | Button click, Dialog Closed | None | Nothing |
| [Refresh entire grid](#refresh-entire-grid) | Button click | None | Nothing |
| [Run server action on selected rows](#run-server-action-on-selected-rows) | Button click | Server action / process name, Preserve selection after refresh | An AJAX Callback process |
| [Recalculate dependent columns](#recalculate-dependent-columns) | Button click, Change | Server action / process name, Target columns | An AJAX Callback process |

### Enable spreadsheet paste

Turns the grid's native paste into a spreadsheet-aware paste: values are converted to each column's type, columns can be matched by header, and rows can be inserted or appended. Run it once, on Page Load. Nothing changes visually; the next paste into the grid uses it. See [Spreadsheet paste](#spreadsheet-paste) for the full behaviour.

| Attribute | Default | Description |
|---|---|---|
| Source date format | `MM/DD/YYYY` | Date format of the spreadsheet the data comes from, e.g. `MM/DD/YYYY` for a US-locale sheet or `DD/MM/YYYY` for a European one. Used only for ambiguous values: ISO dates are always recognised, and a value such as `23/09/2026` settles the order for the whole column. |
| Source number format | `1,234.56 (decimal point)` | `1,234.56` or `1.234,56`. Used only for ambiguous values such as `1,234`; a value like `1,5` or `1.234,56` settles the separator for the whole column. Numbers are always written in the session's own format. |
| Reject paste on conversion errors | No | *No*: convertible values are pasted, and the rest are pasted as they are and flagged by the grid. *Yes*: if any value can't be converted, nothing is pasted and the offending cells are listed. |
| Paste mode | Replace existing rows | *Replace existing rows*: native behaviour. *Insert below the current row*: every tabular paste adds new rows below the current row. *Append after the last row*: every tabular paste adds new rows after the last loaded row. See [Paste mode](#spreadsheet-paste). |

### Refresh selected rows

Reloads only the selected rows from the database, through the grid's native *selection-refresh* action, instead of reloading the whole grid. Use it, for example, on **Dialog Closed** after a modal page edits the current row, or after a process changes a few rows.

Every selected row is refreshed, whether one or many. If the native action isn't available in the grid, the plug-in falls back to a full refresh.

No attributes.

### Refresh entire grid

Refreshes the whole grid with the region's native `refresh()`. When that call returns a Promise, success or failure is written to the debug log. This is also the default command, and the plug-in falls back to it for an unknown command value.

No attributes.

### Run server action on selected rows

Calls an AJAX Callback process with the primary keys of the selected rows, then refreshes the grid. Use it for bulk actions such as approve, validate or mark as done. The process contract and an example are in [Server-side contracts](#run-server-action-on-selected-rows-1).

| Attribute | Default | Description |
|---|---|---|
| Server action / process name | — | Name of the AJAX Callback process to call, on the page or at application level. You write that process; the plug-in contains no application-specific PL/SQL. If it is empty, nothing runs and an error is logged. |
| Preserve selection after refresh | Yes | *Yes*: after the process finishes, only the selected rows are refreshed and stay selected. *No*: the whole grid is refreshed and the selection is lost. Choose *No* when the process can add, delete or reorder rows. |

If no row is selected, the user sees *Select at least one row first.* and nothing is sent. While the process runs, the region is marked busy. If the process returns `{"message": "..."}`, that text is shown as a success message; if it fails, its error is shown as a page error.

### Recalculate dependent columns

Sends the selected row, including the user's unsaved edits, to an AJAX Callback process that recalculates and saves values derived from it, then reloads that row from the database. Use it, for example, on **Change** of a column whose value drives other columns. The process contract and an example are in [Server-side contracts](#recalculate-dependent-columns-1).

| Attribute | Default | Description |
|---|---|---|
| Server action / process name | — | Name of the AJAX Callback process that recalculates the row. It receives the record id in `x01` and the row's current values in `x02`, and must **persist** the result, because the row is then reloaded from the database. |
| Target columns | — | Required. Comma-separated names of the columns the process recalculates, e.g. `PRIORITY_LABEL,DUE_DATE`. In this version it documents the intent only: the plug-in always reloads the whole row. |

The command uses the first selected row. If no row is selected, or if the process fails, nothing changes on the page and the reason is written to the debug log (see [Diagnostics](#diagnostics)).

## Spreadsheet paste

The command runs once on Page Load and enhances the grid's native paste. It works with every way of pasting: Ctrl+V, Ctrl+Shift+V, and Paste or Paste Insert from the Actions menu. Before APEX writes the cells, each value is converted for its target column:

| Column | Accepted input | Written as |
|---|---|---|
| Date / Timestamp | ISO (`2026-11-16`, `2026-11-16 09:30`), numeric (`16/11/2026`, `11/16/2026 9:30 PM`), any format `apex.date.parse` understands with the *Source date format* | The column's format mask |
| Number | `1,234.56`, `1.234,56`, `1 234,56`, `1'234.56`, `$1,200`, `USD 10`, `10 EUR`, `(300)`, `300-`, `15%`, `-15%` | The session's number format, unrounded |
| Switch | `TRUE`/`FALSE`, `Yes`/`No`, `Sí`/`No`, `1`/`0`, `x`, `on`/`off`, the switch's own labels | The switch's on/off value |
| Select List | Display text or return value, case-insensitive | Return value |
| Popup LOV | Display text or return value, case-insensitive (looked up on the server) | Return value, with its display text |
| Textarea | Cells containing line breaks | Line breaks are kept (other columns get a space) |

**Ambiguous dates and numbers.** The plug-in looks at every value in a pasted column before converting any of them. If one value can only be read one way, that reading applies to the whole column. For example, `23/09/2026` settles the day/month order, and `1.234,56` settles the decimal separator. The *Source date format* and *Source number format* attributes are used only when the data proves nothing either way. The plug-in does not leave unresolved ambiguity unreported: values that still can't be converted are pasted as they are and flagged.

**Date and number details.**

| Input | Behaviour |
|---|---|
| Timestamps | Hours, minutes and seconds (24-hour or AM/PM) are kept. Fractional seconds are not parsed by the plug-in; they are passed to `apex.date.parse`, which doesn't support `FF`, so they are flagged. |
| Time zones | Offsets such as `Z` or `+02:00` are not interpreted (`apex.date.parse` doesn't support `TZH`/`TZR`), so such values are flagged. Converted values are built in the browser's local time and written with the column's format mask. |
| Excel serial dates (`46311`) | Not recognised as dates. Copy cells that are formatted as dates; the clipboard carries the formatted text. |
| Month names (`15-OCT-2026`) | Parsed by `apex.date.parse` with the *Source date format* (e.g. `DD-MON-YYYY`), in English or in the application's current language. |
| Mixed formats in one column | If a column contains evidence for both readings (`23/09/2026` and `09/23/2026`, or `1.234,56` and `1,234.56`), the source format attribute decides, and values that contradict it are flagged. They are never silently swapped. |
| Non-breaking and narrow spaces, apostrophes | Accepted as group separators (`1 234,56`, `1'234.56`). |
| Currency | Symbols anywhere (`$`, `€`, `£`…) and ISO codes separated by a space (`USD 10`, `10 EUR`). `USD10` is flagged. |
| Negatives and percentages | `-15%`, `(15%)` and `15%-` all become `-0.15`. A percentage is divided by 100: `15%` becomes 0.15, the numeric value the percentage represents. |

**Header mapping.** If the first pasted row names at least two grid columns, columns are matched by name instead of by position. Names can come from the column heading, label or column name, and the match ignores case, accents and punctuation. Unknown or read-only columns are skipped, and columns the spreadsheet doesn't contain are left untouched.

**Paste mode.**

| Mode | Behaviour |
|---|---|
| Replace existing rows (default) | Native behaviour: Ctrl+V overwrites from the current row, and Ctrl+Shift+V inserts below it. |
| Insert below the current row | Every tabular paste adds new rows below the current row. |
| Append after the last row | Every tabular paste adds new rows after the last loaded row, wherever the cursor is. |

A single value always goes to the current cell. The insert modes do nothing, and show an error, if the grid doesn't allow adding rows.

**Popup LOV lookup.** Popup LOV values are resolved on the server by a read-only Ajax callback. Per column, the plug-in sends the distinct pasted values (up to 1,000) and gets back the matching return/display pairs.

- A pasted value matches an entry's display value or return value, ignoring case and repeated spaces.
- If one pasted value matches entries with **different return values** (duplicate display values, or a value that is one entry's display and another's return), it is rejected as **ambiguous** and flagged. The plug-in never picks the first match.
- The LOV query runs through `APEX_EXEC` in the current user's session. Bind variables that refer to application or page items (`:APP_USER`, `:P1_DEPT`) take their values from session state, so user-filtered LOVs only return what the user may see. Pasted values are never concatenated into SQL.
- **Cascading LOVs**, and LOVs whose query refers to other columns of the same row, are not supported. The row's values are not in session state, so the query sees those binds as empty: values are then usually not found, and are flagged. Don't rely on spreadsheet paste for such columns.
- Only the first 1,000 distinct values of a column are looked up; the rest are flagged as not converted. The LOV query reads at most 100,000 rows.

**Conversion errors.** Values that can't be converted are pasted as they are and flagged by the grid. If *Reject paste on conversion errors* is enabled, nothing is pasted and the offending cells are listed instead. After every paste, a summary like `8 row(s) inserted · 46 value(s) converted · matched by header: …` is shown.

The command's attributes are described in [Enable spreadsheet paste](#enable-spreadsheet-paste).

## Server-side contracts

### Run server action on selected rows

The plug-in calls the AJAX Callback process named in *Server action / process name*. `x01` holds a JSON array with the primary keys of the selected rows. If the process returns `{"message": "..."}`, that text is shown as a success message. Afterwards the plug-in refreshes either the selected rows or the whole grid, depending on *Preserve selection after refresh*.

```sql
declare
    l_ids   apex_t_number;
    l_count pls_integer;
begin
    select id
      bulk collect into l_ids
      from json_table(apex_application.g_x01, '$[*]' columns (id number path '$'));

    update tasks
       set status = 'DONE'
     where id in (select column_value from table(l_ids))
       and owner = :APP_USER;

    l_count := sql%rowcount;

    apex_json.open_object;
    apex_json.write('message', l_count || ' task(s) marked as done');
    apex_json.close_object;
end;
```

`x01` comes from the browser, so the process must apply its own authorization filter.

`x01` is a scalar parameter limited to 32,767 bytes. That is enough for a few thousand numeric keys, but not for very large selections or long composite keys. For bulk operations over many rows, use a dedicated process (for example `apex.server.process` with `f01` arrays, `p_json` or `apex.server.chunk`) or a batch job instead of this command.

### Recalculate dependent columns

The process receives two values:
- `x01`: the row's record id.
- `x02`: a JSON object `{COLUMN: value}` with the row as the user currently sees it, unsaved edits included. For list-of-values columns, it holds the return value.

When the process finishes, the plug-in refreshes the row from the database. So the process has to calculate from `x02` and **persist** the result.

```sql
declare
    l_id       number := to_number(replace(apex_application.g_x01, '"', ''));
    l_priority number := to_number(json_value(apex_application.g_x02, '$.PRIORITY'));
begin
    update tasks
       set priority       = l_priority
         , priority_label = case when l_priority >= 4 then 'High' else 'Normal' end
     where id = l_id
       and owner = :APP_USER;

    if sql%rowcount = 0 then
        raise_application_error(-20001, 'Save the new row before recalculating it');
    end if;
end;
```

## Security

- The Popup LOV lookup is read-only. The plug-in reads the LOV definition from the APEX dictionary, and only for a Popup LOV column of the region the Dynamic Action targets. That region id comes from the server-side definition, never from the browser. Pasted values are compared in PL/SQL and never concatenated into SQL.
- Clipboard HTML is parsed in an inert document and read as text only. It is never inserted into the page.
- Messages are HTML-escaped.

## Demo application

The `demo` folder contains a one-page application with an employees grid (10 editable columns) and a CSV to paste into it:

1. Run `demo/setup_employees.sql` in the application's parsing schema. It creates and fills `IGPT_DEMO_EMPLOYEES`.
2. Import `demo/ig_powertools_demo_app.sql` through App Builder (**Import**, File Type *Application*). The plug-in is included in the import.
3. Import `demo/new_hires.csv` into Google Sheets with **File → Import**. Untick *Convert text to numbers, dates and formulas* so the values keep their original formatting.
4. Copy the sheet, including the header row. In the demo page, click any cell, press Ctrl+V and click **Save**.

The CSV is deliberately messy:
- Its columns are in a different order and include an extra *Badge ID* column.
- Dates are `DD/MM/YYYY`, and numbers use a decimal comma (`115.000,00`, `37,5`).
- Remote is `Yes`/`No`.
- Departments and managers are given by name, one of them in lowercase.

The demo page uses *Append after the last row*, so the new hires are added at the end of the grid. To run the demo again, run `demo/reset_employees.sql`, which deletes the pasted rows.

## Diagnostics

All log messages go through `apex.debug` with the prefix `[IgPowerTools]`, so production pages only show errors. To see details such as matched columns, pasted rows, or why a paste was left to the native grid, enable APEX debug: use the Developer Toolbar, or run `apex.debug.setLevel(4)` in the browser console.

## Limitations

- Spreadsheet paste relies on private Interactive Grid internals (see [Compatibility](#compatibility)). If a future APEX version removes `_paste` or `_getColumnMetadata`, the plug-in logs an error and native paste keeps working without conversion.
- Header-mapped pastes and pastes involving Popup LOV columns are written through the model API. In those cases column-level Dynamic Actions and client-side item validations don't run; server-side validation still applies when saving.
- While writing through the model, the plug-in temporarily replaces the grid's private `afterInsertCallback`. Otherwise the grid would select each new row and enter edit mode, overwriting the values just written. The grid calls this hook once per inserted row, synchronously, or about 1 ms later when the grid was empty. The plug-in counts those calls and restores the original hook as soon as all of them have arrived. If the grid never calls it (for example, for a row that isn't rendered), the original is restored after 1 second.
- Cascading LOVs, LOVs that depend on other columns of the row, and remote or REST LOVs aren't supported by the Popup LOV lookup.
- *Append* inserts after the last **loaded** row. With scroll pagination, that may not be the end of the data.
- Tested with Google Sheets in Firefox. Not tested with desktop Excel.

## Regression checklist

Run it after every APEX upgrade, and before using a new version of the plug-in in production. Test in each browser your users have.

| Area | Cases |
|---|---|
| Volume | 1, 10, 100 and 500 rows |
| Paste mode | Replace, Insert, Append; Ctrl+V, Ctrl+Shift+V and the Actions menu |
| Write path | By position without Popup LOVs (native engine), by header, and with a Popup LOV column (model API) |
| Starting point | A grid with rows, and an empty grid |
| Columns | Ambiguous day/month dates, numbers in both locales, switches, Select Lists, a Popup LOV with an ambiguous display value, Textarea with line breaks |
| Page | Columns with Dynamic Actions on change |
| Result | Every row holds the pasted values (no row repeats the first row, no value is replaced by the grid), and saving passes server validation |

## Project structure

```
src/        APEXlang source: plugin.apx, custom-attributes.apx, static-files/
dist/       Plug-in export, ready to import
demo/       Demo application, setup and reset scripts, sample CSV
tests/      Unit tests for the paste conversion logic
```

Run the tests with Node.js; no dependencies are needed:

```
node tests/paste-conversion.test.js
```

## Authors and support

IG PowerTools is created and maintained by [Waykitech](https://github.com/Waykitech).
Report bugs and request features through [GitHub issues](https://github.com/Waykitech/IG-PowerTools/issues).
For other questions, contact info@waykitech.com.

## License

[MIT](LICENSE). Copyright (c) 2026 Waykitech.

The JavaScript and CSS files begin with a one-line license banner (`/*! ... */`). Keep it when you copy or minify the files, as the MIT License requires the copyright notice to be preserved.
