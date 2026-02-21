---
name: r-fields
description: "For curve, surface and function fitting with an emphasis  on splines, spatial data, geostatistics, and spatial statistics. The major  methods  include  Gaussian spatial process prediction (known as Kriging), cubic and thin plate splines, and compactly supported  covariance functions for large data sets. The spline and spatial process  methods are  supported by functions that can determine the smoothing parameter  (nugget and sill variance) and other covariance function parameters by cross  validation and also by  maximum likelihood. For spatial process prediction  there is an easy to use function that also estimates the correlation  scale (range parameter).  A major feature is that any covariance function  implemented in R and following a simple format can be used for  spatial prediction. As included are fast approximations for prediction  and conditional simulation for larger data sets.  There are also many useful functions for plotting  and working with spatial data as images. This package also contains  an implementation of sparse matrix methods for large spatial data  sets based the  R sparse matrix package spam. Use  help(fields) to get started and for an overview. All package graphics functions  focus on  extending base R graphics and are easy to interpret and modify.  The fields source  code is deliberately commented and provides useful explanations of  numerical details as a companion to the manual pages. The commented  source code can be viewed by expanding the source code version of this package  and looking in the R subdirectory."
homepage: https://cloud.r-project.org/web/packages/fields/index.html
---

# r-fields

name: r-fields
description: Tools for curve, surface, and function fitting with an emphasis on splines, spatial data, geostatistics, and spatial statistics. Use this skill when performing Gaussian spatial process prediction (Kriging), thin plate splines, or working with large spatial datasets using sparse matrix methods. It is ideal for estimating smoothing parameters (nugget/sill) via cross-validation or MLE and for creating spatial plots and images in R.

## Overview

The `fields` package is a comprehensive suite for spatial statistics in R. It focuses on the "spatial process" model (Kriging) and Tps (Thin Plate Splines). It is designed to handle everything from small datasets to large-scale spatial data using compactly supported covariance functions and sparse matrix algebra (via the `spam` package).

## Installation

```R
install.packages("fields")
```

## Core Workflows

### 1. Surface Fitting with Thin Plate Splines (Tps)
Use `Tps` for fitting a smooth surface to irregularly spaced data without assuming a specific covariance model.

```R
library(fields)
# Fit a thin plate spline
obj <- Tps(x, y) # x is a matrix of coordinates, y is the response
# Predict on a grid
surface(obj)
```

### 2. Spatial Process Estimation (Kriging)
Use `spatialProcess` for a high-level interface to Kriging. It automatically estimates the range parameter and smoothing parameters.

```R
# Fit a spatial process model (Matern covariance by default)
fit <- spatialProcess(x, y)

# Summary of parameters (nugget, sill, range)
summary(fit)

# Spatial prediction (Kriging)
out <- predictSurface(fit)
surface(out) # Plot the interpolated surface
```

### 3. Working with Images and Grids
`fields` provides robust tools for visualizing spatial data.

- `image.plot`: Draws an image with a color scale (legend strip).
- `as.image`: Converts irregular spatial data to a grid/image format.
- `quilt.plot`: Plots irregular points as colored squares, useful for visualizing data density before interpolation.
- `world`: Adds low-resolution coastal outlines to a plot.

```R
# Example of image.plot
image.plot(x, y, z)
world(add=TRUE)
```

### 4. Large Datasets
For large datasets where standard Kriging is computationally prohibitive:
- Use `mKrig` (micro-Kriging) for more control over the linear algebra.
- Use compactly supported covariance functions (e.g., `wendland.cov`) to induce sparsity.
- Use `fastTps` for a version of thin plate splines optimized for many points.

## Key Functions Reference

| Function | Purpose |
| :--- | :--- |
| `spatialProcess` | Fits a spatial process model, estimating covariance parameters. |
| `Tps` | Fits a thin plate spline surface. |
| `predictSurface` | Evaluates a fitted model on a grid for plotting. |
| `rdist` | Calculates Euclidean distance matrix (efficiently). |
| `vgram` | Computes an empirical variogram. |
| `interp.surface` | Bilinear interpolation of a gridded surface to new locations. |

## Tips
- **Coordinates**: Most functions expect coordinates as a matrix `x` where each row is a location (e.g., Lon/Lat).
- **Smoothing**: In `spatialProcess`, the "lambda" parameter represents the ratio of the nugget variance to the process variance.
- **Color Scales**: Use `tim.colors()` for the classic fields color palette.

## Reference documentation
- [README](./references/README.md)