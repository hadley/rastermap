# Latitude/longitude conversions
# Written by David Kahle

lonlat2xy <- function(lon, lat, zoom = 10) {
  cbind(lon2x(lon, zoom), lat2y(lat, zoom))
}

lon2x <- function(lon, zoom) {
  n <- 2 ^ zoom

  X <- ((lon + 180) / 360) * n
  data.frame(
    X = floor(X),
    x = floor(256 * (X - floor(X)))
  )
}

lat2y <- function(lat, zoom) {
  n <- 2 ^ zoom

  lat_rad <- lat * pi / 180
  Y <- (1 - (log(tan(lat_rad) + sec(lat_rad)) / pi)) / 2 * n

  data.frame(
    Y = floor(Y),
    y = floor(256 * (Y - floor(Y)))
  )
}


sec <- function(x) 1 / cos(x)
