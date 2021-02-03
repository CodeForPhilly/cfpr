#' Create a table in the CfP datawarehouse
cfp_create_table <- function(tbl, table_name) {
  DBI::dbWriteTable(
    cfp_src()$con,
    DBI::SQL(table_name),
    dplyr::collect(tbl),
    overwrite = TRUE,
  )
}

#' Create a table in the CfP datawarehouse
cfp_create_schema <- function(schema_name) {
  cfp_execute(
    glue::glue("CREATE SCHEMA IF NOT EXISTS {schema_name} AUTHORIZATION {Sys.getenv('DEFAULT_USER')};")
  )
}
