REPORT zab_file_copy.

PARAMETERS: p_file TYPE string LOWER CASE.

START-OF-SELECTION.
  DATA: file_service   TYPE REF TO cl_fs_path,
        file_data      TYPE STANDARD TABLE OF so_raw255,
        file_path      TYPE string,
        file_extension TYPE string,
        copy_to_name   TYPE string.

  file_service = cl_fs_path=>create( name = p_file ).
  file_path = file_service->get_file_base_name( ).
  file_extension = file_service->get_file_extension( ).
  copy_to_name = file_path && '_copy' && file_extension.

  cl_gui_frontend_services=>gui_upload(
  EXPORTING
    filename = p_file
    filetype = 'BIN'
  CHANGING
    data_tab = file_data ).

  cl_gui_frontend_services=>gui_download(
  EXPORTING
    filename = copy_to_name
    filetype = 'BIN'
  CHANGING
    data_tab = file_data ).
