prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2026.03.30'
,p_release=>'26.1.0'
,p_default_workspace_id=>5401991925201113
,p_default_application_id=>105
,p_default_id_offset=>0
,p_default_owner=>'CVS_APP'
);
end;
/
 
prompt APPLICATION 105 - Test
--
-- Application Export:
--   Application:     105
--   Name:            Test
--   Exported By:     SYSTEM
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 17837415176462497
--   Manifest End
--   Version:         26.1.0
--   Instance ID:     2400112968643822
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/dynamic_action/ig_powertools
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(17837415176462497)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'IG_POWERTOOLS'
,p_display_name=>'IG PowerTools'
,p_apexlang_name=>'igPowerTools'
,p_category=>'EXECUTE'
,p_javascript_file_urls=>'#PLUGIN_FILES#ig-powertools.js'
,p_css_file_urls=>'#PLUGIN_FILES#ig-powertools.css'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PROCEDURE render (',
'    p_dynamic_action IN apex_plugin.t_dynamic_action,',
'    p_plugin         IN apex_plugin.t_plugin,',
'    p_param          IN apex_plugin.t_dynamic_action_render_param,',
'    p_result         IN OUT NOCOPY apex_plugin.t_dynamic_action_render_result',
')',
'IS',
'    l_command         VARCHAR2(40);',
'    l_action          VARCHAR2(255);',
'    l_preserve        BOOLEAN;',
'    l_columns         VARCHAR2(4000);',
'    l_source_date_fmt VARCHAR2(100);',
'    l_source_decimal  VARCHAR2(10);',
'    l_reject_errors   BOOLEAN;',
'    l_paste_mode      VARCHAR2(10);',
'    l_column_meta     CLOB;',
'BEGIN',
'',
'    l_command :=',
'        UPPER(',
'            p_dynamic_action.attributes.get_varchar2(',
'                ''command'',',
'                ''REFRESH_GRID''',
'            )',
'        );',
'',
'    IF l_command NOT IN (',
'        ''REFRESH_SELECTED'', ''REFRESH_GRID''',
'      , ''SELECTED_ACTION'', ''DEPENDENT_COLUMN_REFRESH''',
'      , ''SPREADSHEET_PASTE''',
'    ) THEN',
'        l_command := ''REFRESH_GRID'';',
'    END IF;',
'',
'    l_action :=',
'        p_dynamic_action.attributes.get_varchar2(',
'            ''server-action-name''',
'        );',
'',
'    l_preserve :=',
'        p_dynamic_action.attributes.get_boolean(',
'            ''preserve-selection'',',
'            TRUE',
'        );',
'',
'    l_columns :=',
'        p_dynamic_action.attributes.get_varchar2(',
'            ''target-columns''',
'        );',
'',
'    l_source_date_fmt :=',
'        p_dynamic_action.attributes.get_varchar2(',
'            ''source-date-format'',',
'            ''MM/DD/YYYY''',
'        );',
'',
'    l_source_decimal :=',
'        p_dynamic_action.attributes.get_varchar2(',
'            ''source-decimal-separator'',',
'            ''DOT''',
'        );',
'',
'    l_reject_errors :=',
'        p_dynamic_action.attributes.get_boolean(',
'            ''reject-on-errors'',',
'            FALSE',
'        );',
'',
'    l_paste_mode :=',
'        UPPER(',
'            p_dynamic_action.attributes.get_varchar2(',
'                ''paste-mode'',',
'                ''REPLACE''',
'            )',
'        );',
'',
'    IF l_paste_mode NOT IN (''REPLACE'', ''INSERT'', ''APPEND'') THEN',
'        l_paste_mode := ''REPLACE'';',
'    END IF;',
'',
'    IF l_command = ''SPREADSHEET_PASTE'' THEN',
'        p_result.ajax_identifier := apex_plugin.get_ajax_identifier;',
'    END IF;',
'',
'    IF l_command = ''SPREADSHEET_PASTE''',
'       AND p_dynamic_action.affected_region_id IS NOT NULL',
'    THEN',
'        SELECT json_objectagg(',
'                   KEY name',
'                   VALUE json_object(',
'                       ''dataType''   VALUE data_type,',
'                       ''itemType''   VALUE item_type,',
'                       ''formatMask'' VALUE format_mask',
'                   )',
'                   RETURNING CLOB',
'               )',
'          INTO l_column_meta',
'          FROM apex_appl_page_ig_columns',
'         WHERE application_id = apex_application.g_flow_id',
'           AND region_id      = p_dynamic_action.affected_region_id;',
'    END IF;',
'',
'    p_result.function_name := ''master.igPowerTools.run'';',
'',
'    p_result.function_param.open_object;',
'    p_result.function_param.put(''command'', l_command);',
'    p_result.function_param.put(''actionName'', l_action);',
'    p_result.function_param.put(''preserveSelection'', l_preserve);',
'    p_result.function_param.put(''targetColumns'', l_columns);',
'    p_result.function_param.put(''sourceDateFormat'', l_source_date_fmt);',
'    p_result.function_param.put(''sourceDecimalSeparator'', l_source_decimal);',
'    p_result.function_param.put(''rejectOnErrors'', l_reject_errors);',
'    p_result.function_param.put(''pasteMode'', l_paste_mode);',
'    p_result.function_param.put(''ajaxIdentifier'', p_result.ajax_identifier);',
'    p_result.function_param.put(''columnMeta'', dbms_lob.substr(l_column_meta, 32767, 1));',
'    p_result.function_param.close_object;',
'',
'END;',
'',
'PROCEDURE ajax_lov_lookup (',
'    p_dynamic_action IN apex_plugin.t_dynamic_action,',
'    p_plugin         IN apex_plugin.t_plugin,',
'    p_param          IN apex_plugin.t_dynamic_action_ajax_param,',
'    p_result         IN OUT NOCOPY apex_plugin.t_dynamic_action_ajax_result',
')',
'IS',
'    c_max_values CONSTANT PLS_INTEGER := 1000;',
'    c_max_rows   CONSTANT PLS_INTEGER := 100000;',
'',
'    TYPE t_map IS TABLE OF VARCHAR2(4000) INDEX BY VARCHAR2(4000);',
'',
'    l_column      VARCHAR2(128) := UPPER(apex_application.g_x01);',
'    l_lov_type    VARCHAR2(30);',
'    l_lov_id      NUMBER;',
'    l_lov_source  VARCHAR2(32767);',
'    l_unsupported VARCHAR2(200);',
'    l_wanted      t_map;',
'    l_found_r     t_map;',
'    l_found_d     t_map;',
'    l_ambiguous   t_map;',
'    l_key         VARCHAR2(4000);',
'    l_value       VARCHAR2(4000);',
'    l_context     apex_exec.t_context;',
'',
'    FUNCTION norm (p_value IN VARCHAR2) RETURN VARCHAR2 IS',
'    BEGIN',
'        RETURN LOWER(TRIM(REGEXP_REPLACE(p_value, ''[[:space:]]+'', '' '')));',
'    END norm;',
'',
'    PROCEDURE consider (p_display IN VARCHAR2, p_return IN VARCHAR2) IS',
'        l_k VARCHAR2(4000);',
'    BEGIN',
'        FOR i IN 1 .. 2 LOOP',
'            l_k := norm(CASE i WHEN 1 THEN p_display ELSE p_return END);',
'            IF l_k IS NOT NULL AND l_wanted.EXISTS(l_k) THEN',
'                IF NOT l_found_r.EXISTS(l_k) THEN',
'                    l_found_r(l_k) := p_return;',
'                    l_found_d(l_k) := p_display;',
'                ELSIF NVL(l_found_r(l_k), CHR(0)) <> NVL(p_return, CHR(0)) THEN',
'                    l_ambiguous(l_k) := p_return;',
'                END IF;',
'            END IF;',
'        END LOOP;',
'    END consider;',
'',
'    PROCEDURE consider_static (p_static IN VARCHAR2) IS',
'        l_entries apex_t_varchar2;',
'        l_pair    apex_t_varchar2;',
'    BEGIN',
'        l_entries := apex_string.split(SUBSTR(p_static, INSTR(p_static, '':'') + 1), '','');',
'        FOR i IN 1 .. l_entries.COUNT LOOP',
'            l_pair := apex_string.split(l_entries(i), '';'');',
'            consider(l_pair(1), CASE WHEN l_pair.COUNT > 1 THEN l_pair(2) ELSE l_pair(1) END);',
'        END LOOP;',
'    END consider_static;',
'',
'    PROCEDURE consider_query (p_sql IN VARCHAR2) IS',
'    BEGIN',
'        l_context := apex_exec.open_query_context(',
'            p_location  => apex_exec.c_location_local_db,',
'            p_sql_query => p_sql,',
'            p_max_rows  => c_max_rows',
'        );',
'        WHILE apex_exec.next_row(l_context) LOOP',
'            consider(apex_exec.get_varchar2(l_context, 1), apex_exec.get_varchar2(l_context, 2));',
'        END LOOP;',
'        apex_exec.close(l_context);',
'    EXCEPTION',
'        WHEN OTHERS THEN',
'            apex_exec.close(l_context);',
'            RAISE;',
'    END consider_query;',
'',
'    PROCEDURE consider_shared_lov (p_lov_id IN NUMBER) IS',
'    BEGIN',
'        FOR l IN (',
'            SELECT lov_type, source_type_code, location_code, list_of_values_query,',
'                   table_owner, table_name, where_clause,',
'                   return_column_name, display_column_name',
'              FROM apex_application_lovs',
'             WHERE application_id = apex_application.g_flow_id',
'               AND lov_id         = p_lov_id',
'        ) LOOP',
'            IF l.lov_type = ''Static'' THEN',
'                FOR e IN (',
'                    SELECT display_value, return_value',
'                      FROM apex_application_lov_entries',
'                     WHERE application_id = apex_application.g_flow_id',
'                       AND lov_id         = p_lov_id',
'                ) LOOP',
'                    consider(e.display_value, e.return_value);',
'                END LOOP;',
'            ELSIF l.location_code <> ''LOCAL'' THEN',
'                l_unsupported := ''shared LOV location '' || l.location_code;',
'            ELSIF l.source_type_code = ''LEGACY_SQL'' THEN',
'                consider_query(l.list_of_values_query);',
'            ELSIF l.source_type_code = ''SQL'' THEN',
'                consider_query(',
'                    ''select '' || dbms_assert.enquote_name(l.display_column_name, FALSE)',
'                    || '', '' || dbms_assert.enquote_name(l.return_column_name, FALSE)',
'                    || '' from ('' || l.list_of_values_query || '')''',
'                );',
'            ELSIF l.source_type_code = ''TABLE'' THEN',
'                consider_query(',
'                    ''select '' || dbms_assert.enquote_name(l.display_column_name, FALSE)',
'                    || '', '' || dbms_assert.enquote_name(l.return_column_name, FALSE)',
'                    || '' from ''',
'                    || CASE WHEN l.table_owner IS NOT NULL',
'                            THEN dbms_assert.enquote_name(l.table_owner, FALSE) || ''.'' END',
'                    || dbms_assert.enquote_name(l.table_name, FALSE)',
'                    || CASE WHEN l.where_clause IS NOT NULL',
'                            THEN '' where '' || l.where_clause END',
'                );',
'            ELSE',
'                l_unsupported := ''shared LOV source type '' || l.source_type_code;',
'            END IF;',
'        END LOOP;',
'    END consider_shared_lov;',
'',
'BEGIN',
'    FOR i IN 1 .. LEAST(apex_application.g_f01.COUNT, c_max_values) LOOP',
'        l_key := norm(SUBSTR(apex_application.g_f01(i), 1, 4000));',
'        IF l_key IS NOT NULL THEN',
'            l_wanted(l_key) := l_key;',
'        END IF;',
'    END LOOP;',
'',
'    BEGIN',
'        SELECT lov_type_code, lov_id, lov_source',
'          INTO l_lov_type, l_lov_id, l_lov_source',
'          FROM apex_appl_page_ig_columns',
'         WHERE application_id = apex_application.g_flow_id',
'           AND region_id      = p_dynamic_action.affected_region_id',
'           AND name           = l_column',
'           AND item_type      = ''NATIVE_POPUP_LOV'';',
'    EXCEPTION',
'        WHEN NO_DATA_FOUND THEN',
'            l_unsupported := ''not a Popup LOV column of the target region'';',
'    END;',
'',
'    IF l_unsupported IS NULL AND l_wanted.COUNT > 0 THEN',
'        CASE l_lov_type',
'            WHEN ''SQL_QUERY'' THEN consider_query(l_lov_source);',
'            WHEN ''STATIC''    THEN consider_static(l_lov_source);',
'            WHEN ''SHARED''    THEN consider_shared_lov(l_lov_id);',
'            ELSE l_unsupported := ''LOV type '' || l_lov_type;',
'        END CASE;',
'    END IF;',
'',
'    apex_json.open_object;',
'    apex_json.open_object(''values'');',
'    FOR i IN 1 .. LEAST(apex_application.g_f01.COUNT, c_max_values) LOOP',
'        l_value := SUBSTR(apex_application.g_f01(i), 1, 4000);',
'        l_key   := norm(l_value);',
'        IF l_key IS NOT NULL',
'           AND l_found_r.EXISTS(l_key)',
'           AND NOT l_ambiguous.EXISTS(l_key)',
'        THEN',
'            apex_json.open_object(l_value);',
'            apex_json.write(''r'', l_found_r(l_key));',
'            apex_json.write(''d'', l_found_d(l_key));',
'            apex_json.close_object;',
'        END IF;',
'    END LOOP;',
'    apex_json.close_object;',
'    apex_json.open_array(''ambiguous'');',
'    FOR i IN 1 .. LEAST(apex_application.g_f01.COUNT, c_max_values) LOOP',
'        l_value := SUBSTR(apex_application.g_f01(i), 1, 4000);',
'        l_key   := norm(l_value);',
'        IF l_key IS NOT NULL AND l_ambiguous.EXISTS(l_key) THEN',
'            apex_json.write(l_value);',
'        END IF;',
'    END LOOP;',
'    apex_json.close_array;',
'    IF l_unsupported IS NOT NULL THEN',
'        apex_json.write(''unsupported'', l_unsupported);',
'    END IF;',
'    apex_json.close_object;',
'END ajax_lov_lookup;',
''))
,p_api_version=>3
,p_render_function=>'render'
,p_ajax_function=>'ajax_lov_lookup'
,p_standard_attributes=>'REGION:REQUIRED:STOP_EXECUTION_ON_ERROR'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Declarative Interactive Grid operations (spreadsheet paste with type conversion, refresh of the selected rows, server actions on the selection, dependent columns) as a single reusable Dynamic Action step. Add it as an action inside any Dynamic Action'
||', with Affected Elements set to the target Interactive Grid''s region.',
'',
'Created and maintained by Waykitech. Released under the MIT License. Source code, documentation and issues: https://github.com/Waykitech/IG-PowerTools. Contact: info@waykitech.com.'))
,p_version_identifier=>'1.12'
,p_about_url=>'https://github.com/Waykitech/IG-PowerTools'
,p_files_version=>2461356173916
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(17885156461562960)
,p_plugin_id=>wwv_flow_imp.id(17837415176462497)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'command'
,p_prompt=>'Command'
,p_apexlang_name=>'command'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'REFRESH_GRID'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Which Interactive Grid operation this action step performs. Affected Elements must target the grid''s region.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(17885676821562960)
,p_plugin_attribute_id=>wwv_flow_imp.id(17885156461562960)
,p_display_sequence=>50
,p_display_value=>'Recalculate dependent columns'
,p_return_value=>'DEPENDENT_COLUMN_REFRESH'
,p_apexlang_name=>'dependentColumnRefresh'
,p_help_text=>'Calls a named AJAX Callback process for the selected row, then surgically refreshes that row. The process receives x01 = the row''s record id and x02 = a JSON object with the row''s current values as shown in the grid (including unsaved edits); it must'
||' calculate from x02 and persist the result, because the refresh reloads the row from the database.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(17885425319562960)
,p_plugin_attribute_id=>wwv_flow_imp.id(17885156461562960)
,p_display_sequence=>30
,p_display_value=>'Refresh entire grid'
,p_return_value=>'REFRESH_GRID'
,p_apexlang_name=>'refreshGrid'
,p_help_text=>'Full grid refresh via the region''s native refresh call. Use as a safe fallback when a surgical refresh does not apply.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(17885360560562960)
,p_plugin_attribute_id=>wwv_flow_imp.id(17885156461562960)
,p_display_sequence=>20
,p_display_value=>'Refresh selected rows'
,p_return_value=>'REFRESH_SELECTED'
,p_apexlang_name=>'refreshSelected'
,p_help_text=>'Reloads only the selected rows from the database via the native "selection-refresh" action, without reloading the whole grid. Falls back to a full refresh if that action is not available.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(17885512625562960)
,p_plugin_attribute_id=>wwv_flow_imp.id(17885156461562960)
,p_display_sequence=>40
,p_display_value=>'Run server action on selected rows'
,p_return_value=>'SELECTED_ACTION'
,p_apexlang_name=>'selectedAction'
,p_help_text=>'Calls a named AJAX Callback process, created by you on the page, with the primary keys of the selected rows. Use for bulk validate, approve, bulk update, etc.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(19044734523360382)
,p_plugin_attribute_id=>wwv_flow_imp.id(17885156461562960)
,p_display_sequence=>70
,p_display_value=>'Enable spreadsheet paste, with type conversion'
,p_return_value=>'SPREADSHEET_PASTE'
,p_apexlang_name=>'spreadsheetPaste'
,p_help_text=>'Run once on Page Load, with Affected Elements = an editable Interactive Grid. Converts spreadsheet data pasted into the grid (Ctrl+V, Ctrl+Shift+V, Actions menu Paste / Paste Insert) to each column''s type before it is written: dates to the column for'
||'mat mask, numbers to the session format, switch values (TRUE/FALSE, Yes/No...) and select list / Popup LOV display values to return values. If the first pasted row is a header naming grid columns, columns are matched by name instead of by position.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(19650761945068393)
,p_plugin_id=>wwv_flow_imp.id(17837415176462497)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_static_id=>'paste-mode'
,p_prompt=>'Paste mode'
,p_apexlang_name=>'pasteMode'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'REPLACE'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(17885156461562960)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'SPREADSHEET_PASTE'
,p_lov_type=>'STATIC'
,p_help_text=>'Where pasted spreadsheet rows go. Replace existing rows: native behaviour, Ctrl+V overwrites from the current row and Ctrl+Shift+V or Actions > Paste Insert insert new rows below it. Insert below the current row: every paste of two or more cells adds'
||' new rows below the current row. Append after the last row: every paste of two or more cells adds new rows after the last loaded row, wherever the current cell is; with scroll pagination this is the last row loaded so far, not necessarily the end of '
||'the data. A single value is always pasted into the current cell. Insert modes need a grid that allows adding rows; otherwise nothing is pasted.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(19651060704068393)
,p_plugin_attribute_id=>wwv_flow_imp.id(19650761945068393)
,p_display_sequence=>30
,p_display_value=>'Append after the last row'
,p_return_value=>'APPEND'
,p_apexlang_name=>'append'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(19650932810068393)
,p_plugin_attribute_id=>wwv_flow_imp.id(19650761945068393)
,p_display_sequence=>20
,p_display_value=>'Insert below the current row'
,p_return_value=>'INSERT'
,p_apexlang_name=>'insert'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(19650840828068393)
,p_plugin_attribute_id=>wwv_flow_imp.id(19650761945068393)
,p_display_sequence=>10
,p_display_value=>'Replace existing rows'
,p_return_value=>'REPLACE'
,p_apexlang_name=>'replace'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(17885965132562961)
,p_plugin_id=>wwv_flow_imp.id(17837415176462497)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_static_id=>'preserve-selection'
,p_prompt=>'Preserve selection after refresh'
,p_apexlang_name=>'preserveSelection'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(17885156461562960)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'REFRESH_SELECTED,SELECTED_ACTION'
,p_help_text=>'When enabled, refreshes via the native "selection-refresh" action so the current selection is kept. When disabled, performs a full grid refresh and the selection is lost.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(19058046914542680)
,p_plugin_id=>wwv_flow_imp.id(17837415176462497)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_static_id=>'reject-on-errors'
,p_prompt=>'Reject paste on conversion errors'
,p_apexlang_name=>'rejectOnErrors'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(17885156461562960)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'SPREADSHEET_PASTE'
,p_help_text=>'When enabled, the whole paste is cancelled if any value cannot be converted, and an error lists the offending cells. When disabled (default), convertible values are pasted and the rest are left as-is so the grid flags them.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(17885827325562960)
,p_plugin_id=>wwv_flow_imp.id(17837415176462497)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'server-action-name'
,p_prompt=>'Server action / process name'
,p_apexlang_name=>'serverActionName'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(17885156461562960)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'SELECTED_ACTION,DEPENDENT_COLUMN_REFRESH'
,p_help_text=>'Static name of the page/application "AJAX Callback" process to invoke. Applies to Run server action and Recalculate dependent columns. This plugin never contains app-specific PL/SQL; you author that process yourself.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(19044884538360382)
,p_plugin_id=>wwv_flow_imp.id(17837415176462497)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'source-date-format'
,p_prompt=>'Source date format'
,p_apexlang_name=>'sourceDateFormat'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'MM/DD/YYYY'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(17885156461562960)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'SPREADSHEET_PASTE'
,p_help_text=>'Date format used by the spreadsheet the data is copied from, for example MM/DD/YYYY for a US-locale Google Sheet or DD/MM/YYYY for a Spanish one. Used for ambiguous values only: ISO dates (2026-10-15) are always recognized, and when a pasted column c'
||'ontains an unambiguous value (a day greater than 12) the day/month order is inferred from the data itself.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(19054507456450357)
,p_plugin_id=>wwv_flow_imp.id(17837415176462497)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_static_id=>'source-decimal-separator'
,p_prompt=>'Source number format'
,p_apexlang_name=>'sourceDecimalSeparator'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'DOT'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(17885156461562960)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'SPREADSHEET_PASTE'
,p_lov_type=>'STATIC'
,p_help_text=>'Number format used by the spreadsheet the data is copied from. Used for ambiguous values only (1,234 or 1.234): when a pasted column contains a value that proves the decimal separator (1,5 or 1.234,56), it is inferred from the data itself. Numbers ar'
||'e written in the session''s own format.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(19054789174450357)
,p_plugin_attribute_id=>wwv_flow_imp.id(19054507456450357)
,p_display_sequence=>20
,p_display_value=>'1.234,56 (decimal comma)'
,p_return_value=>'COMMA'
,p_apexlang_name=>'comma'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(19054681731450357)
,p_plugin_attribute_id=>wwv_flow_imp.id(19054507456450357)
,p_display_sequence=>10
,p_display_value=>'1,234.56 (decimal point)'
,p_return_value=>'DOT'
,p_apexlang_name=>'dot'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(17886024280562961)
,p_plugin_id=>wwv_flow_imp.id(17837415176462497)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'target-columns'
,p_prompt=>'Target columns'
,p_apexlang_name=>'targetColumns'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(17885156461562960)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'DEPENDENT_COLUMN_REFRESH'
,p_help_text=>'Comma-separated Interactive Grid column names that the server action recalculates. The server action receives the current row (x01 = record id, x02 = JSON of the row''s current values, including unsaved edits) and must persist the recalculated values;'
||' the plugin then refreshes the row from the database so these columns show the new values.'
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A2120494720506F776572546F6F6C732076312E3132207C202863292032303236205761796B6974656368207C204D4954204C6963656E7365207C2068747470733A2F2F6769746875622E636F6D2F5761796B69746563682F49472D506F776572546F';
wwv_flow_imp.g_varchar2_table(2) := '6F6C73202A2F0A2E696770742D62757379207B0A2020637572736F723A2070726F67726573733B0A20206F7061636974793A20302E38353B0A2020706F696E7465722D6576656E74733A206E6F6E653B0A20207472616E736974696F6E3A206F70616369';
wwv_flow_imp.g_varchar2_table(3) := '747920302E31357320656173652D696E2D6F75743B0A7D0A0A406D656469612028707265666572732D726564756365642D6D6F74696F6E3A2072656475636529207B0A20202E696770742D62757379207B0A202020207472616E736974696F6E3A206E6F';
wwv_flow_imp.g_varchar2_table(4) := '6E653B0A20207D0A7D0A';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(17838617135462498)
,p_plugin_id=>wwv_flow_imp.id(17837415176462497)
,p_file_name=>'ig-powertools.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A2120494720506F776572546F6F6C732076312E3132207C202863292032303236205761796B6974656368207C204D4954204C6963656E7365207C2068747470733A2F2F6769746875622E636F6D2F5761796B69746563682F49472D506F776572546F';
wwv_flow_imp.g_varchar2_table(2) := '6F6C73202A2F0A766172206D6173746572203D206D6173746572207C7C207B7D3B0A0A6D61737465722E6967506F776572546F6F6C73203D202866756E6374696F6E286D61737465722C20242C20756E646566696E656429207B0A202027757365207374';
wwv_flow_imp.g_varchar2_table(3) := '72696374273B0A0A2020766172204D4F44554C455F4E414D45203D20274967506F776572546F6F6C73273B0A0A202076617220434F4D4D414E44203D207B0A20202020524546524553485F53454C45435445443A20202020202020202020275245465245';
wwv_flow_imp.g_varchar2_table(4) := '53485F53454C4543544544270A202020202C20524546524553485F475249443A20202020202020202020202027524546524553485F47524944270A202020202C2053454C45435445445F414354494F4E3A2020202020202020202753454C45435445445F';
wwv_flow_imp.g_varchar2_table(5) := '414354494F4E270A202020202C20444550454E44454E545F434F4C554D4E5F524546524553483A27444550454E44454E545F434F4C554D4E5F52454652455348270A202020202C2053505245414453484545545F50415354453A20202020202020275350';
wwv_flow_imp.g_varchar2_table(6) := '5245414453484545545F5041535445270A20207D3B0A0A202076617220425553595F434C415353203D2027696770742D62757379273B0A0A2020766172205F505245464958203D20275B27202B204D4F44554C455F4E414D45202B20275D273B0A0A2020';
wwv_flow_imp.g_varchar2_table(7) := '766172206C6F67676572203D207B0A202020206C6F673A2020202020202066756E6374696F6E286D73672C206461746129207B20617065782E64656275672E696E666F285F5052454649582C206D73672C2064617461207C7C202727293B207D0A202020';
wwv_flow_imp.g_varchar2_table(8) := '202C207761726E696E673A2066756E6374696F6E286D73672C206461746129207B20617065782E64656275672E7761726E285F5052454649582C206D73672C2064617461207C7C202727293B207D0A202020202C206572726F723A20202066756E637469';
wwv_flow_imp.g_varchar2_table(9) := '6F6E286D73672C206461746129207B20617065782E64656275672E6572726F72285F5052454649582C206D73672C2064617461207C7C202727293B207D0A20207D3B0A0A2020766172205F7265736F6C7665526567696F6E203D2066756E6374696F6E28';
wwv_flow_imp.g_varchar2_table(10) := '6461436F6E66696729207B0A2020202076617220656C203D206461436F6E666967202626206461436F6E6669672E6166666563746564456C656D656E7473202626206461436F6E6669672E6166666563746564456C656D656E74732E6C656E6774680A20';
wwv_flow_imp.g_varchar2_table(11) := '20202020203F206461436F6E6669672E6166666563746564456C656D656E74732E666972737428290A2020202020203A206E756C6C3B0A20202020766172207374617469634964203D20656C203F20656C2E61747472282769642729203A206E756C6C3B';
wwv_flow_imp.g_varchar2_table(12) := '0A0A202020206966202821737461746963496429207B0A2020202020206C6F676765722E6572726F722827436F756C64206E6F74207265736F6C766520612074617267657420726567696F6E2E2053657420416666656374656420456C656D656E747320';
wwv_flow_imp.g_varchar2_table(13) := '746F2074686520496E746572616374697665204772696420726567696F6E2E27293B0A20202020202072657475726E206E756C6C3B0A202020207D0A0A2020202076617220726567696F6E203D20617065782E726567696F6E287374617469634964293B';
wwv_flow_imp.g_varchar2_table(14) := '0A202020206966202821726567696F6E29207B0A2020202020206C6F676765722E6572726F722827617065782E726567696F6E282920646964206E6F742066696E64206120726567696F6E20666F7220737461746963206964272C207374617469634964';
wwv_flow_imp.g_varchar2_table(15) := '293B0A20202020202072657475726E206E756C6C3B0A202020207D0A0A2020202072657475726E207B2069643A2073746174696349642C20726567696F6E3A20726567696F6E207D3B0A20207D3B0A0A2020766172205F696E766F6B654966537570706F';
wwv_flow_imp.g_varchar2_table(16) := '72746564203D2066756E6374696F6E28726567696F6E2C20616374696F6E4E616D6529207B0A20202020747279207B0A20202020202076617220616374696F6E73203D20726567696F6E2E63616C6C2827676574416374696F6E7327293B0A2020202020';
wwv_flow_imp.g_varchar2_table(17) := '206966202821616374696F6E73207C7C20747970656F6620616374696F6E732E6C6F6F6B757020213D3D202766756E6374696F6E27207C7C2021616374696F6E732E6C6F6F6B757028616374696F6E4E616D652929207B0A202020202020202072657475';
wwv_flow_imp.g_varchar2_table(18) := '726E2066616C73653B0A2020202020207D0A202020202020616374696F6E732E696E766F6B6528616374696F6E4E616D65293B0A20202020202072657475726E20747275653B0A202020207D20636174636820286529207B0A2020202020206C6F676765';
wwv_flow_imp.g_varchar2_table(19) := '722E7761726E696E672827416374696F6E202227202B20616374696F6E4E616D65202B202722206973206E6F7420617661696C61626C65206F6E207468697320726567696F6E272C2065293B0A20202020202072657475726E2066616C73653B0A202020';
wwv_flow_imp.g_varchar2_table(20) := '207D0A20207D3B0A0A2020766172205F7265667265736846756C6C203D2066756E6374696F6E28726567696F6E29207B0A2020202076617220726573756C74203D20726567696F6E2E726567696F6E2E7265667265736828293B0A202020206966202872';
wwv_flow_imp.g_varchar2_table(21) := '6573756C7420262620747970656F6620726573756C742E7468656E203D3D3D202766756E6374696F6E2729207B0A202020202020726573756C742E7468656E280A202020202020202066756E6374696F6E2829207B206C6F676765722E6C6F6728274772';
wwv_flow_imp.g_varchar2_table(22) := '69642072656672657368656427293B207D0A20202020202020202C2066756E6374696F6E2865727229207B206C6F676765722E6572726F722827477269642072656672657368206661696C6564272C20657272293B207D0A202020202020293B0A202020';
wwv_flow_imp.g_varchar2_table(23) := '207D0A20207D3B0A0A2020766172205F72656672657368537572676963616C203D2066756E6374696F6E28726567696F6E43747829207B0A20202020766172206F6B203D205F696E766F6B654966537570706F7274656428726567696F6E4374782E7265';
wwv_flow_imp.g_varchar2_table(24) := '67696F6E2C202773656C656374696F6E2D7265667265736827293B0A2020202069662028216F6B29207B0A2020202020206C6F676765722E7761726E696E67282746616C6C696E67206261636B20746F2066756C6C206772696420726566726573682028';
wwv_flow_imp.g_varchar2_table(25) := '73656C656374696F6E2D7265667265736820756E617661696C61626C65206F72206E6F7468696E672073656C65637465642927293B0A2020202020205F7265667265736846756C6C28726567696F6E437478293B0A202020207D0A20207D3B0A0A202076';
wwv_flow_imp.g_varchar2_table(26) := '6172205F676574496E74657261637469766547726964576964676574203D2066756E6374696F6E28726567696F6E43747829207B0A20202020747279207B0A20202020202072657475726E20726567696F6E4374782E726567696F6E2E77696467657428';
wwv_flow_imp.g_varchar2_table(27) := '292E696E74657261637469766547726964282767657443757272656E745669657727293B0A202020207D20636174636820286529207B0A2020202020206C6F676765722E6572726F7228275468697320726567696F6E206973206E6F7420616E20656469';
wwv_flow_imp.g_varchar2_table(28) := '7461626C652F696E697469616C697A656420496E7465726163746976652047726964272C2065293B0A20202020202072657475726E206E756C6C3B0A202020207D0A20207D3B0A0A2020766172205F67657453656C65637465645265636F726449647320';
wwv_flow_imp.g_varchar2_table(29) := '3D2066756E6374696F6E28726567696F6E43747829207B0A20202020766172206D6F64656C3B0A20202020766172207265636F7264733B0A20202020747279207B0A2020202020206D6F64656C203D20726567696F6E4374782E726567696F6E2E776964';
wwv_flow_imp.g_varchar2_table(30) := '67657428292E696E74657261637469766547726964282767657443757272656E745669657727292E6D6F64656C3B0A2020202020207265636F726473203D20726567696F6E4374782E726567696F6E2E77696467657428292E696E746572616374697665';
wwv_flow_imp.g_varchar2_table(31) := '47726964282767657453656C65637465645265636F72647327293B0A202020207D20636174636820286529207B0A2020202020206C6F676765722E6572726F722827556E61626C6520746F20726561642074686520496E74657261637469766520477269';
wwv_flow_imp.g_varchar2_table(32) := '642073656C656374696F6E272C2065293B0A20202020202072657475726E205B5D3B0A202020207D0A2020202069662028217265636F726473207C7C20217265636F7264732E6C656E67746829207B0A20202020202072657475726E205B5D3B0A202020';
wwv_flow_imp.g_varchar2_table(33) := '207D0A2020202072657475726E207265636F7264732E6D61702866756E6374696F6E287265636F726429207B0A20202020202072657475726E206D6F64656C2E6765745265636F72644964287265636F7264293B0A202020207D293B0A20207D3B0A0A20';
wwv_flow_imp.g_varchar2_table(34) := '20766172205F72756E53656C6563746564416374696F6E203D2066756E6374696F6E28726567696F6E4374782C20616374696F6E4E616D652C20707265736572766553656C656374696F6E29207B0A202020206966202821616374696F6E4E616D652920';
wwv_flow_imp.g_varchar2_table(35) := '7B0A2020202020206C6F676765722E6572726F72282753454C45435445445F414354494F4E2072657175697265732061202253657276657220616374696F6E202F2070726F63657373206E616D6522206174747269627574652076616C756527293B0A20';
wwv_flow_imp.g_varchar2_table(36) := '202020202072657475726E3B0A202020207D0A0A2020202076617220696473203D205F67657453656C65637465645265636F726449647328726567696F6E437478293B0A2020202069662028216964732E6C656E67746829207B0A202020202020617065';
wwv_flow_imp.g_varchar2_table(37) := '782E6D6573736167652E616C65727428617065782E6C616E672E6765744D6573736167652827415045582E49475F504F574552544F4F4C532E4E4F5F53454C454354494F4E2729207C7C202753656C656374206174206C65617374206F6E6520726F7720';
wwv_flow_imp.g_varchar2_table(38) := '66697273742E27293B0A20202020202072657475726E3B0A202020207D0A0A202020202428272327202B20726567696F6E4374782E6964292E616464436C61737328425553595F434C415353293B0A0A20202020617065782E7365727665722E70726F63';
wwv_flow_imp.g_varchar2_table(39) := '657373280A202020202020616374696F6E4E616D650A2020202020202C207B207830313A204A534F4E2E737472696E676966792869647329207D0A2020202020202C207B2064617461547970653A20276A736F6E27207D0A20202020292E646F6E652866';
wwv_flow_imp.g_varchar2_table(40) := '756E6374696F6E286461746129207B0A2020202020202428272327202B20726567696F6E4374782E6964292E72656D6F7665436C61737328425553595F434C415353293B0A0A202020202020696620286461746120262620646174612E6D657373616765';
wwv_flow_imp.g_varchar2_table(41) := '29207B0A2020202020202020617065782E6D6573736167652E73686F77506167655375636365737328646174612E6D657373616765293B0A2020202020207D0A0A20202020202069662028707265736572766553656C656374696F6E29207B0A20202020';
wwv_flow_imp.g_varchar2_table(42) := '202020205F72656672657368537572676963616C28726567696F6E437478293B0A2020202020207D20656C7365207B0A20202020202020205F7265667265736846756C6C28726567696F6E437478293B0A2020202020207D0A202020207D292E6661696C';
wwv_flow_imp.g_varchar2_table(43) := '2866756E6374696F6E286A7158485229207B0A2020202020202428272327202B20726567696F6E4374782E6964292E72656D6F7665436C61737328425553595F434C415353293B0A2020202020206C6F676765722E6572726F7228275365727665722061';
wwv_flow_imp.g_varchar2_table(44) := '6374696F6E202227202B20616374696F6E4E616D65202B202722206661696C6564272C206A71584852293B0A202020202020617065782E6D6573736167652E73686F774572726F7273285B7B0A2020202020202020747970653A20276572726F72270A20';
wwv_flow_imp.g_varchar2_table(45) := '202020202020202C206C6F636174696F6E3A202770616765270A20202020202020202C206D6573736167653A20286A71584852202626206A715848522E726573706F6E73654A534F4E202626206A715848522E726573706F6E73654A534F4E2E6572726F';
wwv_flow_imp.g_varchar2_table(46) := '7229207C7C20275468652073657276657220616374696F6E20636F756C64206E6F7420626520636F6D706C657465642E270A2020202020207D5D293B0A202020207D293B0A20207D3B0A0A2020766172205F72756E446570656E64656E74436F6C756D6E';
wwv_flow_imp.g_varchar2_table(47) := '52656672657368203D2066756E6374696F6E28726567696F6E4374782C20616374696F6E4E616D6529207B0A202020206966202821616374696F6E4E616D6529207B0A2020202020206C6F676765722E6572726F722827444550454E44454E545F434F4C';
wwv_flow_imp.g_varchar2_table(48) := '554D4E5F524546524553482072657175697265732061202253657276657220616374696F6E202F2070726F63657373206E616D6522206174747269627574652076616C756527293B0A20202020202072657475726E3B0A202020207D0A0A202020207661';
wwv_flow_imp.g_varchar2_table(49) := '722076696577203D205F676574496E7465726163746976654772696457696467657428726567696F6E437478293B0A2020202069662028217669657729207B2072657475726E3B207D0A0A20202020766172207265636F726473203D20726567696F6E43';
wwv_flow_imp.g_varchar2_table(50) := '74782E726567696F6E2E77696467657428292E696E74657261637469766547726964282767657453656C65637465645265636F72647327293B0A20202020766172207265636F7264203D207265636F726473202626207265636F7264732E6C656E677468';
wwv_flow_imp.g_varchar2_table(51) := '203F207265636F7264735B305D203A206E756C6C3B0A2020202069662028217265636F726429207B0A2020202020206C6F676765722E7761726E696E672827444550454E44454E545F434F4C554D4E5F524546524553483A206E6F2063757272656E742F';
wwv_flow_imp.g_varchar2_table(52) := '73656C656374656420726F7720746F2075706461746527293B0A20202020202072657475726E3B0A202020207D0A20202020766172206D6F64656C203D20766965772E6D6F64656C3B0A20202020766172207265636F72644964203D206D6F64656C2E67';
wwv_flow_imp.g_varchar2_table(53) := '65745265636F72644964287265636F7264293B0A0A2020202076617220726F7756616C756573203D207B7D3B0A202020204F626A6563742E6B657973286D6F64656C2E6765744F7074696F6E28276669656C64732729207C7C207B7D292E666F72456163';
wwv_flow_imp.g_varchar2_table(54) := '682866756E6374696F6E286669656C6429207B0A2020202020207661722076616C7565203D206D6F64656C2E67657456616C7565287265636F72642C206669656C64293B0A202020202020726F7756616C7565735B6669656C645D203D2076616C756520';
wwv_flow_imp.g_varchar2_table(55) := '213D3D206E756C6C20262620747970656F662076616C7565203D3D3D20276F626A656374272026262027762720696E2076616C7565203F2076616C75652E76203A2076616C75653B0A202020207D293B0A0A20202020766172206D657461203D206D6F64';
wwv_flow_imp.g_varchar2_table(56) := '656C2E6765745265636F72644D65746164617461287265636F7264496429207C7C207B7D3B0A20202020696620286D6574612E75706461746564207C7C206D6574612E696E73657274656429207B0A2020202020206C6F676765722E7761726E696E6728';
wwv_flow_imp.g_varchar2_table(57) := '27444550454E44454E545F434F4C554D4E5F524546524553483A20726F772068617320756E7361766564206368616E6765733B2074686520726566726573682072656C6F6164732069742066726F6D207468652064617461626173652C2027202B0A2020';
wwv_flow_imp.g_varchar2_table(58) := '20202020202027736F207468652073657276657220616374696F6E206D757374207065727369737420616E79206F66207468656D206974206E6565647320746F206B65657027293B0A202020207D0A0A20202020617065782E7365727665722E70726F63';
wwv_flow_imp.g_varchar2_table(59) := '657373280A202020202020616374696F6E4E616D650A2020202020202C207B207830313A204A534F4E2E737472696E67696679287265636F72644964292C207830323A204A534F4E2E737472696E6769667928726F7756616C75657329207D0A20202020';
wwv_flow_imp.g_varchar2_table(60) := '20202C207B2064617461547970653A20276A736F6E27207D0A20202020292E646F6E652866756E6374696F6E2829207B0A2020202020205F72656672657368537572676963616C28726567696F6E437478293B0A202020207D292E6661696C2866756E63';
wwv_flow_imp.g_varchar2_table(61) := '74696F6E286A7158485229207B0A2020202020206C6F676765722E6572726F72282753657276657220616374696F6E202227202B20616374696F6E4E616D65202B202722206661696C6564272C206A71584852293B0A202020207D293B0A20207D3B0A0A';
wwv_flow_imp.g_varchar2_table(62) := '202076617220415045585F475249445F4D494D45203D2027776562206170706C69636174696F6E2F782D617065782D677269642B6A736F6E273B0A0A20207661722050415354455F4D4F4445203D207B205245504C4143453A20275245504C414345272C';
wwv_flow_imp.g_varchar2_table(63) := '20494E534552543A2027494E53455254272C20415050454E443A2027415050454E4427207D3B0A0A2020766172204954454D5F53454C4543545F4C495354203D20274E41544956455F53454C4543545F4C495354273B0A2020766172204954454D5F5357';
wwv_flow_imp.g_varchar2_table(64) := '49544348203D20274E41544956455F5945535F4E4F273B0A2020766172204954454D5F504F5055505F4C4F56203D20274E41544956455F504F5055505F4C4F56273B0A202076617220444154455F5459504553203D205B2744415445272C202754494D45';
wwv_flow_imp.g_varchar2_table(65) := '5354414D50272C202754494D455354414D505F545A272C202754494D455354414D505F4C545A275D3B0A0A2020766172204D554C54494C494E455F4954454D5F5459504553203D205B274E41544956455F5445585441524541275D3B0A0A202076617220';
wwv_flow_imp.g_varchar2_table(66) := '41465445525F494E534552545F46414C4C4241434B5F4D53203D20313030303B0A0A2020766172204C494E455F4D41524B203D2027EE8080273B0A0A2020766172205F6E6F726D616C697A655753203D2066756E6374696F6E2876616C756529207B0A20';
wwv_flow_imp.g_varchar2_table(67) := '20202072657475726E20537472696E672876616C7565292E7265706C616365282F5B5C73C2A05D2B2F672C20272027292E7472696D28293B0A20207D3B0A0A2020766172205F6A6F696E4C696E6573203D2066756E6374696F6E286C696E657329207B0A';
wwv_flow_imp.g_varchar2_table(68) := '202020206C696E6573203D206C696E65732E6D6170285F6E6F726D616C697A655753293B0A202020207768696C6520286C696E65732E6C656E677468203E2031202626206C696E65735B305D203D3D3D20272729207B206C696E65732E73686966742829';
wwv_flow_imp.g_varchar2_table(69) := '3B207D0A202020207768696C6520286C696E65732E6C656E677468203E2031202626206C696E65735B6C696E65732E6C656E677468202D20315D203D3D3D20272729207B206C696E65732E706F7028293B207D0A2020202072657475726E206C696E6573';
wwv_flow_imp.g_varchar2_table(70) := '2E6A6F696E28275C6E27293B0A20207D3B0A0A2020766172205F63656C6C54657874203D2066756E6374696F6E286E6F646529207B0A2020202072657475726E205F6A6F696E4C696E657328537472696E67286E6F64652E74657874436F6E74656E7420';
wwv_flow_imp.g_varchar2_table(71) := '7C7C202727292E73706C6974284C494E455F4D41524B29293B0A20207D3B0A0A2020766172205F73706C697444656C696D69746564203D2066756E6374696F6E287465787429207B0A2020202074657874203D20746578742E7265706C616365282F5C72';
wwv_flow_imp.g_varchar2_table(72) := '5C6E3F2F672C20275C6E27292E7265706C616365282F5C6E2B242F2C202727293B0A2020202076617220706C61696E203D2066756E6374696F6E2829207B0A20202020202072657475726E20746578742E73706C697428275C6E27292E6D61702866756E';
wwv_flow_imp.g_varchar2_table(73) := '6374696F6E286C696E6529207B2072657475726E206C696E652E73706C697428275C7427293B207D293B0A202020207D3B0A2020202076617220726F7773203D205B5D2C20726F77203D205B5D2C2063656C6C203D2027272C2069203D20302C206E203D';
wwv_flow_imp.g_varchar2_table(74) := '20746578742E6C656E6774683B0A202020207768696C65202869203C206E29207B0A202020202020766172206368203D20746578742E6368617241742869293B0A202020202020696620286368203D3D3D202722272026262063656C6C203D3D3D202727';
wwv_flow_imp.g_varchar2_table(75) := '29207B0A2020202020202020766172206A203D2069202B20312C2071756F746564203D2027273B0A2020202020202020666F7220283B3B29207B0A20202020202020202020696620286A203E3D206E29207B2072657475726E20706C61696E28293B207D';
wwv_flow_imp.g_varchar2_table(76) := '0A202020202020202020207661722071203D20746578742E636861724174286A293B0A202020202020202020206966202871203D3D3D2027222720262620746578742E636861724174286A202B203129203D3D3D2027222729207B2071756F746564202B';
wwv_flow_imp.g_varchar2_table(77) := '3D202722273B206A202B3D20323B20636F6E74696E75653B207D0A202020202020202020206966202871203D3D3D2027222729207B20627265616B3B207D0A2020202020202020202071756F746564202B3D20713B0A202020202020202020206A202B3D';
wwv_flow_imp.g_varchar2_table(78) := '20313B0A20202020202020207D0A2020202020202020766172206166746572203D20746578742E636861724174286A202B2031293B0A202020202020202069662028616674657220213D3D20272720262620616674657220213D3D20275C742720262620';
wwv_flow_imp.g_varchar2_table(79) := '616674657220213D3D20275C6E2729207B2072657475726E20706C61696E28293B207D0A202020202020202063656C6C203D2071756F7465643B0A202020202020202069203D206A202B20313B0A2020202020202020636F6E74696E75653B0A20202020';
wwv_flow_imp.g_varchar2_table(80) := '20207D0A202020202020696620286368203D3D3D20275C742729207B20726F772E707573682863656C6C293B2063656C6C203D2027273B207D0A202020202020656C736520696620286368203D3D3D20275C6E2729207B20726F772E707573682863656C';
wwv_flow_imp.g_varchar2_table(81) := '6C293B20726F77732E7075736828726F77293B20726F77203D205B5D3B2063656C6C203D2027273B207D0A202020202020656C7365207B2063656C6C202B3D2063683B207D0A20202020202069202B3D20313B0A202020207D0A20202020726F772E7075';
wwv_flow_imp.g_varchar2_table(82) := '73682863656C6C293B0A20202020726F77732E7075736828726F77293B0A2020202072657475726E20726F77733B0A20207D3B0A0A2020766172205F72656164436C6970626F6172645461626C65203D2066756E6374696F6E28636C6970626F61726444';
wwv_flow_imp.g_varchar2_table(83) := '61746129207B0A202020207661722068746D6C203D20636C6970626F617264446174612E676574446174612827746578742F68746D6C27293B0A202020207661722074657874203D20636C6970626F617264446174612E67657444617461282774657874';
wwv_flow_imp.g_varchar2_table(84) := '2F706C61696E27293B0A2020202076617220726F7773203D206E756C6C3B0A0A202020206966202868746D6C2026262068746D6C2E696E6465784F6628273C7461626C652729203E3D203029207B0A20202020202076617220646F63203D206E65772044';
wwv_flow_imp.g_varchar2_table(85) := '4F4D50617273657228292E706172736546726F6D537472696E672868746D6C2E7265706C616365282F3C62725C625B5E3E5D2A3E2F67692C204C494E455F4D41524B292C2027746578742F68746D6C27293B0A202020202020766172207461626C657320';
wwv_flow_imp.g_varchar2_table(86) := '3D20646F632E676574456C656D656E747342795461674E616D6528277461626C6527293B0A202020202020696620287461626C65732E6C656E677468203D3D3D203129207B0A2020202020202020726F7773203D205B5D3B0A2020202020202020417272';
wwv_flow_imp.g_varchar2_table(87) := '61792E70726F746F747970652E666F72456163682E63616C6C287461626C65735B305D2E726F77732C2066756E6374696F6E28747229207B0A2020202020202020202076617220726F77203D205B5D3B0A2020202020202020202041727261792E70726F';
wwv_flow_imp.g_varchar2_table(88) := '746F747970652E666F72456163682E63616C6C2874722E63656C6C732C2066756E6374696F6E28746429207B0A2020202020202020202020207661722076616C7565203D205F63656C6C54657874287464293B0A20202020202020202020202076617220';
wwv_flow_imp.g_varchar2_table(89) := '7370616E203D207061727365496E742874642E6765744174747269627574652827636F6C7370616E27292C20313029207C7C20313B0A202020202020202020202020666F7220287661722069203D20303B2069203C207370616E3B20692B2B29207B2072';
wwv_flow_imp.g_varchar2_table(90) := '6F772E707573682876616C7565293B207D0A202020202020202020207D293B0A20202020202020202020726F77732E7075736828726F77293B0A20202020202020207D293B0A2020202020207D0A202020207D0A0A202020206966202821726F77732026';
wwv_flow_imp.g_varchar2_table(91) := '2620746578742026262028746578742E696E6465784F6628275C742729203E3D2030207C7C20746578742E696E6465784F6628275C6E2729203E3D20302929207B0A202020202020726F7773203D205F73706C697444656C696D69746564287465787429';
wwv_flow_imp.g_varchar2_table(92) := '2E6D61702866756E6374696F6E28726F7729207B0A202020202020202072657475726E20726F772E6D61702866756E6374696F6E2863656C6C29207B2072657475726E205F6A6F696E4C696E65732863656C6C2E73706C697428275C6E2729293B207D29';
wwv_flow_imp.g_varchar2_table(93) := '3B0A2020202020207D293B0A202020207D0A0A202020206966202821726F7773207C7C2021726F77732E6C656E677468207C7C0A202020202020202028726F77732E6C656E677468203D3D3D203120262620726F77735B305D2E6C656E677468203C2032';
wwv_flow_imp.g_varchar2_table(94) := '2026262028726F77735B305D5B305D207C7C202727292E696E6465784F6628275C6E2729203C20302929207B0A20202020202072657475726E206E756C6C3B0A202020207D0A0A20202020766172207769647468203D20726F77732E7265647563652866';
wwv_flow_imp.g_varchar2_table(95) := '756E6374696F6E286D61782C20726F7729207B2072657475726E204D6174682E6D6178286D61782C20726F772E6C656E677468293B207D2C2030293B0A20202020726F77732E666F72456163682866756E6374696F6E28726F7729207B0A202020202020';
wwv_flow_imp.g_varchar2_table(96) := '7768696C652028726F772E6C656E677468203C20776964746829207B20726F772E70757368282727293B207D0A202020207D293B0A2020202072657475726E20726F77733B0A20207D3B0A0A2020766172205F7265736F6C7665546172676574436F6C75';
wwv_flow_imp.g_varchar2_table(97) := '6D6E73203D2066756E6374696F6E28677269642C20776964746829207B0A202020207661722063656C6C24203D20677269642E67657443757272656E7443656C6C28293B0A20202020696620282163656C6C24207C7C202163656C6C242E6C656E677468';
wwv_flow_imp.g_varchar2_table(98) := '207C7C202163656C6C242E686173436C6173732827612D47562D63656C6C2729207C7C2063656C6C242E706172656E7428292E686173436C617373282769732D616767726567617465272929207B0A20202020202072657475726E206E756C6C3B0A2020';
wwv_flow_imp.g_varchar2_table(99) := '20207D0A202020206966202863656C6C242E686173436C6173732827612D47562D73656C486561646572272929207B0A20202020202063656C6C24203D2063656C6C242E6E65787428293B0A202020207D0A202020207768696C65202863656C6C242E6C';
wwv_flow_imp.g_varchar2_table(100) := '656E6774682026262028677269642E5F676574436F6C756D6E4D657461646174612863656C6C2429207C7C207B7D292E7669727475616C29207B0A20202020202063656C6C24203D2063656C6C242E6E65787428293B0A202020207D0A0A202020207661';
wwv_flow_imp.g_varchar2_table(101) := '7220726F7743656C6C7324203D20677269642E6C617374526F772420262620677269642E6C617374526F77242E696E6465782863656C6C2429203E3D2030203F20677269642E6C617374526F7724203A2063656C6C242E706172656E7428292E6368696C';
wwv_flow_imp.g_varchar2_table(102) := '6472656E28293B0A20202020766172207374617274203D20726F7743656C6C73242E696E6465782863656C6C24293B0A20202020696620287374617274203C203029207B2072657475726E206E756C6C3B207D0A0A202020207661722074617267657473';
wwv_flow_imp.g_varchar2_table(103) := '203D205B5D3B0A20202020726F7743656C6C73242E736C6963652873746172742C207374617274202B207769647468292E656163682866756E6374696F6E2829207B0A20202020202076617220636F6C203D20677269642E5F676574436F6C756D6E4D65';
wwv_flow_imp.g_varchar2_table(104) := '7461646174612824287468697329293B0A20202020202069662028636F6C20262620636F6C2E70726F70657274792026262021636F6C2E68696464656E2026262021636F6C2E7669727475616C29207B0A2020202020202020746172676574732E707573';
wwv_flow_imp.g_varchar2_table(105) := '6828636F6C293B0A2020202020207D0A202020207D293B0A2020202072657475726E20746172676574733B0A20207D3B0A0A20207661722049534F5F444154455F5245203D202F5E285C647B347D292D285C647B312C327D292D285C647B312C327D2928';
wwv_flow_imp.g_varchar2_table(106) := '3F3A5B20545D285C647B312C327D293A285C647B327D29283F3A3A285C647B327D29293F293F242F3B0A2020766172204E554D455249435F444154455F5245203D202F5E285C647B312C327D295B5C2F2E5C2D5D285C647B312C327D295B5C2F2E5C2D5D';
wwv_flow_imp.g_varchar2_table(107) := '285C647B327D7C5C647B347D29283F3A5B20542C5D2B285C647B312C327D293A285C647B327D29283F3A3A285C647B327D29293F5C732A285B416150705D5B4D6D5D293F293F242F3B0A0A2020766172205F6275696C6444617465203D2066756E637469';
wwv_flow_imp.g_varchar2_table(108) := '6F6E28792C206D2C20642C2068682C206D692C2073732C20616D706D29207B0A2020202079203D207061727365496E7428792C203130293B0A202020206966202879203C2031303029207B2079202B3D2079203C203530203F2032303030203A20313930';
wwv_flow_imp.g_varchar2_table(109) := '303B207D0A202020206D203D207061727365496E74286D2C203130293B0A2020202064203D207061727365496E7428642C203130293B0A202020206868203D207061727365496E74286868207C7C202730272C203130293B0A2020202069662028616D70';
wwv_flow_imp.g_varchar2_table(110) := '6D29207B0A202020202020616D706D203D20616D706D2E746F55707065724361736528293B0A20202020202069662028616D706D203D3D3D2027504D27202626206868203C20313229207B206868202B3D2031323B207D0A20202020202069662028616D';
wwv_flow_imp.g_varchar2_table(111) := '706D203D3D3D2027414D27202626206868203D3D3D20313229207B206868203D20303B207D0A202020207D0A202020207661722064617465203D206E6577204461746528792C206D202D20312C20642C2068682C207061727365496E74286D69207C7C20';
wwv_flow_imp.g_varchar2_table(112) := '2730272C203130292C207061727365496E74287373207C7C202730272C20313029293B0A0A2020202069662028646174652E67657446756C6C59656172282920213D3D2079207C7C20646174652E6765744D6F6E7468282920213D3D206D202D2031207C';
wwv_flow_imp.g_varchar2_table(113) := '7C20646174652E67657444617465282920213D3D206429207B0A20202020202072657475726E206E756C6C3B0A202020207D0A2020202072657475726E20646174653B0A20207D3B0A0A2020766172205F6461794D6F6E74684F72646572203D2066756E';
wwv_flow_imp.g_varchar2_table(114) := '6374696F6E286D61736B29207B0A20202020766172206D203D20537472696E67286D61736B207C7C202727292E746F55707065724361736528293B0A20202020766172206464203D206D2E736561726368282F285E7C5B5E445D294444285B5E445D7C24';
wwv_flow_imp.g_varchar2_table(115) := '292F293B0A20202020766172206D6D203D206D2E736561726368282F285E7C5B5E4D5D294D4D285B5E4D495D7C24292F293B0A20202020696620286464203C2030207C7C206D6D203C203029207B2072657475726E206E756C6C3B207D0A202020207265';
wwv_flow_imp.g_varchar2_table(116) := '7475726E206464203C206D6D203F2027444D5927203A20274D4459273B0A20207D3B0A0A2020766172205F696E666572436F6C756D6E4F72646572203D2066756E6374696F6E2876616C75657329207B0A2020202076617220646D79203D2066616C7365';
wwv_flow_imp.g_varchar2_table(117) := '2C206D6479203D2066616C73653B0A2020202076616C7565732E666F72456163682866756E6374696F6E287629207B0A202020202020766172206D203D204E554D455249435F444154455F52452E657865632876293B0A20202020202069662028216D29';
wwv_flow_imp.g_varchar2_table(118) := '207B2072657475726E3B207D0A2020202020207661722061203D207061727365496E74286D5B315D2C203130292C2062203D207061727365496E74286D5B325D2C203130293B0A2020202020206966202861203E2031322026262062203C3D2031322920';
wwv_flow_imp.g_varchar2_table(119) := '7B20646D79203D20747275653B207D0A2020202020206966202862203E2031322026262061203C3D20313229207B206D6479203D20747275653B207D0A202020207D293B0A2020202069662028646D7920262620216D647929207B2072657475726E2027';
wwv_flow_imp.g_varchar2_table(120) := '444D59273B207D0A20202020696620286D64792026262021646D7929207B2072657475726E20274D4459273B207D0A2020202072657475726E206E756C6C3B0A20207D3B0A0A2020766172205F706172736544617465203D2066756E6374696F6E287661';
wwv_flow_imp.g_varchar2_table(121) := '6C75652C206F726465722C20736F75726365466F726D617429207B0A20202020766172206D203D2049534F5F444154455F52452E657865632876616C7565293B0A20202020696620286D29207B0A20202020202072657475726E205F6275696C64446174';
wwv_flow_imp.g_varchar2_table(122) := '65286D5B315D2C206D5B325D2C206D5B335D2C206D5B345D2C206D5B355D2C206D5B365D293B0A202020207D0A202020206D203D204E554D455249435F444154455F52452E657865632876616C7565293B0A20202020696620286D202626206F72646572';
wwv_flow_imp.g_varchar2_table(123) := '29207B0A20202020202072657475726E206F72646572203D3D3D2027444D59270A20202020202020203F205F6275696C6444617465286D5B335D2C206D5B325D2C206D5B315D2C206D5B345D2C206D5B355D2C206D5B365D2C206D5B375D290A20202020';
wwv_flow_imp.g_varchar2_table(124) := '202020203A205F6275696C6444617465286D5B335D2C206D5B315D2C206D5B325D2C206D5B345D2C206D5B355D2C206D5B365D2C206D5B375D293B0A202020207D0A0A20202020747279207B0A20202020202076617220706172736564203D2061706578';
wwv_flow_imp.g_varchar2_table(125) := '2E646174652E70617273652876616C75652C20736F75726365466F726D6174293B0A20202020202072657475726E2070617273656420262620617065782E646174652E697356616C69642870617273656429203F20706172736564203A206E756C6C3B0A';
wwv_flow_imp.g_varchar2_table(126) := '202020207D20636174636820286529207B0A20202020202072657475726E206E756C6C3B0A202020207D0A20207D3B0A0A2020766172205F73656C6563744C6973745265736F6C766572203D2066756E6374696F6E28636F6C29207B0A20202020766172';
wwv_flow_imp.g_varchar2_table(127) := '206F7074696F6E73203D20636F6C2E656C656D656E744964203F202428272327202B20636F6C2E656C656D656E744964292E66696E6428276F7074696F6E2729203A202428293B0A2020202076617220627956616C7565203D207B7D2C20627954657874';
wwv_flow_imp.g_varchar2_table(128) := '203D207B7D2C20627956616C75654369203D207B7D3B0A2020202069662028216F7074696F6E732E6C656E67746829207B2072657475726E206E756C6C3B207D0A0A202020206F7074696F6E732E656163682866756E6374696F6E2829207B0A20202020';
wwv_flow_imp.g_varchar2_table(129) := '20207661722076616C7565203D20746869732E76616C75653B0A2020202020206966202876616C7565203D3D3D20272729207B2072657475726E3B207D0A202020202020627956616C75655B76616C75655D203D2076616C75653B0A2020202020206279';
wwv_flow_imp.g_varchar2_table(130) := '546578745B5F6E6F726D616C697A65575328746869732E74657874292E746F4C6F7765724361736528295D203D2076616C75653B0A202020202020627956616C756543695B76616C75652E746F4C6F7765724361736528295D203D2076616C75653B0A20';
wwv_flow_imp.g_varchar2_table(131) := '2020207D293B0A2020202072657475726E2066756E6374696F6E287629207B0A202020202020696620284F626A6563742E70726F746F747970652E6861734F776E50726F70657274792E63616C6C28627956616C75652C20762929207B2072657475726E';
wwv_flow_imp.g_varchar2_table(132) := '20763B207D0A202020202020766172206B6579203D20762E746F4C6F7765724361736528293B0A202020202020696620284F626A6563742E70726F746F747970652E6861734F776E50726F70657274792E63616C6C286279546578742C206B6579292920';
wwv_flow_imp.g_varchar2_table(133) := '7B2072657475726E206279546578745B6B65795D3B207D0A202020202020696620284F626A6563742E70726F746F747970652E6861734F776E50726F70657274792E63616C6C28627956616C756543692C206B65792929207B2072657475726E20627956';
wwv_flow_imp.g_varchar2_table(134) := '616C756543695B6B65795D3B207D0A20202020202072657475726E20756E646566696E65643B0A202020207D3B0A20207D3B0A0A202076617220545255455F574F524453203D205B2779272C2027796573272C202773272C20277369272C202773C3AD27';
wwv_flow_imp.g_varchar2_table(135) := '2C202774727565272C202776657264616465726F272C202731272C20276F6E272C202778272C2027E29C93272C2027E29C94275D3B0A20207661722046414C53455F574F524453203D205B276E272C20276E6F272C202766616C7365272C202766616C73';
wwv_flow_imp.g_varchar2_table(136) := '6F272C202730272C20276F6666275D3B0A0A2020766172205F7377697463685265736F6C766572203D2066756E6374696F6E28636F6C29207B0A2020202076617220656C24203D20636F6C2E656C656D656E744964203F202428272327202B20636F6C2E';
wwv_flow_imp.g_varchar2_table(137) := '656C656D656E74496429203A202428293B0A2020202076617220696E7075747324203D20656C242E69732827696E7075742729203F20656C24203A20656C242E66696E642827696E70757427293B0A20202020766172206F6E2C206F66662C206F6E4C61';
wwv_flow_imp.g_varchar2_table(138) := '62656C2C206F66664C6162656C3B0A0A2020202069662028696E70757473242E6C656E677468203D3D3D203120262620696E70757473242E617474722827747970652729203D3D3D2027636865636B626F782729207B0A2020202020206F6E203D20696E';
wwv_flow_imp.g_varchar2_table(139) := '70757473242E61747472282776616C756527293B0A2020202020206F6666203D20696E70757473242E617474722827646174612D6F66662D76616C756527293B0A2020202020206F6E4C6162656C203D20696E70757473242E617474722827646174612D';
wwv_flow_imp.g_varchar2_table(140) := '6F6E2D6C6162656C27293B0A2020202020206F66664C6162656C203D20696E70757473242E617474722827646174612D6F66662D6C6162656C27293B0A202020207D20656C73652069662028696E70757473242E6C656E677468203D3D3D203229207B0A';
wwv_flow_imp.g_varchar2_table(141) := '2020202020206F6E203D20696E70757473242E65712830292E61747472282776616C756527293B0A2020202020206F6666203D20696E70757473242E65712831292E61747472282776616C756527293B0A2020202020206F6E4C6162656C203D20242827';
wwv_flow_imp.g_varchar2_table(142) := '5B666F723D2227202B20696E70757473242E65712830292E61747472282769642729202B2027225D27292E7465787428293B0A2020202020206F66664C6162656C203D202428275B666F723D2227202B20696E70757473242E65712831292E6174747228';
wwv_flow_imp.g_varchar2_table(143) := '2769642729202B2027225D27292E7465787428293B0A202020207D0A20202020696620286F6E203D3D3D20756E646566696E6564207C7C206F6666203D3D3D20756E646566696E656429207B2072657475726E206E756C6C3B207D0A0A20202020766172';
wwv_flow_imp.g_varchar2_table(144) := '206C6F6F6B7570203D207B7D3B0A2020202076617220616464203D2066756E6374696F6E286B65792C2076616C756529207B0A202020202020696620286B657920213D3D20756E646566696E6564202626206B657920213D3D206E756C6C202626206B65';
wwv_flow_imp.g_varchar2_table(145) := '7920213D3D20272729207B0A20202020202020206C6F6F6B75705B5F6E6F726D616C697A655753286B6579292E746F4C6F7765724361736528295D203D2076616C75653B0A2020202020207D0A202020207D3B0A20202020545255455F574F5244532E66';
wwv_flow_imp.g_varchar2_table(146) := '6F72456163682866756E6374696F6E287729207B2061646428772C206F6E293B207D293B0A2020202046414C53455F574F5244532E666F72456163682866756E6374696F6E287729207B2061646428772C206F6666293B207D293B0A0A20202020616464';
wwv_flow_imp.g_varchar2_table(147) := '286F6E4C6162656C2C206F6E293B0A20202020616464286F66664C6162656C2C206F6666293B0A20202020616464286F6E2C206F6E293B0A20202020616464286F66662C206F6666293B0A0A2020202072657475726E2066756E6374696F6E287629207B';
wwv_flow_imp.g_varchar2_table(148) := '0A202020202020766172206B6579203D20762E746F4C6F7765724361736528293B0A20202020202072657475726E204F626A6563742E70726F746F747970652E6861734F776E50726F70657274792E63616C6C286C6F6F6B75702C206B657929203F206C';
wwv_flow_imp.g_varchar2_table(149) := '6F6F6B75705B6B65795D203A20756E646566696E65643B0A202020207D3B0A20207D3B0A0A2020766172204E554D4245525F4954454D5F5459504553203D205B274E41544956455F4E554D4245525F4649454C44272C20274E41544956455F544558545F';
wwv_flow_imp.g_varchar2_table(150) := '4649454C44275D3B0A0A2020766172205F636C65616E4E756D626572203D2066756E6374696F6E2876616C756529207B0A202020207661722076203D2076616C75652E7265706C616365282F5BE28892E28092E280935D2F672C20272D27293B0A202020';
wwv_flow_imp.g_varchar2_table(151) := '20766172206E65676174697665203D2066616C73652C2070657263656E74203D2066616C73653B0A0A2020202076203D20762E7265706C616365282F5E5B412D5A5D7B337D5C732B7C5C732B5B412D5A5D7B337D242F672C202727293B0A202020207620';
wwv_flow_imp.g_varchar2_table(152) := '3D20762E7265706C616365282F5B5C707B53637D5D2F67752C202727293B0A2020202076203D20762E7265706C616365282F5B5C73C2A0E280AF275D2F672C202727293B0A20202020696620282F5E5C282E2A5C29242F2E7465737428762929207B206E';
wwv_flow_imp.g_varchar2_table(153) := '65676174697665203D20747275653B2076203D20762E736C69636528312C202D31293B207D0A20202020696620282F2D242F2E7465737428762929207B206E65676174697665203D20747275653B2076203D20762E736C69636528302C202D31293B207D';
wwv_flow_imp.g_varchar2_table(154) := '0A20202020696620282F5E5B2B2D5D2F2E7465737428762929207B206E65676174697665203D206E6567617469766520213D3D2028765B305D203D3D3D20272D27293B2076203D20762E736C6963652831293B207D0A20202020696620282F25242F2E74';
wwv_flow_imp.g_varchar2_table(155) := '65737428762929207B2070657263656E74203D20747275653B2076203D20762E736C69636528302C202D31293B207D0A0A2020202076203D20762E7265706C616365282F5B5C707B53637D5D2F67752C202727293B0A0A2020202069662028212F5E285C';
wwv_flow_imp.g_varchar2_table(156) := '645B5C642E2C5D2A293F5C2E3F5C642A285B65455D5B2B2D5D3F5C642B293F242F2E74657374287629207C7C20212F5C642F2E7465737428762929207B2072657475726E206E756C6C3B207D0A2020202072657475726E207B20626F64793A20762C206E';
wwv_flow_imp.g_varchar2_table(157) := '656761746976653A206E656761746976652C2070657263656E743A2070657263656E74207D3B0A20207D3B0A0A2020766172205F646563696D616C45766964656E6365203D2066756E6374696F6E28626F647929207B0A20202020766172206D616E7469';
wwv_flow_imp.g_varchar2_table(158) := '737361203D20626F64792E7265706C616365282F5B65455D2E2A242F2C202727293B0A2020202076617220646F7473203D20286D616E74697373612E6D61746368282F5C2E2F6729207C7C205B5D292E6C656E6774683B0A2020202076617220636F6D6D';
wwv_flow_imp.g_varchar2_table(159) := '6173203D20286D616E74697373612E6D61746368282F2C2F6729207C7C205B5D292E6C656E6774683B0A2020202069662028646F747320262620636F6D6D617329207B2072657475726E206D616E74697373612E6C617374496E6465784F6628272E2729';
wwv_flow_imp.g_varchar2_table(160) := '203E206D616E74697373612E6C617374496E6465784F6628272C2729203F20272E27203A20272C273B207D0A2020202069662028646F7473203E203129207B2072657475726E20272C273B207D0A2020202069662028636F6D6D6173203E203129207B20';
wwv_flow_imp.g_varchar2_table(161) := '72657475726E20272E273B207D0A2020202076617220736570203D20646F7473203F20272E27203A20636F6D6D6173203F20272C27203A206E756C6C3B0A202020206966202873657020262620212F5E5C647B312C337D5B2E2C5D5C647B337D242F2E74';
wwv_flow_imp.g_varchar2_table(162) := '657374286D616E74697373612929207B2072657475726E207365703B207D0A2020202072657475726E206E756C6C3B0A20207D3B0A0A2020766172205F696E666572436F6C756D6E446563696D616C203D2066756E6374696F6E2876616C75657329207B';
wwv_flow_imp.g_varchar2_table(163) := '0A20202020766172207365656E203D207B7D3B0A2020202076616C7565732E666F72456163682866756E6374696F6E287629207B0A20202020202076617220636C65616E203D2076202626205F636C65616E4E756D6265722876293B0A20202020202076';
wwv_flow_imp.g_varchar2_table(164) := '6172206576203D20636C65616E202626205F646563696D616C45766964656E636528636C65616E2E626F6479293B0A20202020202069662028657629207B207365656E5B65765D203D20747275653B207D0A202020207D293B0A20202020766172206B65';
wwv_flow_imp.g_varchar2_table(165) := '7973203D204F626A6563742E6B657973287365656E293B0A2020202072657475726E206B6579732E6C656E677468203D3D3D2031203F206B6579735B305D203A206E756C6C3B0A20207D3B0A0A2020766172205F70617273654E756D626572203D206675';
wwv_flow_imp.g_varchar2_table(166) := '6E6374696F6E2876616C75652C20646563696D616C53657029207B0A2020202076617220636C65616E203D205F636C65616E4E756D6265722876616C7565293B0A202020206966202821636C65616E29207B2072657475726E206E756C6C3B207D0A2020';
wwv_flow_imp.g_varchar2_table(167) := '20207661722067726F7570536570203D20646563696D616C536570203D3D3D20272C27203F20272E27203A20272C273B0A20202020766172206D616E7469737361203D20636C65616E2E626F64792E7265706C616365282F5B65455D2E2A242F2C202727';
wwv_flow_imp.g_varchar2_table(168) := '293B0A20202020766172206578706F6E656E74203D20636C65616E2E626F64792E736C696365286D616E74697373612E6C656E677468293B0A0A2020202076617220696E7450617274203D206D616E74697373612E73706C697428646563696D616C5365';
wwv_flow_imp.g_varchar2_table(169) := '70295B305D3B0A2020202069662028696E74506172742E696E6465784F662867726F757053657029203E3D203020262620216E65772052656745787028275E5C5C647B312C337D285C5C27202B2067726F7570536570202B20275C5C647B337D292B2427';
wwv_flow_imp.g_varchar2_table(170) := '292E7465737428696E74506172742929207B0A20202020202072657475726E206E756C6C3B0A202020207D0A20202020696620286D616E74697373612E73706C697428646563696D616C536570292E6C656E677468203E203229207B2072657475726E20';
wwv_flow_imp.g_varchar2_table(171) := '6E756C6C3B207D0A0A20202020766172206E203D204E756D626572286D616E74697373612E73706C69742867726F7570536570292E6A6F696E282727292E7265706C61636528646563696D616C5365702C20272E2729202B206578706F6E656E74293B0A';
wwv_flow_imp.g_varchar2_table(172) := '202020206966202821697346696E697465286E2929207B2072657475726E206E756C6C3B207D0A2020202069662028636C65616E2E70657263656E7429207B206E203D206E202F203130303B207D0A2020202072657475726E20636C65616E2E6E656761';
wwv_flow_imp.g_varchar2_table(173) := '74697665203F202D6E203A206E3B0A20207D3B0A0A2020766172205F666F726D61744E756D626572466F7253657373696F6E203D2066756E6374696F6E286E29207B0A202020207661722073203D20537472696E67284E756D626572286E2E746F507265';
wwv_flow_imp.g_varchar2_table(174) := '636973696F6E2831352929293B0A20202020696620282F652F692E7465737428732929207B0A20202020202073203D206E2E746F4669786564284D6174682E6D696E2832302C204D6174682E6D617828302C202D4D6174682E666C6F6F72284D6174682E';
wwv_flow_imp.g_varchar2_table(175) := '6C6F673130284D6174682E616273286E292929202B2031342929293B0A20202020202073203D20732E696E6465784F6628272E2729203E3D2030203F20732E7265706C616365282F5C2E3F302B242F2C20272729203A20733B0A202020207D0A20202020';
wwv_flow_imp.g_varchar2_table(176) := '72657475726E20732E7265706C61636528272E272C20617065782E6C6F63616C652E676574446563696D616C536570617261746F722829293B0A20207D3B0A0A2020766172205F6E6F726D616C697A65486561646572203D2066756E6374696F6E287661';
wwv_flow_imp.g_varchar2_table(177) := '6C756529207B0A2020202072657475726E20537472696E672876616C7565207C7C202727290A2020202020202E6E6F726D616C697A6528274E464427292E7265706C616365282F5BCC802DCDAF5D2F672C202727290A2020202020202E746F4C6F776572';
wwv_flow_imp.g_varchar2_table(178) := '4361736528292E7265706C616365282F5B5E612D7A302D395D2B2F672C20272027292E7472696D28293B0A20207D3B0A0A2020766172205F737472697054616773203D2066756E6374696F6E2868746D6C29207B0A2020202072657475726E206E657720';
wwv_flow_imp.g_varchar2_table(179) := '444F4D50617273657228292E706172736546726F6D537472696E6728537472696E672868746D6C207C7C202727292C2027746578742F68746D6C27292E626F64792E74657874436F6E74656E74207C7C2027273B0A20207D3B0A0A2020766172205F6973';
wwv_flow_imp.g_varchar2_table(180) := '5772697461626C65436F6C756D6E203D2066756E6374696F6E28677269642C20636F6C29207B0A2020202072657475726E2021636F6C2E68696464656E2026262021636F6C2E7669727475616C2026262021636F6C2E726561646F6E6C79202626202121';
wwv_flow_imp.g_varchar2_table(181) := '636F6C2E656C656D656E7449642026260A20202020202021677269642E6D6F64656C2E69734964656E746974794669656C6428636F6C2E70726F7065727479293B0A20207D3B0A0A2020766172205F6D61746368486561646572526F77203D2066756E63';
wwv_flow_imp.g_varchar2_table(182) := '74696F6E28677269642C20686561646572526F7729207B0A202020207661722062794B6579203D207B7D3B0A20202020677269642E676574436F6C756D6E7328292E666F72456163682866756E6374696F6E28636F6C29207B0A20202020202069662028';
wwv_flow_imp.g_varchar2_table(183) := '636F6C2E68696464656E207C7C20636F6C2E7669727475616C207C7C2021636F6C2E70726F706572747929207B2072657475726E3B207D0A2020202020205B636F6C2E68656164696E67202626205F73747269705461677328636F6C2E68656164696E67';
wwv_flow_imp.g_varchar2_table(184) := '292C20636F6C2E6C6162656C2C20636F6C2E70726F70657274792E7265706C616365282F5F2F672C20272027295D2E666F72456163682866756E6374696F6E286E616D6529207B0A2020202020202020766172206B6579203D205F6E6F726D616C697A65';
wwv_flow_imp.g_varchar2_table(185) := '486561646572286E616D65293B0A2020202020202020696620286B6579202626202162794B65795B6B65795D29207B2062794B65795B6B65795D203D20636F6C3B207D0A2020202020207D293B0A202020207D293B0A0A20202020766172207573656420';
wwv_flow_imp.g_varchar2_table(186) := '3D207B7D2C2074617267657473203D205B5D2C206D617463686564203D205B5D2C2069676E6F726564203D205B5D3B0A20202020686561646572526F772E666F72456163682866756E6374696F6E2863656C6C29207B0A20202020202076617220636F6C';
wwv_flow_imp.g_varchar2_table(187) := '203D2062794B65795B5F6E6F726D616C697A654865616465722863656C6C295D3B0A20202020202069662028636F6C2026262021757365645B636F6C2E70726F70657274795D29207B0A2020202020202020757365645B636F6C2E70726F70657274795D';
wwv_flow_imp.g_varchar2_table(188) := '203D20747275653B0A2020202020202020696620285F69735772697461626C65436F6C756D6E28677269642C20636F6C2929207B0A20202020202020202020746172676574732E7075736828636F6C293B0A202020202020202020206D6174636865642E';
wwv_flow_imp.g_varchar2_table(189) := '707573682863656C6C293B0A2020202020202020202072657475726E3B0A20202020202020207D0A2020202020207D0A202020202020746172676574732E70757368286E756C6C293B0A2020202020206966202863656C6C29207B2069676E6F7265642E';
wwv_flow_imp.g_varchar2_table(190) := '707573682863656C6C293B207D0A202020207D293B0A0A20202020766172207265636F676E697A6564203D204F626A6563742E6B6579732875736564292E6C656E6774683B0A2020202072657475726E207265636F676E697A6564203E3D2032203F207B';
wwv_flow_imp.g_varchar2_table(191) := '20746172676574733A20746172676574732C206D6174636865643A206D6174636865642C2069676E6F7265643A2069676E6F726564207D203A206E756C6C3B0A20207D3B0A0A2020766172205F646973706C61794C6F6F6B7570203D2066756E6374696F';
wwv_flow_imp.g_varchar2_table(192) := '6E28636F6C29207B0A2020202076617220656C24203D20636F6C2E656C656D656E744964203F202428272327202B20636F6C2E656C656D656E74496429203A202428293B0A20202020766172206D6170203D207B7D3B0A20202020656C242E66696E6428';
wwv_flow_imp.g_varchar2_table(193) := '276F7074696F6E27292E656163682866756E6374696F6E2829207B206D61705B746869732E76616C75655D203D205F6E6F726D616C697A65575328746869732E74657874293B207D293B0A2020202076617220696E70757424203D20656C242E69732827';
wwv_flow_imp.g_varchar2_table(194) := '696E7075742729203F20656C24203A202428293B0A2020202069662028696E707574242E6C656E67746820262620696E707574242E617474722827747970652729203D3D3D2027636865636B626F782729207B0A2020202020206D61705B696E70757424';
wwv_flow_imp.g_varchar2_table(195) := '2E61747472282776616C756527295D203D20696E707574242E617474722827646174612D6F6E2D6C6162656C27293B0A2020202020206D61705B696E707574242E617474722827646174612D6F66662D76616C756527295D203D20696E707574242E6174';
wwv_flow_imp.g_varchar2_table(196) := '74722827646174612D6F66662D6C6162656C27293B0A202020207D0A2020202072657475726E2066756E6374696F6E287629207B0A20202020202072657475726E204F626A6563742E70726F746F747970652E6861734F776E50726F70657274792E6361';
wwv_flow_imp.g_varchar2_table(197) := '6C6C286D61702C207629202626206D61705B765D20213D3D20756E646566696E6564203F206D61705B765D203A20763B0A202020207D3B0A20207D3B0A0A2020766172205F6973436F6D706F736974654669656C64203D2066756E6374696F6E286D6F64';
wwv_flow_imp.g_varchar2_table(198) := '656C2C206669656C6429207B0A20202020766172206C696D6974203D2035303B0A20202020666F7220287661722069203D20303B2069203C206C696D69743B20692B2B29207B0A20202020202076617220726563203D206D6F64656C2E7265636F726441';
wwv_flow_imp.g_varchar2_table(199) := '742869293B0A202020202020696620282172656329207B20627265616B3B207D0A2020202020207661722076616C7565203D206D6F64656C2E67657456616C7565287265632C206669656C64293B0A2020202020206966202876616C756520213D3D206E';
wwv_flow_imp.g_varchar2_table(200) := '756C6C2026262076616C756520213D3D20756E646566696E65642026262076616C756520213D3D20272729207B0A202020202020202072657475726E20747970656F662076616C7565203D3D3D20276F626A65637427202626204F626A6563742E70726F';
wwv_flow_imp.g_varchar2_table(201) := '746F747970652E6861734F776E50726F70657274792E63616C6C2876616C75652C20277627293B0A2020202020207D0A202020207D0A2020202072657475726E2066616C73653B0A20207D3B0A0A2020766172205F6973536B69707061626C655265636F';
wwv_flow_imp.g_varchar2_table(202) := '7264203D2066756E6374696F6E286D6F64656C2C207265636F726429207B0A20202020766172206D657461203D206D6F64656C2E6765745265636F72644D65746164617461286D6F64656C2E6765745265636F72644964287265636F72642929207C7C20';
wwv_flow_imp.g_varchar2_table(203) := '7B7D3B0A2020202072657475726E206D6574612E616767207C7C206D6574612E64656C65746564207C7C20216D6F64656C2E616C6C6F7745646974287265636F7264293B0A20207D3B0A0A2020766172205F77726974655669614D6F64656C203D206675';
wwv_flow_imp.g_varchar2_table(204) := '6E6374696F6E28677269642C20726F77732C20746172676574732C2072656A65637465642C206F7074696F6E7329207B0A202020206F7074696F6E73203D206F7074696F6E73207C7C207B7D3B0A20202020766172206D6F64656C203D20677269642E6D';
wwv_flow_imp.g_varchar2_table(205) := '6F64656C3B0A202020207661722073746172744964203D206F7074696F6E732E737461727449643B0A2020202069662028217374617274496429207B0A2020202020207661722063656C6C24203D20677269642E67657443757272656E7443656C6C2829';
wwv_flow_imp.g_varchar2_table(206) := '3B0A20202020202073746172744964203D2063656C6C242026262063656C6C242E636C6F736573742827747227292E617474722827646174612D696427293B0A202020207D0A202020207661722073746172745265636F7264203D207374617274496420';
wwv_flow_imp.g_varchar2_table(207) := '3F206D6F64656C2E6765745265636F7264287374617274496429203A206E756C6C3B0A2020202076617220696E646578203D2073746172745265636F7264203F206D6F64656C2E696E6465784F662873746172745265636F726429203A202D313B0A2020';
wwv_flow_imp.g_varchar2_table(208) := '202076617220726573756C74203D207B207772697474656E3A20302C20696E7365727465643A20302C2073746F707065643A2066616C7365207D3B0A2020202069662028696E646578203C203029207B2072657475726E206E756C6C3B207D0A0A202020';
wwv_flow_imp.g_varchar2_table(209) := '207661722072656A65637465644B657973203D207B7D3B0A2020202072656A65637465642E666F72456163682866756E6374696F6E287829207B2072656A65637465644B6579735B28782E726F77202D203129202B20273A27202B20782E636F6C5D203D';
wwv_flow_imp.g_varchar2_table(210) := '20783B207D293B0A0A2020202076617220646973706C61794D617073203D206F7074696F6E732E646973706C61794D617073207C7C207B7D3B0A2020202076617220636F6D706F73697465436F6C756D6E73203D206F7074696F6E732E636F6D706F7369';
wwv_flow_imp.g_varchar2_table(211) := '7465436F6C756D6E73207C7C207B7D3B0A2020202076617220636F6C756D6E73203D20746172676574732E6D61702866756E6374696F6E28636F6C29207B0A2020202020206966202821636F6C207C7C20215F69735772697461626C65436F6C756D6E28';
wwv_flow_imp.g_varchar2_table(212) := '677269642C20636F6C2929207B2072657475726E206E756C6C3B207D0A202020202020766172206C6F76446973706C6179203D20646973706C61794D6170735B636F6C2E70726F70657274795D3B0A20202020202072657475726E207B0A202020202020';
wwv_flow_imp.g_varchar2_table(213) := '2020636F6C3A20636F6C2C0A2020202020202020636F6D706F736974653A202121636F6D706F73697465436F6C756D6E735B636F6C2E70726F70657274795D207C7C205F6973436F6D706F736974654669656C64286D6F64656C2C20636F6C2E70726F70';
wwv_flow_imp.g_varchar2_table(214) := '65727479292C0A2020202020202020646973706C61793A206C6F76446973706C61790A202020202020202020203F2066756E6374696F6E287629207B2072657475726E204F626A6563742E70726F746F747970652E6861734F776E50726F70657274792E';
wwv_flow_imp.g_varchar2_table(215) := '63616C6C286C6F76446973706C61792C207629203F206C6F76446973706C61795B765D203A20763B207D0A202020202020202020203A205F646973706C61794C6F6F6B757028636F6C290A2020202020207D3B0A202020207D293B0A0A20202020766172';
wwv_flow_imp.g_varchar2_table(216) := '206C617374203D20696E646578203E2030203F206D6F64656C2E7265636F7264417428696E646578202D203129203A206E756C6C3B0A20202020696620286F7074696F6E732E696E7365727429207B0A2020202020206C617374203D2073746172745265';
wwv_flow_imp.g_varchar2_table(217) := '636F72643B0A202020207D0A0A202020207661722073757070726573736F72203D205F73757070726573734166746572496E736572742867726964293B0A20202020747279207B0A202020202020666F7220287661722072203D20303B2072203C20726F';
wwv_flow_imp.g_varchar2_table(218) := '77732E6C656E6774683B20722B2B29207B0A2020202020202020766172207265636F7264203D206F7074696F6E732E696E73657274203F206E756C6C203A206D6F64656C2E7265636F7264417428696E646578293B0A20202020202020207768696C6520';
wwv_flow_imp.g_varchar2_table(219) := '287265636F7264202626205F6973536B69707061626C655265636F7264286D6F64656C2C207265636F72642929207B0A20202020202020202020696E646578202B3D20313B0A202020202020202020207265636F7264203D206D6F64656C2E7265636F72';
wwv_flow_imp.g_varchar2_table(220) := '64417428696E646578293B0A20202020202020207D0A202020202020202069662028217265636F726429207B0A2020202020202020202069662028216D6F64656C2E616C6C6F77416464282929207B20726573756C742E73746F70706564203D20747275';
wwv_flow_imp.g_varchar2_table(221) := '653B20627265616B3B207D0A202020202020202020207265636F7264203D206D6F64656C2E6765745265636F7264286D6F64656C2E696E736572744E65775265636F7264286E756C6C2C206C61737429293B0A20202020202020202020726573756C742E';
wwv_flow_imp.g_varchar2_table(222) := '696E736572746564202B3D20313B0A20202020202020207D0A2020202020202020696E646578203D206D6F64656C2E696E6465784F66287265636F726429202B20313B0A20202020202020206C617374203D207265636F72643B0A0A2020202020202020';
wwv_flow_imp.g_varchar2_table(223) := '766172207265636F72644964203D206D6F64656C2E6765745265636F72644964287265636F7264293B0A2020202020202020666F7220287661722063203D20303B2063203C20636F6C756D6E732E6C656E6774683B20632B2B29207B0A20202020202020';
wwv_flow_imp.g_varchar2_table(224) := '20202076617220746172676574203D20636F6C756D6E735B635D3B0A20202020202020202020696620282174617267657429207B20636F6E74696E75653B207D0A202020202020202020207661722076616C7565203D20726F77735B725D5B635D3B0A20';
wwv_flow_imp.g_varchar2_table(225) := '20202020202020202076617220746F536574203D207461726765742E636F6D706F73697465203F207B20763A2076616C75652C20643A207461726765742E646973706C61792876616C756529207D203A2076616C75653B0A202020202020202020207472';
wwv_flow_imp.g_varchar2_table(226) := '79207B0A2020202020202020202020206D6F64656C2E73657456616C7565287265636F72642C207461726765742E636F6C2E70726F70657274792C20746F536574293B0A202020202020202020202020726573756C742E7772697474656E202B3D20313B';
wwv_flow_imp.g_varchar2_table(227) := '0A202020202020202020207D20636174636820286529207B0A2020202020202020202020206C6F676765722E7761726E696E672827436F756C64206E6F74207365742027202B207461726765742E636F6C2E70726F7065727479202B2027206F6E20726F';
wwv_flow_imp.g_varchar2_table(228) := '772027202B202872202B2031292C2065293B0A202020202020202020207D0A202020202020202020206966202872656A65637465644B6579735B72202B20273A27202B20635D29207B0A2020202020202020202020206D6F64656C2E73657456616C6964';
wwv_flow_imp.g_varchar2_table(229) := '69747928276572726F72272C207265636F726449642C207461726765742E636F6C2E70726F70657274792C2072656A65637465644B6579735B72202B20273A27202B20635D2E616D626967756F75730A20202020202020202020202020203F2027222720';
wwv_flow_imp.g_varchar2_table(230) := '2B2076616C7565202B202722206D617463686573206D6F7265207468616E206F6E65206C69737420656E747279270A20202020202020202020202020203A2027436F756C64206E6F7420636F6E76657274202227202B2076616C7565202B20272227293B';
wwv_flow_imp.g_varchar2_table(231) := '0A202020202020202020207D0A20202020202020207D0A2020202020207D0A202020207D2066696E616C6C79207B0A20202020202073757070726573736F722E72656C6561736528726573756C742E696E736572746564293B0A202020207D0A0A202020';
wwv_flow_imp.g_varchar2_table(232) := '2072657475726E20726573756C743B0A20207D3B0A0A2020766172205F73757070726573734166746572496E73657274203D2066756E6374696F6E286772696429207B0A20202020766172207361766564203D20677269642E6166746572496E73657274';
wwv_flow_imp.g_varchar2_table(233) := '43616C6C6261636B3B0A202020207661722063616C6C73203D20303B0A20202020766172206578706563746564203D206E756C6C3B0A2020202076617220726573746F726564203D2066616C73653B0A20202020766172207375707072657373203D2066';
wwv_flow_imp.g_varchar2_table(234) := '756E6374696F6E2829207B0A20202020202063616C6C73202B3D20313B0A20202020202069662028657870656374656420213D3D206E756C6C2026262063616C6C73203E3D20657870656374656429207B20726573746F726528293B207D0A202020207D';
wwv_flow_imp.g_varchar2_table(235) := '3B0A2020202076617220726573746F7265203D2066756E6374696F6E2829207B0A20202020202069662028726573746F72656429207B2072657475726E3B207D0A202020202020726573746F726564203D20747275653B0A202020202020696620286772';
wwv_flow_imp.g_varchar2_table(236) := '69642E6166746572496E7365727443616C6C6261636B203D3D3D20737570707265737329207B0A2020202020202020677269642E6166746572496E7365727443616C6C6261636B203D2073617665643B0A2020202020207D0A202020207D3B0A20202020';
wwv_flow_imp.g_varchar2_table(237) := '677269642E6166746572496E7365727443616C6C6261636B203D2073757070726573733B0A2020202072657475726E207B0A20202020202072656C656173653A2066756E6374696F6E28696E73657274656429207B0A2020202020202020657870656374';
wwv_flow_imp.g_varchar2_table(238) := '6564203D20696E7365727465643B0A20202020202020206966202863616C6C73203E3D20657870656374656429207B0A20202020202020202020726573746F726528293B0A2020202020202020202072657475726E3B0A20202020202020207D0A202020';
wwv_flow_imp.g_varchar2_table(239) := '202020202073657454696D656F75742866756E6374696F6E2829207B0A202020202020202020206966202821726573746F72656429207B0A2020202020202020202020206C6F676765722E6C6F672827526573746F72696E67206166746572496E736572';
wwv_flow_imp.g_varchar2_table(240) := '7443616C6C6261636B2061667465722027202B2063616C6C73202B2027206F662027202B206578706563746564202B202720696E73657274206E6F74696669636174696F6E28732927293B0A202020202020202020202020726573746F726528293B0A20';
wwv_flow_imp.g_varchar2_table(241) := '2020202020202020207D0A20202020202020207D2C2041465445525F494E534552545F46414C4C4241434B5F4D53293B0A2020202020207D0A202020207D3B0A20207D3B0A0A2020766172205F7265736F6C7665506F7075704C6F7673203D2066756E63';
wwv_flow_imp.g_varchar2_table(242) := '74696F6E28616A61784964656E7469666965722C20726F77732C20746172676574732C20636F6C756D6E4D6574612C20737461747329207B0A20202020766172206C6F6F6B757073203D205B5D3B0A2020202076617220646973706C61794D617073203D';
wwv_flow_imp.g_varchar2_table(243) := '207B7D3B0A0A20202020746172676574732E666F72456163682866756E6374696F6E28636F6C2C206329207B0A2020202020206966202821636F6C207C7C2028636F6C756D6E4D6574615B636F6C2E70726F70657274795D207C7C207B7D292E6974656D';
wwv_flow_imp.g_varchar2_table(244) := '5479706520213D3D204954454D5F504F5055505F4C4F5629207B2072657475726E3B207D0A2020202020207661722064697374696E6374203D205B5D3B0A202020202020726F77732E666F72456163682866756E6374696F6E28726F7729207B0A202020';
wwv_flow_imp.g_varchar2_table(245) := '202020202069662028726F775B635D20213D3D2027272026262064697374696E63742E696E6465784F6628726F775B635D29203C203029207B2064697374696E63742E7075736828726F775B635D293B207D0A2020202020207D293B0A20202020202069';
wwv_flow_imp.g_varchar2_table(246) := '6620282164697374696E63742E6C656E67746829207B2072657475726E3B207D0A0A2020202020206C6F6F6B7570732E70757368280A2020202020202020617065782E7365727665722E706C7567696E28616A61784964656E7469666965722C207B2078';
wwv_flow_imp.g_varchar2_table(247) := '30313A20636F6C2E70726F70657274792C206630313A2064697374696E6374207D2C207B2064617461547970653A20276A736F6E27207D290A202020202020202020202E7468656E2866756E6374696F6E286461746129207B0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(248) := '20207661722076616C756573203D20286461746120262620646174612E76616C75657329207C7C207B7D3B0A20202020202020202020202076617220616D626967756F7573203D20286461746120262620646174612E616D626967756F757329207C7C20';
wwv_flow_imp.g_varchar2_table(249) := '5B5D3B0A202020202020202020202020696620286461746120262620646174612E756E737570706F7274656429207B0A20202020202020202020202020206C6F676765722E7761726E696E672827506F707570204C4F56206C6F6F6B757020666F722027';
wwv_flow_imp.g_varchar2_table(250) := '202B20636F6C2E70726F7065727479202B2027206E6F7420737570706F727465643A2027202B20646174612E756E737570706F72746564293B0A2020202020202020202020207D0A202020202020202020202020646973706C61794D6170735B636F6C2E';
wwv_flow_imp.g_varchar2_table(251) := '70726F70657274795D203D207B7D3B0A202020202020202020202020726F77732E666F72456163682866756E6374696F6E28726F772C207229207B0A20202020202020202020202020207661722076203D20726F775B635D3B0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(252) := '202020206966202876203D3D3D20272729207B2072657475726E3B207D0A202020202020202020202020202076617220686974203D2076616C7565735B765D3B0A2020202020202020202020202020696620282168697429207B0A202020202020202020';
wwv_flow_imp.g_varchar2_table(253) := '2020202020202073746174732E72656A65637465642E70757368287B0A202020202020202020202020202020202020726F773A2072202B20312C20636F6C3A20632C20636F6C756D6E3A20636F6C2E6C6162656C207C7C205F7374726970546167732863';
wwv_flow_imp.g_varchar2_table(254) := '6F6C2E68656164696E6729207C7C20636F6C2E70726F70657274792C2076616C75653A20762C0A202020202020202020202020202020202020616D626967756F75733A20616D626967756F75732E696E6465784F66287629203E3D20300A202020202020';
wwv_flow_imp.g_varchar2_table(255) := '202020202020202020207D293B0A2020202020202020202020202020202072657475726E3B0A20202020202020202020202020207D0A2020202020202020202020202020646973706C61794D6170735B636F6C2E70726F70657274795D5B6869742E725D';
wwv_flow_imp.g_varchar2_table(256) := '203D206869742E643B0A2020202020202020202020202020696620286869742E7220213D3D207629207B0A20202020202020202020202020202020726F775B635D203D206869742E723B0A2020202020202020202020202020202073746174732E636F6E';
wwv_flow_imp.g_varchar2_table(257) := '766572746564202B3D20313B0A20202020202020202020202020207D0A2020202020202020202020207D293B0A202020202020202020207D290A202020202020293B0A202020207D293B0A0A2020202072657475726E2050726F6D6973652E616C6C286C';
wwv_flow_imp.g_varchar2_table(258) := '6F6F6B757073292E7468656E2866756E6374696F6E2829207B0A20202020202072657475726E207B20646973706C61794D6170733A20646973706C61794D617073207D3B0A202020207D293B0A20207D3B0A0A2020766172205F6170706C794C696E6542';
wwv_flow_imp.g_varchar2_table(259) := '7265616B73203D2066756E6374696F6E28726F77732C20746172676574732C20636F6C756D6E4D65746129207B0A20202020746172676574732E666F72456163682866756E6374696F6E28636F6C2C206329207B0A2020202020206966202821636F6C20';
wwv_flow_imp.g_varchar2_table(260) := '7C7C204D554C54494C494E455F4954454D5F54595045532E696E6465784F662828636F6C756D6E4D6574615B636F6C2E70726F70657274795D207C7C207B7D292E6974656D5479706529203E3D203029207B2072657475726E3B207D0A20202020202072';
wwv_flow_imp.g_varchar2_table(261) := '6F77732E666F72456163682866756E6374696F6E28726F7729207B0A202020202020202069662028726F775B635D20262620726F775B635D2E696E6465784F6628275C6E2729203E3D203029207B20726F775B635D203D20726F775B635D2E7265706C61';
wwv_flow_imp.g_varchar2_table(262) := '6365282F5C6E2B2F672C20272027293B207D0A2020202020207D293B0A202020207D293B0A20207D3B0A0A2020766172205F636F6E766572745461626C65203D2066756E6374696F6E28726F77732C20746172676574732C20636F6C756D6E4D6574612C';
wwv_flow_imp.g_varchar2_table(263) := '20736F7572636544617465466F726D61742C20736F75726365446563696D616C29207B0A20202020766172207374617473203D207B20636F6E7665727465643A20302C2072656A65637465643A205B5D207D3B0A2020202076617220736F757263654F72';
wwv_flow_imp.g_varchar2_table(264) := '646572203D205F6461794D6F6E74684F7264657228736F7572636544617465466F726D6174293B0A0A20202020746172676574732E666F72456163682866756E6374696F6E28636F6C2C206329207B0A2020202020206966202821636F6C29207B207265';
wwv_flow_imp.g_varchar2_table(265) := '7475726E3B207D0A202020202020766172206D657461203D20636F6C756D6E4D6574615B636F6C2E70726F70657274795D207C7C207B7D3B0A20202020202076617220636F6E76657274203D206E756C6C3B0A0A20202020202069662028444154455F54';
wwv_flow_imp.g_varchar2_table(266) := '595045532E696E6465784F66286D6574612E646174615479706529203E3D203029207B0A20202020202020207661722076616C756573203D20726F77732E6D61702866756E6374696F6E28726F7729207B2072657475726E20726F775B635D3B207D293B';
wwv_flow_imp.g_varchar2_table(267) := '0A2020202020202020766172206F72646572203D205F696E666572436F6C756D6E4F726465722876616C75657329207C7C20736F757263654F726465723B0A2020202020202020766172206D61736B203D206D6574612E666F726D61744D61736B207C7C';
wwv_flow_imp.g_varchar2_table(268) := '20756E646566696E65643B0A2020202020202020636F6E76657274203D2066756E6374696F6E287629207B0A202020202020202020207661722064617465203D205F70617273654461746528762C206F726465722C20736F7572636544617465466F726D';
wwv_flow_imp.g_varchar2_table(269) := '6174293B0A2020202020202020202072657475726E2064617465203F20617065782E646174652E666F726D617428646174652C206D61736B29203A20756E646566696E65643B0A20202020202020207D3B0A2020202020207D20656C736520696620286D';
wwv_flow_imp.g_varchar2_table(270) := '6574612E6974656D54797065203D3D3D204954454D5F53454C4543545F4C49535429207B0A2020202020202020636F6E76657274203D205F73656C6563744C6973745265736F6C76657228636F6C293B0A2020202020207D20656C736520696620286D65';
wwv_flow_imp.g_varchar2_table(271) := '74612E6974656D54797065203D3D3D204954454D5F53574954434829207B0A2020202020202020636F6E76657274203D205F7377697463685265736F6C76657228636F6C293B0A2020202020207D20656C736520696620286D6574612E64617461547970';
wwv_flow_imp.g_varchar2_table(272) := '65203D3D3D20274E554D42455227202626204E554D4245525F4954454D5F54595045532E696E6465784F66286D6574612E6974656D5479706529203E3D203029207B0A202020202020202076617220646563696D616C536570203D205F696E666572436F';
wwv_flow_imp.g_varchar2_table(273) := '6C756D6E446563696D616C28726F77732E6D61702866756E6374696F6E28726F7729207B2072657475726E20726F775B635D3B207D2929207C7C20736F75726365446563696D616C3B0A2020202020202020636F6E76657274203D2066756E6374696F6E';
wwv_flow_imp.g_varchar2_table(274) := '287629207B0A20202020202020202020766172206E203D205F70617273654E756D62657228762C20646563696D616C536570293B0A2020202020202020202072657475726E206E203D3D3D206E756C6C203F20756E646566696E6564203A205F666F726D';
wwv_flow_imp.g_varchar2_table(275) := '61744E756D626572466F7253657373696F6E286E293B0A20202020202020207D3B0A2020202020207D0A2020202020206966202821636F6E7665727429207B2072657475726E3B207D0A0A202020202020726F77732E666F72456163682866756E637469';
wwv_flow_imp.g_varchar2_table(276) := '6F6E28726F772C207229207B0A20202020202020207661722076203D20726F775B635D3B0A20202020202020206966202876203D3D3D20272729207B2072657475726E3B207D0A2020202020202020766172206F7574203D20636F6E766572742876293B';
wwv_flow_imp.g_varchar2_table(277) := '0A2020202020202020696620286F7574203D3D3D20756E646566696E656429207B0A2020202020202020202073746174732E72656A65637465642E70757368287B20726F773A2072202B20312C20636F6C3A20632C20636F6C756D6E3A20636F6C2E6C61';
wwv_flow_imp.g_varchar2_table(278) := '62656C207C7C205F73747269705461677328636F6C2E68656164696E6729207C7C20636F6C2E70726F70657274792C2076616C75653A2076207D293B0A20202020202020207D20656C736520696620286F757420213D3D207629207B0A20202020202020';
wwv_flow_imp.g_varchar2_table(279) := '202020726F775B635D203D206F75743B0A2020202020202020202073746174732E636F6E766572746564202B3D20313B0A20202020202020207D0A2020202020207D293B0A202020207D293B0A2020202072657475726E2073746174733B0A20207D3B0A';
wwv_flow_imp.g_varchar2_table(280) := '0A2020766172205F646573637269626552656A6563746564203D2066756E6374696F6E2872656A656374656429207B0A2020202072657475726E2072656A65637465642E736C69636528302C2033292E6D61702866756E6374696F6E287829207B0A2020';
wwv_flow_imp.g_varchar2_table(281) := '2020202072657475726E2027726F772027202B20782E726F77202B20272C2027202B20782E636F6C756D6E202B2027202227202B20782E76616C7565202B20272227202B2028782E616D626967756F7573203F20272028616D626967756F75732927203A';
wwv_flow_imp.g_varchar2_table(282) := '202727293B0A202020207D292E6A6F696E28273B202729202B202872656A65637465642E6C656E677468203E2033203F2027E280A627203A202727293B0A20207D3B0A0A2020766172205F7265706F72745061737465203D2066756E6374696F6E28726F';
wwv_flow_imp.g_varchar2_table(283) := '77436F756E742C2073746174732C206865616465722C20696E7365727429207B0A202020206966202821686561646572202626202173746174732E636F6E766572746564202626202173746174732E72656A65637465642E6C656E67746829207B207265';
wwv_flow_imp.g_varchar2_table(284) := '7475726E3B207D0A20202020766172206D7367203D20726F77436F756E74202B202720726F772873292027202B2028696E73657274203F2027696E73657274656427203A20277061737465642729202B202720C2B72027202B2073746174732E636F6E76';
wwv_flow_imp.g_varchar2_table(285) := '6572746564202B20272076616C756528732920636F6E766572746564273B0A202020206966202868656164657229207B0A2020202020206D7367202B3D202720C2B7206D617463686564206279206865616465723A2027202B206865616465722E6D6174';
wwv_flow_imp.g_varchar2_table(286) := '636865642E6A6F696E28272C2027293B0A202020202020696620286865616465722E69676E6F7265642E6C656E67746829207B0A20202020202020206D7367202B3D202720C2B72069676E6F7265643A2027202B206865616465722E69676E6F7265642E';
wwv_flow_imp.g_varchar2_table(287) := '6A6F696E28272C2027293B0A2020202020207D0A202020207D0A202020206966202873746174732E72656A65637465642E6C656E67746829207B0A2020202020206D7367202B3D202720C2B72027202B2073746174732E72656A65637465642E6C656E67';
wwv_flow_imp.g_varchar2_table(288) := '7468202B202720636F756C64206E6F7420626520636F6E7665727465643A2027202B205F646573637269626552656A65637465642873746174732E72656A6563746564293B0A2020202020206C6F676765722E7761726E696E67282756616C756573206C';
wwv_flow_imp.g_varchar2_table(289) := '65667420756E636F6E766572746564272C2073746174732E72656A6563746564293B0A202020207D0A20202020617065782E6D6573736167652E73686F77506167655375636365737328617065782E7574696C2E65736361706548544D4C286D73672929';
wwv_flow_imp.g_varchar2_table(290) := '3B0A20207D3B0A0A2020766172205F7265736F6C766550617374654D6F6465203D2066756E6374696F6E28636F6E666967757265642C207370656369616C29207B0A2020202069662028636F6E66696775726564203D3D3D2050415354455F4D4F44452E';
wwv_flow_imp.g_varchar2_table(291) := '494E53455254207C7C20636F6E66696775726564203D3D3D2050415354455F4D4F44452E415050454E4429207B0A20202020202072657475726E20636F6E666967757265643B0A202020207D0A2020202072657475726E207370656369616C203F205041';
wwv_flow_imp.g_varchar2_table(292) := '5354455F4D4F44452E494E53455254203A2050415354455F4D4F44452E5245504C4143453B0A20207D3B0A0A2020766172205F636865636B43616E496E73657274203D2066756E6374696F6E286772696429207B0A2020202069662028677269642E6D6F';
wwv_flow_imp.g_varchar2_table(293) := '64656C2E616C6C6F77416464282929207B2072657475726E20747275653B207D0A20202020617065782E6D6573736167652E636C6561724572726F727328293B0A20202020617065782E6D6573736167652E73686F774572726F7273285B7B0A20202020';
wwv_flow_imp.g_varchar2_table(294) := '2020747970653A20276572726F72270A2020202020202C206C6F636174696F6E3A202770616765270A2020202020202C206D6573736167653A20274E6F7468696E6720776173207061737465643A2074686973206772696420646F6573206E6F7420616C';
wwv_flow_imp.g_varchar2_table(295) := '6C6F7720616464696E6720726F77732E270A202020207D5D293B0A2020202072657475726E2066616C73653B0A20207D3B0A0A2020766172205F6C617374446174615265636F7264203D2066756E6374696F6E286D6F64656C29207B0A20202020766172';
wwv_flow_imp.g_varchar2_table(296) := '206C617374203D206E756C6C3B0A202020206D6F64656C2E666F72456163682866756E6374696F6E287265636F726429207B0A2020202020206966202821286D6F64656C2E6765745265636F72644D65746164617461286D6F64656C2E6765745265636F';
wwv_flow_imp.g_varchar2_table(297) := '72644964287265636F72642929207C7C207B7D292E61676729207B206C617374203D207265636F72643B207D0A202020207D293B0A2020202072657475726E206C6173743B0A20207D3B0A0A2020766172205F6D6F7665546F5265636F7264526F77203D';
wwv_flow_imp.g_varchar2_table(298) := '2066756E6374696F6E28677269642C2063656C6C242C207265636F7264496429207B0A2020202076617220726F7724203D2063656C6C242E636C6F73657374282774626F647927292E6368696C6472656E2827747227292E66696C7465722866756E6374';
wwv_flow_imp.g_varchar2_table(299) := '696F6E2829207B0A20202020202072657475726E20242874686973292E617474722827646174612D69642729203D3D3D207265636F726449643B0A202020207D293B0A202020207661722074617267657424203D20726F77242E6368696C6472656E2829';
wwv_flow_imp.g_varchar2_table(300) := '2E65712863656C6C242E696E6465782829293B0A202020206966202821746172676574242E6C656E67746829207B2072657475726E2066616C73653B207D0A20202020677269642E73657443757272656E7443656C6C2874617267657424293B0A202020';
wwv_flow_imp.g_varchar2_table(301) := '20677269642E5F73657443757272656E74526F7728746172676574245B305D293B0A2020202072657475726E20747275653B0A20207D3B0A0A2020766172205F66696E6973685061737465203D2066756E6374696F6E28677269642C206F726967696E61';
wwv_flow_imp.g_varchar2_table(302) := '6C50617374652C2064617461526F77732C20746172676574732C2073746174732C206865616465722C20706C6163656D656E742C206D6F64656C4F7074696F6E732C2063666729207B0A2020202076617220696E73657274203D20706C6163656D656E74';
wwv_flow_imp.g_varchar2_table(303) := '2E696E736572743B0A20202020696620286366672E72656A6563744F6E4572726F72732026262073746174732E72656A65637465642E6C656E67746829207B0A202020202020617065782E6D6573736167652E636C6561724572726F727328293B0A2020';
wwv_flow_imp.g_varchar2_table(304) := '20202020617065782E6D6573736167652E73686F774572726F7273285B7B0A2020202020202020747970653A20276572726F72270A20202020202020202C206C6F636174696F6E3A202770616765270A20202020202020202C206D6573736167653A2027';
wwv_flow_imp.g_varchar2_table(305) := '4E6F7468696E6720776173207061737465643A2027202B2073746174732E72656A65637465642E6C656E677468202B20272076616C756528732920636F756C64206E6F7420626520636F6E766572746564202827202B0A2020202020202020202020205F';
wwv_flow_imp.g_varchar2_table(306) := '646573637269626552656A65637465642873746174732E72656A656374656429202B202729270A2020202020207D5D293B0A2020202020206C6F676765722E7761726E696E67282750617374652072656A65637465642028616C6C2D6F722D6E6F746869';
wwv_flow_imp.g_varchar2_table(307) := '6E6729272C2073746174732E72656A6563746564293B0A20202020202072657475726E3B0A202020207D0A0A20202020766172207573654D6F64656C203D20212128686561646572207C7C206D6F64656C4F7074696F6E73293B0A202020206966202821';
wwv_flow_imp.g_varchar2_table(308) := '7573654D6F64656C20262620706C6163656D656E742E6D6F6465203D3D3D2050415354455F4D4F44452E415050454E442026260A2020202020202020215F6D6F7665546F5265636F7264526F7728677269642C20706C6163656D656E742E63656C6C242C';
wwv_flow_imp.g_varchar2_table(309) := '20706C6163656D656E742E616E63686F7249642929207B0A2020202020206C6F676765722E6C6F672827417070656E643A20746865206C617374206C6F6164656420726F77206973206E6F742072656E64657265643B2077726974696E67207468726F75';
wwv_flow_imp.g_varchar2_table(310) := '676820746865206D6F64656C27293B0A2020202020207573654D6F64656C203D20747275653B0A202020207D0A0A202020206C6F676765722E6C6F67282750617374696E672027202B2064617461526F77732E6C656E677468202B202720726F77287329';
wwv_flow_imp.g_varchar2_table(311) := '2027202B2028686561646572203F202762792068656164657227203A2027627920706F736974696F6E2729202B0A20202020202028696E73657274203F2027206173206E657720726F7773202827202B20706C6163656D656E742E6D6F6465202B202729';
wwv_flow_imp.g_varchar2_table(312) := '27203A20272729202B202720696E746F20636F6C756D6E732027202B0A202020202020746172676574732E6D61702866756E6374696F6E287429207B2072657475726E2074203F20742E70726F7065727479203A20272D273B207D292E6A6F696E28272C';
wwv_flow_imp.g_varchar2_table(313) := '2027292C0A2020202020207B2073746174733A2073746174732C206669727374526F77733A2064617461526F77732E736C69636528302C203329207D293B0A0A20202020696620287573654D6F64656C29207B0A20202020202076617220726573756C74';
wwv_flow_imp.g_varchar2_table(314) := '203D205F77726974655669614D6F64656C28677269642C2064617461526F77732C20746172676574732C2073746174732E72656A65637465642C0A2020202020202020242E657874656E64287B20696E736572743A20696E73657274207D2C206D6F6465';
wwv_flow_imp.g_varchar2_table(315) := '6C4F7074696F6E732C207B20737461727449643A20706C6163656D656E742E616E63686F724964207D29293B0A2020202020206966202821726573756C7429207B0A20202020202020206C6F676765722E6572726F72282753505245414453484545545F';
wwv_flow_imp.g_varchar2_table(316) := '50415354453A20636F756C64206E6F74206C6F63617465207468652063757272656E7420726F7720696E20746865206D6F64656C27293B0A202020202020202072657475726E3B0A2020202020207D0A20202020202069662028726573756C742E73746F';
wwv_flow_imp.g_varchar2_table(317) := '7070656429207B0A20202020202020206C6F676765722E7761726E696E67282752616E206F7574206F6620726F777320616E642074686973206772696420646F6573206E6F7420616C6C6F7720616464696E6720726F77733B2072656D61696E696E6720';
wwv_flow_imp.g_varchar2_table(318) := '726F7773206E6F742070617374656427293B0A2020202020207D0A202020207D20656C7365207B0A2020202020206F726967696E616C50617374652E63616C6C28677269642C207B0A202020202020202074797065733A205B415045585F475249445F4D';
wwv_flow_imp.g_varchar2_table(319) := '494D455D0A20202020202020202C207370656369616C3A20696E736572740A20202020202020202C206173796E63476574446174613A2066756E6374696F6E2829207B2072657475726E2050726F6D6973652E7265736F6C76652864617461526F777329';
wwv_flow_imp.g_varchar2_table(320) := '3B207D0A2020202020207D293B0A202020207D0A202020205F7265706F727450617374652864617461526F77732E6C656E6774682C2073746174732C206865616465722C20696E73657274293B0A20207D3B0A0A2020766172205F68616E646C65537072';
wwv_flow_imp.g_varchar2_table(321) := '65616473686565745061737465203D2066756E6374696F6E28677269642C206173796E63446174615472616E736665722C206F726967696E616C50617374652C2063666729207B0A20202020766172207479706573203D2041727261792E70726F746F74';
wwv_flow_imp.g_varchar2_table(322) := '7970652E736C6963652E63616C6C286173796E63446174615472616E736665722E7479706573207C7C205B5D293B0A20202020766172207370656369616C203D2021216173796E63446174615472616E736665722E7370656369616C3B0A202020207661';
wwv_flow_imp.g_varchar2_table(323) := '72206D6F6465203D205F7265736F6C766550617374654D6F6465286366672E70617374654D6F64652C207370656369616C293B0A2020202076617220696E73657274203D206D6F646520213D3D2050415354455F4D4F44452E5245504C4143453B0A2020';
wwv_flow_imp.g_varchar2_table(324) := '20207661722063656C6C24203D20677269642E67657443757272656E7443656C6C28293B0A202020207661722073746172744964203D2063656C6C242026262063656C6C242E6C656E677468203F2063656C6C242E636C6F736573742827747227292E61';
wwv_flow_imp.g_varchar2_table(325) := '7474722827646174612D69642729203A206E756C6C3B0A0A2020202076617220706C6163656D656E74466F72203D2066756E6374696F6E2829207B0A20202020202076617220616E63686F724964203D20737461727449643B0A20202020202069662028';
wwv_flow_imp.g_varchar2_table(326) := '6D6F6465203D3D3D2050415354455F4D4F44452E415050454E4429207B0A2020202020202020766172206C617374203D205F6C617374446174615265636F726428677269642E6D6F64656C293B0A2020202020202020616E63686F724964203D206C6173';
wwv_flow_imp.g_varchar2_table(327) := '74203F20677269642E6D6F64656C2E6765745265636F72644964286C61737429203A20737461727449643B0A2020202020207D0A20202020202072657475726E207B206D6F64653A206D6F64652C20696E736572743A20696E736572742C20616E63686F';
wwv_flow_imp.g_varchar2_table(328) := '7249643A20616E63686F7249642C2063656C6C243A2063656C6C24207D3B0A202020207D3B0A0A202020206966202874797065732E696E6465784F6628415045585F475249445F4D494D4529203E3D203029207B0A202020202020696620286D6F646520';
wwv_flow_imp.g_varchar2_table(329) := '3D3D3D2050415354455F4D4F44452E5245504C414345207C7C20286D6F6465203D3D3D2050415354455F4D4F44452E494E53455254202626207370656369616C2929207B0A202020202020202072657475726E206F726967696E616C50617374652E6361';
wwv_flow_imp.g_varchar2_table(330) := '6C6C28677269642C206173796E63446174615472616E73666572293B0A2020202020207D0A20202020202072657475726E206173796E63446174615472616E736665722E6173796E634765744461746128415045585F475249445F4D494D45292E746865';
wwv_flow_imp.g_varchar2_table(331) := '6E2866756E6374696F6E28677269644461746129207B0A20202020202020207661722073696E676C65203D202141727261792E6973417272617928677269644461746129207C7C202867726964446174612E6C656E677468203D3D3D2031202626206772';
wwv_flow_imp.g_varchar2_table(332) := '6964446174615B305D2E6C656E677468203C2032293B0A2020202020202020696620282173696E676C6529207B0A2020202020202020202069662028215F636865636B43616E496E7365727428677269642929207B2072657475726E3B207D0A20202020';
wwv_flow_imp.g_varchar2_table(333) := '20202020202076617220706C6163656D656E74203D20706C6163656D656E74466F7228293B0A20202020202020202020696620286D6F6465203D3D3D2050415354455F4D4F44452E415050454E44202626207374617274496420262620215F6D6F766554';
wwv_flow_imp.g_varchar2_table(334) := '6F5265636F7264526F7728677269642C2063656C6C242C20706C6163656D656E742E616E63686F7249642929207B0A2020202020202020202020206C6F676765722E7761726E696E672827417070656E643A20746865206C617374206C6F616465642072';
wwv_flow_imp.g_varchar2_table(335) := '6F77206973206E6F742072656E64657265643B20696E73657274696E672062656C6F77207468652063757272656E7420726F7727293B0A202020202020202020207D0A20202020202020207D0A20202020202020206F726967696E616C50617374652E63';
wwv_flow_imp.g_varchar2_table(336) := '616C6C28677269642C207B0A2020202020202020202074797065733A205B415045585F475249445F4D494D455D0A202020202020202020202C207370656369616C3A2073696E676C65203F207370656369616C203A20747275650A202020202020202020';
wwv_flow_imp.g_varchar2_table(337) := '202C206173796E63476574446174613A2066756E6374696F6E2829207B2072657475726E2050726F6D6973652E7265736F6C7665286772696444617461293B207D0A20202020202020207D293B0A2020202020207D293B0A202020207D0A0A2020202076';
wwv_flow_imp.g_varchar2_table(338) := '61722072656164203D2066756E6374696F6E287479706529207B0A20202020202072657475726E2074797065732E696E6465784F66287479706529203E3D2030203F206173796E63446174615472616E736665722E6173796E6347657444617461287479';
wwv_flow_imp.g_varchar2_table(339) := '706529203A2050726F6D6973652E7265736F6C7665282727293B0A202020207D3B0A202020207661722068746D6C50203D20726561642827746578742F68746D6C27293B0A20202020766172207465787450203D20726561642827746578742F706C6169';
wwv_flow_imp.g_varchar2_table(340) := '6E27293B0A0A2020202072657475726E2050726F6D6973652E616C6C285B68746D6C502C2074657874505D292E7468656E2866756E6374696F6E286461746129207B0A2020202020207661722068746D6C203D20646174615B305D207C7C2027272C2074';
wwv_flow_imp.g_varchar2_table(341) := '657874203D20646174615B315D207C7C2027273B0A0A202020202020766172207265706C6179203D2066756E6374696F6E28726561736F6E29207B0A20202020202020206C6F676765722E6C6F6728275061737465206C65667420746F206E6174697665';
wwv_flow_imp.g_varchar2_table(342) := '20677269643A2027202B20726561736F6E293B0A20202020202020206F726967696E616C50617374652E63616C6C28677269642C207B0A2020202020202020202074797065733A2074797065732E66696C7465722866756E6374696F6E287429207B2072';
wwv_flow_imp.g_varchar2_table(343) := '657475726E2074203D3D3D2027746578742F68746D6C27207C7C2074203D3D3D2027746578742F706C61696E273B207D290A202020202020202020202C207370656369616C3A207370656369616C0A202020202020202020202C206173796E6347657444';
wwv_flow_imp.g_varchar2_table(344) := '6174613A2066756E6374696F6E287479706529207B2072657475726E2050726F6D6973652E7265736F6C76652874797065203D3D3D2027746578742F68746D6C27203F2068746D6C203A2074657874293B207D0A20202020202020207D293B0A20202020';
wwv_flow_imp.g_varchar2_table(345) := '20207D3B0A0A202020202020696620282163656C6C24207C7C202163656C6C242E6C656E677468207C7C202163656C6C242E686173436C6173732827612D47562D63656C6C2729207C7C20217374617274496429207B0A20202020202020207265747572';
wwv_flow_imp.g_varchar2_table(346) := '6E207265706C6179282763757272656E742063656C6C206973206E6F74206120646174612063656C6C27293B0A2020202020207D0A20202020202076617220726F7773203D205F72656164436C6970626F6172645461626C65287B20676574446174613A';
wwv_flow_imp.g_varchar2_table(347) := '2066756E6374696F6E287479706529207B2072657475726E2074797065203D3D3D2027746578742F68746D6C27203F2068746D6C203A20746578743B207D207D293B0A2020202020206966202821726F777329207B0A202020202020202072657475726E';
wwv_flow_imp.g_varchar2_table(348) := '207265706C61792827636C6970626F617264206973206E6F7420746162756C617227293B0A2020202020207D0A20202020202069662028726F77732E6C656E677468203D3D3D203120262620726F77735B305D2E6C656E677468203D3D3D203129207B0A';
wwv_flow_imp.g_varchar2_table(349) := '20202020202020207661722063656C6C54617267657473203D205F7265736F6C7665546172676574436F6C756D6E7328677269642C2031293B0A2020202020202020696620282163656C6C5461726765747329207B0A2020202020202020202072657475';
wwv_flow_imp.g_varchar2_table(350) := '726E207265706C6179282763757272656E742063656C6C206973206E6F74206120646174612063656C6C27293B0A20202020202020207D0A20202020202020205F6170706C794C696E65427265616B7328726F77732C2063656C6C546172676574732C20';
wwv_flow_imp.g_varchar2_table(351) := '6366672E636F6C756D6E4D657461293B0A20202020202020206C6F676765722E6C6F67282750617374696E672061206D756C74692D6C696E652076616C756520696E746F2027202B202863656C6C546172676574735B305D203F2063656C6C5461726765';
wwv_flow_imp.g_varchar2_table(352) := '74735B305D2E70726F7065727479203A20272D2729293B0A202020202020202072657475726E206F726967696E616C50617374652E63616C6C28677269642C207B0A2020202020202020202074797065733A205B415045585F475249445F4D494D455D0A';
wwv_flow_imp.g_varchar2_table(353) := '202020202020202020202C207370656369616C3A207370656369616C0A202020202020202020202C206173796E63476574446174613A2066756E6374696F6E2829207B2072657475726E2050726F6D6973652E7265736F6C766528726F7773293B207D0A';
wwv_flow_imp.g_varchar2_table(354) := '20202020202020207D293B0A2020202020207D0A20202020202069662028696E7365727420262620215F636865636B43616E496E7365727428677269642929207B0A202020202020202072657475726E3B0A2020202020207D0A20202020202076617220';
wwv_flow_imp.g_varchar2_table(355) := '706C6163656D656E74203D20706C6163656D656E74466F7228293B0A0A20202020202076617220686561646572203D20726F77732E6C656E677468203E2031203F205F6D61746368486561646572526F7728677269642C20726F77735B305D29203A206E';
wwv_flow_imp.g_varchar2_table(356) := '756C6C3B0A2020202020207661722064617461526F7773203D20686561646572203F20726F77732E736C696365283129203A20726F77733B0A2020202020207661722074617267657473203D20686561646572203F206865616465722E74617267657473';
wwv_flow_imp.g_varchar2_table(357) := '203A205F7265736F6C7665546172676574436F6C756D6E7328677269642C20726F77735B305D2E6C656E677468293B0A20202020202069662028217461726765747329207B0A202020202020202072657475726E207265706C6179282763757272656E74';
wwv_flow_imp.g_varchar2_table(358) := '2063656C6C206973206E6F74206120646174612063656C6C27293B0A2020202020207D0A0A2020202020207661722073746174733B0A202020202020747279207B0A20202020202020205F6170706C794C696E65427265616B732864617461526F77732C';
wwv_flow_imp.g_varchar2_table(359) := '20746172676574732C206366672E636F6C756D6E4D657461293B0A20202020202020207374617473203D205F636F6E766572745461626C652864617461526F77732C20746172676574732C206366672E636F6C756D6E4D6574612C206366672E736F7572';
wwv_flow_imp.g_varchar2_table(360) := '636544617465466F726D61742C206366672E736F75726365446563696D616C293B0A2020202020207D20636174636820286529207B0A20202020202020206C6F676765722E6572726F72282753505245414453484545545F50415354453A20636F6E7665';
wwv_flow_imp.g_varchar2_table(361) := '7273696F6E206661696C6564272C2065293B0A202020202020202072657475726E207265706C61792827636F6E76657273696F6E206661696C656427293B0A2020202020207D0A0A20202020202076617220706F707570436F6C756D6E73203D20746172';
wwv_flow_imp.g_varchar2_table(362) := '676574732E66696C7465722866756E6374696F6E287429207B0A202020202020202072657475726E207420262620286366672E636F6C756D6E4D6574615B742E70726F70657274795D207C7C207B7D292E6974656D54797065203D3D3D204954454D5F50';
wwv_flow_imp.g_varchar2_table(363) := '4F5055505F4C4F563B0A2020202020207D293B0A2020202020206966202821706F707570436F6C756D6E732E6C656E67746829207B0A202020202020202072657475726E205F66696E697368506173746528677269642C206F726967696E616C50617374';
wwv_flow_imp.g_varchar2_table(364) := '652C2064617461526F77732C20746172676574732C2073746174732C206865616465722C20706C6163656D656E742C206E756C6C2C20636667293B0A2020202020207D0A0A20202020202076617220726567696F6E24203D202428272327202B20636667';
wwv_flow_imp.g_varchar2_table(365) := '2E726567696F6E4964292E616464436C61737328425553595F434C415353293B0A20202020202072657475726E205F7265736F6C7665506F7075704C6F7673286366672E616A61784964656E7469666965722C2064617461526F77732C20746172676574';
wwv_flow_imp.g_varchar2_table(366) := '732C206366672E636F6C756D6E4D6574612C207374617473290A20202020202020202E7468656E2866756E6374696F6E286C6F7629207B0A20202020202020202020726567696F6E242E72656D6F7665436C61737328425553595F434C415353293B0A20';
wwv_flow_imp.g_varchar2_table(367) := '20202020202020202076617220636F6D706F73697465436F6C756D6E73203D207B7D3B0A20202020202020202020706F707570436F6C756D6E732E666F72456163682866756E6374696F6E287429207B20636F6D706F73697465436F6C756D6E735B742E';
wwv_flow_imp.g_varchar2_table(368) := '70726F70657274795D203D20747275653B207D293B0A202020202020202020205F66696E697368506173746528677269642C206F726967696E616C50617374652C2064617461526F77732C20746172676574732C2073746174732C206865616465722C20';
wwv_flow_imp.g_varchar2_table(369) := '706C6163656D656E742C207B0A202020202020202020202020646973706C61794D6170733A206C6F762E646973706C61794D6170732C0A202020202020202020202020636F6D706F73697465436F6C756D6E733A20636F6D706F73697465436F6C756D6E';
wwv_flow_imp.g_varchar2_table(370) := '730A202020202020202020207D2C20636667293B0A20202020202020207D2C2066756E6374696F6E2865727229207B0A20202020202020202020726567696F6E242E72656D6F7665436C61737328425553595F434C415353293B0A202020202020202020';
wwv_flow_imp.g_varchar2_table(371) := '206C6F676765722E6572726F72282753505245414453484545545F50415354453A20506F707570204C4F56206C6F6F6B7570206661696C65643B206E6F7468696E672077617320706173746564272C20657272293B0A2020202020202020202061706578';
wwv_flow_imp.g_varchar2_table(372) := '2E6D6573736167652E73686F774572726F7273285B7B0A202020202020202020202020747970653A20276572726F72270A2020202020202020202020202C206C6F636174696F6E3A202770616765270A2020202020202020202020202C206D6573736167';
wwv_flow_imp.g_varchar2_table(373) := '653A20274E6F7468696E6720776173207061737465643A20746865206C697374206F662076616C756573206C6F6F6B7570206661696C65642E270A202020202020202020207D5D293B0A20202020202020207D293B0A202020207D292E63617463682866';
wwv_flow_imp.g_varchar2_table(374) := '756E6374696F6E286529207B0A2020202020206C6F676765722E6572726F72282753505245414453484545545F50415354453A207061737465206661696C6564272C2065293B0A202020207D293B0A20207D3B0A0A2020766172205F696E7374616C6C50';
wwv_flow_imp.g_varchar2_table(375) := '6173746557726170706572203D2066756E6374696F6E28677269642C2063666729207B0A2020202069662028677269642E5F69677074506173746529207B0A202020202020677269642E5F6967707450617374652E636667203D206366673B0A20202020';
wwv_flow_imp.g_varchar2_table(376) := '202072657475726E20747275653B0A202020207D0A2020202069662028747970656F6620677269642E5F706173746520213D3D202766756E6374696F6E27207C7C20747970656F6620677269642E5F676574436F6C756D6E4D6574616461746120213D3D';
wwv_flow_imp.g_varchar2_table(377) := '202766756E6374696F6E2729207B0A20202020202072657475726E2066616C73653B0A202020207D0A20202020766172207374617465203D207B206366673A206366672C206F726967696E616C3A20677269642E5F7061737465207D3B0A202020206772';
wwv_flow_imp.g_varchar2_table(378) := '69642E5F696770745061737465203D2073746174653B0A20202020677269642E5F7061737465203D2066756E6374696F6E286173796E63446174615472616E7366657229207B0A20202020202072657475726E205F68616E646C65537072656164736865';
wwv_flow_imp.g_varchar2_table(379) := '6574506173746528746869732C206173796E63446174615472616E736665722C2073746174652E6F726967696E616C2C2073746174652E636667293B0A202020207D3B0A2020202072657475726E20747275653B0A20207D3B0A0A2020766172205F6765';
wwv_flow_imp.g_varchar2_table(380) := '744772696456696577203D2066756E6374696F6E28726567696F6E43747829207B0A20202020747279207B0A2020202020207661722076696577203D20726567696F6E4374782E726567696F6E2E77696467657428292E696E7465726163746976654772';
wwv_flow_imp.g_varchar2_table(381) := '696428276765745669657773272C20276772696427293B0A20202020202072657475726E207669657720262620766965772E7669657724203F20766965772E76696577242E677269642827696E7374616E63652729203A206E756C6C3B0A202020207D20';
wwv_flow_imp.g_varchar2_table(382) := '636174636820286529207B0A20202020202072657475726E206E756C6C3B0A202020207D0A20207D3B0A0A2020766172205F656E61626C6553707265616473686565745061737465203D2066756E6374696F6E28726567696F6E4374782C207365747469';
wwv_flow_imp.g_varchar2_table(383) := '6E677329207B0A2020202076617220636F6C756D6E4D6574613B0A20202020747279207B0A202020202020636F6C756D6E4D657461203D2073657474696E67732E636F6C756D6E4D657461203F204A534F4E2E70617273652873657474696E67732E636F';
wwv_flow_imp.g_varchar2_table(384) := '6C756D6E4D65746129203A207B7D3B0A202020207D20636174636820286529207B0A2020202020206C6F676765722E6572726F72282753505245414453484545545F50415354453A20696E76616C696420636F6C756D6E206D657461646174612066726F';
wwv_flow_imp.g_varchar2_table(385) := '6D2074686520736572766572272C2065293B0A20202020202072657475726E3B0A202020207D0A20202020766172206D657461436F756E74203D204F626A6563742E6B65797328636F6C756D6E4D657461292E6C656E6774683B0A202020206966202821';
wwv_flow_imp.g_varchar2_table(386) := '6D657461436F756E7429207B0A2020202020206C6F676765722E6572726F72282753505245414453484545545F50415354453A206E6F20636F6C756D6E206D657461646174612072656365697665642066726F6D20746865207365727665723B2076616C';
wwv_flow_imp.g_varchar2_table(387) := '7565732077696C6C206E6F7420626520636F6E76657274656427293B0A202020207D0A2020202076617220636667203D207B0A202020202020726567696F6E49643A20726567696F6E4374782E69640A2020202020202C20636F6C756D6E4D6574613A20';
wwv_flow_imp.g_varchar2_table(388) := '636F6C756D6E4D6574610A2020202020202C20736F7572636544617465466F726D61743A2073657474696E67732E736F7572636544617465466F726D6174207C7C20274D4D2F44442F59595959270A2020202020202C20736F75726365446563696D616C';
wwv_flow_imp.g_varchar2_table(389) := '3A2073657474696E67732E736F75726365446563696D616C536570617261746F72203D3D3D2027434F4D4D4127203F20272C27203A20272E270A2020202020202C2072656A6563744F6E4572726F72733A2073657474696E67732E72656A6563744F6E45';
wwv_flow_imp.g_varchar2_table(390) := '72726F7273203D3D3D20747275650A2020202020202C2070617374654D6F64653A2073657474696E67732E70617374654D6F6465207C7C2050415354455F4D4F44452E5245504C4143450A2020202020202C20616A61784964656E7469666965723A2073';
wwv_flow_imp.g_varchar2_table(391) := '657474696E67732E616A61784964656E7469666965720A202020207D3B0A0A2020202076617220747279496E7374616C6C203D2066756E6374696F6E2829207B0A2020202020207661722067726964203D205F676574477269645669657728726567696F';
wwv_flow_imp.g_varchar2_table(392) := '6E437478293B0A20202020202069662028216772696429207B2072657475726E2066616C73653B207D0A20202020202069662028215F696E7374616C6C50617374655772617070657228677269642C206366672929207B0A20202020202020206C6F6767';
wwv_flow_imp.g_varchar2_table(393) := '65722E6572726F72282753505245414453484545545F50415354453A2070726976617465206772696420415049206E6F7420666F756E6420696E207468697320415045582076657273696F6E3B206E6174697665207061737465206C65667420756E6368';
wwv_flow_imp.g_varchar2_table(394) := '616E67656427293B0A202020202020202072657475726E20747275653B0A2020202020207D0A2020202020206C6F676765722E6C6F672827537072656164736865657420706173746520656E61626C656420666F7220726567696F6E2027202B20726567';
wwv_flow_imp.g_varchar2_table(395) := '696F6E4374782E6964202B2027202827202B206D657461436F756E74202B202720636F6C756D6E287329206465736372696265642927293B0A20202020202072657475726E20747275653B0A202020207D3B0A0A202020206966202821747279496E7374';
wwv_flow_imp.g_varchar2_table(396) := '616C6C282929207B0A202020202020726567696F6E4374782E726567696F6E2E77696467657428292E6F6E2827696E74657261637469766567726964766965776368616E67652E696770745061737465272C2066756E6374696F6E2829207B0A20202020';
wwv_flow_imp.g_varchar2_table(397) := '2020202069662028747279496E7374616C6C282929207B0A20202020202020202020242874686973292E6F66662827696E74657261637469766567726964766965776368616E67652E69677074506173746527293B0A20202020202020207D0A20202020';
wwv_flow_imp.g_varchar2_table(398) := '20207D293B0A202020207D0A20207D3B0A0A20207661722072756E203D2066756E6374696F6E2873657474696E67732C206461436F6E66696729207B0A2020202076617220636F6D6D616E64203D202873657474696E67732026262073657474696E6773';
wwv_flow_imp.g_varchar2_table(399) := '2E636F6D6D616E6429207C7C20434F4D4D414E442E524546524553485F475249443B0A0A20202020747279207B0A20202020202076617220726567696F6E437478203D205F7265736F6C7665526567696F6E286461436F6E666967293B0A202020202020';
wwv_flow_imp.g_varchar2_table(400) := '6966202821726567696F6E43747829207B2072657475726E3B207D0A0A2020202020207377697463682028636F6D6D616E6429207B0A20202020202020206361736520434F4D4D414E442E524546524553485F53454C45435445443A0A20202020202020';
wwv_flow_imp.g_varchar2_table(401) := '2020205F72656672657368537572676963616C28726567696F6E437478293B0A20202020202020202020627265616B3B0A0A20202020202020206361736520434F4D4D414E442E524546524553485F475249443A0A202020202020202020205F72656672';
wwv_flow_imp.g_varchar2_table(402) := '65736846756C6C28726567696F6E437478293B0A20202020202020202020627265616B3B0A0A20202020202020206361736520434F4D4D414E442E53454C45435445445F414354494F4E3A0A202020202020202020205F72756E53656C65637465644163';
wwv_flow_imp.g_varchar2_table(403) := '74696F6E28726567696F6E4374782C2073657474696E67732E616374696F6E4E616D652C2073657474696E67732E707265736572766553656C656374696F6E293B0A20202020202020202020627265616B3B0A0A20202020202020206361736520434F4D';
wwv_flow_imp.g_varchar2_table(404) := '4D414E442E444550454E44454E545F434F4C554D4E5F524546524553483A0A202020202020202020205F72756E446570656E64656E74436F6C756D6E5265667265736828726567696F6E4374782C2073657474696E67732E616374696F6E4E616D65293B';
wwv_flow_imp.g_varchar2_table(405) := '0A20202020202020202020627265616B3B0A0A20202020202020206361736520434F4D4D414E442E53505245414453484545545F50415354453A0A202020202020202020205F656E61626C655370726561647368656574506173746528726567696F6E43';
wwv_flow_imp.g_varchar2_table(406) := '74782C2073657474696E6773293B0A20202020202020202020627265616B3B0A0A202020202020202064656661756C743A0A202020202020202020206C6F676765722E7761726E696E672827556E6B6E6F776E20636F6D6D616E642C2064656661756C74';
wwv_flow_imp.g_varchar2_table(407) := '696E6720746F2066756C6C2072656672657368272C20636F6D6D616E64293B0A202020202020202020205F7265667265736846756C6C28726567696F6E437478293B0A2020202020207D0A202020207D20636174636820286529207B0A2020202020206C';
wwv_flow_imp.g_varchar2_table(408) := '6F676765722E6572726F722827556E68616E646C6564206572726F722072756E6E696E6720636F6D6D616E64202227202B20636F6D6D616E64202B202722272C2065293B0A202020207D0A20207D3B0A0A202072657475726E207B0A2020202072756E3A';
wwv_flow_imp.g_varchar2_table(409) := '2072756E0A202020202C20434F4D4D414E443A20434F4D4D414E440A20207D3B0A7D29286D61737465722C20617065782E6A5175657279293B0A';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(17838710305462498)
,p_plugin_id=>wwv_flow_imp.id(17837415176462497)
,p_file_name=>'ig-powertools.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
