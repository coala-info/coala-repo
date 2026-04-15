---
name: r-wicket
description: The r-wicket package provides high-performance R functions for validating, manipulating, and extracting information from Well-Known Text (WKT) geospatial data. Use when user asks to validate WKT strings, extract bounding boxes or centroids, convert coordinates to WKT, or transform sp objects into WKT format.
homepage: https://cloud.r-project.org/web/packages/wicket/index.html
---

# r-wicket

## Overview
`wicket` is an R package designed for efficient geospatial data manipulation, specifically focusing on Well-Known Text (WKT). It provides high-performance C++ based functions to validate WKT strings, generate bounding boxes, extract coordinates/centroids, and convert `sp` objects into WKT format.

## Installation
```R
install.packages("wicket")
```

## Core Workflows

### WKT Validation
Use `validate_wkt()` to check if WKT strings are syntactically correct or have orientation issues. It returns a data.frame with validity status and error comments.
```R
wkt <- c("POLYGON ((30 10, 40 40, 20 40, 10 20, 30 10))", "INVALID WKT")
validate_wkt(wkt)
```

### Bounding Boxes
*   **Extract from WKT:** `wkt_bounding()` takes WKT strings and returns a data.frame/matrix of min/max coordinates.
*   **Generate WKT from Coordinates:** `bounding_wkt()` converts R bounding box values into WKT POLYGONs.
```R
# WKT to R Bounding Box
wkt_bounding("LINESTRING (30 10, 10 90, 40 40)")

# R Coordinates to WKT
bounding_wkt(min_x = 10, min_y = 10, max_x = 40, max_y = 40)
```

### Coordinate and Centroid Extraction
*   **Coordinates:** `wkt_coords()` flattens WKT objects into a data.frame of longitude and latitude, identifying the object index and ring (inner/outer).
*   **Centroids:** `wkt_centroid()` calculates the geometric center of WKT objects.
```R
wkt <- "POLYGON ((30 10, 40 40, 20 40, 10 20, 30 10))"
wkt_coords(wkt)
wkt_centroid(wkt)
```

### Converting sp Objects
`sp_convert()` transforms `SpatialPolygons` or `SpatialPolygonsDataFrame` objects into WKT strings.
*   Set `group = TRUE` to generate a `MULTIPOLYGON`.
*   Set `group = FALSE` to generate a vector of individual `POLYGON` strings.
```R
library(sp)
# Assuming 'sp_object' is a SpatialPolygons object
wkt_strings <- sp_convert(sp_object, group = TRUE)
```

## Tips
*   **Performance:** The package uses C++ (via Rcpp) for parsing, making it significantly faster than pure R regex-based WKT parsers for large datasets.
*   **Orientation:** `validate_wkt` is particularly useful for identifying polygons that have a different winding order (orientation) than the default expected by many GIS systems.

## Reference documentation
- [Introduction to Wicket](./references/Introduction.Rmd)
- [Wicket README](./references/README.md)