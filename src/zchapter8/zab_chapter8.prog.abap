REPORT zab_chapter8.

"Listing 8.1
DATA: flights TYPE STANDARD TABLE OF sflight.

READ TABLE flights ASSIGNING FIELD-SYMBOL(<flight>)
INDEX 1.
IF sy-subrc = 0.
  "Do Something
ENDIF.

"Listing 8.2
SELECT *
FROM sflight
INTO TABLE @DATA(flights_8_2).
IF sy-subrc = 0.
  "Do something with results
ELSE.
  "Display an error message
ENDIF.

"Listing 8.3
*PARAMETERS: p_value TYPE i.
*MESSAGE e002(zmy_messages) WITH p_value.

*"Listing 8.4
*SELECTION-SCREEN BEGIN OF BLOCK selection.
*PARAMETERS: p_param TYPE i.
*SELECTION-SCREEN END OF BLOCK selection.
*
*AT SELECTION-SCREEN.
*    IF p_param = 0.
*        MESSAGE e002(zmy_messages) WITH p_param.
*    ENDIF.
*
*START-OF-SELECTION.
*    WRITE: 'END'.

"Listing 8.5
*SELECTION-SCREEN BEGIN OF BLOCK selection.
*PARAMETERS: p_param TYPE i.
*SELECTION-SCREEN END OF BLOCK selection.
*
*AT SELECTION-SCREEN.
*  IF p_param = 0.
*    MESSAGE w002(zmy_messages) WITH p_param.
*  ENDIF.
*
*START-OF-SELECTION.
*  WRITE: 'END'.

"Listing 8.6
*SELECTION-SCREEN BEGIN OF BLOCK selection.
*PARAMETERS: p_param TYPE i.
*SELECTION-SCREEN END OF BLOCK selection.
*
*START-OF-SELECTION.
*  DATA: result TYPE i.
*  result = 10 / p_param.
*
*  WRITE: result.

"Listing 8.7
*SELECTION-SCREEN BEGIN OF BLOCK selection.
*PARAMETERS: p_param TYPE i.
*SELECTION-SCREEN END OF BLOCK selection.
*
*START-OF-SELECTION.
*  DATA: result TYPE i.
*  TRY.
*      result = 10 / p_param.
*    CATCH cx_sy_zerodivide.
*      WRITE: 'Caught!'.
*  ENDTRY.
*  WRITE: result.

"Listing 8.8
*SELECTION-SCREEN BEGIN OF BLOCK selection.
*PARAMETERS: p_param TYPE i.
*SELECTION-SCREEN END OF BLOCK selection.
*
*START-OF-SELECTION.
*  DATA: result       TYPE i,
*        my_exception TYPE REF TO cx_sy_zerodivide.
*  TRY.
*      result = 10 / p_param.
*    CATCH cx_sy_zerodivide INTO my_exception.
*      MESSAGE e001(zmy_messages)
*      WITH my_exception->get_text( ).
*  ENDTRY.
*  WRITE: result.

"Listing 8.9
TRY.
    RAISE RESUMABLE EXCEPTION TYPE cx_sy_zerodivide.
    WRITE: 'resumed'.
  CATCH BEFORE UNWIND cx_sy_zerodivide.
    RESUME.
ENDTRY.

"Listing 8.10
"See zcl_ab_global_class

"Listing 8.11, 8.12
"See zcx_ab_custom_exception

"Listing 8.13
*DATA: custom_exception TYPE REF TO zcx_ab_custom_exception,
*      my_string        TYPE string.
*TRY.
*    my_string = |More Information|.
*    "Do Something
*    RAISE EXCEPTION TYPE zcx_ab_custom_exception
*      EXPORTING
*        ip_custom_data = my_string.
*  CATCH zcx_ab_custom_exception INTO custom_exception.
*    WRITE: custom_exception->custom_data.
*ENDTRY.

"Listing 8.14
"See ZFM_AB_EXCEPTION_TEST

"Listing 8.15
*DATA: my_string TYPE string VALUE 'string'.
*CALL FUNCTION 'ZFM_EXCEPTION_TEST'
*  EXPORTING
*    ip_string  = my_string
*  IMPORTING
*    ep_string  = my_string
*  EXCEPTIONS
*    exception1 = 1
*    OTHERS     = 2.

"Listing 8.16
DATA: my_string TYPE string VALUE 'string'.
CALL FUNCTION 'ZFM_EXCEPTION_TEST'
  EXPORTING
    ip_string  = my_string
  IMPORTING
    ep_string  = my_string
  EXCEPTIONS
    exception1 = 1
    OTHERS     = 2.
IF sy-subrc = 1.
  "exception exception1 was raised
ELSEIF sy-subrc = 2.
  "Another exception was raised
ENDIF.
