@AbapCatalog.sqlViewName: 'zabsql_cds_view'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS view demo'
define view zab_cds_view as select * from sflight 
 