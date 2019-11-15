REPORT zab_hello_world.

"Listing 2.1
WRITE 'Hello World'.

"Listing 2.2
WRITE: 'Hello World',
        'Here I am!'.

"Listing 2.3
WRITE: 'Hello World', 'Here I am!'.

"Listing 2.4
WRITE 'Hello World'.
WRITE 'Here I am!'.

"Listing 2.5
IF sy-timlo BETWEEN '000000' AND '115959'.
  WRITE: 'Good Morning!'.
ELSEIF sy-timlo BETWEEN '120000' AND '155959'.
  WRITE: 'Good Afternoon!'.
ELSEIF sy-timlo BETWEEN '160000' AND '235959'.
  WRITE: 'Good Evening!'.
ELSE.
  WRITE: 'Oh no, we are lost in time and space!'.
ENDIF.

"Listing 2.6
PARAMETERS: name TYPE string LOWER CASE.
WRITE: 'Hello',
       name,
       '!'.

"Listing 2.7
PARAMETERS: "name TYPE string LOWER CASE,
birthday TYPE datum.

DATA: days TYPE i.

WRITE: 'Hello',
       name,
       '!'.

days = birthday - sy-datlo.
WRITE: |There are { days } days until your birthday!|.
