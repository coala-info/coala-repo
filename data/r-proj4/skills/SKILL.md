---
name: r-proj4
description: This tool performs cartographic projections and datum transformations in R using the PROJ.4 library. Use when user asks to convert geographic coordinates to projected coordinates, transform data between different coordinate reference systems, or perform datum shifts.
homepage: https://cloud.r-project.org/web/packages/proj4/index.html
---

# r-proj4

name: r-proj4
description: Perform cartographic projections and datum transformations in R using the PROJ.4 library. Use this skill when you need to convert geographic coordinates (latitude/longitude) to projected coordinates, or transform data between different coordinate reference systems (CRS) and datums.

## Overview
The `proj4` package provides a streamlined R interface to the PROJ.4 library. It is primarily used for two tasks: projecting raw geographic coordinates into Cartesian space (and vice versa) and transforming coordinates between different datums or projections. It is a lightweight alternative to larger spatial packages when only coordinate transformation is required.

## Installation
To install the package from CRAN:
```R
install.packages("proj4")
library(proj4)
```

## Core Functions

### project()
Converts between geographic (lat/long) and projected coordinates.
- **Forward Projection**: `project(xy, proj, inverse = FALSE)`
- **Inverse Projection**: `project(xy, proj, inverse = TRUE)`

**Arguments:**
- `xy`: A list, matrix, or data frame with two columns (longitude/latitude or x/y).
- `proj`: A character string defining the PROJ.4 projection parameters (e.g., `"+proj=utm +zone=33 +ellps=WGS84"`).

### ptransform()
Performs more complex transformations, including datum shifts.
- `ptransform(data, src.proj, dst.proj)`

**Arguments:**
- `data`: Coordinates to transform (3-column matrix or list for x, y, z).
- `src.proj`: The source projection definition.
- `dst.proj`: The destination projection definition.

## Workflows

### Simple Forward Projection
Convert decimal degrees to UTM coordinates:
```R
library(proj4)
# Coordinates: Longitude, Latitude
coords <- cbind(13.4050, 52.5200) 
# Define UTM Zone 33N
params <- "+proj=utm +zone=33 +ellps=WGS84"
projected <- project(coords, params)
```

### Datum Transformation
Transform coordinates from one specific CRS to another:
```R
src <- "+init=epsg:4326" # WGS84
dst <- "+init=epsg:28992" # Amersfoort / RD New
# Input must be in radians for ptransform if using raw proj strings, 
# or handled via project() for degrees.
# Note: ptransform expects a 3-column matrix (x, y, z)
input <- matrix(c(4.89, 52.37, 0), ncol=3)
transformed <- ptransform(input, src, dst)
```

## Tips
- **Coordinate Order**: Always ensure input is in `x, y` order (Longitude, then Latitude).
- **Units**: `project()` handles degrees by default. If using `ptransform()` with raw PROJ.4 strings, ensure you account for whether the library expects radians or degrees based on the projection string.
- **Projection Strings**: You can find PROJ.4 strings for specific EPSG codes at spatialreference.org.

## Reference documentation
- [About proj4](./references/home_page.md)
- [Package Index](./references/index.html.md)