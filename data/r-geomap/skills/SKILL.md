---
name: r-geomap
description: r-geomap is an R package for topographic and geologic mapping, coordinate projections, and spatial data visualization. Use when user asks to perform map projections, convert coordinates between geographic and Cartesian systems, create topographic or perspective plots, or handle geological map symbols.
homepage: https://cran.r-project.org/web/packages/geomap/index.html
---

# r-geomap

name: r-geomap
description: Specialized R package for topographic and geologic mapping. Use this skill to perform map projections (forward and inverse), create topographic maps, generate perspective plots, and handle geological map symbols or databases. It is particularly useful for geophysical and geological spatial data visualization.

## Overview
GEOmap is a comprehensive R package designed for Earth Science applications. It provides robust routines for map projections, topographic plotting, and interactive selection of focus regions. It integrates well with other geophysical packages like RSEIS and RFOC.

## Installation
To install the package from CRAN, use:
install.packages("GEOmap")

## Core Workflows

### Initialize Projections
Define the projection parameters before converting coordinates or plotting.
- Use `setPROJ` to establish the projection type (e.g., 1 for Lambert, 2 for UTM).
- Parameters typically include `type`, `LAT0`, `LON0`, and `FE` (False Easting).

### Coordinate Conversion
Convert between geographic (Latitude/Longitude) and projected (X, Y) coordinates.
- Use `GLOB.XY` for forward projection (Lat/Lon to Cartesian).
- Use `XY.GLOB` for inverse projection (Cartesian to Lat/Lon).
- Ensure the projection is set via `setPROJ` or passed as a list to these functions.

### Mapping and Plotting
- Use `plotGEOmap` to render map data stored in GEOmap format.
- Use `plotGEOmapXY` to plot maps in projected coordinates.
- Add geological symbols using `geolXY` or standard R plotting functions after coordinate conversion.
- Create perspective plots of topographic data using `persp` or specialized wrappers within the package.

### Data Structures
GEOmap often uses a specific list structure for map data:
- `STROKES`: A list containing metadata for map lines (color, type, number of points).
- `POINTS`: A list containing `lat`, `lon`, and `z` values.
- Use `getGEOmap` to load or subset map databases.

### Interactive Selection
- Use `swath.GEOmap` for interactive selection of data along a profile.
- Use `LOCATE` (from the RPMG dependency) to interactively pick points on a map for zooming or identification.

## Tips and Best Practices
- Always check the aspect ratio of plots using `asp = 1` to ensure geographic features are not distorted.
- When working with large datasets, use the `sf` package integration for faster spatial operations before passing data to GEOmap for specialized plotting.
- Combine with the `geomapdata` package to access high-resolution global and regional map datasets.
- Use `rect2latlon` and `latlon2rect` to quickly define bounding boxes for map clipping.

## Reference documentation
- [GEOmap: Topographic and Geologic Mapping](./references/home_page.md)