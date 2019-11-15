REPORT zab_file_write.

PARAMETERS: p_file TYPE string LOWER CASE.

START-OF-SELECTION.
  DATA: customer_bookings TYPE STANDARD TABLE OF scus_book.
  FIELD-SYMBOLS: <booking> TYPE scus_book.

  SELECT * FROM scus_book
  INTO TABLE customer_bookings
  UP TO 10 ROWS.

  TRY.
      OPEN DATASET p_file FOR OUTPUT IN TEXT MODE
      ENCODING DEFAULT.
      LOOP AT customer_bookings ASSIGNING <booking>.
        TRANSFER <booking> TO p_file.
      ENDLOOP.
      CLOSE DATASET p_file.
    CATCH cx_sy_file_access_error.
      MESSAGE e001(00) WITH 'File access error'.
  ENDTRY.
