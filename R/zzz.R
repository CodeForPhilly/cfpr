# Exports ----

#' @exportPattern ^cfp_.*$
NULL


# Startup ----

.onLoad <- function(libname, pkgname){
  DB_URL <- Sys.getenv("AIRFLOW_CONN_POSTGRES_DEFAULT")
  if (DB_URL == "" & Sys.getenv("CFP_USER") != "") {
    DB_URL <- glue::glue(
      "{CFP_DIALECT}://{CFP_USER}:{CFP_PASSWORD}@{CFP_HOST}:{CFP_PORT}/{CFP_DB}",
      .envir = as.list(Sys.getenv())
    )
  }

  pkg_ns_env <- parent.env(environment())

  if (DB_URL != "") {
    dbcooper::dbc_init(
      DBI::dbConnect(dbpath::dbpath(DB_URL)),
      "cfp",
      env = pkg_ns_env
    )
  }
  else {
    warning("No cfpr credentials detected. Skipping connection.")
  }

}

