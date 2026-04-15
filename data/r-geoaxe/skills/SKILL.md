---
name: r-geoaxe
description: This R package subdivides large geospatial objects into smaller, more manageable pieces for easier processing or API compatibility. Use when user asks to chop spatial polygons, split WKT strings into smaller chunks, or subdivide GeoJSON objects.
homepage: https://cran.r-project.org/web/packages/geoaxe/index.html
---

# r-geoaxe

## Overview
`geoaxe` is an R package designed to "chop" or subdivide geospatial objects into smaller pieces. This is particularly useful for interacting with web APIs that have limits on the length of Well-Known Text (WKT) strings or for processing large spatial geometries in smaller, more manageable chunks. It supports `SpatialPolygons`, `SpatialPolygonsDataFrame`, WKT strings, and GeoJSON.

## Installation
Install the package from CRAN:
```r
install.packages("geoaxe")
```

## Core Workflows

### Chopping Spatial Objects
The primary function is `chop()`. It takes a spatial object and returns a subdivided version of that object.

```r
library(geoaxe)
library(sp)
library(rgeos)

# Define a WKT polygon
wkt <- "POLYGON((-180 -20, -140 55, 10 0, -140 -60, -180 -20))"

# Chop into pieces
chopped_polys <- chop(wkt)

# Plotting to visualize the grid
plot(rgeos::readWKT(wkt), lwd = 5)
plot(chopped_polys, add = TRUE)
```

### Controlling Subdivision Density
You can control how the object is split using either the `n` parameter (number of cells) or the `size` parameter (cell size).

**By Number of Cells (`n`):**
```r
# Split into approximately 50 cells
chopped_50 <- chop(wkt, n = 50)
plot(chopped_50)
```

**By Cell Size (`size`):**
```r
# Split into cells of 5x5 units
chopped_size_5 <- chop(wkt, size = 5)
plot(chopped_size_5)
```

### Supported Input Formats
- **WKT**: Character strings representing Well-Known Text.
- **Spatial Objects**: `SpatialPolygons` and `SpatialPolygonsDataFrame` (from the `sp` package).
- **GeoJSON**: Character strings or list representations of GeoJSON.

## Tips and Best Practices
- **API Limits**: If a web service rejects a query because the geometry is too complex (too many vertices), use `chop()` to create multiple smaller requests.
- **Visualization**: When plotting chopped objects, the result is typically a `SpatialPolygons` object where each "chip" is a separate polygon in the collection.
- **Dependencies**: `geoaxe` relies on `sp` and `rgeos` for spatial operations; ensure these are loaded if you are performing manual spatial manipulations on the output.

## Reference documentation
- [geoaxe introduction](./references/geoaxe.Rmd)
- [README](./references/README.md)