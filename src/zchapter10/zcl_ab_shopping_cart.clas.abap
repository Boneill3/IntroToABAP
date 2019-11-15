CLASS zcl_ab_shopping_cart DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF t_cart,
             product     TYPE zab_product-product,
             description TYPE zab_product-description,
           END OF t_cart,
           t_cart_table TYPE STANDARD TABLE OF t_cart WITH KEY product.

    METHODS:
      constructor IMPORTING ip_customer TYPE scustom-id
                  RAISING   zcx_ab_shopping_cart,
      add_product IMPORTING ip_product TYPE zab_product-product,
      remove_product IMPORTING ip_product
                                 TYPE zab_product-product,
      clear_cart,
      get_cart RETURNING VALUE(rt_cart) TYPE t_cart_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: customer TYPE scustom-id.
ENDCLASS.



CLASS zcl_ab_shopping_cart IMPLEMENTATION.
  METHOD constructor.
    "New syntax
    SELECT SINGLE id
    INTO @customer
    FROM scustom
    WHERE id = @ip_customer.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_ab_shopping_cart.
    ENDIF.

    " Old syntax
*    SELECT SINGLE id
*    INTO customer
*    FROM scustom
*    WHERE id = ip_customer.
*    IF sy-subrc <> 0.
*      RAISE EXCEPTION TYPE zcx_shopping_cart.
*    ENDIF.

  ENDMETHOD.

  METHOD add_product.
    DATA: cart TYPE zab_cart.
    cart-customer = customer.
    cart-product = ip_product.
    INSERT zab_cart FROM cart.
  ENDMETHOD.

  METHOD remove_product.
    DATA: cart TYPE zab_cart.
    cart-customer = customer.
    cart-product = ip_product.
    DELETE zab_cart FROM cart.
  ENDMETHOD.

  METHOD clear_cart.
    DELETE FROM zab_cart WHERE customer = customer.
  ENDMETHOD.

  METHOD get_cart.
    "New syntax
    SELECT zab_cart~product, description
    FROM zab_cart
    INNER JOIN zab_product
    ON zab_cart~product = zab_product~product
    WHERE zab_cart~customer = @customer
    INTO TABLE @rt_cart.

    "Old syntax
*    SELECT zab_cart~product description
*    INTO TABLE rt_cart
*    FROM zab_cart
*    INNER JOIN zab_product
*    ON zab_cart~product = zab_product~product
*    WHERE zab_cart~customer = customer.

  ENDMETHOD.

ENDCLASS.
