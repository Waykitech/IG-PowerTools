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
,p_default_application_id=>110
,p_default_id_offset=>0
,p_default_owner=>'CVS_APP'
);
end;
/
 
prompt APPLICATION 110 - IG PowerTools Demo
--
-- Application Export:
--   Application:     110
--   Name:            IG PowerTools Demo
--   Exported By:     SYSTEM
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                      3
--       Items:                    3
--       Processes:                5
--       Regions:                  2
--       Buttons:                  1
--       Dynamic Actions:          1
--     Shared Components:
--       Logic:
--         Build Options:          1
--       Navigation:
--         Lists:                  2
--         Breadcrumbs:            1
--           Entries:              1
--       Security:
--         Authentication:         1
--         Authorization:          1
--       User Interface:
--         Themes:                 1
--         Templates:
--         LOVs:                   1
--         Plug-ins:               1
--       PWA:
--       Globalization:
--       Reports:
--       E-Mail:
--     Supporting Objects:  Included
--   Version:         26.1.0
--   Instance ID:     2400112968643822
--

prompt --application/delete_application
begin
wwv_flow_imp.remove_flow(wwv_flow.g_flow_id);
end;
/
prompt --application/create_application
begin
wwv_imp_workspace.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'CVS_APP')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'IG PowerTools Demo')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'IG-POWERTOOLS-DEMO')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'F24CB3F32EAF1FA45BC9EEFDBCB903B3CB63DC9FFA497275936C625027BC1291'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'26.1'
,p_flow_language=>'en'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_allow_feedback_yn=>'Y'
,p_date_format=>'DS'
,p_timestamp_format=>'DS'
,p_timestamp_tz_format=>'DS'
,p_flow_image_prefix=>nvl(wwv_flow_application_install.get_image_prefix,'')
,p_authentication_id=>wwv_flow_imp.id(20062659608326768)
,p_application_tab_set=>0
,p_logo_type=>'T'
,p_logo_text=>'IG PowerTools Demo'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'Release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_authorize_batch_job=>'N'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>'IG PowerTools Demo'
,p_file_prefix=>nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>2461356174019
,p_print_server_type=>'INSTANCE'
,p_file_storage=>'DB'
,p_is_pwa=>'Y'
,p_pwa_is_installable=>'N'
,p_pwa_is_push_enabled=>'N'
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.'
,p_login_url=>'f?p=&APP_ID.:LOGIN:&SESSION.::&DEBUG.'
,p_theme_style_by_user_pref=>false
,p_built_with_love=>false
,p_global_page_id=>0
,p_navigation_list_id=>wwv_flow_imp.id(20062725308326768)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>2469215554099805162
,p_nav_list_template_options=>'#DEFAULT#:t-TreeNav--styleA:js-navCollapsed--hidden'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_imp.id(20062868344326768)
,p_nav_bar_list_template_id=>2849019392706229583
,p_nav_bar_template_options=>'#DEFAULT#'
);
end;
/
prompt --application/shared_components/plugins/dynamic_action/ig_powertools
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(20066318013326771)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'IG_POWERTOOLS'
,p_display_name=>'IG PowerTools'
,p_apexlang_name=>'igPowerTools'
,p_category=>'EXECUTE'
,p_image_prefix=>nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','IG_POWERTOOLS'),'')
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
,p_files_version=>2461356174019
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20066435237326772)
,p_plugin_id=>wwv_flow_imp.id(20066318013326771)
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
 p_id=>wwv_flow_imp.id(20066989402326772)
,p_plugin_attribute_id=>wwv_flow_imp.id(20066435237326772)
,p_display_sequence=>50
,p_display_value=>'Recalculate dependent columns'
,p_return_value=>'DEPENDENT_COLUMN_REFRESH'
,p_apexlang_name=>'dependentColumnRefresh'
,p_help_text=>'Calls a named AJAX Callback process for the selected row, then surgically refreshes that row. The process receives x01 = the row''s record id and x02 = a JSON object with the row''s current values as shown in the grid (including unsaved edits); it must'
||' calculate from x02 and persist the result, because the refresh reloads the row from the database.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20066793592326772)
,p_plugin_attribute_id=>wwv_flow_imp.id(20066435237326772)
,p_display_sequence=>30
,p_display_value=>'Refresh entire grid'
,p_return_value=>'REFRESH_GRID'
,p_apexlang_name=>'refreshGrid'
,p_help_text=>'Full grid refresh via the region''s native refresh call. Use as a safe fallback when a surgical refresh does not apply.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20066692738326772)
,p_plugin_attribute_id=>wwv_flow_imp.id(20066435237326772)
,p_display_sequence=>20
,p_display_value=>'Refresh selected rows'
,p_return_value=>'REFRESH_SELECTED'
,p_apexlang_name=>'refreshSelected'
,p_help_text=>'Reloads only the selected rows from the database via the native "selection-refresh" action, without reloading the whole grid. Falls back to a full refresh if that action is not available.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20066811192326772)
,p_plugin_attribute_id=>wwv_flow_imp.id(20066435237326772)
,p_display_sequence=>40
,p_display_value=>'Run server action on selected rows'
,p_return_value=>'SELECTED_ACTION'
,p_apexlang_name=>'selectedAction'
,p_help_text=>'Calls a named AJAX Callback process, created by you on the page, with the primary keys of the selected rows. Use for bulk validate, approve, bulk update, etc.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20067168020326772)
,p_plugin_attribute_id=>wwv_flow_imp.id(20066435237326772)
,p_display_sequence=>70
,p_display_value=>'Enable spreadsheet paste, with type conversion'
,p_return_value=>'SPREADSHEET_PASTE'
,p_apexlang_name=>'spreadsheetPaste'
,p_help_text=>'Run once on Page Load, with Affected Elements = an editable Interactive Grid. Converts spreadsheet data pasted into the grid (Ctrl+V, Ctrl+Shift+V, Actions menu Paste / Paste Insert) to each column''s type before it is written: dates to the column for'
||'mat mask, numbers to the session format, switch values (TRUE/FALSE, Yes/No...) and select list / Popup LOV display values to return values. If the first pasted row is a header naming grid columns, columns are matched by name instead of by position.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20068127485326773)
,p_plugin_id=>wwv_flow_imp.id(20066318013326771)
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
,p_depending_on_attribute_id=>wwv_flow_imp.id(20066435237326772)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'SPREADSHEET_PASTE'
,p_lov_type=>'STATIC'
,p_help_text=>'Where pasted spreadsheet rows go. Replace existing rows: native behaviour, Ctrl+V overwrites from the current row and Ctrl+Shift+V or Actions > Paste Insert insert new rows below it. Insert below the current row: every paste of two or more cells adds'
||' new rows below the current row. Append after the last row: every paste of two or more cells adds new rows after the last loaded row, wherever the current cell is; with scroll pagination this is the last row loaded so far, not necessarily the end of '
||'the data. A single value is always pasted into the current cell. Insert modes need a grid that allows adding rows; otherwise nothing is pasted.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20068435555326773)
,p_plugin_attribute_id=>wwv_flow_imp.id(20068127485326773)
,p_display_sequence=>30
,p_display_value=>'Append after the last row'
,p_return_value=>'APPEND'
,p_apexlang_name=>'append'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20068380454326773)
,p_plugin_attribute_id=>wwv_flow_imp.id(20068127485326773)
,p_display_sequence=>20
,p_display_value=>'Insert below the current row'
,p_return_value=>'INSERT'
,p_apexlang_name=>'insert'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20068234132326773)
,p_plugin_attribute_id=>wwv_flow_imp.id(20068127485326773)
,p_display_sequence=>10
,p_display_value=>'Replace existing rows'
,p_return_value=>'REPLACE'
,p_apexlang_name=>'replace'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20067371418326772)
,p_plugin_id=>wwv_flow_imp.id(20066318013326771)
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
,p_depending_on_attribute_id=>wwv_flow_imp.id(20066435237326772)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'REFRESH_SELECTED,SELECTED_ACTION'
,p_help_text=>'When enabled, refreshes via the native "selection-refresh" action so the current selection is kept. When disabled, performs a full grid refresh and the selection is lost.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20068062368326773)
,p_plugin_id=>wwv_flow_imp.id(20066318013326771)
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
,p_depending_on_attribute_id=>wwv_flow_imp.id(20066435237326772)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'SPREADSHEET_PASTE'
,p_help_text=>'When enabled, the whole paste is cancelled if any value cannot be converted, and an error lists the offending cells. When disabled (default), convertible values are pasted and the rest are left as-is so the grid flags them.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20067261763326772)
,p_plugin_id=>wwv_flow_imp.id(20066318013326771)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'server-action-name'
,p_prompt=>'Server action / process name'
,p_apexlang_name=>'serverActionName'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(20066435237326772)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'SELECTED_ACTION,DEPENDENT_COLUMN_REFRESH'
,p_help_text=>'Static name of the page/application "AJAX Callback" process to invoke. Applies to Run server action and Recalculate dependent columns. This plugin never contains app-specific PL/SQL; you author that process yourself.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20067669412326772)
,p_plugin_id=>wwv_flow_imp.id(20066318013326771)
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
,p_depending_on_attribute_id=>wwv_flow_imp.id(20066435237326772)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'SPREADSHEET_PASTE'
,p_help_text=>'Date format used by the spreadsheet the data is copied from, for example MM/DD/YYYY for a US-locale Google Sheet or DD/MM/YYYY for a Spanish one. Used for ambiguous values only: ISO dates (2026-10-15) are always recognized, and when a pasted column c'
||'ontains an unambiguous value (a day greater than 12) the day/month order is inferred from the data itself.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20067732135326773)
,p_plugin_id=>wwv_flow_imp.id(20066318013326771)
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
,p_depending_on_attribute_id=>wwv_flow_imp.id(20066435237326772)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'SPREADSHEET_PASTE'
,p_lov_type=>'STATIC'
,p_help_text=>'Number format used by the spreadsheet the data is copied from. Used for ambiguous values only (1,234 or 1.234): when a pasted column contains a value that proves the decimal separator (1,5 or 1.234,56), it is inferred from the data itself. Numbers ar'
||'e written in the session''s own format.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20067981851326773)
,p_plugin_attribute_id=>wwv_flow_imp.id(20067732135326773)
,p_display_sequence=>20
,p_display_value=>'1.234,56 (decimal comma)'
,p_return_value=>'COMMA'
,p_apexlang_name=>'comma'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20067896206326773)
,p_plugin_attribute_id=>wwv_flow_imp.id(20067732135326773)
,p_display_sequence=>10
,p_display_value=>'1,234.56 (decimal point)'
,p_return_value=>'DOT'
,p_apexlang_name=>'dot'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20067428283326772)
,p_plugin_id=>wwv_flow_imp.id(20066318013326771)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'target-columns'
,p_prompt=>'Target columns'
,p_apexlang_name=>'targetColumns'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(20066435237326772)
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
 p_id=>wwv_flow_imp.id(20068522350326773)
,p_plugin_id=>wwv_flow_imp.id(20066318013326771)
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
 p_id=>wwv_flow_imp.id(20068617130326777)
,p_plugin_id=>wwv_flow_imp.id(20066318013326771)
,p_file_name=>'ig-powertools.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/plugin_settings
begin
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20068765379326778)
,p_plugin_type=>'DYNAMIC ACTION'
,p_plugin=>'NATIVE_OPEN_AI_ASSISTANT'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20069051431326778)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'mode', 'FULL')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20069142913326778)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_DATE_PICKER_APEX'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'show_on', 'FOCUS',
  'time_increment', '15')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20069252996326778)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_GEOCODED_ADDRESS'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'background', 'default',
  'display_as', 'LIST',
  'map_preview', 'POPUP:ITEM',
  'match_mode', 'RELAX_HOUSE_NUMBER')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20069331114326778)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SELECT_MANY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_values_as', 'separated')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20069416897326778)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SINGLE_CHECKBOX'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'checked_value', 'Y',
  'unchecked_value', 'N')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20069521039326778)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_STAR_RATING'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'default_icon', 'fa-star',
  'tooltip', '#VALUE#')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20069691484326778)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_style', 'SWITCH_CB',
  'off_value', 'N',
  'on_value', 'Y')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20069721226326778)
