*&---------------------------------------------------------------------*
*& Report zab_file_pres_server_read
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zab_file_pres_server_read.

PARAMETERS: p_file TYPE string.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  DATA: selected_files TYPE filetable,
        selected_file  TYPE LINE OF filetable,
        rc             TYPE i.

  cl_gui_frontend_services=>file_open_dialog(
    EXPORTING
      multiselection          = abap_false
    CHANGING
      file_table              = selected_files
      rc                      = rc
      ).

  READ TABLE selected_files INTO selected_file INDEX 1.
  p_file = selected_file-filename.

START-OF-SELECTION.

  DATA: customer_bookings TYPE STANDARD TABLE OF scus_book,
        booking           TYPE scus_book,
        bookings_in_csv   TYPE STANDARD TABLE OF soli,
        converter         TYPE REF TO cl_rsda_csv_converter,
        salv_table        TYPE REF TO cl_salv_table.

  FIELD-SYMBOLS: <booking_in_csv> TYPE soli.

  cl_gui_frontend_services=>gui_upload(
    EXPORTING
      filename                = p_file
    CHANGING
      data_tab                = bookings_in_csv
         ).

  converter = cl_rsda_csv_converter=>create( ).

  LOOP AT bookings_in_csv ASSIGNING <booking_in_csv>.
    converter->csv_to_structure(
      EXPORTING
        i_data   = <booking_in_csv>
      IMPORTING
        e_s_data = booking ).

    APPEND booking TO customer_bookings.
  ENDLOOP.

  cl_salv_table=>factory(
    IMPORTING
      r_salv_table = salv_table
    CHANGING
      t_table      = customer_bookings ).

  salv_table->display( ).
