CLASS zcl_ab_global_class DEFINITION
PUBLIC
FINAL
CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS: method1
      IMPORTING
                !ip_parameter   TYPE i
      RETURNING
                VALUE(rp_value) TYPE i
      RAISING   zcx_ab_custom_exception,
      method2.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.
CLASS zcl_ab_global_class IMPLEMENTATION.
  METHOD method1.
    RAISE EXCEPTION TYPE zcx_ab_custom_exception
      EXPORTING
        ip_custom_data = ''.
  ENDMETHOD.
  METHOD method2.
    TRY.
        me->method1( 5 ).
      CATCH zcx_ab_custom_exception.
        "Handle exception
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
