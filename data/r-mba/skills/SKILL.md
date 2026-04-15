---
name: r-mba
description: This tool performs fast multilevel B-spline interpolation for scattered 2D data. Use when user asks to interpolate irregularly spaced data, create smooth surfaces from scattered points, or estimate values at specific coordinates using B-splines.
homepage: https://cran.r-project.org/web/packages/mba/index.html
---

# r-mba

name: r-mba
description: Multilevel B-Spline Approximation (MBA) for fast interpolation of scattered data. Use this skill when you need to create smooth surfaces from irregularly spaced 2D data points or interpolate values at specific locations using B-splines.

# r-mba

## Overview
The `MBA` package provides functions for interpolating irregularly and regularly spaced data using Multilevel B-spline Approximation. It is particularly effective for surface reconstruction from scattered data points, implementing the fast algorithm developed by Lee, Wolberg, and Shin (1997).

## Installation
Install the package from CRAN:
```R
install.packages("MBA")
```

## Core Functions

### Surface Interpolation with `mba.surf`
Use `mba.surf` to create a grid of interpolated values from scattered data.

```R
# xyz: a 3-column matrix or data frame (x, y, z)
# no.X, no.Y: resolution of the output grid
# n, m: initial size of the control lattice (usually small, e.g., 1)
# h: number of levels in the multilevel hierarchy
result <- mba.surf(xyz_data, no.X = 100, no.Y = 100, n = 1, m = 1, h = 8)

# The output is a list compatible with image(), contour(), and persp()
image(result$xyz.est)
```

### Point Interpolation with `mba.points`
Use `mba.points` to estimate values at specific coordinates rather than a full grid.

```R
# xy.est: a 2-column matrix of coordinates where you want estimates
estimates <- mba.points(xyz_data, xy.est)
```

## Workflow Example
1. **Prepare Data**: Ensure your data is in a three-column format (X, Y, and the value Z).
2. **Define Lattice**: Set `n` and `m` (initial control lattice size). A value of 1 is a common starting point.
3. **Set Levels**: Set `h`. Increasing `h` allows the spline to capture finer details but may lead to overfitting if the data is noisy.
4. **Execute**: Run `mba.surf`.
5. **Visualize**: Use standard R plotting functions to inspect the surface.

## Tips
- **Data Range**: The algorithm works best when the input coordinates are scaled or well-distributed.
- **Memory**: For very large datasets, `mba.surf` is significantly faster than many kriging or thin-plate spline implementations.
- **Extrapolation**: B-splines can extrapolate, but results outside the convex hull of the input data should be treated with caution.

## Reference documentation
- [MBA: Multilevel B-Spline Approximation](./references/home_page.md)