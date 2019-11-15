REPORT zab_file_pres_server.

PARAMETERS: p_file TYPE string LOWER CASE.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  CALL METHOD cl_gui_frontend_services=>directory_browse
    CHANGING
      selected_folder = p_file.

START-OF-SELECTION.

  DATA: customer_bookings TYPE STANDARD TABLE OF scus_book,
        booking_in_csv    TYPE soli,
        bookings_in_csv   TYPE STANDARD TABLE OF soli,
        converter         TYPE REF TO cl_rsda_csv_converter.

  FIELD-SYMBOLS: <booking> TYPE scus_book.

  SELECT * FROM scus_book
    INTO TABLE  customer_bookings
    UP TO 10 ROWS.

  converter = cl_rsda_csv_converter=>create( ).

  LOOP AT customer_bookings ASSIGNING <booking>.
    converter->structure_to_csv(
      EXPORTING
        i_s_data = <booking>
      IMPORTING
        e_data   = booking_in_csv
    ).
    APPEND booking_in_csv TO bookings_in_csv.
  ENDLOOP.

  cl_gui_frontend_services=>gui_download(
    EXPORTING
      filename = p_file
    CHANGING
      data_tab = bookings_in_csv ).
