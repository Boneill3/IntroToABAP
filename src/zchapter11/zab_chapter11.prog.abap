REPORT zab_chapter11.

"Listing 11.1
DATA: my_string TYPE string.
my_string = 'Hello World'.

"Listing 11.2
my_string = |Hello World|.

"Listing 11.3
DATA: my_number TYPE i VALUE 123.
my_string = |{ my_number } gadgets ordered|.

"Listing 11.4
my_string = |some text| &&
            | some more text|.

"Listing 11.5
my_string = |{ 'left' WIDTH = 10 ALIGN = LEFT PAD = '1' }|.
WRITE: / my_string.

my_string = |{ 'center' WIDTH = 10 ALIGN = CENTER PAD = '2' }|.
WRITE: / my_string.

my_string = |{ 'right' WIDTH = 10 ALIGN = RIGHT PAD = '3' }|.
WRITE: / my_string.

"Listing 11.6
my_string = |{ 'aBc' CASE = UPPER }|.
my_string = |{ 'aBc' CASE = LOWER }|.

"Listing 11.7
DATA: my_decimal TYPE decfloat16 VALUE '1.236'.
my_string = |{ my_decimal DECIMALS = 2 }|.

"Listing 11.8
DATA(my_string1) = |{ 'left' WIDTH = 10 ALIGN = LEFT PAD = '1' }|.

"Listing 11.9
DATA: my_length TYPE i.
my_length = strlen( my_string ).

"Listing 11.10
DATA: string_table TYPE TABLE OF string.

APPEND 'Thing One' TO string_table.
APPEND 'Thing Two' TO string_table.
my_string = concat_lines_of( table = string_table sep = ` ` ).

"Listing 11.11
my_string = substring( val = 'this is the whole string'
                       off = 8 len = 3 ).

"Listing 11.12
my_string = substring_from( val = 'the whole string' sub = 'whole' ).
my_string = substring_after( val = 'the whole string' sub = 'whole' ).
my_string = substring_before( val = 'the whole string' sub = 'whole' ).
my_string = substring_to( val = 'the whole string' sub = 'whole' ).

"Listing 11.13
my_string = text-001.
my_string = |symbol: { text-001 }|.

"Listing 11.14
my_string = 'Some Text'(001).

"Listing 11.15
"Skipped, not executable example

"Listing 11.16
DATA: my_string2 TYPE string VALUE 'two',
my_string3 TYPE string VALUE 'three',
my_result TYPE string.
"old way
CONCATENATE my_string1 my_string2 my_string3
INTO my_result SEPARATED BY ' '.
"new way
my_result = |{ my_string1 } { my_string2 } { my_string3 }|.

"Listing 11.17
"old way
my_string = 'aBc'.
TRANSLATE my_string TO UPPER CASE.
"new way
my_string = |{ 'aBc' CASE = UPPER }|.

"Listing 11.18 - 11.21
"Included in ZAB_PRODUCT_MAINT_11

"Listing 11.22
"Included in ZCL_AB_SHOPPING_CART_11
