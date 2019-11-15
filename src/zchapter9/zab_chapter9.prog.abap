REPORT zab_chapter9.

"Listing 9.1 - 9.5
*CLASS lcl_report DEFINITION.
*  PUBLIC SECTION.
*    DATA: alv_table_object TYPE REF TO cl_salv_table,
*          flights          TYPE STANDARD TABLE OF sflight.
*    METHODS:
*      get_data,
*      present_data.
*  PRIVATE SECTION.
*    METHODS:
*      set_default_functions,
*      set_layout.
*ENDCLASS.
*
*PARAMETERS: p_rows TYPE i OBLIGATORY.
*
*START-OF-SELECTION.
*  DATA: my_report TYPE REF TO lcl_report.
*  CREATE OBJECT my_report.
*  my_report->get_data( ).
*  my_report->present_data( ).
*
*CLASS lcl_report IMPLEMENTATION.
*  METHOD get_data.
*    SELECT *
*    INTO TABLE flights
*    FROM sflight
*    UP TO p_rows ROWS.
*  ENDMETHOD.
*
*  METHOD present_data.
*    TRY.
*        cl_salv_table=>factory(
*        IMPORTING
*        r_salv_table = alv_table_object
*        CHANGING
*        t_table = flights ).
*      CATCH cx_salv_msg.
*    ENDTRY.
*    me->set_default_functions( ).
*    me->set_layout( ).
*    alv_table_object->display( ).
*  ENDMETHOD.
*
*  METHOD set_default_functions.
*    DATA: functions TYPE REF TO cl_salv_functions_list.
*    functions = alv_table_object->get_functions( ).
*    functions->set_all( abap_true ).
*  ENDMETHOD.
*  METHOD set_layout.
*    DATA: layout     TYPE REF TO cl_salv_layout,
*          layout_key TYPE salv_s_layout_key.
*    layout = alv_table_object->get_layout( ).
*    layout_key-report = sy-repid.
*    layout->set_key( layout_key ).
*    layout->set_save_restriction( if_salv_c_layout=>restrict_none ).
*  ENDMETHOD.
*
*ENDCLASS.

"Listing 9.6 - 9.17
TYPES: BEGIN OF t_tree,
         agencynum TYPE sbook-agencynum,
         connid    TYPE sbook-connid,
         fldate    TYPE sbook-fldate,
         loccuram  TYPE sbook-loccuram,
         loccurkey TYPE sbook-loccurkey,
       END OF t_tree.

CLASS lcl_report DEFINITION.
  PUBLIC SECTION.
    DATA: tree_data        TYPE STANDARD TABLE OF t_tree,
          alv_tree_object  TYPE REF TO cl_salv_tree,
          empty_tree_table TYPE STANDARD TABLE OF t_tree.
    METHODS:
      get_data,
      present_data.
  PRIVATE SECTION.
    METHODS:
      create_node_hierarchy,
      set_headers,
      set_aggregations,
      set_columns_technical.
ENDCLASS.

PARAMETERS: p_rows TYPE i OBLIGATORY DEFAULT 30.

START-OF-SELECTION.
  DATA: my_report TYPE REF TO lcl_report.
  CREATE OBJECT my_report.
  my_report->get_data( ).
  my_report->present_data( ).

CLASS lcl_report IMPLEMENTATION.

  METHOD get_data.
    SELECT *
    INTO CORRESPONDING FIELDS OF TABLE tree_data
    FROM sbook
    UP TO p_rows ROWS
    WHERE agencynum > space.
    SORT tree_data BY agencynum.
  ENDMETHOD.

  METHOD present_data.
    TRY.
        cl_salv_tree=>factory(
        IMPORTING
        r_salv_tree = alv_tree_object
        CHANGING
        t_table = empty_tree_table ).
      CATCH cx_salv_no_new_data_allowed
      cx_salv_error.
    ENDTRY.
    me->create_node_hierarchy( ).
    me->set_headers( ).
    me->set_columns_technical( ).
    me->set_aggregations( ).
    alv_tree_object->display( ).
  ENDMETHOD.

  METHOD create_node_hierarchy.
    DATA: parent_node_key TYPE lvc_nkey,
          nodes           TYPE REF TO cl_salv_nodes,
          node            TYPE REF TO cl_salv_node,
          node_text       TYPE lvc_value.
    FIELD-SYMBOLS: <hierarchy_line> TYPE t_tree.
    nodes = alv_tree_object->get_nodes( ).
    TRY.
        LOOP AT tree_data ASSIGNING <hierarchy_line>.
          AT NEW agencynum.
            node = nodes->add_node( related_node = space
            relationship = if_salv_c_node_relation=>parent
            folder = abap_true ).
            node_text = <hierarchy_line>-agencynum.
            SHIFT node_text LEFT DELETING LEADING '0'.
            node->set_text( node_text ).
            node->set_data_row( <hierarchy_line> ).
            parent_node_key = node->get_key( ).
          ENDAT.
          node = nodes->add_node( related_node = parent_node_key
          relationship = if_salv_c_node_relation=>first_child ).
          node->set_data_row( <hierarchy_line> ).
        ENDLOOP.
      CATCH cx_salv_msg.
    ENDTRY.
  ENDMETHOD.

  METHOD set_headers.
    DATA: settings TYPE REF TO cl_salv_tree_settings.
    settings = alv_tree_object->get_tree_settings( ).
    settings->set_hierarchy_header( 'Agency' ).
    settings->set_hierarchy_size( 20 ).
    settings->set_header( 'Bookings by Agency' ).
  ENDMETHOD.

  METHOD set_aggregations.
    DATA: aggregations TYPE REF TO cl_salv_aggregations.
    aggregations = alv_tree_object->get_aggregations( ).
    TRY.
        aggregations->add_aggregation( columnname = 'LOCCURAM' ).
      CATCH cx_salv_not_found cx_salv_data_error cx_salv_existing.
    ENDTRY.
  ENDMETHOD.

  METHOD set_columns_technical.
    DATA: columns TYPE REF TO cl_salv_columns,
          column  TYPE REF TO cl_salv_column.
    columns = alv_tree_object->get_columns( ).
    TRY.
        column = columns->get_column( 'AGENCYNUM' ).
        column->set_technical( abap_true ).
      CATCH cx_salv_not_found.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.

"Listing 9.18 (Does not work on non-HANA demo system)
*cl_salv_gui_table_ida=>create(
*iv_table_name = 'SCUS_BOOK' )->fullscreen( )->display( ).
