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
    glue::glue("CREATE SCHEMA IF NOT EXISTS {schema_name};")# AUTHORIZATION {Sys.getenv('CFP_USER')};")
  )
}

#' @export
`odbcDataType.Snowflake` <- function(con, obj, ...) {
  switch_type(
    obj,
    factor = "VARCHAR(16777216)",
    datetime = "TIMESTAMP",
    date = "DATE",
    time = "TIME",
    binary = "VARBINARY(16777216)",
    integer = "INTEGER",
    double = "DOUBLE PRECISION",
    character = "VARCHAR(16777216)",
    logical = "BOOLEAN",
    list = "VARCHAR(16777216)",
    stop("Unsupported type", call. = FALSE)
  )
}
