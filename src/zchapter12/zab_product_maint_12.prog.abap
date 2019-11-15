REPORT zab_product_maint_12.

SELECTION-SCREEN BEGIN OF BLOCK product
WITH FRAME TITLE TEXT-001.
PARAMETERS: p_prod TYPE zab_product-product,
            p_desc TYPE zab_product_text-description LOWER CASE,
            p_price TYPE zab_product-price,
            p_curr TYPE zab_product-currency,
            p_uom  TYPE zab_product-uom.
SELECTION-SCREEN END OF BLOCK product.

SELECTION-SCREEN BEGIN OF BLOCK action
WITH FRAME TITLE TEXT-002.
PARAMETERS: p_upd TYPE abap_bool RADIOBUTTON GROUP act,
            p_rem TYPE abap_bool RADIOBUTTON GROUP act,
            p_dis TYPE abap_bool RADIOBUTTON GROUP act.
SELECTION-SCREEN END OF BLOCK action.

"For non ABAP 7.4 SP 8 systems
*TYPES: BEGIN OF t_product,
*         product     TYPE zab_product-product,
*         description TYPE zab_product_text-description,
*         price       TYPE zab_product-price,
*         currency    TYPE zab_product-currency,
*         uom         TYPE zab_product-uom,
*       END OF t_product.

*DATA: products  TYPE STANDARD TABLE OF t_product,
*      alv_table TYPE REF TO cl_salv_table.

DATA: product      TYPE zab_product,
      product_text TYPE zab_product_text.

product-product = p_prod.
product-price = p_price.
product-currency = p_curr.
product-uom = p_uom.
product_text-product = p_prod.
product_text-language = sy-langu.
product_text-description = p_desc.

IF p_upd = abap_true.
  MODIFY zab_product FROM product.
  IF sy-subrc = 0.
    MODIFY zab_product_text FROM product_text.
    IF sy-subrc = 0.
      MESSAGE i001(zab_cart).
    ELSE.
      MESSAGE e006(zab_cart).
    ENDIF.
  ELSE.
    MESSAGE e006(zab_cart).
  ENDIF.
ELSEIF p_rem = abap_true.
  DELETE zab_product FROM product.
  IF sy-subrc = 0.
    DELETE FROM zab_product_text WHERE product = p_prod.
    IF sy-subrc = 0.
      MESSAGE i002(zab_cart).
    ELSE.
      MESSAGE e006(zab_cart).
    ENDIF.
  ELSE.
    MESSAGE e006(zab_cart).
  ENDIF.
ELSEIF p_dis = abap_true.
  SELECT zab_product~product, zab_product_text~description, price, currency, uom
    FROM zab_product
    INNER JOIN zab_product_text
    ON zab_product~product = zab_product_text~product
    WHERE language = @sy-langu
    INTO TABLE @DATA(products).
  cl_salv_table=>factory( IMPORTING r_salv_table = DATA(alv_table)
                          CHANGING t_table = products ).
  alv_table->display( ).

  "For non-abap 7.4 SP 8 systems
*  SELECT zab_product~product zab_product_text~description price currency uom
*    INTO TABLE products
*    FROM zab_product
*    INNER JOIN zab_product_text
*    ON zab_product~product = zab_product_text~product
*    WHERE language = @y-langu
*
*  cl_salv_table=>factory( IMPORTING r_salv_table = alv_table
*                          CHANGING t_table = products ).
*  alv_table->display( ).

ENDIF.