,p_plugin_type=>'PROCESS TYPE'
,p_plugin=>'NATIVE_GEOCODING'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'match_mode', 'RELAX_HOUSE_NUMBER')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20069843399326778)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'include_slider', 'Y')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20069914200326778)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'actions_menu_structure', 'IG')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20070007995326778)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_MAP_REGION'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_vector_tile_layers', 'Y')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20070121201326778)
,p_plugin_type=>'WEB SOURCE TYPE'
,p_plugin=>'NATIVE_ADFBC'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(20070208901326778)
,p_plugin_type=>'WEB SOURCE TYPE'
,p_plugin=>'NATIVE_BOSS'
);
end;
/
prompt --application/shared_components/navigation/lists/navigation_bar
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(20062868344326768)
,p_name=>'Navigation Bar'
,p_static_id=>'navigation-bar'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(20071216768326788)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'&APP_USER.'
,p_static_id=>'app-user'
,p_list_item_link_target=>'#'
,p_list_item_icon=>'fa-user'
,p_list_text_02=>'has-username'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(20071301886326789)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'---'
,p_static_id=>'list_item'
,p_list_item_link_target=>'separator'
,p_list_item_disp_cond_type=>'USER_IS_NOT_PUBLIC_USER'
,p_parent_list_item_id=>wwv_flow_imp.id(20071216768326788)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(20071447782326789)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Sign Out'
,p_static_id=>'sign-out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_icon=>'fa-sign-out'
,p_list_item_disp_cond_type=>'USER_IS_NOT_PUBLIC_USER'
,p_parent_list_item_id=>wwv_flow_imp.id(20071216768326788)
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/navigation_menu
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(20062725308326768)
,p_name=>'Navigation Menu'
,p_static_id=>'navigation-menu'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(20071520335326789)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Spreadsheet Paste Demo'
,p_static_id=>'home'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/listentry
begin
null;
end;
/
prompt --application/shared_components/files/icons_app_icon_144_rounded_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000090000000900806000000E746E2B8000011A449444154785EED9D795454579EC7BFF7D542B18388A880806BA208E28E264A4191CDA8E93631E9CED2E9A4934ECFD23367CE9CE9993E3D67D2333D933E6726';
wwv_flow_imp.g_varchar2_table(2) := 'A793E93E9DDEB29BE96827D118B3C892922846828A14E28A0B8B28414AD9AA8AAA7AF5E6DC2775439082E2BD02EA91FBF947F881A7EEABFAF0DE5D7EF77709381C1510F61587A3002E1047155C208E2AB8401C55708138AAE0027154C105E2A8820BC451';
wwv_flow_imp.g_varchar2_table(3) := '051788A30A2E1047155C208E2AB8401C55708138AA084B810AAC567D7B7BBB109796A6EBEAEBD399BC5E9DDB64123C7D7D026BF924C61011E133BA5C3E975E2FC64544885D2D2D627272B26F9FD9EC0DB7CB9E588124892CDE57B28040B70A12590522AD';
wwv_flow_imp.g_varchar2_table(4) := '049003C0106E6F5498E00160034115247C2141ACAA2BB8E334089126AA7DE32A50DE671F258B5E7D3E0461152450595600889FA88B9F247402A806A42A10A14A74792AEBEFBACB3E5ED7367E02D1BB8DB56C1304F24F44C29AF1BAC06F16522501F9656D';
wwv_flow_imp.g_varchar2_table(5) := '41D187E375571A7381961D3E6C70F75C7B9CF8C83F8260FE37EB039D304E03F86F436CC21B47962FA78FBD31634C05CA2D2F4F9504E97D00CB5890339E1CD6E9DCF7D4ACBBA77DAC5E74CC04CA2B2B5B28EA50022095053913C13922099B6B0B0BEBC7E2';
wwv_flow_imp.g_varchar2_table(6) := 'C5C744A05C6BE96D12C81EDE410E1B3A25C9B7B9AEF08E8A50B728E402C9771E01D520886241CEC423C14120AC0CF59D28A4022DFBE08328777464352158C8829C70A2DED0E35C7964E34647A81A15528172AC65AF01F81E0B70C291D76D66CBE3A16A58';
wwv_flow_imp.g_varchar2_table(7) := 'C8045A6C2D7F9C407A950538618B04F2FD3A7311FD63574D4804CA3F7830B2B7CF710940220B72C217097643AF333D148FB29008946B2D7F4682F4120B70C21E02F2A35A73D1EFD43654BD40924472F6959F04B080C5385AE0A4ADA06891DA250FD502E5';
wwv_flow_imp.g_varchar2_table(8) := '58CBEE02F0310B70B4C4DD36B3E513350D0E8540B40177B200474BECB5992DF406A0185502655AADA63849EC05C13722D16BD221C1176D8A8AF97CCD1AA7D26B5325D0126B69810FC4CA021CCD2140321F3317EF53DA705502E55A4BFF5902798E05389A';
wwv_flow_imp.g_varchar2_table(9) := '8340FA975A73F12F95365C954039D6B25D0036B300478BBC6F335BEE53DA703502911C6B19CD334962118E1669B3992DD395365CB14072071AA2E2CE17277C708B987ACA62E950D222C5022DB15A137C10AFB10047B31049C8569AE6A158A05BCACA928C';
wwv_flow_imp.g_varchar2_table(10) := '3A5C65018E661108561E2BB0542BB900C502E554EE9D06B7AE8D05389A45F291F57545459F29B900C502E59594CC140D025D81E7681FC54B1A8A05CAAEA848177C9E2616E068174236D90A8A3E5072018A05CAA9D89B059FEE3C0B70340B91A42DB585C5';
wwv_flow_imp.g_varchar2_table(11) := 'EF29B900C502659797CF1104A981052621922842ECEC843E3111208ADFAAB047021EA9335BDE52D250C5EFCA64BF03495E2FFA9A9A21793D10222311919636692522C0A3B566CB36F6E18E022ED010486E37FA5A5A648952A624A1CDDE01C1148988F4C9';
wwv_flow_imp.g_varchar2_table(12) := '2911172884C8F23437CB8FAF150B6EC18294141C68388B8BADAD20111188484F07112657F60A172844C88FADC646599E65F3E6E3D61933D8CF2A4E9F42735BDBA4BC137181428124C145E571BBB128330B79B366B11FF929A9ABC397D7ECD0C5C6C23840';
wwv_flow_imp.g_varchar2_table(13) := '2EADC3050A017D2D97E073F42263FA0CDC3E7FE82A341E5144496D2DAEF574439F940443D2E44844E002A9C4D3D1016F4707A6254EC11D8B17B3F850B8BC5EEC397204AE3E973C3213A2B45F02800BA4025F5F9FDCEF311A8CD8B8620522F57AF6B3405C';
wwv_flow_imp.g_varchar2_table(14) := 'E9EE4659CD5110BD1EA6AC2CCD0FEFB9404AA1FD9E8B8D903C6E9897E421352E8EFD68248E3636E244E345E8E2E2609CAE381F2B2CE00229C473F52ABC763BE6A6A561F5EC392C1E2C7B8E1EC5F59E6E18D3D2A0D3F0A38C0BA4003A64775DB80093D188';
wwv_flow_imp.g_varchar2_table(15) := 'CD2B56C2A0606EC7EE70E0A3C3D52046234C99992CAE35B8400A705FB902B1AB0BEB7272312B2181C5478BFF514687F57478AF45B840A344F278E4BB4F282106234C59DABC0B71814689FBF21588DD5DECFB50413BD3B453AD35B840A340EEFB9C3F8F19';
wwv_flow_imp.g_varchar2_table(16) := 'F109F8E8FEAD2CAE860EB71B966DAF83180C9AEC0B71814681A7BD1DDE6BD7F00FEB0AF0E8BCA1679C95F09383075072F2842647645CA0609124381BCE01920F158F7D1F7186D09DE972D8DE81A776BE0B5D74348CA9DA2A8DCD050A12B1A707EED656DC';
wwv_flow_imp.g_varchar2_table(17) := '9BBD18FFB12A9FC587A2D9E1409DBD03ED0E07526363B1626A32E247106EE37BEFA0E59A1D91F3E6696A769A0B1424EEB6363945F5F90D1B51383DF06AFAB686B378FEB37DF21DCBCF94E8183C6729C6CAA9C92C3698176CB578BDBA0AC69933A18B8961';
wwv_flow_imp.g_varchar2_table(18) := 'F170870B1424B4F34C737D0E7DEF0944E8742C3E90CAF62FF137BB7721C61489B5F3E621253606E73A3A5079E60CA28D46EC7CE021244744B0DF1F488DDD8E2776BE037D42020CD3A6B178B8C3050A02FFDCCFDA3973F19B8242161FCC96DDBB70F1EA55';
wwv_flow_imp.g_varchar2_table(19) := 'FC70DD3AA44647B3F8E1B62BD875E4081EC85B8A9F2E5DCEE28359FFD69BE816454DCD0971818280CE3AD3D9E7BFBD6D1D9E58700B8B0FC4258AC87FED65CC9A9A8CA757D2F3F0BEC22349F8CF92BDC84A9A8A1D1B0357B4F9718515FB1BCEC23477AE66';
wwv_flow_imp.g_varchar2_table(20) := '525FB94041E01FBEFFEFBD9B707BCAD0ABE7C108949934157F1946A017EB6C78ED8B439ACA15E2020501DD65E17338B0E7BB8F2035327012D8031FBC8FF3EDED011F615B72F3F0B3E5F4A4CEA1F9B0A5193FDBFBB1DC07A27D212DC0050A02DA818E1474';
wwv_flow_imp.g_varchar2_table(21) := 'A87C74F8A33CF6B75DC18FF7EC4694C984DBE7CDFF5A273A526FC0CE071F424A8489FDFE604E7675E2BB7FD9AEA98E341728089C67CF223521017BBEFD008B05E2AD86B3F89F2186F1BF282A467E72E0613CA5ADCF85BBB6BD210FE3E9705E0B708182C0';
wwv_flow_imp.g_varchar2_table(22) := '79E60C164C9F8EB7376C62B1E16876F4A2CE6E1FD54422C5E1F562EDEBAFC8B9D2F26E560DC0051A01C9E783ABA1014B6765E0E5E2B1AF899EF7F21FE44D88A68C0CD68670860B340274F2D075EEDC887340A1429E0BF27A619A9DC562E10C176804FC77';
wwv_flow_imp.g_varchar2_table(23) := 'A0BC59197865BCEE401A4A30E3020501ED03CD4F998EEDF706D707528ADB2762D5AB2FF347D84868ADBC0B4DE3A0DB76F66C197914A60639B9ECCDD720444523224D1B691DFC0E340274BFBBABB149CE03AA79F269161F0BEA3BAFE3917776C839D21119';
wwv_flow_imp.g_varchar2_table(24) := 'B334B19CC1051A06BA88DAD7D42477A429BBBFF330D2A3BE9A611E898BBDBDC81C30233D127B5A9AF1AF7B6F1C9F264498604C4F0B7B89B84001B85165AC49FE37212656DE0438DC5AD860DE6DBC805F9495E2ADFB1FC4C2F878161F8E5F1FB7E195AA43';
wwv_flow_imp.g_varchar2_table(25) := '888B8941574F8F26CAC1708186E0863C374AD4E5CE998BC4E868ECB3D5E2E9FC35F8D1C26CF67BC3F1FB9327F0BB83074625DD53652538DC7811F7AF598BAA730D9AA829C4051AC440796ECDC8C4B28C0CB934CBF6CA03A31ACA2B1128EF953F22362A0A';
wwv_flow_imp.g_varchar2_table(26) := '9B97DDC819B29E3A854B5FB685759D452ED04006148AF2CBE3674F4D0DAE7777E1D0E34F06CC481CC868053A6AEFC0933BDFC5DCD434AC9EF3D55EFBF2FA7A5CEEB81AB685A9B84003F06F1A9C979E8E5559B3599C52D3D484FA8B17F0AB0D1B51304C4E';
wwv_flow_imp.g_varchar2_table(27) := 'B49FD10AF42BDB31BC51FD05D6E7E4227D502A87BFBA99615A0AF409C1F5A7C60B2E503F34DF87E6FDA4264F83F9D65B6F7AFF3B1C0E7C7CB81A772FCCC67FE5AF61F1408C5620CBF63FA3D3E9C4436BD7B2981F8FCF870F8F1E418FD3252F719020EE80';
wwv_flow_imp.g_varchar2_table(28) := 'E30517A81F7FD2D87DABF31163340EF9FEEFAAFE023ED107EBC38FC0280CFF218E46A0BAEBD7F1D8BB3B903533156BE7CE65F1819CEFE8C0C1FAE361571E8F0B44BB3EFDEB5DC98989B873718EFF33BB89632DCD387EFE3CFEFD8EBBB031FDE6429A0319';
wwv_flow_imp.g_varchar2_table(29) := '8D403FAFAEC22E5BEDB085AAE85D68FB81FDF2FC109D640C17B840F4F1E574CAF59D07779C07E3F47AF1EEC14A2C9A998A6D776F60F1A10856A02E8F07EBDF7815F131B1D8B874298B0FC5C7B5B5E8E8BC8EC800853C27022E10DD75D1DD0DF7E5CBC89B';
wwv_flow_imp.g_varchar2_table(30) := '3B0F8B46C804FCFCDC399CBBD4826DF76FC5A2F8C079CBC10AF4FA99D378617F05D62C5C84D953A7B2F850549C3E8DE6B62B30CD9E2DD7580C07B84003045A3A6F3E168E50C3B9ABAF0FBBAB0E217FF61CFCD65CC4E2830946A05EAF171B76BC0D8F4FC4';
wwv_flow_imp.g_varchar2_table(31) := 'B757AD66F140EC3F73068D572ECBC53969358F70800B344A812887CE9F47434B335EDAFC2DAC0EB05D391881FC4B176B166563761075A3B940FD845B3AC76805A2F59E775555212B2929E046C13F9C3C81970E1EC0AF376EC66DD35258DC4FABD3810DFF';
wwv_flow_imp.g_varchar2_table(32) := 'B70D53E213704F6E2E8B0F0717A81FAD0B443971F9328E9E3D83A756AFC15F2DBA797D6CA43BD0C31FEDC189CBADB873F90A240759A5950BD48FD605A243EAFDA74FA3B5FD4BF97ADED8B2158B07CD1E0F27D01F4F9DC06F2B0FC85F2FCCC8C4D261467E';
wwv_flow_imp.g_varchar2_table(33) := '03E102F5A365817ADD6E7C7AFC383A7BBAE5740B9FCB89A498586CDB7C1FA69B22FD971850A083ED5FE2AF77EF02D1DFE804D345DBB46929B86DFE7CE8472817CC05EA47AB0275389DF8B4B6167DEE3EE862E3609C311DDECE4E78DADA306B4A12DEBC77';
wwv_flow_imp.g_varchar2_table(34) := '13AB5C369440A7BB3AF1F8AE9D7079DC88C8C89047526E7A508BCB89C4D83898B3B31135CCE88A0BD48F16056AB2DB71A0BE1E3EC9074372F28DB350FBF1179FA29B0F9F2B28445674CC4D02555D6DC74FCB4A61EFEDB9A922ABBFEEB429C284A29C1C24';
wwv_flow_imp.g_varchar2_table(35) := '467E75271B0817A81FAD0974BCB515C71ACE0244803175E6904713F88F7C1A8940473DD1EA1FB40A885EA7C7EDD9D9481D228B910BD48F9604AA3C7B16172EB7CA7D16BA53821E4D10087A7686E870C8794592C72BF76FE82E53F9984B22401F1F376C45';
wwv_flow_imp.g_varchar2_table(36) := '7AFA7FDD975AE504FEA1A614B840FD6841203AD75371F224DAAFD9E5CEB291CA3342277720FE73C468D5555A7D35586E1CDA7B49966F70721917A89F701568C6D46424C7C743927C38DDDC02B7C7ADF84826A50251687680BF734D175933526E4C4436B5';
wwv_flow_imp.g_varchar2_table(37) := 'B5C9C9FD7C29A3626F167CBAF3FDEFD78423F6F6C27DE9D2D7DA41172B696779B847CE70F8FB346A4E26A48F444F875D7EA40DE41BBF989A5D51912EF83C4DEC1D99682409DEEBD7E5BF7C4288FC810BA6C085A08281EE25F3F5F6AA3FFF4292E4BE91CF';
wwv_flow_imp.g_varchar2_table(38) := 'D547BF8160342A967A2C2092B4A5B6B0F83D161805847D354AF24A4A668A06E1EB7FF21CAD72B7CD6CF94449E3150B9453B9771ADCBA3616E06816C947D6D715157DA6E402140B744B5959925187AB2CC0D12C02C1CA6305966A2517A058A025566B820F';
wwv_flow_imp.g_varchar2_table(39) := 'E23516E068162209D9B58585F54A2E40B1408BACD6181DC46E16E0681649C49C3A8B45D1885AB1409956AB290EA29305389A45846E46BDD97C45C905281608CF3E2BE4ACBF8D2E1CA91B2B73261A97213621EEC8F2E51E250D512E101D8959CB6931E5F5';
wwv_flow_imp.g_varchar2_table(40) := '2CC0D120A4C2662E2A50DA709502953E0B907F63018E06917E6E33173FABB4E1AA045A622D2DF081585980A3390448E663E6E27D4A1BAE4AA0FE8E341DCAF37E90367175419778D16C76296DBE2A812839D6B2B7013CC8021C2DB1DD66B63CA4A6C12110';
wwv_flow_imp.g_varchar2_table(41) := 'A87435403E67018E8690F26DE6E2436A1AAC5A204A8EB5F4104056B100470348553673F1C87BB14720440295D1DBE09F5980A305BE63335B68F743152111A8C06AD5DB215E00A08DF38D3897A64097B9CF6CF6AA7D2B42221065F1A7A59B0921BB588013';
wwv_flow_imp.g_varchar2_table(42) := 'BE10B2C95650F441281A1832812839D6B21700FC1D0B70C291176D66CBDF87AA61211568D9E1C30677F7F54A02043E959633911C31C426E42B5DF71A8A900A445962B566FA20D600085CFA8B3311B4E97C64554D515163285F3CE40251722B4AF3241FA1';
wwv_flow_imp.g_varchar2_table(43) := '49DA992CC899481A4549D85C5F58581BEA468C894094FE94573A4CB4B02067FC21F8D4EDC5D653164BC758BCF8980924B363872E2739F137007986C538E3C9F3B676FB4FB075EB8DB3AEC680B115A89F5C6BF9339224BD0882C09BD239A143829B103C56';
wwv_flow_imp.g_varchar2_table(44) := '6BB66C67B131625C04A2E49697A782484F4A043F0090DEFFFA9CD0D202903F111FFE545B54342E7BF6C64D20C68E1DBADC69499B2449FA21803BC653E2490A7D3C7D2448D2EF8F5DBDF6C9583EAE8662FC051AC0B2D2D278B720E41241CAA39B5D01D032';
wwv_flow_imp.g_varchar2_table(45) := 'EFF49494F0A8C01D7ED0A5879320A881446A2449AC318AE4D891E2E2CE896AEA840A14889CBD7BA30D4663A4CBEB8DD2E97491442746895E21522FF8BE117D28AF4F70EBF43EA724EA1CA2283A4D7ABDC3E3763B6D77DE3972F5AB71262C05E268072E10';
wwv_flow_imp.g_varchar2_table(46) := '47155C208E2AB8401C55708138AAE0027154C105E2A8820BC451051788A30A2E1047155C208E2AB8401C55708138AAE0027154F1FF80C2600921A4C35E00000010646542474436343131343031344135313932433656999AFC0000000049454E44AE4260';
wwv_flow_imp.g_varchar2_table(47) := '82';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(20070562714326786)
,p_file_name=>'icons/app-icon-144-rounded.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_192_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000C0000000C0080600000052DC6C070000141449444154785EEDDD097015C79907F0FFBB75A103210924A1270E592090B86F8CB9CC158C0D36B631E0C4D9245BBB9B6C3954B2BBC996B39BA492D47AE3DA4D';
wwv_flow_imp.g_varchar2_table(2) := '76E3D88EBDBEB00DC6E6B40DBE386C30973108844020217401921048021DEFDEEA9ED16424EBE9CDBC4312EEEF57E5AA6EB5ABF45C9EBFDE4C4FF7D786827D9FF84088A00C140022320A00111A0580088D02408446012042A30010A1510088D028004468';
wwv_flow_imp.g_varchar2_table(3) := '140022340A00111A0580088D02408446012042A30010A1510088D028004468140022340A00111A0580088D02408446012042A30010A1510088D028004468140022340A00111A0580088D02408446012042A30010A1510088D028004468140022340A0011';
wwv_flow_imp.g_varchar2_table(4) := '1A0580088D02408446012042A30010A1510088D028004468140022340A00111A0580088D02408446012042A30010A1510088D028007DC4E776C3515909C0005BD65018CCE63EFA2462A300F4019FCB054755150F01C32E7EDBD0A130582C7DF069C44601';
wwv_flow_imp.g_varchar2_table(5) := 'E8653EA753BAF83D9E4EBFD960324921B05A959F91C8A300F422AFC301475535E0952EFEB8E868F80C06B4B4B64A9FC2C8429009A3CDD68B9F4A6C14805EE26D6B83A3BA06F079F96F6417FFC28271BCFD51E129B4B6B74B9FC4609442101525F5494451';
wwv_flow_imp.g_varchar2_table(6) := '007A01BFF8ABAA94DFD471F1C7C97FE96F3B1C5D4260802D3313C6E868A94F2286021061EC81B7BDA2B2D36D8FFAE2EFF0B510184D88CAB6D3EC5084510022C9E743FBE50AF85C4EDE8DB1D9B068C244C4F979D0BDED7261CF5727D0EE70F03E7B208EB2';
wwv_flow_imp.g_varchar2_table(7) := 'DBF93702890C0A4004B1DB1E76FBC3988C262C9D340989016E6B6EB6B561CF8913F0C8DF18C698187E3B442283021021CE6BD7E0696EE66D030C58307E3C06C7C7CBA33DAB696AC2FED385F0F97CBC6F4E4C822535451E25E1440188007763235C75754A';
wwv_flow_imp.g_varchar2_table(8) := '7F665E1E860FD2770197D45EC3F19212A56F494B83392141E993F0A00084199FEBAFA850FA79F66C4C64F7F14138565E8E0B556CB984C466B7D33B8230A30084539787DEE484442C291817F433ACD7E7C39EC242DC686EE27D7A280E3F0A4018B9EAEAE1';
wwv_flow_imp.g_varchar2_table(9) := '6EBCC9DB16B305F74D99829810D7F7DC723AF1FEF1E3707BA47543E68103611934481E25A1A2008489B7B5158EEA6AA53F7FDC78A487E99EBDEAE64D1C38735AE9DBB2B2E84D71985000C281DDFA94972BAB3B4765D931393B5B1E0C8F23972EA1B45A7A';
wwv_flow_imp.g_varchar2_table(10) := '9B6C305B10352C9BDE0F840105200CD4539E09710370DFC489F248F8B87D3EEC3AF1A5B270CE9C98084B6AAA3C4A8245010851D7599FC5932623253656E987D395E666EC3D7552E9D3AC50E8280021725456C1DB2EBDED1D36241DB37272E491C8F8FCE2';
wwv_flow_imp.g_varchar2_table(11) := '05545CBDCADBA6D858583332E411120C0A40083CB76FC379E50A6F9B4D66AC9C360DB6086F6D6C73B9B0E3D8316556886DA2A155A3C1A30084A0BDFCB232E73F75D468DCD54BF7E4EAB7C4465B146CF62CDE26FA510082E46E6A82ABB656E9F725EB9021';
wwv_flow_imp.g_varchar2_table(12) := '300D18D0971FE18E450108069BF6BC74E96BFB7AFB0A9F161D3EACAF7EFD1D8D0210047763135C75FDE3AF7F07FA16080E052008EA7BFFDF2E5E8AA59943E591DEB5BBBA0A3FFF7037FFA5C6A8685E5F88E84301D0C9D3DA0AA7BCE421213A1A9FAE5907';
wwv_flow_imp.g_varchar2_table(13) := '53B0ABDD42E4F27AB168F39B68945F8ED17B01FD28003A396B6AE06969E1EDEF4D9F897F1833561EE91BFF5B74062F1D3DCC7FB9293E1ED6C183FBE683DCA128003AB0B53EECE19761BBBC76AF5D87B4A89EB73846DAB5F6362C7B63237CF0F1B5415123';
wwv_flow_imp.g_varchar2_table(14) := '46C060342AE3A46714001D5CF5F570DF94963BCFCF1D856766CF9147FAD69307F6E140E945FE21D85269B6649A684301D0814F7DCA2B3EFF7CFF4A4CD7B9CD31520ED5D7E1873BB7F336BD18D38702A0917AD1DB80A8687CB676BD3CA24F79CB6D6C2DBD';
wwv_flow_imp.g_varchar2_table(15) := '8892FA7A945EAFE73FCB4949456E4A0A1E1A9983AC98E016D2CDDEF81A5A1C524DA1A8E1C3A99E904614008D5C0D37E06EB8CEDB4B468FC1EF66CE9247B47BFE5C319EFBE2A0D2EFCE867BE662FDC8BB94BE563F3DF8393E2939C7DBB4815E3B0A8046EA';
wwv_flow_imp.g_varchar2_table(16) := '559FBF59BC14CB74CEFD3F7DF204DEFAEA84D2EFC9DFCD9C8D1F8CCE53FA5AECA8ACC0BF7FFC216FD32A51ED28001AF8BC5EB497962AFDFD8F3F81041D7B7DB7555CC6AF3EF948E9DB5352B178F428A446C7F07E5D6B0B3E3C771E15F22D11F3DFCB57E0';
wwv_flow_imp.g_varchar2_table(17) := '9E34ED539A0D4E0716BEFEAAD43118113D7204ED18D38002A001DBEDC5767D31059943F1EAE2A5F288360B36BD891B2DB779BBC06EC7EA3163D1F5D5192B81B5A5E80C4EF3536380E129297877C54A79549B35EFEFC2F96BD25E016B66264C3152C0887F';
wwv_flow_imp.g_varchar2_table(18) := '14000D9CB5B5F03449A549FE7ED66C7C7F94F6DB93E30D0DF8C1F67779DB66B5E227F3E623DA6492473B6BF5B8F1CCDEBD70B85CBCBFFDD1B5B0EBD85DF6A7B34578F1C817BC6D4E4E862539591E21FE500034705454C22BCFB03CBB622566A4689FFEDC';
wwv_flow_imp.g_varchar2_table(19) := '74A914FFB16F2F6FE7666460FDB8F1F248F75E2F3C85929A1ADED6BBCE687FED35FCF8BD9DBC6D8A8B83353D5D1E21FE50003468BB78912F81663E5CF738526DDA0FAFF8BF92F3F89F839FF1F6C2BC3CCCCDEE79D9F2C797CA70E0FC79DE7EF2EE7BF0ED';
wwv_flow_imp.g_varchar2_table(20) := 'BB72E591C0AA5A5BB1E2AD8DBC6DB058A5CA11A447148000787DFFF272DE8E8F8AC6019DF3FF5B2F97E3D79F7ECCDB7ABF01FEEDDE4578204BDF453CF59597E092F72944B3FDC97DB450EF4E41010840BDEF778A3D1B2F2C5C248F6873B6A911EBDE799B';
wwv_flow_imp.g_varchar2_table(21) := 'B7A3AC566C98370F31A6EEF70DB7793CF8FDDE4F9567804DAB1F45AEC68AD21DD6EFF9004535D26A555A1D1A18052000F50BB0C7264DC64FC7EBAFF9B378CB26D4C97583B4CE020D4D1A889DAB1E9247B5FBE5F1A3D87EBA90B7D9CA50B64294F8470108';
wwv_flow_imp.g_varchar2_table(22) := 'C079F51A3CB7A48BF7A9858BB0CAAEEF968479AFAA124F7DB447E96B790FF05FCB5760AE8EF7001D36965EC43307F6F1B6392909161D0FEC22A20004C04E76F4B64AEBFFF5BE9C52FBCF5327F1E689E34ABF273F9C7537FE66D468A5AFC79E9A6AFC6CCF';
wwv_flow_imp.g_varchar2_table(23) := '07BC4DFB0302A30004A05E02F1E2CA07316960F073EB2F9C2BC69F03AC05FA97790BF0C8F0114A5FAF8375B5F8D1AE1DBC4D53A18151000268AFA8804F3EB4EECDD58F60747C68159F4B6FDDC2F6B2529CAFAF43697D3D8C46037253D3903B28050FE7E4';
wwv_flow_imp.g_varchar2_table(24) := '205DBE2D0A56E1CD1BF8CED677789B15CC6285B3887F148000DA2FB1AACFD2ACCCAE35EB90D9CF9717B0E5D6AB36BDC93FAFC166934E99247E510002682B2D53CEF8DDF7F8779068E9FE88D3FEA2DEE1C0A28DD2A23883D9CCF70610FF280001B45DB8A0';
wwv_flow_imp.g_varchar2_table(25) := 'B4BFFAEEF761E8E72F96D8BB8499AFBC247D60B62A3467A4D426DDA20004A05E0671EC89EFC1D2CF379CB35229535F7E51FAF00683F43698F8450108A0ED6229DB10C0DB77C22DD04DA713F35F7F45FAF04693B42F80F8450108A0BDAC4CA901BA73CD3A';
wwv_flow_imp.g_varchar2_table(26) := '0CEDE70FC155AD2D58F1D61BFCF3D2334060148000D4651037AD7E04B9214E83465A715313D6BEB399B769456860148000C2F922AC371CBB7E1D7FBB632BFF55F41E20300A40006C25285B11CA3CBDF45BB837BD7F1F49D46929C48001BC6A34F18F0210';
wwv_flow_imp.g_varchar2_table(27) := '807A2DD08F66CFC1777347C923FDD35FCE17E3D943D2720BAA0E111805A007EABDC0CC7D630BF0AB69D3957E7FF4F3C35F60777191F2D14C0909B0A6A5297DD21905C00FF5D9BF1D82A908D1DB1E7B7F17CEC995213A5008FCA30074A3EB5FFE0EC16C89';
wwv_flow_imp.g_varchar2_table(28) := 'F4A7D6D18EC7B6490FAB9B573E8841369B3C129A19AFBD827679D64A8D42D03D0A40175D2F7EFBE021A850FD45FD68DDB79112868BF5E50BE7F1C7CFA5CDF23F9E33178FE7E82F87D855756B2BEE9337C533F62143943385190AC1D7510054BADEF6B083';
wwv_flow_imp.g_varchar2_table(29) := 'AF678C1C894F8A8A5077F306FFD9EF972DC78221A1971B513FACEAAD35E4CF07D555F857F9C8A4D4A4815838762C0E9796A2FCAAB4A799A14D329D5100645D2FFEE1E919983162242FAA70AABA0A45F2C118EBA74CC586829E2B3B68118900FCF6C4716C';
wwv_flow_imp.g_varchar2_table(30) := '397592B7F3870FC7B8CCA17C19D3E1B2525CBA22559A6028047F4501E8E6E2CFC9CCC4D46123948A22579A9BB1B7E3C2CAC8C46B4B964903218844001EDAB91D65F575BCBD70C2440C96CF0E662138565E868BF2D9660C8540227C00BADEF38FCAB26372';
wwv_flow_imp.g_varchar2_table(31) := '76E78DEF4E8F075BBE38049FCF07B3D188838F3F019B9FF2865A853B00AD6E1766BDFA326FB3E39B1E99350BE62E9FF1CBCB9771BE523AE380312726C2D24BA7DBF7574207801D77C48E3DEA30C69E8D097E7650ED2E3C85063928CFDFBF0A53070D9247';
wwv_flow_imp.g_varchar2_table(32) := '8213EE001CA8BD8627E5B288294949589C5F208F7476B2A202672B2E2B7D1600160451091B00F571A7CC98EC61989095A5F4BB2AACA9C699B232DE7E78C244FC6CE264792438E10EC053470FE3BDA233BC3D6E640EF27BA80BFA5565258A2F4BD5EE185B';
wwv_flow_imp.g_varchar2_table(33) := '66268CFD7C956BA48819009F8F973BEC38EF8B4D75DE7D57CFD390B71C0EEC387A84B713A263B077CD5A1843D81D16CE0038BD1ECC79FD3538E4BDCB2BA64E437C54CFF54B3F2F294145AD54F2DD60B648754443F8EFB953091900F78D1B705D97AABD0D';
wwv_flow_imp.g_varchar2_table(34) := '888DC5FD93B4FD357FEFE44934CA45B2FEB4E201CC4C499547F40B67003EBE52837FDAFD3E6F27C72760E9786DB354DBBE3C8E16F9906D516F85840C807AA3FB8CBC3118A1F17EBEE8CA159C928F235D913F0EBF9C3A4D1ED12F9C01D870F033EC2B912A';
wwv_flow_imp.g_varchar2_table(35) := '4A4FCCB90B791A57805EA8AFC7B173C5BC6D3099F819C3A2112E00DEB63638AAAAF8FFE7E8A8283CA8E32256DF06C5DA6CF874CDBAA06783C215801B4E2716746C8104B072C64CC4EA38BE69CB91237038A5BA472216D3152E00ECD687DD0231B9595998';
wwv_flow_imp.g_varchar2_table(36) := '12A05E7F571F1416E24653236FFFF3BC057834C82A6EE10A80BADA5CEAC0815834365F1ED1E68BD2BFBE2433270F822559AC43B6850B00FBEBCFBE0598F9E327205D67F5E4D2EBD771A4F82C6F0F1D988C9D0FAC0AEAE1311C01601520EEDDFC169AE4FD';
wwv_flow_imp.g_varchar2_table(37) := '0AB3C78E45B6CE1D6B95376FE2B333A779DB18130B5B66FFDEF0136EC20540BDC7F781193311A7E37681F1F87CD876EC28DAE572897F58BE02738228981B8E00ECAAAAC42FE4AAD3EC766ED59469BAB3D8D4DE8E5DC78EF2B6C16A4554979780DF74C205';
wwv_flow_imp.g_varchar2_table(38) := '405DE7E7B1BBE7043595A97E189E9A3D0CCF2FB8571ED12E1C0158B5632BCAE5D9ACC9B9B918154410D969329BE5CF2162212DF102A0AAF4B66ECE3D4A5B0F87C7836D478EC0ED91DE23BCF6E06AE42726C9A3DA841A807DD7AE62C3FBBB78DB6AB162E5';
wwv_flow_imp.g_varchar2_table(39) := 'B4694117EDDAF8D901A51D1DE07DC8370D052048EA75357943D2F1C6B2E5F28836A104C0EDF5E2816DEFA2A6F126EF8F1D361CE343A8024D01104838BE019816A713DB8E1C56FABF5BB20C4B3232957E20A104E0ADB2523CBD5F3A7AD56C32E3FEE9D3FD';
wwv_flow_imp.g_varchar2_table(40) := '9E3DAC05054020E10A00A37E16488B4FC0CE071F82D5A8ED420C3600CD2E27BEF5F666DC966B15057BEFAF460110483803E0F5F9B0F3AB13B8DDA2BF6C4AB001501FB5141F1787E5132606F520AF460110483803C0D43637E36379B38CC564C28E471EC3';
wwv_flow_imp.g_varchar2_table(41) := '90E86879D4BF600270B6B111EBDFDD021F3F5312583C6932526263E5D1E051000412EE003087D8BE5BF96DEAE42C3BFE72EF6279C43FBD0160EF1F566DDF8ACA1B0DBCCFF62BCF0A53E9730A8040221180AEEBEB7FB170115606384E556F009E3F578CE7';
wwv_flow_imp.g_varchar2_table(42) := '5407EC05DABFA007054020E10C007B06E85A7581610BE5763EBC0603ADFE8F53D2130076EED7EAB737C323AF60EDD051B5829E018247EF0182E474BBB1FFDC39A55C0AC76680E48B74C2D02CBCB07011DF43DC1DAD0168F3B8B1F6BD9DCA1B5FF5EF6058';
wwv_flow_imp.g_varchar2_table(43) := 'F993B9A347C36A362B3FD38BBE0104128E6F00B62CFAD333A7715BDE4CC2B0A253EC5476C7E5CBCA4EB3E563F2F1EBE933E47FA3334D01F0F9F08F07F6E1F3B252DE653BB76CD976BE8F59BD913F2E26060BF20B3020C8825D140081841A80BADBB7B1FF';
wwv_flow_imp.g_varchar2_table(44) := 'CC193855E507D5BBA9BC0E071C9595CA7AA30D73E6627D3755DFB404E0B9E2B378FEF021A96330C0969505A37C91BB1B1BE1AA934AA0306C39C4DCFC7CA4C6C5293FD38A022090500250D1D08043C5C5F0CA6786B1C563D6F421BC0CB99ABBB109AEBA5A';
wwv_flow_imp.g_varchar2_table(45) := 'DE66254A9E5D713FA677D93E192800EA2A0F8C252D0DE684CEA7D3785A5AE0BC725539C3CC683062565E1EECC9FA9644530004124C00D81FF3D335553823578763D8F95BD68C0CE52F7257EA8335989FDC330F4BB2EC48961F8CFD05A0C1E9C0EECA4A3C';
wwv_flow_imp.g_varchar2_table(46) := '73601FEF333D1D74C1BE719C3535CA6D17533062040A742CCBA00008446F003C5E2F0E5DBC884AB98202C34E6067A544D83E5ABFBA549E0896968A0DEC103F4775357CF21E05262B6D307F4F60F2F310AE460110889E0038D84C4FF159D4374A5B20197E';
wwv_flow_imp.g_varchar2_table(47) := 'EA0AABB9D3C305D9C1E772F1E7818E532675339A1065CF8241CBA61D9F4FFAD69197653029898998973726E00C110540205A03D0DCDECE677A5AE4ED938C392989CFF4E8E1F37A79053A4F63A3E620B0DB2B534222CC49893068F80BAEE6AAAB875B5E26';
wwv_flow_imp.g_varchar2_table(48) := 'CDC445C7607E7E7E8F7582280002D11200B6BE677F51115C72A129A6BB87D050B81A1AE06E90963598939361D1F9E0DA137753135CB5D2433863315B30AFA0C0EF0C11054020810270FEDA357C79A144E9B3991E5B467AD84B074632000C2FFD58734599';
wwv_flow_imp.g_varchar2_table(49) := '2162A6E4E622B79BA5D31400817417801BADADA8BBD58C92EA6ADC52DD43F3174F99197CB378B8453A008CCFE9E4A75CFA54DF64AC125E6EE650A4C5C723495EB54A0110883A003D314645C39A91DEF34C4F087A23000C7BEE70B2A35E1DEDF26FEE19ED';
wwv_flow_imp.g_varchar2_table(50) := '09FE86D312007362122CA9FA1E76F552D727B50C1A04F3C0C816A4EAFA70EC0F05E01B4E5D19AE03BBD53146D9F80B27137B50D430C5192AF67EC05151A12C7160333F11E7F3C173EB16FFC7EB7076BA356222752BD69F09B71A9410350A00111A058008';
wwv_flow_imp.g_varchar2_table(51) := '8D02408446012042A30010A1510088D028004468140022340A00111A0580088D02408446012042A30010A1510088D028004468140022340A00111A0580088D02408446012042A30010A1510088D028004468140022340A00111A0580088D024084460120';
wwv_flow_imp.g_varchar2_table(52) := '42A30010A1510088D028004468140022340A00111A0580088D02408446012042A30010A1510088D028004468140022340A00111A0580088D02408446012042A30010A1510088D028004468FF0F73F2E448ACF52935000000106465424744464432364245';
wwv_flow_imp.g_varchar2_table(53) := '354537394546413442EECC3F880000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(20070609042326787)
,p_file_name=>'icons/app-icon-192.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_256_rounded_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000001000000010008060000005C72A8660000200049444154785EEDDD797813F78137F0EF489665E3036303060C36F7ED83E004480820B0712E1292100249BA4DD3A7C7BEEDA6DDDDB7BBEDB6DBD0EE6EDAB4DD';
wwv_flow_imp.g_varchar2_table(2) := '67D37DDE6C9BA7FB244D0A6DD2DCE404DBC884104CC08065EEDB0E9701DB18E343B6A4799F9F341ECBC606499646C77C3FFFA0DF0CCFA39981F96AE6774A2022DD92747BE644C40020D2333E0110E918038048C71800443AC60020D2310600918E310088';
wwv_flow_imp.g_varchar2_table(3) := '748C0140A4630C00221D630010E918038048C71800443AC60020D2310600918E310088748C0140A4630C00221D630010E918038048C71800443AC60020D2310600918E310088748C0140A463BA0D80B9A5A5439D4679B613865912300B126642C64C4818';
wwv_flow_imp.g_varchar2_table(4) := 'A3E3FF0FB14F463D24F9982C4B470D927CCC05E930E03C5C6329391CFB277FBD980F80DC6DDB86191C1DB35CB2345332609672938B9B9D373A796B9281DD12E42F6419BB5C52DCCE0316CB05756F8C8AD90010BFF00E93E17E972C3F28C92881842131FA';
wwv_flow_imp.g_varchar2_table(5) := '6F48A120C3254BA8828C4F8C706DDA77F94A2556AF76AAFB63444C05C09CCD9BC7B84C86152E497E4892250B00538CFC3B5198C9C07909D28B4E185E8CA5278398088059A5A5D97171D2B3B28CB5906008F3FF158A6D5D00DE32C8AEFFB76FE9F2EDD17E';
wwv_flow_imp.g_varchar2_table(6) := 'AA511D00333EFD64749CD3F82F922C7D1312E2A3FD1F83A28C247F2449F849F5E2E2BD5176E4AAA80C8002AB35CD05C78F01E93B0012D5B321D29E0CE06DA3133FDD5B547450FBAF1F9CA80A8059566BB251763E0D093F0090A69E0551F83921E1395372';
wwv_flow_imp.g_varchar2_table(7) := 'DABAAAC242F19A1015A2260072AD9BA64B307E0C607C545C59D2ABBD2E83FCF8FEC5C587A2E102444500CC2E2FBF5D92E48F2509A9D1705149E764B44990BF52BDB4F8ED48BF12111F00B9D6B2C725192FB1928FA28C2C43FA518D65D973917CDC911B00';
wwv_flow_imp.g_varchar2_table(8) := 'B22CE559CBFF03127E14C91790E88624BCEABCD8F88D03AB5777AADB2248C40640BEB5EC9732F0CF1174AD880223C91B6D15DB1FC4BA752E755B8488C800C8AD28FD9A244B2F45C835221A340978A1DA52F45D75438488B800C8AD285B20C9D8CA6EBC14';
wwv_flow_imp.g_varchar2_table(9) := '6B24E0B96A4BD10F23E9BC222A000AB66E9EE272193E07303C922E125110ADB5598A5E534B6116310130F9A38F528724C6EF063025CCD78428949A6070CEB52D2E39A56E09A3880880B9BB779B3A5BAE7C2801C561BC16441A91773A2F352D8A84968188';
wwv_flow_imp.g_varchar2_table(10) := '08807C6BF9B765C8BFD3E8EA13859D04F947D596E25F86FB40C21E00EE47FF21F1C7206364B82F0691865A9C0E79F681E2E23A0DBFF33A610F803C6BE93A407A463D2222FD78DD66295A13CED30D6B00E46DDA345236198FB18F3FE9954BC2F2FD4B8A4A';
wwv_flow_imp.g_varchar2_table(11) := 'C375FE610D805C6BD9EF25E05BE13A79A2F09377DA2CC5F3C3751C610B8002AB75BC0BCEE3008CE13A79A2C8202FB0598A2BC3712C610B803C6B99E80CF168384E9A28C284AD2E202C0130CB6A1D6584F35C24544212450007609C60B358CE687D2C6109';
wwv_flow_imp.g_varchar2_table(12) := '00B6FB13F525FFCC66295EA71635129600C8B3967D02A044A373248A06476C96A2E95A1FA8E60130EDB3CF52CC9D1D9739C30F516F06B8E6ECB32CDFA76ED080E601906B2D7F5282FCB206E7461455C2315C58F300E0E33F51FF64A0BAC65254A06ED080';
wwv_flow_imp.g_varchar2_table(13) := 'A601C0C77FA21B90E172763A461CB8EBAE46755B88691A0079D632D1EFF92FEAB713512F32F0608DA5E85D754388691A00ECFA4B7453BFB5598ABEAF96424CD300C8B3965700F262F5DB89A817ADEB01340E80B20B0032D5B325A2BE9C4E18D30E582CD7';
wwv_flow_imp.g_varchar2_table(14) := 'D42D21A459007856F47536A9DF4C44FDD2B23F80660190672D9D0F483BD4B324A281683673B06601C0FEFF44BED1B24390660190672D7B1EC0F7D4B324A281BC67B314AD544B21A46100947E02481C004474135AB6046817005BCA2E40620B00910FEA6D';
wwv_flow_imp.g_varchar2_table(15) := '96A2516A2984B40B006B99AC7E2B110D4C46A76D695182E76120B418004411281D465385C5E208F5A13100882290F352A3598BA5C318004411C874AD3DA96AC58AB6501F1A0380280231008874CC949296545558C82700225D4A7726DBF24B5A437DEE7C';
wwv_flow_imp.g_varchar2_table(16) := '05208A40F6ABADA9471E78A025D487C600D031B9AB0BB2CB0583D9ACE3AB1099DADA3B871EBFE79EABA13E3A06804EB9DADA603F7B0E905D308DCC445CDA509D5E89C86472C86955C5C5CDA13E3A06800E796EFEB380DCD3D18C21105918001412CEB636';
wwv_flow_imp.g_varchar2_table(17) := '74F6B9F9BB31042207038082CED9DAEAB9F915F1A6782499CD68BAD653D7641A3E1C71E9E96A99C283014041E5BEF9CF89777ECF2FBF39DE8CE5050548309950565DDD3B04468C40DCB0616A99B4C700A0A0715EBBE6B9F915E2E62F2928406A82187006';
wwv_flow_imp.g_varchar2_table(18) := 'D89DCEEB42202E63384C197C12081706000585ABA303F62FBFECF5CB5F32670E52FB34FDF51702F1A346C1989AAA96493B0C001A34D1CEDF515B07B89CEE72DF5FFEBEFA0B01F3D8B1300C19A296491B0C001A14D1C1C77EBA16B2A3CB5D361A8D289973';
wwv_flow_imp.g_varchar2_table(19) := '0BD26F7233B73B1CF8784F15DA3A3A3C1B0C4624E4644332993C65D20403800227CBB07F7906AE8E767593A5600EB27C7C9C6FEEE8C0C7555570383DF351487126984508188DCADFA050630050C03ACF5F80B3A5A717E9BC19333165C408B5EC8BF32D2D';
wwv_flow_imp.g_varchar2_table(20) := '28DFBB472D1BCC0930678F0324CDFA8EE91A038002E2686C44D7E5CB6A797A760E0AC78F57CBFE3871F932761C3CA0968D2929881F3D5A2D53E83000C86FEE1AFFBA3AB53C7AF8082C9B39532D07A2AAB616876A4FAB651100220828B41800E41F594687';
wwv_flow_imp.g_varchar2_table(21) := 'A8F4EBEA741713CC66AC28BC15E620BCB77FB46F1F1AAF2AE35244A5E0F81C4871719E3285040380FCD2595F0F6773CFE0B1925BE6624472B25A1E8C6B9D9DF860D72EB552D09090E8A90FA090610090CFFAF6F1CF9B34197959596A3918CE5CB9820A5B';
wwv_flow_imp.g_varchar2_table(22) := 'B55AE69881D06200904F64A7131DA74EAB9D7D46A6A763F9EC5C656F70ED3C7512C744AF42419260CECEE6642221C200209F883EFEA2AF7FB707E72F40527CBC5A0E2687CB85F776EF42BBD249488A8F4742802D0C74630C00BAA9BEB5FEA178F4EFABAE';
wwv_flow_imp.g_varchar2_table(23) := 'B1119FEEAF51CBA6CC4CC40DE56C42C1C600A09BB2D7D6C165F7FC1A0F494CC443B7DEA6EC09ADB2030770A1C1D3D740F40E4C9838911D84828C014037E46C6941E7F9F36A79716E1EC66934865FB40ABCBBB3521D61C80AC1E06300D00D759C3CA50EF4';
wwv_flow_imp.g_varchar2_table(24) := '1995311C45B366297BB4B1B7AE0E074E9FF27C99E81B3071022483419B2FD70106000DC8D1DC8CAEFA7AB53C3439050921AAF81B88D3E5C4E52B57D4B2984148CC2444C1C100A0FE891E7F274FBA9BFF228A242161C204F6100C120600F5CB71E50ABA2E';
wwv_flow_imp.g_varchar2_table(25) := '5E54CB91242E6D184C23F914100C0C00EA97E8F4D3DDDF7F6E760EE68D0B6F97DC938D4DF8E4903262D06044E224B60804030380AEE39ED3FFCC19B5FCFAEA35989AE2DB241FA1D2E17462E9863FA15D0925F60B080E06005D47F4F717FDFE858271D978';
wwv_flow_imp.g_varchar2_table(26) := '79F95DCA9EF0FAF5BE3DF873D56EF741B07760703000A817D9E17057FE75FBD5DDF7A2784C687BFDF9EA4C5B1B56FC65BD5A368F1B074362A25A26FF3100A897AE4B97E0686A727FCE484E41D9A36B953D91E1BB155BB0FDC471F7C170E6A0C16300502F';
wwv_flow_imp.g_varchar2_table(27) := 'EDC74FA823FEFE6EE1223C356DBAB227327C76B11E7FF7FE7BEAC1244C9AC44944078101402AF76ABE5E957F157FF3350C8DC069BAEF7DEB0D9CBBE2794AE1A22283C3002095F7E3FF9CEC1CBC545CA2ECF15F436727CACF7C898ADAD33876F1A2BBF67E';
wwv_flow_imp.g_varchar2_table(28) := '5AE628DC919D83E271D918779375036EE4B9BD55786D4F95FB335F0306870140AA8ED3A721777A9AD906F3F8FFD39D95787FBF4D2DF7E78E4993F1EC1D77223580278C6DF517F0F4071B3D05C980C429933D9FC96F0C0072EB5BFBFFDA238F625AAAFFE3';
wwv_flow_imp.g_varchar2_table(29) := 'EF9F2ADD84BD75B56AF946B2D333B061C50348F673E2CF76A713B7BFF252CF3A845C562C600C0072F3EEFA9B9E948CF2358FF97D659EB755E3955D3BD572CEF01198376102F294C13BA7AFB66067DD29D4D429D37D01289E3E13BFBA63A15AF6D5FFB196';
wwv_flow_imp.g_varchar2_table(30) := '63C7C913EECF1C2014380600B9D9CF9C85ABCDD3F967655E3E9EB9759E5F57A6A1D38EA2F5AFAABFCAF939E3F1C8004387B7D5D562D3FEFD6A3990A78D0DC78FE1375BADEECF92291E0913386558201800E4D67EF4A87A257E7DCF7D281A3D462DFBE20F';
wwv_flow_imp.g_varchar2_table(31) := '870FE27FB67FE6FE3C342909FFB878310C187879AF3FEDDB8B23E7CEB93F3F32E716FCCB2D85CA1EDF9C6ABD86875EFBB35A16B305710D01FF3100C85DF1272A00BB953EF1550C379BD5B22F9EDCF431AACF781EED8B66E7624976B6B2A77F871B1BB1BE';
wwv_flow_imp.g_varchar2_table(32) := '7287FBF398B461F8F0E147943DBE5BB4FE55B4285395C56765C19894A4EC215F3100A8D7B45FA90989D8FAF857FCBE2ADE6DF36BE6CDC7EC8C0C654FFF2E77D8F1FC9632B55CF9E4D7FD5E5DC8BBC291D38505860140EE453EC5629F4261760EFE1040FB';
wwv_flow_imp.g_varchar2_table(33) := 'FF03EFBC85BAC606F7E735B7CDC3ECE1C3953DFDBB62B7E337E5830B805FECD98DBF2A2B0B1B5352113F7A94B2877CC500A05E15808FCD2DC40F0A6EF1FBAA7CC75A8ECF955AF9F953A6E2BE2953943DFDDB535F8FB795917D81B63ABC71EA249E559E22';
wwv_flow_imp.g_varchar2_table(34) := '24B319093939CA1EF21503803C537F393CEBF1FDB468391ECCF1BF467DC389E3F84DC516F7E778533C7EB06C29120D03FFA2BFB06307CE37799E3A1EC8CBC73A3F5B1D84BD8D8D78EA9D37D572A2081D69E08A47BA1E0340E764970B1DC73DA3EB84571F';
wwv_flow_imp.g_varchar2_table(35) := '5E8DDCB434B5ECABE6AE2EDCF5E7F5E85066109E969585D5B97930F73383EF47C78EE1F3633DAD0EEB57ADC6ACA1FE7FE7D5AE2E2C7EF565B56CCEC9E112627E6200E89CCB6E87BDB6A7E7DED6BFF95A40DD7385170EECC7FF567EAE9653128760D1B4A9';
wwv_flow_imp.g_varchar2_table(36) := '189D9CE22E5FB57760FB891338ABD4370845D366E0D70BEF54CBFE5AF6DA9FD1D8EA59B28C2D01FE6300E89CABBD1DF6EE8538C563F5D7BFA97E0EC4374A3761B71F5D81D7AFB81F297181058EB06AE3BB3871C9D383912303FDC700D039EF25BF531212';
wwv_flow_imp.g_varchar2_table(37) := 'F169004D80DEEC4E277EF6C54E7C7CB0A7A75F7F164E9C84FF58B828E0A78D6E4F6DFE047BBFF4AC5B681A39127101BCBEE8190340E7BCFB0004DA21A73FBB1B1B5076FA148E3734E0746323BA1C0E4C1A3102776667A3645C0EC62405A7D3CEF7B65AF1';
wwv_flow_imp.g_varchar2_table(38) := 'E9F163EECF7119C361CA4857F6902F18003AE7BDFACFD4CC5178FDBEFBA3EA8AFCEBCE1DF840594598EB05F88F01A07362021031118830D84940C2C17BA660636AAABB1E807CC700D0B9AE8606381A3C3DF8164D9E82DF2EB644D515F9FDC1037871C776';
wwv_flow_imp.g_varchar2_table(39) := 'F7311B9393113FC6BF414C7AC700D039EF00B873F214FC779405C08B870EE2F79F7B46218AC140A229907CC700D0393106408C0510A2F115E037FBF66243D52EF7F1737E40FF310074CEBB0E60CAC84CFC75C5035175459EF9622736D654BB8F990382FC';
wwv_flow_imp.g_varchar2_table(40) := 'C700D039C79566745DF4B40204B319502BFFF8D9A7D872E4B0FBEB441F00D117807CC700D039E7B56BE85466E609464720AD7DABBC145F9C3EE5FEDAB88C0C986E320F01F5C600D039574707EC759E9E74C260BB026B6DCD871B71E4C205F7D79A466622';
wwv_flow_imp.g_varchar2_table(41) := '2ECDBFB905F58E01A0737DA703DFB8F689412DDAA1B5392FFD419D885434018AA640F21D0340E7C454E0624AF06E2FDCBF12B78F888EF7E88BF60E948899881562A560B14600E704F01D0340C73AEBEBE16C6EEE7505FED9B2146B2646C74A3B62BCC137';
wwv_flow_imp.g_varchar2_table(42) := 'DE794B3D76C1909008F3388680AF18003AD5DFCD2FAC9D5B887F0A604AB01B112BF9B4391DC888F76FA6E19B79ABF614FEBDAC542D77E39380EF18003A34D0CD2F2C983809FF6359A69607EB607333BEF9FE7B68B57704B4DEC08DFC67F53EACDFFD855A';
wwv_flow_imp.g_varchar2_table(43) := 'F6C610F00D034067FADEFCC9494998306A146A4E7826F41C3A2409156B1F57F60EDEFF1E3E8817940543964E9B8EFF5CB848D93378DF28DB8CDDB59EF50C26668D456B4707EA1B3CBD1A05BE0EDC1C0340473A2F5C80F3EA55F58CC5CD5F523007F6CE4E';
wwv_flow_imp.g_varchar2_table(44) := '7CB0ABE797F49D358F637C5270C6EB7BAF18B478F2143C1FC4B106F35F791976650EC2DB67CDC6C48C0C941F3C88F3973D3D1B05833901E6EC71AC181C000340273ACF5F80B3A5E7E64F4D4E46717E011295B9F85FDBBE1D0EA76766E0678A976365B6FF';
wwv_flow_imp.g_varchar2_table(45) := '3303F7275401606B6AC257DF7E432DAF5C703B9295D9851802BE6300E8407F377F495E3ECC5ECB72571C3E8C334A97E015B3F3F0F379F3953D8313AA0078E5E8113CBF6DABFB73823901ABE6F59E56DC7AE810CE2A73050A7C12E81F0320C6F57DEC4F4B';
wwv_flow_imp.g_varchar2_table(46) := '4945716E6EAF9B5F3878FE3CF62853758F4D4FC7FB0FAE52F60C4EA802C07B2AB00963B270C7E4EB9B2EAD870FE3AC126A0243E07A0C8018E63DD24F1037FFF2BC3CC4F7B304D7A5D6566C5266D611363FF1558CF07381D0FE7807C0922953F15F8B9628';
wwv_flow_imp.g_varchar2_table(47) := '7B06E7CE0D7FC2B58E76F7E7DBA6CFC0D4010601F50D018E18EC8D0110A39C6D6DE83C73463DBB61E2977F809BBFDB5F77EC406757A7FBF33F2D598AB593AEFF55F557289E003EBF7411DFD9F8AE5A5E397F0192E3E3D5725FDB8E1E41AD325E40E0ECC1';
wwv_flow_imp.g_varchar2_table(48) := '3D1800B148963DCB7D399DEEB333C79B71DFDCB948BCC914DC95274EE0F8594F68E48F1D873F96DCADEC095C280260DDAE9D78CFE699032063E850DC9D5FA0EC19D8C7FBF6A1E16A4FF367C2C48990FABC06E91103200679CFF22394DC3217237C182473';
wwv_flow_imp.g_varchar2_table(49) := 'A1A50565CA6ABB42D9579E44C60D7E597D118A0058B8FE5577C722A170EA344CF76122D0B6AE2E7CB07BB7FA84C357010F0640AC9165B49F3809B83CBFFE93B3C662FEA4493E9FE59B3B2BD161B7BB3FFFDF254BF1F8205F03821D00DBEA2FE0E90F36AA';
wwv_flow_imp.g_varchar2_table(50) := 'E5550B6E47C24D9E6CBA1DAEBF80DD478EA865AE25C8008839A2C65FD4FC777B70C1ED48F2F10611769F3E8DC3CAD25EB3B3C6E24F77DDA3EC094CB02B017F52F9393E3CE05975283363388A67CD52F6F8E6ED2F76A2ADC3F3F410979E0ED3F0E1CA1E7D';
wwv_flow_imp.g_varchar2_table(51) := 'E213408C11B3FB88597E84F1A34663E1D4A97E9DE1E5D6567CE2D51AF0FAEA35989A92AA96FD15CC2780A6CE4E2C5DFF8A3AFE7FDE8C9998326284B2D737B6B367613BE1590D598A8F47C2F8E074788A560C8018D37EEC3820BBDC67B568762EB2D3FD5F';
wwv_flow_imp.g_varchar2_table(52) := '2A6BE39E2A5C5542E4BED9B9F8B7790B943DFE0B6600F45A03C068C4C3F317DCB055A33F57DADB7B757BD67B6520032086F49DDDE7913B16C2ECE70D221CBF7C1995070FA8E5F2AF3C89F4002B038319004BFEB201CD6DADEECF3372C6636E4E8EB2C73F';
wwv_flow_imp.g_varchar2_table(53) := '6F5456C2DEE9A9E7D0FB92E20C8018E2B2DB61AFED599AFB89458BD5CFFE7AB372073A3A3D35E65F9FB700DF9D9DABECF14FB002E09DDAD3F879D9664F4192F0D0FC0518E247DD86B70FF7EE4593D235DA949989B8A1FA9D4790011043BC3BFF24C49BB1';
wwv_flow_imp.g_varchar2_table(54) := '6A7EE0FDF9BDBB06A7262462D39AC79010C0D344B02A011F7AEF1D9C5246F94D1C9385DBFBE9FAEBAB2D870EE19C324E4054028ACA40BD6200C410EFA5BEC550DF95730B033EBB2EA7136F5556AA2304BF7DFB427C6BC64C65AFEF82F104F0FE9775F8E9';
wwv_flow_imp.g_varchar2_table(55) := 'E64FD4F28ADBE6616842825AF6D7B6A347517BC1739DF4DE12C0008821BD0260C810AC2CBC755067B7B7AE0E079439F7CD7126BCBFE631BFC7070C36003A9C4EDCFBC6EB686CF5544A8E1D998925D3A72B7B03D32B00860D83C9CF968458C2008821C10E';
wwv_flow_imp.g_varchar2_table(56) := '804EA713EF7EF185DA7BEE81BC7CACBBB5F7B0DB9B196C00782FFE29DC7FDB3CA40EE2D75F6000F46000C49060078070E4623D761DF62CBD25BCF5E86398E843B7E26E830980CB763B8A37BCAAB6FB4F1D978DDB264C50F6068E01D083011043421100C2';
wwv_flow_imp.g_varchar2_table(57) := 'FB7BF6A0F95A8BFB7361760EFE505CA2ECB9B9C15402FEEBCE1DF8607F8DFB73BC291E2B6FBBCDEF76FFFE30007A30006248A802E0624B0B367B0D12F267CAB0409F00763534E09BEFF6CCF97FA331FFFE6200F46000C490500580B0FDD8319C3AEF5944';
wwv_flow_imp.g_varchar2_table(58) := '34C96CC6C6D56B7DEA1C144800B43B1D78F0EDB750AF0CDF1D9A9C8215B7046FAD0206400F06400C0965009CBB7A155BF6ED55CBBE3ECE071200CFEED98D37BC9E386E99321533478F56CB83F5D9D1A338CD56003706400C095500D45FBD0A6B4D8DDA27';
wwv_flow_imp.g_varchar2_table(59) := 'A0DB7377DF8BE563B2D4727FFC0D80EAA6463CF9F69B6AB95BE1B4E9989E99A99607834F003D180031A457000CB22350B7E3972EA1F2D041B5EC6D68E210BCFEF02A649A076E96F3A712B0D5E1C0A3EFBD83B3579AD46DDEA68C1D87791327AAE540F50A';
wwv_flow_imp.g_varchar2_table(60) := '009D0F096600C490600740556D2D0E292BEF748BCBC880A3B1491D713873F4186CB8E73E65EFF5FC7902F84EC5167CAE0CD515FA7E973066C448DC396D1A4C0683BACD5F0C801E0C801812AC570087CB854F8F1C51FBCBBB4906C48F190D6352927BBE01';
wwv_flow_imp.g_varchar2_table(61) := '31EF40B71B0D19F635005E3E7A18FFBDED53B5DCFDCB2C7776C27EE68C7BA463B7A149C958969717F06020BE02F46000C490600480983BCFBA7FBF3A5A4E908C46C48F1D0B835737E0BE6B0CFE6459311E1E7F7D271D5F02606F53239EF27AEF772FEC39';
wwv_flow_imp.g_varchar2_table(62) := '6E9C5A16939B769E390B97320FA0906036C392978F8CC444759BAF18003D18003164B0AF004DEDED28B7D9D0E175A3496633CC5959D7CFA02B661EAEAB83ACCC1F28BCF4E02ACCE933B2EE667500173ADAF1D8BB6FA3A9D533CE5F848D79FC78F79FBDC8';
wwv_flow_imp.g_varchar2_table(63) := 'B2FBDCBA673B12C4A42062D2932C3F87F3F215A0070320860C2600CE363763DBFEFDBD6AFAC5E37EFC9831032EAC291ECBC5FC03DDD38F0B5FBD751E0A478D42529CE7F17CE38963785799C2BB60EC383CAD8C2510837C0E365EC6CBBB76A933FC0AE6EC';
wwv_flow_imp.g_varchar2_table(64) := '6C186ED0D75F2C7422163CF1E66F332103A007032086041A00872F5CC0EEA33DB3E50A7169C3601A79F35172AEF676D8BFFC522D0F86AF9373389A9BD155DFB3DA8F3069EC382CF0B1858001D0830110430209809D274FE2D899DE37B0696426E2D26E7E';
wwv_flow_imp.g_varchar2_table(65) := '237673B6B67A2A0595413B81104372C5D05C5FB9DADA603F775E9DFE5C18959E81C53366C0D4F7F5A10F06400F06400CF12700BA5C2E6C3D7408171A7A161071D7F4678D8171C8107593AFC4EB8068B2131575AE0E7BAFA6BB811812122199E3119796D6';
wwv_flow_imp.g_varchar2_table(66) := 'AB82D1579E1682B3901D5DEA36B1F2F1B2D9B948BA41376506400F06400CF1B515A0B5B3135B6A6AD0AC4CB221884A3EF3D8B1EEA9B283A9ABA1018E8606F767779D42D68D7B0EFAABBF1602B1149A253717C39392D46DDED80AD0830110437C09804B6D';
wwv_flow_imp.g_varchar2_table(67) := '6DA8B0D9D4597105B16C76FCD8ACEB6BDE8320D401E0265A08C432E82D9E21CBDDEECCCD45CEB0EBE7FBE358801E0C801872A35780E68E0E9CBC78519DE2AB9B313919F1A2067D809AFEC1D22400BABFEBF265F7BA88DE268E1E83695959C8F07AADE12B';
wwv_flow_imp.g_varchar2_table(68) := '400F06400CF10E00A3C188E169699065195744CF3D655A2F6F5AF483D7320004EF6BE02DCE188761A9A9304892FB7A743F0169710D2219032086F4EDA23B208311F1A332DDBFFEA1D6D5D0088752D1E87EDA10FD0A424CAC8FD079F65CAFCAC1813000E4';
wwv_flow_imp.g_varchar2_table(69) := 'B4AAE2E29E2E9D21129AE7CB7EE459CB026F8B8A727D5706EA4BBCE31B5353DDFFE943F1BEDF1F77739DB2568169E448778DBF2664D9DD5FC0D17405723F4F3FDD4417E7405A3D62059F00628C681AF31E38A3321A036A6A0B06F18B0C97CBDDC73F1C22';
wwv_flow_imp.g_varchar2_table(70) := 'F19A440A0600918ED9AFB6A61E79E081DECD2721C05700A24894EE4CB6E5977846628510038028029952D292AA0A0BDB427D680C00A20864BAD69E54B562050380488FAEC29878DA62E9E9471D227C02208A40CE4B8DE603AB570FDC4E1A240C00A20864';
wwv_flow_imp.g_varchar2_table(71) := '5BB2CC0849BAF9D0CD41620010451EBBCD5234F0F44B41A45D006C293B0D0939EA3713D1406A6D9622DF16791C24ED02C05A5A01488BD56F26A201485B6D966503AFD412441A0640D91FC5DC94EA3713D1405EB7598AD6A8A510D230004AD701D233EA37';
wwv_flow_imp.g_varchar2_table(72) := '1351BF24E0B96A4BD10FD50D21A45900E45ACB9F9420BFAC7E33110D64ADCD52F49A5A0A21CD02A0C0BAB9C00543CF3AD644D42F19CE19359692C3EA8610D22C00B06E9D216FF14231DB6578C69E124503196DB64F3F4BC1BA7521EF0320681700EE4941';
wwv_flow_imp.g_varchar2_table(73) := '4A2B01C9B3040D11F543DE69B314CF578B21A67100943D0FE07BEAB713512F32F0628DA5E8DBEA8610D33A0044D3C65FD46F27A25E24487F5B6D59F67B754388691A0073366F1EE33419C444749A7E2F5194908D5DAEB17B972FF76106D9E0D0FC46643D';
wwv_flow_imp.g_varchar2_table(74) := '0051FF64A0BAC65254A06ED080E601906F2DFDA10CE9171A9C1B5154D1B2035037CD0320D7BA69BA04E321F5088848212FB0598A2BB5BC1C9A0780906B2DDB2701F95A9E2851449350972E1B2755582CFDCC1D1F3A6109803C6BF9F701F9BFD4A320D23D';
wwv_flow_imp.g_varchar2_table(75) := 'F967364BF13AAD2F43580260AED53ABC0BCED300FA5F279A485F1C4E873CE94071719DD6A71D960010F2383C98A8DB7B364BD14AB5A4A1B005C0AC2D5BF28D92AB4A2C8EA5E1F912451C0364CB3E4B7145380E2C6C0120F02980089B6C96A2BBC2751DC2';
wwv_flow_imp.g_varchar2_table(76) := '1A00B965651325238EF22980F44A36C879358B8B6BC275FE610D00814F01A463617BF7EF16F600C82F2FCF9225D90609E9EA5111C5BE56974BCADFBF6CD989709E6AD80340E07461A4375A8FFA1B48440480906B2DFB4002EE558E8B2886C9DB6D96E285';
wwv_flow_imp.g_varchar2_table(77) := '9170821113007C15209D888847FF6E111300C2EC8AB262838C0F019894E3238A1D325C92415A55BD64D93B91725211150042BEB5FCDB32E4DF45CA05220A1EE9EF6D9665625ABC8811710120E471EE408A3DBFB5598ABE1F69A7159101005996722BCA9E';
wwv_flow_imp.g_varchar2_table(78) := '952069B23A0A5128C9C03B355B3F5BA5D554DFFE88CC005070F6208A01EF99AEB53F56B562455B249E4B440780905751FAB790A517223DAC88AE23E31736CBB21F439264755B8489F80010F2CBCB97CB06F95500991176FD88AE27A35396F0548DA56883';
wwv_flow_imp.g_varchar2_table(79) := 'BA2D4245450008B3CBCA32A538F95549969647E8B524126A5C703DB5DFB27C77345C8EA80900375996F2B76E794296E55F0118150D179874A34B96F1CBF8D4B47FAB2A2CEC8A96B38EAE00504CFEE8A3D4C421F1CF48329E0610172D179B629278BF7FCB';
wwv_flow_imp.g_varchar2_table(80) := '09E38F0E582CC7A3ED0CA33200BACDB25A27C7C1F96319788241405A93810A8341FE87EAC5C551BBEC7D54074037060169C82E016F4AB2EB77FB962EDFAEE1F786444C0440B739E5E5394E83EB6B802416219DA6EE201A2C192721C9BF3321EE8F5516CB';
wwv_flow_imp.g_varchar2_table(81) := '65757B948BA900F05660DD5C204B86B5B28CBBC56863750791EFBE8484F75DC0BBFB971495AA5B6348CC0680B7BC4D9B92E478E30209D23C40BE15C05C0063D5BF40E4D10A0955125026C9AEF7F75996EF8BF50BA38B00E8CF9C4F3F1AE170990B21BBE6';
wwv_flow_imp.g_varchar2_table(82) := '1A20CD95254C74372DCA18A9FE258A4D12CE41C64500B5B2846A834BAE76CA86EA704FCF150EBA0D801B5962B5C69D06E23252520C1D2D2D067B7BBB213931D1E08C8B93BAEC7683FA1729E298CC6697D1E190CD8989AE2BF5F5B2797C822BA935C575F5';
wwv_flow_imp.g_varchar2_table(83) := 'CC19E701C089D5AB9D1177D061C40020D2310600918E310088748C0140A4630C00F55959DC0000006049444154221D630010E918038048C71800443AC60020D2310600918E310088748C0140A4630C00221D630010E918038048C71800443AC60020D231';
wwv_flow_imp.g_varchar2_table(84) := '0600918E310088748C0140A4630C00221D630010E918038048C71800443AC60020D2B1FF0F0FFD2CE24161114B000000106465424739314441323943423844453542363731B640C2E20000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(20070793276326787)
,p_file_name=>'icons/app-icon-256-rounded.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_32_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7AF400000256494441545847ED95CF6B134114C7BFBBD9D4A44D768D8936126DAC16412C89D880CDC18A547A50100FE21F20BD88148A7A10C49B07C183B742C183F71EBC88';
wwv_flow_imp.g_varchar2_table(2) := '1E4C2B22D652DB626A8B85B686B4D1FA23BB75A79B346E7EC98E71B107CB6CB014613F97D9F766063E3CE6BDE522CF13556C239C2D6057C0AEC07F5D01E7EA2A9D20459FAFEE495277059C2AC199D656189713A9144A9268EE59A12E81723E8F93FE0082';
wwv_flow_imp.g_varchar2_table(3) := 'A244E3CF44C54B4586C3EDAE9D60A72E814AE6130E37EF316383F9AFDFC085F69A312B9605CA9A8681137174ECF29B398309398BAB13E37034369A39162C0B4884E0E9B9F320C522AE0C3F03C70183DD3D703B1C38FBE43188E835CFB26059A0CBB90377';
wwv_flow_imp.g_varchar2_table(4) := '3BE3985F5BC3C3B959FA087B8FB4E3A0C7831B63A3182DEAE659162C0B5C9476E25AE418FD1E4A7D8093E771217C80C6F7926FF1887CA7DFAC5816B824F9D01F899AF19FDC9F4E6248FD351B58B1245052097A02BB71A7334EE32F85025D9B5D2EBADE7C';
wwv_flow_imp.g_varchar2_table(5) := 'FD0A238A0C41649F09CC0246EFC74409255DC7E0A9D33437A9C8E0001CAF75C4E59161B8DC2E4C1295B91B9805025A0E5D87DA9052B2B8DE1EA58F6E4A91E99E21F05E553130378BB0CF8F178B0B903D4DB59B9BC32CD0562C21B26F3FCAD50A742D87DB';
wwv_flow_imp.g_varchar2_table(6) := '1DB10D15B8353E064992C0733C921F97B12808E6DDCDB02C60F0269D465F340AB7205001E547010F666610AB75C37466190BCE2D10381A0A616A6909690E107279740783742FB1B282B2A709617088B5B4E05D26F3EF05C4AC8C0A0710AF177C4303CD95';
wwv_flow_imp.g_varchar2_table(7) := 'D7D7E9FAFB2754D175889A06BE5205096C1CD57F835960ABB005EC0AD815D8F60AFC0429630C304656C67300000010646542473046334232353434393233453235353415A6B9EC0000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(20070896631326788)
,p_file_name=>'icons/app-icon-32.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_512_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000200000002000806000000F478D4FA0000200049444154785EEDDD777C5CD77DE7FDDF7414A290200A091020C022F62A56518D1225518DEA946C756D9C38EB78E3C4EB7893F53A8F9DE4B1B359DBC9E33477';
wwv_flow_imp.g_varchar2_table(2) := '358A1225AB8BA21A258A127B0729F60680040892684499FEBC2E249EA521DC9941BD77E67CDEFF84BFAB5873E60E5FBADF7BEF39BFE398B6F6BDA8000000AD3808000000E887000000808608000000688800000080860800000068880000008086080000';
wwv_flow_imp.g_varchar2_table(3) := '00688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000';
wwv_flow_imp.g_varchar2_table(4) := '68880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068';
wwv_flow_imp.g_varchar2_table(5) := '88000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888';
wwv_flow_imp.g_varchar2_table(6) := '00000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800';
wwv_flow_imp.g_varchar2_table(7) := '00008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000';
wwv_flow_imp.g_varchar2_table(8) := '00808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000';
wwv_flow_imp.g_varchar2_table(9) := '808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000068261A0A49B0BE5E226D6D9DDFDC9991299EFCE1E270BB353B1380DE08008046221D1D';
wwv_flow_imp.g_varchar2_table(10) := 'E2AFAA168946FEF05B3B5DE22B1E29CEF4747508406A2300009A08B7B549A0A646241AEDFE1B3B1CE22D2E165746863A0420751100000D842F5C90C0E9D3E617FF8B8C10505424AEAC2C7508406A220000292EDCDC2C81DADA1E7DCBCE10909DAD6A00A9';
wwv_flow_imp.g_varchar2_table(11) := '870000A4B0D0F9F3123C7BB657DFD0535020EEDC5C5503482D0400204505CFD44BA8B1A14FDFCE3D6C9878860F573580D44100005250A0AE4EC24D4DFDF2CD8CA700C6D30000A9850000A498C0E95A09B734F7EBB772E5E488B7B050D500921F01004821';
wwv_flow_imp.g_varchar2_table(12) := '3DB9F80FF962B9DF852F1A02C5430800520B010048113DBAF8A767C80D336674FEF99D5D3B090180860800400AE8C9C53F2773882C993E5DD2BE68FDDB1E0AC9BBBB764973EB852FFE3F62E34900901A08004092EBC9C57F6856B62C993A55BC5DFAFEFB';
wwv_flow_imp.g_varchar2_table(13) := '8D10B07BB7345E6851C7627165658B774491AA01241F020090C402A74E7576F94B445E4E8E5C3F65AA785C2E75EC52815048DEDFBB57CE3535AA63B1100280E446000092544FEEFC0B860D936B274D168FD3A98E7527180ECB077B2BA5BE31C110909DDD';
wwv_flow_imp.g_varchar2_table(14) := 'D9351040F221000049C8D8CE37D49058939F82A1C364F1E4C9E28E73F1BF281889C807957B120E01EEBC3CF1E4E5A91A40722000004926D4D424C1BABA8446DDD38BFF453D0D01EC1D00241F020090443AB7F4ADAE4E68C4BDBDF85FD4D310E02B291127';
wwv_flow_imp.g_varchar2_table(15) := '5B090349830000248988DF2FFE9327E36FE9DB0F17FF8B7A14021C4EF1958E12A7CFA70E01B02F02009004A2A190F84F9C9068381C77B4F9B9B972DD94A97DBEF85F648480F776EF9273CDF1271C3A5C2EF1959589A3CB324300F64300006C2E1A8988FF';
wwv_flow_imp.g_varchar2_table(16) := 'C44989060371473A342B4B964C9B2E5E93A57EBD652C117C3BC166410EAF57D2CACA441C0E750C80FD1000003B8B46C55F552D918EF6B8A334DAFB2E9D39537C0374F7DD160CCAEA1DDBA5BDA3431D3363CC0530E60400B02F0200606381D3A725DC12BF';
wwv_flow_imp.g_varchar2_table(17) := '3B5F9AD72B4B67CD964CAF571D1B08CD1D1DB27AFB76098682EA98197A0400F64600006CCA58E76FACF78FC7ED72CBD2D9B325272D4D1D1B48675B5BE59DEDDB25128DA863663C0585E2CECD513500FB2000003694E8723FA7C3294B66CD92FCCC4C756C';
wwv_flow_imp.g_varchar2_table(18) := '309C6A6A92B5BB764954E2AF48F08D1A25CEF4745503B00702006033D140403A4E18CBFDE2DF615F3D6DBA8CCACD55F5603A76EE9C7CB2B732FE473A5D92369A950180DD1000003B8946A5E3D8718926F08E7DC6D8713265E448555B61E7C9935279FC58';
wwv_flow_imp.g_varchar2_table(19) := 'DC8F76F87C92565ACACA00C0460800808DF8ABAB25D2D616774465854572E56597A9DA2A464FA20F3FDB273567E3CF55700D19225E8B030B80FF8B0000D844F04CBD841AE36FF033342B5B6E9A31435C3659676F340A5AB36B973426B033A13B6FB878F2';
wwv_flow_imp.g_varchar2_table(20) := '86A91A80750800800D842F5C90C0A953714792E6F3C92DB3664BBAC7A38ED9416B20206F6EDB2A8160FC5717EC1900D8030100B098D1E6D778EF1F6FD29FCBE9929B66CF96A1369D517FE6C2057977FBF6B82B033ADB058F1EDDF97F015887000058CC7F';
wwv_flow_imp.g_varchar2_table(21) := 'B22AA14E7F8BA64E95D143EDFDF8FCE0993AD9BC7FBF1AB3196746A6F84A8A550D60F01100000B05CF9E95D0F9F3714730AEA444E6558C51B59D7D7460BF54D5D5C51DA2273F5FDC4387AA1AC0E02200001689B4B78BBFAA2AEEA7E7640E919B67CDB2CD';
wwv_flow_imp.g_varchar2_table(22) := 'A4BF7802E1B0BCB57D9B5C688FF354C3E1105F6929DB0703162100001630B6F5EDDCDE37148AF9E9469BDF9B67CF96EC416AF3DB5F1ADADA64F5B66D71DB053BDC1E492B1F4D7F00C0020400C00289AEF7BF66DA7429B1A8D35F5F1DACAB93CD07E2CF07';
wwv_flow_imp.g_varchar2_table(23) := '7065658B774491AA010C0E020030C8428D8D123C7326EEA75E36AA54E69497AB3A197D74E08054D5D5C61DBA77C408716565A91AC0C023000083281A0C4AC77163C95FECA57246B39F5B66CE5475B20A86C3F2E68EED7221DED30E63BF80729606028389';
wwv_flow_imp.g_varchar2_table(24) := '00000C2263D29F31F92F166387BFDBE6CE952C9F4F1D4B66E73BE7036C95689CD0633C01309E0400181C04006090841A9B247826FEF2B8B9974D90F18585AA4E057B6A6A64D791C371BF8AB7B8585C83BCB531A02B0200300812EDF6579C9F2FD74E9CA4';
wwv_flow_imp.g_varchar2_table(25) := 'EA5461DCFCAFD9B35BCEC6D9EBA0B34B6079B9389C4E750CC0C020000083209159FF3EAF4F965D7EB978DD6E752C9518FB05BCB175AB04E36C75ECCACE166F11AB0280814600000658B8A54502A74FABDACCF533664A5176B6AA53D1B1F3E7E493CACAB8';
wwv_flow_imp.g_varchar2_table(26) := '5FCD5B5222AE8C0C5503E87F04006000190D7F3A1FFD47C2EA5877C68F2A95B949BEE42F5189B40AA6411030F00800C0000A9CAE95704BB3AABB636CF1BB6CCE5CF168F2DEBB3D189457376F9650384E17C4A1433BF70B0030300800C00089747488FFE4';
wwv_flow_imp.g_varchar2_table(27) := '49559BB96AEA3429D56C539CFD75B5B2F5C001750ECCA419DB067BBDAA06D07F0800C000311AFE4403015577A770589E2C993245D5BA8844A3B27AC70E69B8D012F32B3BD3D3C5376A94AA01F41F020030001269F7EB72BAE456A3E18FA677B8E75A5B3B';
wwv_flow_imp.g_varchar2_table(28) := '1B04C5E31D39525C4386A81A40FF200000FDAC73E2DFD16371D7FCCF183B4EA68C1CA96A1D6D39764C0E54C57E4DC2844060601000807E16A8AB93705393AABB933D6488DC3E6BB6AA7565EC15F0CA962DE20FF8639E02775E9E78F2F2540DA0EF080040';
wwv_flow_imp.g_varchar2_table(29) := '3F8AF8FDE23F7142D5666E9C7DB9E4D3F2B6D3F173E764FDDE38BD011C0E49333A04A6689324C00A0400A01F759C3821517FECBBD9B2A21172E5F8F1AA86C87B9595527BFE5CCC5361CC0330E60300E81F0400A09F24D2F1CF98F877C7BC7992EEF1A863';
wwv_flow_imp.g_varchar2_table(30) := '1069F1FBE5F5CD9B251267DE84AFAC4C9C29B24B2260350200D04F8C897FD1387DEE678D1B2F93D8F2B65B3BABABA4F2E851557787658140FF210000FD20D4D424C138ED6D876464C8EDB32F17A7C3A18EE1FF0A47A3F2EAD62DD2D6DEAE8E75877D0280';
wwv_flow_imp.g_varchar2_table(31) := 'FE410000FA2A1A958E63C6DD7FECD6B64B66CC94C214DFECA7AF4E3537CB073B77A8BA3BCEB474F195D21C08E82B0200D047A1C626099E897DF78FFEE52D2E1617AB28803E2100007D61DCFD1F3DDAD9FC0783C7E1F3495A59D9E07D2090820800401F84';
wwv_flow_imp.g_varchar2_table(32) := '1A1A24585FAF6A0C1EEF8811E2CACA1ABC0F04520C0100E8AD6854DA8F1C158970F76F0563974063B74000BD4300007A89BB7FEBF11400E83D0200D04B9DEFFEE3CCFCC7C0624500D07B0400A01712E9FA87C1E12B2D15675ADAE07C1890420800402F24';
wwv_flow_imp.g_varchar2_table(33) := 'D2F31F83C3980868BC0A00D0330400A08722EDEDE2AFAA5275776E9B324D7E306FBEAAD17BFF6BD34679BD72B7AABB935651C14E81400F1100801E0A9C3A25E10B1754DD9D97963F20154358A2D61F0EB7B4C8BD2F3CA7EAEEB8870E154F7EBEAA01C447';
wwv_flow_imp.g_varchar2_table(34) := '00007AC098F4674CFE8BE58A3163E5E7D72C5635FAEEBFAE7D5F3E3D7A44D55FE2704AFAD83122ECB300248C0000F440F04CBD841A1B54DD9DFF5C7697CC1D3E5CD5E8BB4D67EBE54F5E7D59D5DDF11414883B3757D5006223000089321AFF1C3E221263';
wwv_flow_imp.g_varchar2_table(35) := 'CFFA710585F2C26DCB548DFE73FF1BAFC981BA5A5577E5F07825AD9CC64040A20800408212D9F2F74737DD2C371697A81AFD67757595FCF59AD5AAEE8E6FD42871A6A7AB1A803902009020FFC92A897498EF555F90952D6FDDBB5C5CBC871E10E168546E';
wwv_flow_imp.g_varchar2_table(36) := '79F105A96B6E52C7BA7265678BB7A848D500CC11008004440301E9387E5CD5DDF9CBABAF9507C78E5335FADF93070FC8CF3EFE48D5DD491B3B561C4EA7AA01748F000024C0D8F1CFE8FD6FC6ED72C9DAAF3E2C433C1E750CFDAF311890C54F3D295189AA';
wwv_flow_imp.g_varchar2_table(37) := '635D790A0AC59D9BA36A00DD230000F124B0EBDF0D1327C98F172E523506CE5FAE5F271F1CD8AFEAAE9CBE34F19595AA1A40F70800401C89F4FDFFD7DBEF9085F905AAC6C0F9B8AE56BEF9C66BAAEE8EB14DB0B15D3000730400200E7F758D44DA5A55DD';
wwv_flow_imp.g_varchar2_table(38) := '557E5696ACB9F77E7130F96F5044A351B96EE50A6988F19BB873878AA780CE80402C04002086443AFF7D6DC142F9FAA429AAC6C0FB97CADDF2DB4D1BCD3FC8E9FABC33200053040020865063A304CF9C517577567FE5212962EDF9A03AD1DA2A77AC7C36';
wwv_flow_imp.g_varchar2_table(39) := 'E6677A4B4AC49591A16A007F880000C4106FEDFFBCF20AF98FC5D7AB1A83E7B135AB6567B5F9AE8CAE9C1CF11616AA1AC01F220000261279FCFF831B6E92DB4631E3DC0A2F1E3F2A7FFFFE7BE61FCD6B0020260200602291C7FF1F3DFC986427C1DAFF7A';
wwv_flow_imp.g_varchar2_table(40) := 'BF5F36D4D5CAB6DAD3B2F9C409A9EDD24DAF283B47E69695C99C1123654161A1E4797DEA9FD9D5F94040AE7BFA773187C76B00C01C010030E1AFAA92487BF23EFEAFED6897A7F7EF974F8F1F93E3E7CEAAEF9588F2E1F972C5E8D1F2F0844992EFB36F18';
wwv_flow_imp.g_varchar2_table(41) := '7874CD6AD9C56B00A05708004037A2E1B0741C89B1FFBC88FC8FC5D7CB7DE515AAB60B7F382CBF39F099FC62C3A77D1E92CFE5EE5CE5F0F86513D4313B79FAD041F9C9BA0FCD87C46B00C0140100E846228FFFDF7DF011196EB3BBE37575B5F2F7EB3E94';
wwv_flow_imp.g_varchar2_table(42) := '33CDCD6A9CFDA178E850F9FED58B654E5E9E3A660735ED6D72EB8A67620EC55752224E5603005F420000BA11EFF1FFD4E21279EAA69B556D35E3AEFF075B36C95B7B2B077428CB67CE96EFCE9AAD6A3BB8F7F557E5F019F36D9ADDB9B9E229A04B23D015';
wwv_flow_imp.g_varchar2_table(43) := '0100E8CAE8FD7FE8902ABBF3E7575E2D8F8CBF4CD5566A0A06E5EBEFBC2D9FD5C66E57DC5FE68E2E979F5DB358D25D2E75CC4AFFBEAF32E6EB0E87DB236915E5AA06F0390200D045B8B555023535AAEECEEAAF3E244569E9AAB68A71E7FFF89AD5B2EFF4';
wwv_flow_imp.g_varchar2_table(44) := 'A9411DC2C28A31F2F36B16DBA2FDF181E666B97FD5CA98DF3FADA2421C6EB7AA011000802F099EA99750A3F9D6BFA387E7CBCBCBEE54B595FEFBFA8FE5BD039F59328447E7CE97FF36759A259FDDD58DAB56C69CF7E0292C14770E5B040397E20900D045';
wwv_flow_imp.g_varchar2_table(45) := 'C7F1E3120D0454DDD503B366CB77665AFF1E7CC591C3F2BF3FFC408D2B9E0C5F9A4C292E96098585322C3D43B2BD9ECEE3CD81A09C6F6F93FD67EAA4B2BA46DAFC1D5FFC2FE2FBFF6E5B268B0AACEFB6F7BF366D94D72B77AB7175E5CACA12EF8811AA06';
wwv_flow_imp.g_varchar2_table(46) := '400000FE4022CBFF7E7AEBED724D6191AAAD70D6EF975B9E7B5602E150DC8FCFC9CC94C51326C88C824271C5D9B1301C8DCA8EDA3A597B70BF34B59AEFB677514156B6BC71CF7DE2713AD5312BBC555D257FB366B5F947B31C10F8129E00009708B7B448';
wwv_flow_imp.g_varchar2_table(47) := 'E074ECC9741F3FF2B80CB1F87DF2F7366D90372AF7A83199995C5A2AF74C9E229E3817FEAE82D1A8BCB8678FEC8DD164E7A26F2CBA4A9EB0B84F801188963CF3A41A53777C6565E2B4D9B24DC04A0400E01281DA5A09C778976C87E57F556D6DB2ECB967';
wwv_flow_imp.g_varchar2_table(48) := '252A5135AEEE5C3371925C5FDEB7D9EFEF1C3922EB0EEC57757772D23364CDF207C467F1AA80BB5E7D598E9DAD57E3EACA939F2FEEA143550DE88E00005CC278FC6FBC0630F347F317CA9F4E9EA26A2BFCC3F6ADB26AC7F6981F3DA5B44C964F99223DBB';
wwv_flow_imp.g_varchar2_table(49) := 'EFFF322362BCB0678FECA93AA98E75C70E5D117FBC639BACDCBE4D8DA92B5766A6788B8B550DE88E00007C2191DDFF7E71C7DD9676C30B462272F5B34F4B7BC0AFC6D455514EAEFCF1C2853D7EEC6FC6781DF09F9FAC97DA184F46268D1829CFDE7CABAA';
wwv_flow_imp.g_varchar2_table(50) := 'ADF061ED69F9D69BAF9B7FB4C329E9E3C6AA12D01D0100F842BCF7FF5E975BD63FFCA8A513DE8C56BFFFED8DD7D498BA73FFBCF932A59F5BF6569EA997955B37ABBA3BEF3EF8B00CF7A5A97AB035050272EDD34FC67C3592565E2E8E24D8BD11180C0400';
wwv_flow_imp.g_varchar2_table(51) := 'E00BC1FA7A093598AFFFBFBC6CB4FCF2FA1B546D859FECDE294F6F31BF10E765E7C8B7162D52757FFAC9471FC9F9D60BAAEEEAEF6F5C2A37978C52B515EE7FF33539505B6BFAD1C65240634920005601008ABFBA5A226D6DAAEEEAB179F3E59B53AC6D7C';
wwv_flow_imp.g_varchar2_table(52) := 'F3C4BB6B64FBC9136A4C5D5D3369925C3FBA6F13FFCCAC3E74483E397450D55D3D3C67AE7C6BDA0C555BE1EFB66D919776EE30FD686312A031191000010050DA0F1D16894654DDD53FDD7CAB5C3762A4AAADB078E5B3D210637DFE13575E29E559D9AAEE';
wwv_flow_imp.g_varchar2_table(53) := '4F471A1BE4B79F9AF7DCBF7AEC38F9D9D5D7AADA0A2F9F382E3F78EF1DD38F76A6A78B6F94B54F2900BBE01500604C000C06A5E3D8B198E7E2ADAF3C2423D2ADEDFF3FF3D7BF50E3E9CEB7AF5F22B95EAFAAFBD3D9F60EF9D9DAF755DDD598FC0279F1F6';
wwv_flow_imp.g_varchar2_table(54) := '3B546D8503CD4D72FFAAE7CD3F9A89808042000012980038242D5D3EFEEA43AAB642341A9559BFF965CC8FFEDBA5378BBB9F66FF77656C3CF4C3356FABBA2B3B9CA35024220B9EFAAD84622CE5642220F039020090C004C02BC78E937FB1F8F1B661EE93';
wwv_flow_imp.g_varchar2_table(55) := 'BF9160C8BCFDEFF76E5A2ABE016ACBEB8F44E4876F9BB7DBF5BADDB2E991C7556D9587DF7E4BF6D4549B7E3C130181CF110000E3E256552591F676D373F1F5858BE46B1327A9DA2AD7AC78469ADACD272AFEF9E2EB65789A4FD5FDE96C875F7EF6C17BAA';
wwv_flow_imp.g_varchar2_table(56) := 'EE6A58E61079FFFEAFA8DA2AFFB863BB3CB77DABE9C7331110F81C0100486002A05D76BDBBF7B557E470FD1935AEAE9E58B448CAB30766DBDB63CD4DF2EBF5EB55DDD5C4A211B2E296DB546D9537AAABE47B3136067266648AAF848E80000100DA4B6407';
wwv_flow_imp.g_varchar2_table(57) := 'C0B71F7C580A2D6C7273D1B7D7AF93F763F4E6BF7AC20459523146D5FDE9DDA347E4A3FDE69FBD74D214F987050B556D9503CDCD72FFAA95A61FEF707B24AD6260964A02C9840000ED453A3AC47FD2BCD7BDD10170D3A3D6BFDB36FCFAC07EF9F9FA755F';
wwv_flow_imp.g_varchar2_table(58) := '8CECCBF2B2B2E55B575EA9EAFEF4D38FD7C9B996165577F5EDABAF95AF8E1DA76AAB18ED92E7FEF657313F3E7DDC3891019A2C09240B0200B467ECFE67EC0268E6B2A2225979CBEDAAB6D28E86F3F2F8EF5F8C3984FBE7CE9329C387ABBA3F54D6D7CBCA';
wwv_flow_imp.g_varchar2_table(59) := '181D080DCFDDBB5C260CD0EB879EBAE1859552DF62BE7741DAE8D1E218A0E59240B22000407BC1B3672574FEBCE979B861E224F9F1C28169AFDB53C632B71B9E7F4E1ADACC9B010DCDCA966F2E5AD4AF9B01FDF3471F49638CCF1C99932B6FDE7DAF6DEE';
wwv_flow_imp.g_varchar2_table(60) := 'AAFFE8DD35B23546C744EFC891E21A3244D5808E0800D05EE0D429095F30EF71FFC4BC05F28D2953556DB59FEDDE254F6ED914731853BFD80EB8AF8C6D759EDFB35B2AABAAD4B1EE7C63D195F2C46513556DB51F6EDD2CBFDFB5D37418463B60633500A0';
wwv_flow_imp.g_varchar2_table(61) := '330200B4D771E28444FDE6DBEBFEF0869BE4D651A5AAB6DA597F87DCB4E2190947CC572D18AE9E38499694F76DB2DBDB870FCBFA830754DD9D34B747DEF9CA839265A35DF69E3A74507EBAEE4335C6AE5C3939E22D2C5435A0230200B4D77EE89048D47C';
wwv_flow_imp.g_varchar2_table(62) := '0BD9DFDD758F4C1F3A4CD57610EF0EF7A229656572EFA4C9E2EAE1EB00E3B1FFAACA3DB22FCE9DBFE1F179F3E5CF2CDE24A9AB0F6B4FCBB7DE7C5DD55DB12700401F00682E1A0A49C7D1A331CFC2070F3D2A436D3661AC3118909B9F5B21EDC1801AA799';
wwv_flow_imp.g_varchar2_table(63) := 'DC219972CDF80932B3B0306E100847A3B2B3AE4E3E38B05F9A626C3A74D1D08C4C79E3DEE592E176AB637670A4A545EE79E139D3A138DC6E49ABA85035A0239E00406B11BF5FFC27CC278B65FA7CB2FEC147546D27CF1F3B2A3F8AD199AFAB8CB4349952';
wwv_flow_imp.g_varchar2_table(64) := '522213F20B64587A86647B3D9DC79B034139DBDE269FD5D5CA6735A7A4CDDFF1C5FF22BE9FDE7ABB5C5358A46ABBE8088765C1EF7E1D7338E9E3C7AB3F033A2200406BE1D65609D4D4989E83D26179F2EA9D77ABDA6EBEF3C97A7977FF3E4B86F5D5D973';
wwv_flow_imp.g_varchar2_table(65) := 'E4DB33665AF2D98958F4CC93D21A636E47DAD8B1E218A07D138064400080D6424D4D12ACAB333D07B34ACBE4D74B6E54B5DD183BF43DB2FA4D395067DEC760202CA818233FBF66B138E3BC52B0D2B2975F9293E7CF990E815E00D01D01005A33D6FF1B7D';
wwv_flow_imp.g_varchar2_table(66) := '00CC2C993049FEF10A7BF40030D31008C89FBCF3B61C1CA41030AFBC427E7AF5B592EE72A931D8D1A36B56CBAE6AF3498CBE51A33A270302BA2200406BC133F5126A34DF06F8FE59B3E5AF66CE56B55DB58743F2D79F7E221FC659B2D757767FEC7FA9BF';
wwv_flow_imp.g_varchar2_table(67) := '5CBFAE7332A319B60586EE0800D05AE074AD8463B48CFDD32B16C91F4DB07E1BE044ADA9A9967FFC789D9C6F356F6CD41BE5C387CBF7AEBC46660EB3D772C858FE61DB1659B57387AABBF214148A3BD71EAD8B012B1000A0357F75B544DADA4CCFC1F7AE';
wwv_flow_imp.g_varchar2_table(68) := '5B22778DEE5B339DC1D6160AC9BF56EE9115DBB6F4F9A333BC3EF9E3F90BE4E171C93763FE3FF6ED95FFDCF089FA2E5DB9F3F2C49397A76A40370400682D5E1740BB2E734BC4C9B65659B17FBFAC3D7248CE349B3FE5E8CEF8C2425958562E8F4C9820B9';
wwv_flow_imp.g_varchar2_table(69) := '9EE4DC3427DE3249776EAE780A0A540DE8860000AD194D808C664066ECD805B037AADADA64D3995AD97AEA946C3979F24BAF0846E70D9739A346C9E52346CAE5C3F36598CD1A1FF5C6BBA76AE43BABDF547557AEACACCE790080AE0800D05AC79123120D';
wwv_flow_imp.g_varchar2_table(70) := '874DCFC10BF7DD2FE3B2B2558DE4F169FD19F9AFAFBD623A605766A6788B8B550DE8860000ADC50B002FDFFF55199D99A96A248FEDE7CFC9132FBF643A60674686F84A4A540DE8860000ADB51F3E2212310F006F7CE541294ECF503592C7DEA64679F0C5';
wwv_flow_imp.g_varchar2_table(71) := '174C07EC4C4B175FE9285503BA2100406BED870E8B44CDB7D57DE7C14724DFE7533592C7D10B17E4EEE757980ED8E1F3495A5999AA01DD1000A0B5785B017FF8F0639263A37DEE91B8EAB636B9EDB96754DD95C3E395B4F2D1AA0674430080D6E205804F';
wwv_flow_imp.g_varchar2_table(72) := '1E79DC765BDD2231E7027EB9FEE92755DD155B024377040068ADFDE0C198DF7FF363FF453CEC1897942E844272E593BF311FBBD325E963C7A812D00D01005A8B1700763CF135F5672497502422737EFB2BF3413B1C923E6E9C2A01DD1000A0B578AF00B6';
wwv_flow_imp.g_varchar2_table(73) := '3EFE47E2B2F196B730178E46E5F2DFFC52D55F420080E60800D05ABC55009F3EFAB8A4BBDCAA46F230F644B822D62B008753D2C78D5525A01B0200B416AF11D0DA871F4DDA5EF8BA6B080464F1D3BF333D0D0E974BD2C6300700FA2200406B1D478F4934';
wwv_flow_imp.g_varchar2_table(74) := '14343D076F3FF8B014FAD2548DE451DBDE2E4B573C6D3A6087DB236915C9B5D323D09F0800D05AC7F1E3120D044CCFC16B0F7C554665D00A38191D6F6D953B573E6B3A7487D72B69A3E903007D1100A0B578DB01B31950F23AD0DC24F7AF7ADEF40B387D';
wwv_flow_imp.g_varchar2_table(75) := '69E22B2B5535A01B0200B4E63F5925918E76D373F0CC3DF7C9E49C5C552379EC6E6890477EBFCA74C0CEF474F18D622F00E88B0000ADF9ABAB25D2D6667A0EFE73D99D327778BEAA913CE26D07ECCCC8145F09DB01435F0400682D505323E1D656D373F0';
wwv_flow_imp.g_varchar2_table(76) := 'E3A5B7C80D23B94824A3B7AAABE46FD6AC361DBA6BC810F18E1CA96A40370400682D505B2BE1E666D373F0DD6BAF93E5152C154B46CF1E3E24FFF4D15AD3A1BBB2B3C55B54A46A40370400682D585F2FA18606D373F0F5858BE46B1327A91AC9E35FF756';
wwv_flow_imp.g_varchar2_table(77) := 'CAAF367E6A3A60F7B061E2193E5CD5806E0800D09A71F1374280990766CD96EFCC9CAD6A248FBFDBBA455EDAB5C374C09E820271E732C113FA2200406BE19616099C3E6D7A0E6E9A3859FEDF8557A81AC9E32FD6AF93B507F69B0ED83B6284B8B2B2540D';
wwv_flow_imp.g_varchar2_table(78) := 'E8860000AD192B008C950066E69757C8BF2FBE5ED5481E8FBDF3B6ECAC3A693A606309A0B11410D01501005A33BA001ADD00CD940FCF97DF2FBB53D5481EB7BEB44A6A1ACDE777A495978BC3E35135A01B0200B4168D44A4E3F061D373E072BA64EBA38F';
wwv_flow_imp.g_varchar2_table(79) := '776E1D8BE41189466576ACAD8045247DDC387E57688D0000EDB51F3A24128D9A9E87F71E7A44F2BC3E55C3FE6ADADBE4D615CF980FD4E1F83C00001A2300406B11BF5FFC274EC43C074FDD7D9F4C65B67852D97CF6ACFCF1ABBF8F39665F5999387D043B';
wwv_flow_imp.g_varchar2_table(80) := 'E88B00006D755EFCABAA4522E198E7E04737DD2C371697A81AF6F7CAC9E3F2FFBCFB4EEC813A5DE21B55420880B60800D052A2177FC39F2DBA4A1EBF6C82AA617FFFB6B7527E19A30990420880C60800D04E4F2EFE86BBA7CF94FF79F91C55C3FEFE7AC3';
wwv_flow_imp.g_varchar2_table(81) := 'A7B27A5F65620325044053040068A5A7177FC3ACD232F9F5921B550DFB7BE0CDD7657FAD7983A72F21044043040068A337177F43A6CF27EB1F7C44D5B0B768342AF39EFC8D04C33DFB9D0901D00D01005AE8EDC5FFA2F71E7A54F2BC5E55C3BEAADADAE4';
wwv_flow_imp.g_varchar2_table(82) := 'F6E7622C018C852701D008010029AFAF177FC32FEEB85BE6E4E5A93A999D0F04E4071B3E91DDA74F757E8D1925A3E4FBF316484E8A74C5FBB0AE56BEF5C66BBDFF890801D004010029AD3F2EFE86EF2EBE5E969757A83A591917FFE5AFFC5ECEB634FFC1';
wwv_flow_imp.g_varchar2_table(83) := '5728CAC995E797DD29D92910027E7D60BFFC7CFD3AF5DD7AC3E17289B784258248B2DC533700001E90494441546D0400A4ACFEBAF81B96CF9C2DDF9D95FCDB027F6FD30679A3728FFA5E97BA67C64CF99BD9C9BFDAE17F6EFC54DEDC9BE00A8058781280';
wwv_flow_imp.g_varchar2_table(84) := '144700404A322EFE81EA6A89263211CCE194D2C20239595BAB0E7535BBB44C7E95022B0196BCB0F24B77FF1715E6E4C8DBF72C5775B25AFEC66B72B0CEFCB72C2D2A9293757531DB3F5F643C0930760D7430FF032988008094D3B9C3DFC9AA84EEFC8DCD';
wwv_flow_imp.g_varchar2_table(85) := '7E164F9F2EC6563FEFECD8AE8E7795E6F1CAA70F3D228E24DF1468E6AF7FA1BE5377763CF135F5E76414888465FE6F7F235131BFB8DF386B76E766411FECDA25E104FE8E100290AA08004829C6C5DF5F5595D09DFFC58B7F61569684221179FE93F59D4B';
wwv_flow_imp.g_varchar2_table(86) := 'C8CCBC78DF0332262B4BD5C928D503C08E86F3F2F8EF5F34FD698C00B7FC8A45E2763AA5AEA5851000AD110090327A7AF1BF7EE64CC9CFCC54C7DEDCB1431A4C1E8F1BBEBFE406B9A374B4AA9351AA0780A70F1D949FACFBD0F4A7C9CBCE91A53366A89A';
wwv_flow_imp.g_varchar2_table(87) := '10009D11009012FA7AF1376C3A7A440E5557ABBAAB5468099CEA01E0DBEBD7C9FB07F6ABDFACABF1A34A656E79B9AA0D8400E88A0080A4D71F177FC3E1FA7AD9F8D93E55773536BF4056DD7E87AA9351AA07806B9F7B461ADBDA4C7F9A85932649C5F07C';
wwv_flow_imp.g_varchar2_table(88) := '555F54DFDA2AEFEDD891F89C80D25271A4C09249E88D0080A4D65F177F43637BBBBCB165B3AABBF3F1C38FC99024FE0F7F2A0780DAF67659BAE269F55B75E7F679F325DBE753F5A57A1402DCEECF570724F1DF05800080A4D5938BBFDBE596EB66CC30BD';
wwv_flow_imp.g_varchar2_table(89) := 'F81B8CF97F2B3F591FF302F01FCBEE9479DDDC41268B540E00EF9CAA91BF5AFDA6E94FE1717B64F9C285AAEE4EFD850BF2EE8E1D128946D431333C0940B2230020294583C1CF2FFEA150DCF11B17FF2533674A5E46863A66E6837DFBE4D4D97A5577F5F8';
wwv_flow_imp.g_varchar2_table(90) := 'BCF9F26753A6A93AD9A47200F8C1964DF2F2EE5DA63F494941815C3361A2AACDF02400BA200020E90CD4C5DFB0EFF469D97EE8A0AABB9A58344256DC729BAA934D2A0780C5CF3D2B0D6DADA63FC9E5974D90098585AA8EC50801EFEFDC29A170FCBF63BC';
wwv_flow_imp.g_varchar2_table(91) := '0E40B2220020A90CE4C5DF70BEAD4DDEDABA45D5DD59F7F0639295A4EF7E5335001C6BBD2077AD5CA17EA3EEDC36779EE4A4A5A93A9E736D6D9DAF03080148550400248D9E5CFC8DF7BDD7CF98D1A38BBFC19807B06AE306090403EA58573FBAE966B9B1';
wwv_flow_imp.g_varchar2_table(92) := 'B844D5C9245503C0CAA387E5C76B3F30FD297C5E9FDC3B7FBEAA1375AEB555DEEDC99300637580DBAD8E017646004052884622E23F7E42A2A160DCF11A17FF1B66CE94A1E9E9EA584F7C7CF0A09CA83DADEAAEEE98365DBE3F679EAA9349AA06806F7EB4';
wwv_flow_imp.g_varchar2_table(93) := '563E3E7CC8F4A7A818592C0BC78E55754FF4EC4980477C65A59D130401BB2300C0FEA251F19FAC9288BF23EE58FB7AF1371CAAAF974D31FA010CCB1C22EFDFFF15552793540C00465FFF054FFE5602312ED00B274F968ABCE1AAEEA99E8400A72F4D7CA5';
wwv_flow_imp.g_varchar2_table(94) := 'A38CBEC3EA1860470400D89EBFBA46223126775DD41F177FC38540405ED9B841D5DD5975DF03323609F70548C500B0F16CBD7CFDD597D56FD39D7B162C94B43ECEDB3042C07B3B774A3081A750AECC4CF11617AB1AB02302006C2D585F2FA18686B863F4';
wwv_flow_imp.g_varchar2_table(95) := '7ABC72FDF4E932AC87EFFCCDBCBC758BB4C6E828F78D4557C913974D5075B248C500F08F3BB7CB73DBB69AFE043943B2E4B659B354DD17C624D1F776ED8A3947E422F7B061E219DEFBA70EC0402300C0B6C2172E48E0D4A9B8E3332EFE37CE9CD9A319DE';
wwv_flow_imp.g_varchar2_table(96) := 'F16C3D7E5CF69F3CA1EAAEA61697C85337DDACEA64918A01E086179E93FA9616D39F60CAE87299515AAAEABE6A686F977776EC48E84980F114C0781A00D8110100B664CCF8EF387E42244E47B6FEBEF3BFA8B6A545DEDBB15DD5DDF9F0E1C724A78F8F95';
wwv_flow_imp.g_varchar2_table(97) := '075BAA058003CDCD72FFAA95314FE38D97CF91FC7EFEFB71AEBDBDB36D70DC10E07449DAE8325606C0960800B02563B95FA4BD3DE6D87AB3CE3F51C6C4B2551B36C4FC0F7C326E0F9C6A01E097FBF7C9BF7DB25EFD265DA5F97C72CFBC9E2FFF4B84D12C';
wwv_flow_imp.g_varchar2_table(98) := 'E8DDEDDBE3B60D663E00EC8A0000DB49F4D1FFF533664A5176B6AAFBDB27870FCBB15335AAEEEA9AF197C94FAFBC5AD5C920D502C057DF7A43F69D36FFBB32BEB454E68EFEC3ED7FFBD3A9A626F960D74E559BF19594887300822AD0170400D84EC7D163';
wwv_flow_imp.g_varchar2_table(99) := '71D7FBCF1C3B4E268F1CA9EA8150D5D8281FC5E82DEF737B64DD430F8BD7993C6BBE532900D4F93BE4A6679E52BF4777AE9B3153460C604834ECAEA991DD470EABBA3B0EAF57D2468F563560070400D84AA8B1518267CEC41C5351DE70B96ED2E4015F66';
wwv_flow_imp.g_varchar2_table(100) := '1D8A44E4F9F5EB252A51F5D95DFD78E92D72C3C8E459EE954A01E0E9C307E5271F7DA87E8BAE8C65A1F72E5820CE015E8F6F748F7C77EF1E3973FEBC3AD61D6F5191B806388C003D4100807D44A3D271CCB8FB376FB662BCF75F3677AEA40FD2E4BB0FF7';
wwv_flow_imp.g_varchar2_table(101) := 'EF97EA3375EAF3BBBA6AEC38F9E7ABAF55B5DDA55200B8EBD597E5588C9D1B478F18298BC68D53F5406A0D04E4B5CD9B636E256D74094CAB18B8D711404F1100601BA1A62609D6995F6C0D83F1E8FF5247CE9E950DFBF6AABA2BE3EE72ED438F48B6C7AB';
wwv_flow_imp.g_varchar2_table(102) := '8ED959AA0480432DCD72DF0BB167FF5F3D6DBA8CCACD55F5404BE4558077C4087125610329A42602006CA3E3D87189C668B032242343EEB87C8EAA074330129117377C2AE1B0F99DDD77AFBD4E96578C51B59DA54A00F8D9EE5DF2E4964DA6A7DA581E7A';
wwv_flow_imp.g_varchar2_table(103) := 'DF8205AA1E0CA168545EDBB259DA3ACC5B5677B6092EEBBF9E04405F1000600B91B636F15757C71CCBC24993A5C282CE6A1B8E1C962335E6AB0192A929504A0480685416AF5C210D31DA434F2C1B2DB3CBCA543D580ED4D5CA960307627E9CAFAC4C9C3E';
wwv_flow_imp.g_varchar2_table(104) := '9FAA01AB1000600B81BA3A093735998E25333D5D965D3E67C0277475E7CC850BF2CEF66DAAEECE1B5F79508AD3EDBFCC2B1502C0A6B3F5F227717AFF2F9B375FB22CB8C81A13475FDCB021E6A641EEA143C5939FAF6AC02A0400D842FBE12322312650CD';
wwv_flow_imp.g_varchar2_table(105) := '9D3051C61714A87AB0BDBA6DABB4B49ADF713E316F817C63CA5455DB552A0480BFDEF0A9ACDE57697A8AF3727265E9F4E9AA1E6CDB4F9C907D278E9B7E2C930161170400582EDCDA2A81188FD89D0EA7DCB3608178DD6E756CB0ED3D7D5A761C3A68FAB1';
wwv_flow_imp.g_varchar2_table(106) := 'B91919F2CEF2AF88C7E954C7EC28D903C0F940406E78F6290947CCBBEFCD9B3849C6597887DDE2F7CBAB9B36AAF174C7575A2ACE7EDCBB02E80D02002C173C532FA146F31DFF461516C9D5975DA66A2B740483F2D2C60D1235167D9BF8871B97CAD29251';
wwv_flow_imp.g_varchar2_table(107) := 'AAB6A3640F00F15AFFBA9C2EB967E142CB83D89A3D7BA4BEC1BC2F803B6FB878F286A91AB002010096EB387142A27EBFE938164D9922A387E5A9DA2A6B3FFB4C6AEACD9B1425C364C0640E00E168546E7C61A59CBB60BEF35FC5C862593876ACAAAD72F0';
wwv_flow_imp.g_varchar2_table(108) := 'CC19D9BCFF33D38F37DA021BED81012B110060A96824221D8763AF9DBE6FE115963EFEBFA8A6B959D6EEDCA1EAEE3C77CF7D322167F0D69EF754320780774FD5C87756BFA9BE4B770662E7BFDE88FB1AC0E190F4416A5204982100C052F1DEFFE76665CB';
wwv_flow_imp.g_varchar2_table(109) := 'AD3367AADA4AC6D3FF57B66D91D6B636D3612C9B365DFE76CE3C55DB4D32078027DE5D23DB4F9E303DA5C3B273E4E61933546DB517376D948E184FB6580E08AB110060A950438304EBCDDBB98E1F552A73CBEDD33EF5B3D3A7655B8CC980860F1F7E4C72';
wwv_flow_imp.g_varchar2_table(110) := '06A955714F256B0038D2D222F7BCF09CFA1EDDB1AA4F8499F5870EC9F1183B15D21510562300C05281DA5A0937379B8EE1F2CB26C884C242555B2D180E77AEF38ED5F3FD4F162E923F9E3849D57692AC01E06F367E2A6FED355FFAE7F578E4EEF90BC435';
wwv_flow_imp.g_varchar2_table(111) := 'C01BFFF444BCD6C0EEBC3CF1E4593FB705FA2200C052FE935512E968371DC3E2E93364644E8EAAED60E3912372B8C6BC6B614E7A86AC59FE80F85CF6DB26381903C0E9F676B965C5333177659C3CBA5C6696DAABC5EEB1F3E7E4934AF3D062EC09603C05';
wwv_flow_imp.g_varchar2_table(112) := '00AC420080A5E2F5FFB7AAA35B2CE7DBDAE4ADAD5B54DD9DBFBA76B1DC5F61FD6CF4AE923100FC78C7365919A713E31DF317C810AFBD36643ADBDA2A6F6FDBAAC6D895333D5D7CA3ECBD6C14A98D00004B751C3922D1181BEDDC7BC5225BDE49AFD9B35B';
wwv_flow_imp.g_varchar2_table(113) := 'EA1BCC7B171466E7C89BF7DC67AB47D286640B008D41A3F1CFD39DAF5ECC8C2A2894AB274C50B55DC45B09E0F07A256DF4685503838D00004BC56B017CFFA22BC56DC3EE7A271A1AE4E33DBBD538BBF377372E955B6CD61828D902C0BFEDAD945F6EFC54';
wwv_flow_imp.g_varchar2_table(114) := '9DD3EE2C99394B0A6DB8C56E7B382C2FC5685AE470BB25ADA242D5C0602300C052ED0763CFA87FF0AAABD59FEDC45812F8C6F66DD2D47AC1745815F905F2D2ED77A8DA0E922900B4854272C3CA15D2EA37DF5E7778EE50B969DA3455DB89D1B8E8B98FD7';
wwv_flow_imp.g_varchar2_table(115) := '990FC9E194F471F67B4D047D100060A9640D0086449E02FCD3CDB7CA752346AADA6AC914007EB57F9FFC6B8C3B68C34DB32F97E19999AAB69B67D67D147348E9E3C7AB3F03838D00004B25730048E429C098FC025975DB3271D864795AB204800BC1A0DC';
wwv_flow_imp.g_varchar2_table(116) := 'FCC24A6989B142A4306FB82C993C59D5764400809D110060A9640E0086449E02FCE8A69BE5C6627BF47D4F9600F0EFFB2AE5171B62BFFBB7FBDDBF8100003B2300C052C91E0012790A503A2C4F5EB9E32E5B3C05488600D01C0CCAD295CF4A5BC07C7968';
wwv_flow_imp.g_varchar2_table(117) := 'D1B03CB97ECA1455DB15010076460080A5923D001812790AF0C31B97CAAD365811900C01E09FF7EC96DF6D365F3E674886BB7F03010076460080A552210018DEDCBE5D1A626C533B3227575EBBFB5ECBFB02D83D001877FF37AC7846FCA1A03A775D8D18';
wwv_flow_imp.g_varchar2_table(118) := '9E2FD74DB267ABE5AE0800B03302002C952A01E07473B3BC1F67ABE0EF5E7B9D2CAF18A36A2BD83D00FCFDB62DF2629CF378DBDC79929396A66A3B2300C0CE0800B054AA0400C37B9595527BFE9CE9F934F60878EDDEFB24DB635DCB5A3B0780C32D2D72';
wwv_flow_imp.g_varchar2_table(119) := 'DF0B2B63F6FC1F535C2C0BC624CFDA790200EC8C00004BA55200686C6F9737B76E91A83133D0C403B366CB7766CE56F560B3730078F8EDB7644F8C4D965C4E97DC396F9EA4D974ABE5EE100060670400582A95028061C3E1C372E4548DE939753A1CF2E2';
wwv_flow_imp.g_varchar2_table(120) := 'F207A43C73883A3698EC1A00DE3955237FB5FACD98A762EA983132DD26CB29134500809D110060A9540B006DC1A0BCB271A344A211D3F37A796999FC72C98DAA1E4C760C00C148446E79F179A96F319F44E9F37AE5CEB9F36CB92F442C0400D819010096';
wwv_flow_imp.g_varchar2_table(121) := '4AB50060D8595D2595478FC63CAF3FBDF576B9A6B048D583C58E01E0179FED937FFF3476CBDF791327C9B8FC7C55270B0200EC8C00004BA5620030EE685FDBBA45DA3BCC37B129CCC99197EFBC5BD25D6E756C30D82D0054B5B6CADD2FAC94608C1D2187';
wwv_flow_imp.g_varchar2_table(122) := '0EC9925B66CD5275322100C0CE0800B0542A0600435543837C14A739901513026D1500A2517978CDEA9813FF0C4B2F9F23791919AA4E260400D8190100964AD50060F8E8C07EA9AAAB8B797E9FB9E73E999C93ABEA8166A700F0FCD123F2A3B5EFABB175';
wwv_flow_imp.g_varchar2_table(123) := '675C4989CCB3B877425F100060670400582A9503407B3028AF6EDE2CA170C8F41C970DCB9355CBEE148FD3A98E0D24BB0480FA8E0EB9FD8595D21134EFF7EFF578E58E3973C4EB1EDCD724FD8900003B2300C052A91C000C07CE9C912DFB3F8B798E9F98';
wwv_flow_imp.g_varchar2_table(124) := 'B740BE3165AAAA07925D02C0D73F784F361E8B3D5172E1A44952313CF926FE5D8A00003B2300C052A91E008C9E406FEFDE25E79A1A639EE7E7EE5D2E13B273543D50EC10005E3B7942BEFFEE1A35A6EEE40F1D2A374E9DA6EA644500809D110060A9540F';
wwv_flow_imp.g_varchar2_table(125) := '0086443A04960FCF97E76F5B36E0AF02AC0E00751DED72D7AAE7636EF5EB7038E4B63973253B49FAFDC74200809D110060291D02C0FEBA3AD976F040CC00607868CE5CF98B6933543D102C0D00D1A83CBA66B5EC8A33EBDF0800B3C75F26130A0BD5B164';
wwv_flow_imp.g_varchar2_table(126) := '4500809D110060A9540E00C6F57EF3B12372A83AF605EF52BFBEE36E999597A7EAFE66650078EAD041F9E9BA0FD558E2315600CC2D1F230E873A94740800B03302002C95AA01201489C8BAFDFBE5D4D9FA1E9DDFFCAC2C79F9AE7B25738066BE5B15008E';
wwv_flow_imp.g_varchar2_table(127) := 'B4B4C8F2175F90708C863FDD19393C5FAE9A3021E95A005F4400809D110060A9540C00EDA1907CB0678F34B434F7EADCDE3A65AAFC70DE0255F7272B0280D11971F9EBAFC8B1B367D5387A626856B62C9E3A55D20728140D240200EC8C00004BA55A0068';
wwv_flow_imp.g_varchar2_table(128) := '6A6F97F777EF9236BFBF4FE7F59F6EBE55AE1B3152D5FDC58A00F0BF77EE9015DBB6A831F44686CF27D74D9B2E39E9E9EA58322000C0CE0800B0542A058053CDCDB26ECF9E988D7F1295EEF1CA8ABBEF95D19999EA587F18EC00B0B6F6B4FCC59BAFABCF';
wwv_flow_imp.g_varchar2_table(129) := 'EF0BB7CB2DD74E9D2A85D9D9EA98DD110060670400582A5502C0E1FA7AD9B4FFB3B833FD15A74B24CEFBF0D26179B2F2F665FDBA61D060068013ADADF2C04BABA43D46B7BF4E099C8B8B1CE290791327CAD824D9199000003B2300C052C91E008CEBFD8E';
wwv_flow_imp.g_varchar2_table(130) := 'AA93B2EFF8B184CFA3332353BC234788BFAA4AA2715E155C336EBCFCF4AA6B54DD57831500DAC321B9FFB557E5E4F973EAB3BBE3F07AC5575A2AC1D3A725DCDAAA8EC7337974B9CC18556AFB15020400D8190100964AE60060CCF45F7FF080549F3993F0';
wwv_flow_imp.g_varchar2_table(131) := '3974E70E154FC1E7ED6DA3C1A0741C3F21128D7CF14FBBF7DFAF592C5F193356D57D315801E0CF3F5A2B1F1D3EA43EB75B0EA7A48D2E1387C7D35906CFD44BA8B1E18B7F185F4941812C1A7F99AD5708100060670400582A590380DF98E9BFB752CE3535';
wwv_flow_imp.g_varchar2_table(132) := '257CFE3C8585E2CEF9C376BFE1E66609D4D6AABA3B2EA74B7E77E75D322577A83AD65B8311009E397C48FECF476BD5679AF1161589ABCBFBFC50539304E3ECA078A9BC9C1C593C798AF86CBA428000003B2300C052C918005AFC7E796FF72E696D6F4FEC';
wwv_flow_imp.g_varchar2_table(133) := 'DC399CE22D1E292E933DED03C6E3EF96165577676846A6ACB8E32E29EAE32CF8810E009BEAEBE54F5F7F452271E642B8B2B2C53BA248D5970AB7B549A0E654DC27231765A6A7CBF5D3A64B96CFA78ED905010076460080A5922D00D43537CB879595120C';
wwv_flow_imp.g_varchar2_table(134) := '05133A6F0EB75BBCC5C5E28C75718A46A5E3D87189C6F9771A93029FBAF576C9F9E291796F0C640038DEDA2A5FFDFDAA987DFE0D0EB747D2CA471B3D7FD5B1AE227EBF046A6A241A4A6C4585C7ED916BA74D93822143D4313B2000C0CE0800B054320580';
wwv_flow_imp.g_varchar2_table(135) := 'A3E7CECA86BDFB242AB1EF6E2F72F87CE22B291187CBA58E99897474744E0AEC9C5518C3A41123E537372E155F02FFCEEE0C5400680A06E5FE577E2FB5CD715E89381C9D93FE6206A22F44C361F15757C79D287991D3E194F993264A45DE7075CC6A0400';
wwv_flow_imp.g_varchar2_table(136) := 'D8190100964A8600605C93775757C99E38FBD75FCA9569CCF41F19F32EB7ABD0F9F3124CA05BDE5563C775AE0C70F6E0DF7DD1400400A3D3DFE36B564BE5A91A75CC8CA7A040DCB9B9AA8E2B1A95C0A9533D5A2130A5A242A6178FEAC9A91F300400D819';
wwv_flow_imp.g_varchar2_table(137) := '010096B27B00084722F2C9A14372B22EF644BD4B5D3AD3BFA73A2F76172EA8DACCB2A9D3E46FE7CE5775A2062200FCD5A7EBE59DCFF6A9DA8C2B2B4BBC2346A8BA277ABA42A0B4B048AE18374E5C4EA73A66050200EC8C00004BD9390004422159BB6FAF';
wwv_flow_imp.g_varchar2_table(138) := 'D43736267C8E3C0585E2CEFDC399FE3D62CC07387932A1C7DE8FCC99277F3E6DBAAA13D1DF01E0FFECDA21CF6C8DDFE6D7E94B135FE9A81E3D11E92AD4D824C13389AF10C8CFCD956B274D16AF852B040800B03302002C65D70060CCF47F7FF76EB9D0DE';
wwv_flow_imp.g_varchar2_table(139) := '96D8F98933D3BF278C896F9DFD0112E88E77EF8C99F2CDE93365488217B9FE0A00CDC1A0FCCBEE9DF2D2CE1DEA9819630E84AFACAC7342645F19AF0202A74E27BC4260487A865C3775AA64A5A5A963838900003B2300C052760C00672E5C90B5BB77F7EF';
wwv_flow_imp.g_varchar2_table(140) := '4CFF1E8AB4B5754E804BC4105F9A2CB9EC32B97E74B954646549519AF952C1BE0480DAF67639DCD22CEF9D382EEF1DD82FAD093CA530F8468D12671F972F5EAAA72B04BC1EAF2C9E364D86F7F3BE0A892000C0CE0800B094DD02C089F3E7E593BD7B2592';
wwv_flow_imp.g_varchar2_table(141) := 'E01D664F66FAF754A8B151823DE83268477D7E2562C2B8F8FB8D109060083156085C3179B2940D1BA68E0D060200EC8C00004BD92900ECAEA991DD470E277C3E8C9EFEBEE29ECDF4EFA9C0E95A09B734AB3A99185DFE8C6E7F03261A157FCD2989B425BE';
wwv_flow_imp.g_varchar2_table(142) := '4260FA98B132B5B858D5038D00003B2300C05276080046D7BA0D870FCBB1D3A7123E177D99E9DF53467F8048A25D076DC29991D1F9646430184F498CA725892A1F3152168C1DDBAB65943D4500809D11006029AB038031D3FFC3CF3E93330DE7133E0FDD';
wwv_flow_imp.g_varchar2_table(143) := 'F5F41F50C65A78A35D7002CB03EDA073B99F71E73F0817D88B7AFABAA460E830B976D224F10CC0AB9B4B11006067040058CACA00D039D37FCF6EB9D036F833FD7B23585F2FA186C4D7C25BC13D6C9878865BD389AFA72B04B2338774AE10C8F47AD5B1FE';
wwv_flow_imp.g_varchar2_table(144) := '4600809D11006029AB02C0D9D656F960F76E090463F7ADBF682066FAF786D13238505797F0E4B7C1624C8634EEFA2D3F3FC60A01A37D7038FE124A83CFEB936BA74E1DB015020400D819010096B222009C3C7F5E3EAEAC1C909EFE83C5688A633C0D8826';
wwv_flow_imp.g_varchar2_table(145) := '1860068AC3EB15F7D0A183FB4A248E9EAE10708843AE9C32454A07608500010076460080A5063B00549E3A253B0F1F4AF83BF7A6A7FF60329E0818EFBFA3FE40E75D6F341249A88150AF385DE2703A3B839023CDD7D9D3DFEA3B7E53BD5821306BDC7899';
wwv_flow_imp.g_varchar2_table(146) := 'D4CB56C5660800B03302002C355801C098E9BFF1C811399AC08635170DE64CFFC112EF7CA78F1FAFFE9C0A8CD725E1A6383B145EA26264B1CC1F33A6DF5608100060670400582ADE05E9C1ABAE567FEEAD60382C6BF7EDB3F74CFF4112EF7CA75A0030F4';
wwv_flow_imp.g_varchar2_table(147) := '748540D1B03CB9DA5821D00F1B09110060670400582ADE05A9AF01A0351090F7F7EC91E6D60497D0F5634F7F3B8A77BE533100187ABA4220C75821306D9A64783CEA586F100060670400582ADE05A92F01E05C5B5BE74C7F7F20C1C9602E97784B4AECFB';
wwv_flow_imp.g_varchar2_table(148) := '5EBB1FC43BDFA91A000C3D5D2190E63356084C93BC3E84410200EC8C00004BC5BB20F536001C3B7F4E367EF6998413FC8F7DE74CFFE2E27ED9B1CECEE29DEF540E00869EAE1070BBDC327FE204193D2C4F1DEB090200EC8C00004BC5BB20F5340084A251';
wwv_flow_imp.g_varchar2_table(149) := 'D97AECA81C4E70273DC360F4F4B78B78E73BD50340A75EAC10185B522297975788BB8793030900B03302002C15EF82946800680904E4485D9D1CAEA9918E041FF91B5C3939E22D2C5475AA8B77BEB508005FE8E90A8134AF4FC61617CBD8C242199260F7';
wwv_flow_imp.g_varchar2_table(150) := '400200EC8C00004BC5BB20751700FCA1907484429D13FCEA1A1BE5D4B973D2D08B1DF33C05059D6BD97512EF7CEB14000C463325A3C5724FE565E748D1B06152989BDBD94A38CDED165F37AF8F0800B03302002C15EF823420527CA67F2CF1CEB76E01C0';
wwv_flow_imp.g_varchar2_table(151) := 'F0F90A81539DAF06069B8EE71BF6410080A5E25D90FA9B0E33FD638977BE75BD20F57485407FD1F57CC31E0800B054BC0B527F72A6A78B77C488949FE91F4BBCF3ADF305C95821606CBB1C696F57E763A0E97CBE613D02002C15EF82D42F1C0E710FCB13';
wwv_flow_imp.g_varchar2_table(152) := '4F5EFF6FF6926CE29D6F2E4822C173E72574EEAC3A270389F30D2B110060A98EA3473BEFBC068AC3E315EF882271A6A5A9633A8B75BE8D1E08691515AAD659E7B6CBA76B0774B745CE37AC460080A502B5B5126EEEF90CFE789CBE34710F1B2AAEAC2C75';
wwv_flow_imp.g_varchar2_table(153) := '0C12F37CEBB6243211E19616099D6F9088BF431DEB2F9C6F588D00004B1993AEFCC78FF7CFE42BA74B5C43323BF7A637DEF7E3CBCCCEB7C3ED11DFE8B2CEED7EF165C6BC80505393842FB4F6CB76CB9C6FD801010096331E49078DA62CED1D89FDC7D561';
wwv_flow_imp.g_varchar2_table(154) := 'EC49EF14F9626F7AE3F1BE6BC8102EFA09BAF47C1B8DED8CB0E4292CEC3C9788CF0803E10B173A5F137406A94844A2E148421B0D75FE7DE57CC3260800000068880000008086080000006888000000808608000000688800000080860800000068880000';
wwv_flow_imp.g_varchar2_table(155) := '00808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000';
wwv_flow_imp.g_varchar2_table(156) := '80860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080';
wwv_flow_imp.g_varchar2_table(157) := '86080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086';
wwv_flow_imp.g_varchar2_table(158) := '08000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608';
wwv_flow_imp.g_varchar2_table(159) := '00000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800';
wwv_flow_imp.g_varchar2_table(160) := '00006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086080000';
wwv_flow_imp.g_varchar2_table(161) := '006888000000808608000000688800000080860800000068880000008086080000006888000000808608000000688800000080860800000068880000008086FE7F143A34878A99CF4B000000106465424734374341333346444330344439423341227A65';
wwv_flow_imp.g_varchar2_table(162) := '600000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(20070985318326788)
,p_file_name=>'icons/app-icon-512.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/security/authorizations/administration_rights
begin
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(20070426018326779)
,p_name=>'Administration Rights'
,p_static_id=>'administration-rights'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'plsql_function_body', 'return true;')).to_clob
,p_error_message=>'Insufficient privileges, user is not an Administrator'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
end;
/
prompt --application/shared_components/navigation/navigation_bar
begin
null;
end;
/
prompt --application/shared_components/logic/application_settings
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/standard
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/parent
begin
null;
end;
/
prompt --application/shared_components/user_interface/lovs/boolean
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(20071651869326789)
,p_lov_name=>'BOOLEAN'
,p_static_id=>'boolean'
,p_lov_query=>'.'||wwv_flow_imp.id(20071651869326789)||'.'
,p_location=>'STATIC'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(20071712171326789)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'No'
,p_lov_return_value=>'FALSE'
,p_static_id=>'false'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(20071897088326789)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Yes'
,p_lov_return_value=>'TRUE'
,p_static_id=>'true'
);
end;
/
prompt --application/pages/page_groups
begin
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(20071952573326789)
,p_group_name=>'Administration'
,p_static_id=>'administration'
);
end;
/
prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
wwv_flow_imp_shared.create_menu(
 p_id=>wwv_flow_imp.id(20071078014326788)
,p_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(20071110642326788)
,p_short_name=>'Home'
,p_static_id=>'home'
,p_link=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.'
,p_page_id=>1
);
end;
/
prompt --application/shared_components/navigation/breadcrumbentry
begin
null;
end;
/
prompt --application/shared_components/user_interface/themes
begin
wwv_flow_imp_shared.create_theme(
 p_id=>wwv_flow_imp.id(20064313050326770)
,p_theme_id=>42
,p_static_id=>'universal-theme'
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_version_identifier=>'26.1'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_is_locked=>false
,p_current_theme_style_id=>2243014446517417
,p_default_page_template=>4073832297226169690
,p_default_dialog_template=>2101883943284197310
,p_error_template=>2102634289808461002
,p_printer_friendly_template=>4073832297226169690
,p_login_template=>2102634289808461002
,p_default_button_template=>4073839297780169708
,p_default_region_template=>4073835273271169698
,p_default_chart_template=>4073835273271169698
,p_default_form_template=>4073835273271169698
,p_default_reportr_template=>4073835273271169698
,p_default_wizard_template=>4073835273271169698
,p_default_menur_template=>2532939663579242476
,p_default_listr_template=>4073835273271169698
,p_default_irr_template=>2102002977963900996
,p_default_report_template=>2540130677583398057
,p_default_label_template=>1610598304472262251
,p_default_menu_template=>4073839682315169711
,p_default_list_template=>4073837480889169704
,p_default_top_nav_list_temp=>2528231041045349458
,p_default_side_nav_list_temp=>2469215554099805162
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>2127905476394690047
,p_default_dialogr_template=>4502917002193490937
,p_default_option_label=>1610598304472262251
,p_default_required_label=>1610598484065263269
,p_default_navbar_list_template=>2849019392706229583
,p_file_prefix=>nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#APEX_FILES#themes/theme_42/26.1/')
,p_files_version=>2461356174019
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_FILES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_FILES#css/Core#MIN#.css?v=#APEX_VERSION#'
,p_reference_id=>wwv_imp_util.get_subscription_id(4073840274158169736,2000,'universal-theme',8842.261)
,p_version_scn_master=>'SH256:WOPVC8vP1TPWUxczh2dJ4mCZcNGSTzA1cn8DjR2oQjY'
);
end;
/
prompt --application/shared_components/user_interface/theme_style
begin
null;
end;
/
prompt --application/shared_components/user_interface/theme_files
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_opt_groups
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_options
begin
null;
end;
/
prompt --application/shared_components/globalization/language
begin
null;
end;
/
prompt --application/shared_components/logic/build_options
begin
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(20070366384326778)
,p_build_option_name=>'Commented Out'
,p_static_id=>'commented-out'
,p_build_option_status=>'EXCLUDE'
);
end;
/
prompt --application/shared_components/globalization/messages
begin
null;
end;
/
prompt --application/shared_components/globalization/dyntranslations
begin
null;
end;
/
prompt --application/shared_components/security/authentications/oracle_apex_accounts
begin
wwv_flow_imp_shared.create_authentication(
 p_id=>wwv_flow_imp.id(20062659608326768)
,p_name=>'Oracle APEX Accounts'
,p_static_id=>'oracle-apex-accounts'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
);
end;
/
prompt --application/user_interfaces/combined_files
begin
null;
end;
/
prompt --application/pages/page_00000
begin
wwv_flow_imp_page.create_page(
 p_id=>0
,p_name=>'Global Page'
,p_reload_on_submit=>null
,p_warn_on_unsaved_changes=>null
,p_autocomplete_on_off=>'OFF'
,p_protection_level=>'D'
);
end;
/
prompt --application/pages/page_00001
begin
wwv_flow_imp_page.create_page(
 p_id=>1
,p_name=>'Spreadsheet Paste Demo'
,p_alias=>'HOME'
,p_step_title=>'Spreadsheet Paste Demo'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(20072268407326789)
,p_plug_name=>'Employees'
,p_static_id=>'employees-grid'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    employee_id,',
'    full_name,',
'    email,',
'    department,',
'    job_title,',
'    manager_id,',
'    hire_date,',
'    salary,',
'    bonus,',
'    weekly_hours,',
'    is_remote',
'FROM igpt_demo_employees',
'ORDER BY employee_id'))
,p_plug_source_type=>'NATIVE_IG'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(20072601868326789)
,p_name=>'APEX$ROW_SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'enable_multi_select', 'Y',
  'hide_control', 'N',
  'show_select_all', 'Y')).to_clob
