# Latitude/longitude conversions
# Written by David Kahle

LonLat2XY <- function(lon_deg, lat_deg, zoom, xpix=256, ypix=256){
  n <- 2^zoom
  X <- ((lon_deg + 180) / 360) * n
  lat_rad <- lat_deg * pi/180
  Y <- (1 - (log(tan(lat_rad) + sec(lat_rad)) / pi)) / 2 * n
  df <- data.frame(
    X = floor(X),
    Y = floor(Y),
    x = xpix*(X - floor(X)),
    y = xpix*(Y - floor(Y))
  )
  row.names(df) <- NULL
  df
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


sec <- function(x) 1/cos(x)
