REPORT zab_cart_maint_12.

SELECTION-SCREEN BEGIN OF BLOCK cart
WITH FRAME TITLE TEXT-001.
PARAMETERS: p_cust TYPE zab_cart-customer OBLIGATORY,
            p_prod TYPE zab_cart-product,
            p_qty  TYPE zab_cart-quantity.
SELECTION-SCREEN END OF BLOCK cart.

SELECTION-SCREEN BEGIN OF BLOCK action
WITH FRAME TITLE TEXT-002.
PARAMETERS: p_view  TYPE abap_bool RADIOBUTTON GROUP act,
            p_add   TYPE abap_bool RADIOBUTTON GROUP act,
            p_rem   TYPE abap_bool RADIOBUTTON GROUP act,
            p_clear TYPE abap_bool RADIOBUTTON GROUP act.
SELECTION-SCREEN END OF BLOCK action.

INITIALIZATION.
  DATA: cart TYPE REF TO zcl_ab_shopping_cart_12.

AT SELECTION-SCREEN.
  TRY.
      CREATE OBJECT cart EXPORTING ip_customer = p_cust.
    CATCH zcx_ab_shopping_cart.
      MESSAGE e000(zab_cart) WITH p_cust.
  ENDTRY.

  "Without inline data declarations
*START-OF-SELECTION.
*  DATA: cart_contents TYPE cart->t_cart_table,
*        alv_table     TYPE REF TO cl_salv_table.
*  IF p_view = abap_true.
*    cart_contents = cart->get_cart( ).
*    cl_salv_table=>factory( IMPORTING r_salv_table = alv_table
*                            CHANGING t_table = cart_contents ).
*    alv_table->display( ).
*  ENDIF.

START-OF-SELECTION.
  IF p_view = abap_true.
    DATA(cart_contents) = cart->get_cart( ).
    cl_salv_table=>factory( IMPORTING r_salv_table = DATA(alv_table)
                            CHANGING t_table = cart_contents ).
    alv_table->display( ).
  ELSEIF p_add = abap_true.
    cart->add_product( ip_product = p_prod ip_quantity = p_qty ).
    MESSAGE i003(zab_cart) WITH p_prod.
  ELSEIF p_rem = abap_true.
    cart->remove_product( p_prod ).
    MESSAGE i004(zab_cart) WITH p_prod.
  ELSEIF p_clear = abap_true.
    cart->clear_cart( ).
    MESSAGE i005(zab_cart).
  ENDIF.