,p_use_as_row_header=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(20074453847326789)
,p_name=>'BONUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BONUS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Bonus'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>100
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
,p_format_mask=>'999G999G990D00'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(20073440138326789)
,p_name=>'DEPARTMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DEPARTMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Department'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_is_required=>true
,p_lov_type=>'STATIC'
,p_lov_source=>'STATIC:Engineering;ENG,Sales;SAL,Marketing;MKT,Finance;FIN,Human Resources;HR,Operations;OPS'
,p_lov_display_extra=>false
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(20073296530326789)
,p_name=>'EMAIL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMAIL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Email'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>true
,p_max_length=>200
,p_enable_filter=>true
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(20072895712326789)
,p_name=>'EMPLOYEE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMPLOYEE_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>20
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_use_as_row_header=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(20073096638326789)
,p_name=>'FULL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FULL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Full Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>true
,p_max_length=>100
,p_enable_filter=>true
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(20074083577326789)
,p_name=>'HIRE_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HIRE_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Hire Date'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
,p_format_mask=>'DD-MON-YYYY'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(20074843285326789)
,p_name=>'IS_REMOTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_REMOTE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_YES_NO'
,p_heading=>'Remote'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>120
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>true
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'N'
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(20073616245326789)
,p_name=>'JOB_TITLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'JOB_TITLE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Job Title'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>true
,p_max_length=>100
,p_enable_filter=>true
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(20073878943326789)
,p_name=>'MANAGER_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MANAGER_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Manager'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'display_as', 'POPUP',
  'fetch_on_search', 'N',
  'initial_fetch', 'FIRST_ROWSET',
  'manual_entry', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select full_name d, employee_id r',
