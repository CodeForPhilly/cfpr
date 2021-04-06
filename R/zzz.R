# Exports ----

#' @exportPattern ^cfp_.*$
NULL


# Startup ----

.onLoad <- function(libname, pkgname){
  dbpath::dialect_defaults$set(SnowflakeDSIIDriver = "odbc")

  DB_URL <- Sys.getenv("CFP_WAREHOUSE_URI")
  if (DB_URL == "" & Sys.getenv("CFP_USER") != "") {
    DB_URL <- glue::glue(
      "{CFP_DIALECT}://{CFP_USER}:{CFP_PASSWORD}@{CFP_HOST}:{CFP_PORT}/{CFP_DATABASE}?warehouse={CFP_WAREHOUSE}&role={CFP_ROLE}",
      .envir = as.list(Sys.getenv())
    )
  }

  pkg_ns_env <- parent.env(environment())

  if (DB_URL != "") {
    dbcooper::dbc_init(
      DBI::dbConnect(dbpath::dbpath(DB_URL)),
      "cfp",
      table_formatter = function(x) gsub("CODEFORPHILLY.", "", x, fixed = TRUE),
      env = pkg_ns_env
    )
  }
  else {
    warning("No cfpr credentials detected. Skipping connection.")
  }

}

