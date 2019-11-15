REPORT zab_product_maint.

SELECTION-SCREEN BEGIN OF BLOCK product
WITH FRAME TITLE TEXT-001.
PARAMETERS: p_prod TYPE zab_product-product,
            p_desc TYPE zab_product-description LOWER CASE.
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
*         description TYPE zab_product-description,
*       END OF t_product.
*
*DATA: products  TYPE STANDARD TABLE OF t_product,
*      alv_table TYPE REF TO cl_salv_table.

DATA: product TYPE zab_product.
product-product = p_prod.
product-description = p_desc.
IF p_upd = abap_true.
  MODIFY zab_product FROM product.
  IF sy-subrc = 0.
    MESSAGE i001(zab_cart).
  ELSE.
    MESSAGE e006(zab_cart).
  ENDIF.
ELSEIF p_rem = abap_true.
  DELETE zab_product FROM product.
  IF sy-subrc = 0.
    MESSAGE i002(zab_cart).
  ELSE.
    MESSAGE e006(zab_cart).
  ENDIF.
ELSEIF p_dis = abap_true.
  SELECT product, description
  FROM zab_product
  INTO TABLE @DATA(products).
  cl_salv_table=>factory( IMPORTING r_salv_table = DATA(alv_table)
                          CHANGING t_table = products ).
  alv_table->display( ).

  "For non-abap 7.4 SP 8 systems
*  SELECT product description
*    INTO TABLE products
*    FROM zab_product.
*
*  cl_salv_table=>factory( IMPORTING r_salv_table = alv_table
*                          CHANGING t_table = products ).
*  alv_table->display( ).

ENDIF.