'  from igpt_demo_employees',
' order by full_name'))
,p_lov_display_extra=>false
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(20074248180326789)
,p_name=>'SALARY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SALARY'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Salary'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>90
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
,p_format_mask=>'999G999G990D00'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(20074648902326789)
,p_name=>'WEEKLY_HOURS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WEEKLY_HOURS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Weekly Hours'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>110
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
,p_format_mask=>'990D0'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'40'
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(20072334323326789)
,p_internal_uid=>20072334323326789
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>null
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(20072431811326789)
,p_interactive_grid_id=>wwv_flow_imp.id(20072334323326789)
,p_static_id=>'PRIMARY'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(20890069047506719)
,p_report_id=>wwv_flow_imp.id(20072431811326789)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20890193825506719)
,p_view_id=>wwv_flow_imp.id(20890069047506719)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(20072601868326789)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>20
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20890236607506719)
,p_view_id=>wwv_flow_imp.id(20890069047506719)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(20072895712326789)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20890332452506719)
,p_view_id=>wwv_flow_imp.id(20890069047506719)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(20073096638326789)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>160
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20890402607506719)
,p_view_id=>wwv_flow_imp.id(20890069047506719)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(20073296530326789)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>230
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20890552657506719)
,p_view_id=>wwv_flow_imp.id(20890069047506719)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(20073440138326789)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>140
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20890694385506719)
,p_view_id=>wwv_flow_imp.id(20890069047506719)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(20073616245326789)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>210
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20890778387506719)
,p_view_id=>wwv_flow_imp.id(20890069047506719)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(20073878943326789)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>160
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20890806946506719)
,p_view_id=>wwv_flow_imp.id(20890069047506719)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(20074083577326789)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20890972931506719)
,p_view_id=>wwv_flow_imp.id(20890069047506719)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(20074248180326789)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20891057180506719)
,p_view_id=>wwv_flow_imp.id(20890069047506719)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(20074453847326789)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>110
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20891192847506719)
,p_view_id=>wwv_flow_imp.id(20890069047506719)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(20074648902326789)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>110
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20891261168506719)
,p_view_id=>wwv_flow_imp.id(20890069047506719)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(20074843285326789)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(20075010133326794)
,p_name=>'IGPT - Enable Spreadsheet Paste'
,p_static_id=>'da-spreadsheet-paste'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20075145042326794)
,p_event_id=>wwv_flow_imp.id(20075010133326794)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_static_id=>'igpt-spreadsheet-paste'
,p_action=>'PLUGIN_IG_POWERTOOLS'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(20072268407326789)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'command', 'SPREADSHEET_PASTE',
  'paste-mode', 'APPEND',
  'reject-on-errors', 'N',
  'source-date-format', 'DD/MM/YYYY',
  'source-decimal-separator', 'COMMA')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(20075261260326794)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(20072268407326789)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process rows'
