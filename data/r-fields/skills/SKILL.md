---
name: r-fields
description: This tool provides functions for spatial statistics, including Kriging, thin plate splines, and spatial data visualization in R. Use when user asks to fit smooth surfaces to spatial data, perform Gaussian process prediction, estimate covariance parameters, or create spatial plots and images.
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