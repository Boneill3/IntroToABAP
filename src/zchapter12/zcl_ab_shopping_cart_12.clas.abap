CLASS zcl_ab_shopping_cart_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF t_cart,
             product     TYPE zab_product-product,
             description TYPE zab_product_text-description,
             quantity    TYPE zab_cart-quantity,
             uom         TYPE zab_product-uom,
           END OF t_cart,
           t_cart_table TYPE STANDARD TABLE OF t_cart WITH KEY product.

    METHODS:
      constructor IMPORTING ip_customer TYPE scustom-id
                  RAISING   zcx_ab_shopping_cart,
      add_product IMPORTING ip_product TYPE zab_product-product
                            ip_quantity TYPE zab_cart-quantity OPTIONAL,
      remove_product IMPORTING ip_product TYPE zab_product-product,

      clear_cart,
      get_cart RETURNING VALUE(rt_cart) TYPE t_cart_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: customer TYPE scustom-id.
ENDCLASS.



CLASS zcl_ab_shopping_cart_12 IMPLEMENTATION.
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
    IF ip_quantity IS NOT INITIAL.
        cart-quantity = ip_quantity.
    ELSE.
        cart-quantity = 1.
    ENDIF.

    MODIFY zab_cart FROM cart.
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
    SELECT zab_cart~product, zab_product_text~description, quantity, uom
    FROM zab_cart
    INNER JOIN zab_product
    ON zab_cart~product = zab_product~product
    INNER JOIN zab_product_text
    ON zab_cart~product = zab_product_text~product
    WHERE zab_product_text~language = @sy-langu
    AND zab_cart~customer = @customer
    INTO TABLE @rt_cart.

    "Old syntax
*    SELECT zab_cart~product zab_product_text~description quantity uom
*    INTO TABLE rt_cart
*    FROM zab_cart
*    INNER JOIN zab_product
*    ON zab_cart~product = zab_product~product
*    INNER JOIN zab_product_text
*    ON zab_cart~product = zab_product_text~product
*    WHERE zab_product_text~language = sy-langu
*    AND zab_cart~customer = customer.

  ENDMETHOD.

ENDCLASS.
