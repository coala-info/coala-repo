---
name: r-splancs
description: The r-splancs package provides tools for the display and analysis of spatial and space-time point pattern data. Use when user asks to analyze spatial point patterns, calculate Ripley's K-function, perform kernel density estimation, or test for space-time clustering and interaction.
homepage: https://cran.r-project.org/web/packages/splancs/index.html
---

# r-splancs

## Overview
The `splancs` package is a foundational R library for the display and analysis of spatial point pattern data. Originally developed for S-Plus, it provides tools for point pattern analysis, including polygon manipulation, kernel smoothing, and space-time clustering. It is particularly useful for epidemiological and ecological spatial studies.

## Installation
To install the package from CRAN:
```R
install.packages("splancs")
library(splancs)
```

## Core Workflows

### 1. Data Preparation and Polygons
`splancs` uses two-column matrices (x, y) for point patterns and polygons.
- **Define a study area**: Create a matrix of vertices where the first and last rows are identical.
- **Check points in polygon**: Use `inout(pts, poly)` to filter points.
- **Generate random points**: Use `csr(poly, n)` to generate Complete Spatial Randomness points within a boundary.

### 2. Spatial Point Pattern Analysis
- **Kernel Density**: `kernel2d(pts, poly, h, nx, ny)` calculates a fixed bandwidth kernel density estimate.
- **K-Function**: `khat(pts, poly, s)` calculates Ripley's K-function for various distances `s`.
- **Envelopes**: `kenv.csr(n, poly, s, nsim)` generates simulation envelopes under CSR to test for clustering.

### 3. Space-Time Analysis
`splancs` is well-known for its space-time interaction functions:
- **STK-Function**: `stkhat(pts, times, poly, s, t)` calculates the combined space-time K-function.
- **Space-Time Interaction Test**: `stse(pts, times, poly, s, t, nsim)` provides standard errors for the space-time K-function via simulations.
- **Knox Test**: `knox(pts, times, s, t)` performs the Knox test for space-time adjacency.

### 4. Visualization
- **Point Plots**: `pointmap(pts)` or `polymap(poly)`.
- **Perspective/Contour**: Use `persp()` or `contour()` on the output of `kernel2d`.
- **Shifting**: `shift(pts, vec)` to translate point patterns.

## Usage Tips
- **Coordinate Precision**: Ensure your polygon coordinates are closed (first point equals last point) to avoid errors in area-based calculations.
- **Bandwidth Selection**: For `kernel2d`, the parameter `h` (quartic kernel) is sensitive; use `mse2d` to help estimate an optimal bandwidth via mean square error.
- **Memory**: Since the package is in maintenance mode and uses older Fortran routines, very large point patterns (e.g., >100,000 points) may require significant memory or pre-processing.

## Reference documentation
- [Splancs Home Page](./references/home_page.md)