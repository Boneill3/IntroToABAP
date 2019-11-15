CLASS zcx_ab_custom_exception DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: custom_data TYPE string.
    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .

    METHODS constructor
      IMPORTING
        !textid        LIKE if_t100_message=>t100key OPTIONAL
        !previous      LIKE previous OPTIONAL
        ip_custom_data TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_ab_custom_exception IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
    me->custom_data = ip_custom_data.
  ENDMETHOD.
ENDCLASS.