,p_static_id=>'process-rows'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>20075261260326794
);
end;
/
prompt --application/pages/page_09999
begin
wwv_flow_imp_page.create_page(
 p_id=>9999
,p_name=>'Login Page'
,p_alias=>'LOGIN'
,p_step_title=>'IG PowerTools Demo - Log In'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>2102634289808461002
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(20075447549326794)
,p_plug_name=>'IG PowerTools Demo'
,p_static_id=>'test'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2675634334296186762
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_region_image=>'#APP_FILES#icons/app-icon-512.png'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(20075881706326795)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(20075447549326794)
,p_button_name=>'LOGIN'
,p_static_id=>'login'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Sign In'
,p_button_position=>'NEXT'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(20075549838326794)
,p_name=>'P9999_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(20075447549326794)
,p_prompt=>'Password'
,p_placeholder=>'Password'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_tag_attributes=>'autocomplete="current-password"'
,p_label_alignment=>'RIGHT'
,p_field_template=>2042262243893469891
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'submit_when_enter_pressed', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(20075660356326794)
,p_name=>'P9999_REMEMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(20075447549326794)
,p_prompt=>'Remember username'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_label_alignment=>'RIGHT'
,p_display_when=>'apex_authentication.persistent_cookies_enabled'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>2042262243893469891
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(20075722777326794)
,p_name=>'P9999_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(20075447549326794)
,p_prompt=>'Username'
,p_placeholder=>'Username'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_tag_attributes=>'autocomplete="username"'
,p_label_alignment=>'RIGHT'
,p_field_template=>2042262243893469891
,p_item_icon_css_classes=>'fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(20075973397326795)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_static_id=>'clear-page-s-cache'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'type', 'CLEAR_CACHE_CURRENT_PAGE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>33743179632801253809
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(20076097476326795)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_static_id=>'get-username-cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P9999_USERNAME := apex_authentication.get_login_username_cookie;',
':P9999_REMEMBER := case when :P9999_USERNAME is not null then ''Y'' end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>33743179252090253809
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(20076125309326795)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_INVOKE_API'
,p_process_name=>'Login'
,p_static_id=>'login'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'package', 'APEX_AUTHENTICATION',
  'package_method', 'LOGIN',
  'type', 'PLSQL_PACKAGE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>33743175962213253806
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(20076276694326795)
,p_page_process_id=>wwv_flow_imp.id(20076125309326795)
,p_page_id=>9999
,p_name=>'p_password'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>2
,p_value_type=>'ITEM'
,p_value=>'P9999_PASSWORD'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(20076334607326795)
,p_page_process_id=>wwv_flow_imp.id(20076125309326795)
,p_page_id=>9999
,p_name=>'p_set_persistent_auth'
,p_direction=>'IN'
,p_data_type=>'BOOLEAN'
,p_has_default=>true
,p_display_sequence=>3
,p_value_type=>'API_DEFAULT'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(20076465666326795)
,p_page_process_id=>wwv_flow_imp.id(20076125309326795)
,p_page_id=>9999
,p_name=>'p_username'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>1
,p_value_type=>'ITEM'
,p_value=>'P9999_USERNAME'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(20076506855326795)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_INVOKE_API'
,p_process_name=>'Set Username Cookie'
,p_static_id=>'set-username-cookie'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'package', 'APEX_AUTHENTICATION',
  'package_method', 'SEND_LOGIN_USERNAME_COOKIE',
  'type', 'PLSQL_PACKAGE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>33743177880663253808
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(20076693499326795)
,p_page_process_id=>wwv_flow_imp.id(20076506855326795)
,p_page_id=>9999
,p_name=>'p_consent'
,p_direction=>'IN'
,p_data_type=>'BOOLEAN'
,p_has_default=>false
,p_display_sequence=>2
,p_value_type=>'ITEM'
,p_value=>'P9999_REMEMBER'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(20076766373326795)
,p_page_process_id=>wwv_flow_imp.id(20076506855326795)
,p_page_id=>9999
,p_name=>'p_username'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>1
,p_value_type=>'EXPRESSION'
,p_value_language=>'PLSQL'
,p_value=>'lower( :P9999_USERNAME )'
);
end;
/
prompt --application/deployment/definition
begin
null;
end;
/
prompt --application/deployment/checks
begin
null;
end;
/
prompt --application/deployment/buildoptions
begin
null;
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
