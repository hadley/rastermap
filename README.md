# rastermap

[![Travis-CI Build Status](https://travis-ci.org/hadley/rastermap.svg?branch=master)](https://travis-ci.org/hadley/rastermap)

This package provides a simple API to retrieve a raster image (i.e. a matrix of RGB colours) from a map server.

rastermap is not currently available on CRAN, please install with:

```R
# install.packages("devtools")
devtools::install_github("hadley/rastermap")
```

## Examples

```R
houston <- fetch_region(c(-95.80204, -94.92313), c(29.38048, 30.14344),
  stamen("terrain"))
houston
plot(houston)
```

## Caching

To avoid downloading the same maps again and again, rastermap locally caches the you've downloaded. By default, they will be stored in a session specific temporary directory which will be deleted each time you quit R. If you want them to persist across sessions, set the global option "rastermap.cache".
