*----------------------------------------------------------------------*
***INCLUDE ZAB_SCREEN_TEST_STATUS_0100O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE initialize_0100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
  SET TITLEBAR 'TITLE_100'.

  DATA: g_editor           TYPE REF TO cl_gui_textedit,
        g_editor_container TYPE REF TO
                             cl_gui_custom_container.
  IF g_editor IS INITIAL.
    CREATE OBJECT g_editor_container
      EXPORTING
        container_name              = 'TEXT_CONTROL'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5.
    IF sy-subrc NE 0.
      MESSAGE e001(00) WITH 'Editor error'.
    ELSE.
      CREATE OBJECT g_editor
        EXPORTING
          parent                 = g_editor_container
        EXCEPTIONS
          error_cntl_create      = 1
          error_cntl_init        = 2
          error_cntl_link        = 3
          error_dp_create        = 4
          gui_type_not_supported = 5
          OTHERS                 = 6.
      IF sy-subrc <> 0.
        MESSAGE e001(00) WITH 'Editor error'.
      ENDIF.
    ENDIF.
  ENDIF.

ENDMODULE.
