REPORT zab_file_read.

PARAMETERS: p_file TYPE string LOWER CASE.

START-OF-SELECTION.
  DATA: customer_bookings TYPE STANDARD TABLE OF scus_book,
        booking           TYPE scus_book,
        salv_table        TYPE REF TO cl_salv_table.

  TRY.
      OPEN DATASET p_file FOR INPUT IN TEXT MODE
      ENCODING DEFAULT.
      DO.
        READ DATASET p_file INTO booking.
        IF sy-subrc = 0.
          APPEND booking TO customer_bookings.
        ELSE.
          EXIT.
        ENDIF.
      ENDDO.
      CLOSE DATASET p_file.
    CATCH cx_sy_file_access_error.
      MESSAGE e001(00) WITH 'File access error'.
  ENDTRY.

  cl_salv_table=>factory(
  IMPORTING
    r_salv_table = salv_table
  CHANGING
    t_table = customer_bookings ).

  salv_table->display( ).
