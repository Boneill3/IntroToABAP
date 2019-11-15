REPORT zab_unit_test.

CLASS lcl_report DEFINITION.
  PUBLIC SECTION.
    METHODS get_time_of_day
      IMPORTING i_time               TYPE tims
      RETURNING VALUE(r_time_of_day) TYPE string
      RAISING   cx_sy_conversion_no_time.

ENDCLASS.

PARAMETERS: p_name TYPE string LOWER CASE.
DATA: time_of_day TYPE string,
      my_report   TYPE REF TO lcl_report.

CREATE OBJECT my_report.
time_of_day = my_report->get_time_of_day( sy-timlo ).
WRITE: | Time is { sy-timlo }. Good { time_of_day }, { p_name }!|.

CLASS lcl_report IMPLEMENTATION.

  METHOD get_time_of_day.

    IF i_time BETWEEN '000000' AND '115959'.
      r_time_of_day = 'Morning'.
    ELSEIF i_time BETWEEN '120000' AND '155959'.
      r_time_of_day = 'Afternoon'.
    ELSEIF i_time BETWEEN '160000' AND '235959'.
      r_time_of_day = 'Evening'.
    ELSE.
      RAISE EXCEPTION TYPE cx_sy_conversion_no_time.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_test DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    DATA: cut         TYPE REF TO lcl_report,
          time_of_day TYPE string.

    METHODS: setup,
      teardown,
      get_time_of_day_success FOR TESTING,
      get_time_of_day_fail FOR TESTING.
ENDCLASS.

CLASS lcl_test IMPLEMENTATION.
  METHOD setup.
    CREATE OBJECT cut.
  ENDMETHOD.
  METHOD teardown.
    CLEAR cut.
  ENDMETHOD.
  METHOD get_time_of_day_success.
*    DATA: cut         TYPE REF TO lcl_report,
*          time_of_day TYPE string.
*
*    CREATE OBJECT cut.
    time_of_day = cut->get_time_of_day( '090000' ).

    cl_aunit_assert=>assert_equals(
        exp                  = 'Morning'
        act                  = time_of_day
        msg                  = 'Wrong time of day'
           ).
  ENDMETHOD.
  METHOD get_time_of_day_fail.

    TRY.
        time_of_day = cut->get_time_of_day( '250000' ).
        cl_abap_unit_assert=>fail(
          msg = 'Exception not raised' ).
      CATCH cx_sy_conversion_no_time.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
