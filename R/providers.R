# With help from
# https://github.com/leaflet-extras/leaflet-providers/blob/master/leaflet-providers.js

osm_license <- paste0('<a href="http://openstreetmap.org">OpenStreetMap</a>,',
  '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>')

#' Create a new provider.
#'
#' A provider wrappers a tile function with attribution details.
#'
#' @param tile_f A tile function has inputs x, y and z and returns
#'   a url.
#' @param attr_title,attr_data Attribution information for rendered tiles
#'   and underlying data.
#' @export
#' @keywords internal
provider <- function(tile_f, attr_tile, attr_data = osm_license) {
  structure(
    list(
      tile_f = tile_f,
      attr_tile = attr_tile,
      attr_data = attr_data
    ),
    class = "slippymap_provider"
  )
}


# ------------------------------------------------------------------------------

#' Built-in tile set providers
#'
#' @name providers
NULL


#' @export
#' @rdname providers
#' @param style Map style.
stamen <- function(style = "terrain") {
  provider(
    function(x, y, z) {
      sprintf("http://tile.stamen.com/%s/%i/%i/%i.png", style, z, x, y)
    },
    paste0('<a href="http://stamen.com">Stamen Design</a>',
      '(<a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a>')
  )
}

#' @export
#' @rdname providers
open_street_map <- function() {
  provider(
    function(x, y, z) {
      sprintf('http://a.tile.openstreetmap.org/%i/%i/%i.png', x, y, z)
    },
    osm_license
  )
}

#' @export
#' @rdname providers
#' @param key api key
cloudmade <- function(style, key) {
  provider(
    function(x, y, z) {
      sprintf("http://tile.cloudmade.com/%s/%s/256/%i/%i/%i.png", key, style, z, x, y)
    },
    ""
  )
}

#' @export
#' @rdname providers
cartodo <- function() {
  provider(
    function(x, y, z, style = "terrain") {
      sprintf("http://basemaps.cartocdn.com/%s/%i/%i/%i.png", style, z, x, y)
    },
    "&copy <a href='CartoDb'>http://cartodb.com/attributions</a>"
  )
}
