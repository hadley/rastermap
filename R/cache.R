#' Manage the rastermap file cache.
#'
#' To avoid downloading the same maps again and again, rastermap locally
#' caches the you've downloaded. By default, they will be stored in a
#' session specific temporary directory which will be deleted each time you
#' quit R. If you want them to persist across sessions, set the global option
#' "rastermap.cache".
#'
#' @export
#' @keywords internal
#' @examples
#' dir(cache_path())
cache_path <- function(...) {
  dir <- getOption("rastermap.cache", file.path(tempdir(), "rastermap"))
  file.path(dir, ...)
}

cache_init <- function() {
  if (file.exists(cache_path())) return()

  dir.create(cache_path(), recursive = TRUE, showWarnings = FALSE)
  saveRDS(list(), cache_path("index.rds"))

  invisible(TRUE)
}

cache_index <- function() {
  cache_init()
  readRDS(cache_path("index.rds"))
}

cache_set <- function(url, map, name = NULL) {
  if (is.null(name)) {
    name <- paste0(digest::digest(url), '.rds')
  }

  index <- cache_index()

  if (url %in% names(index)) {
    file.remove(index[[url]])
  }
  index[[url]] <- name
  saveRDS(index, cache_path("index.rds"))
  saveRDS(map, cache_path(name))

  invisible(TRUE)
}

cache_get <- function(url) {
  index <- cache_index()
  name <- index[[url]]

  if (is.null(name)) return(NULL)
  readRDS(cache_path(name))
}
