---
name: r-deldir
description: The r-deldir package computes Delaunay triangulations and Dirichlet (Voronoi) tessellations for spatial data analysis in R. Use when user asks to calculate tile areas, perform Lloyd's algorithm for centroidal Voronoi tessellations, or visualize planar partitions from a set of points.
homepage: https://cloud.r-project.org/web/packages/deldir/index.html
---

# r-deldir

## Overview
The `deldir` package is a specialized R tool for computing Delaunay triangulations and Dirichlet (Voronoi) tessellations. It is widely used in spatial analysis to partition a plane based on a set of points. Key capabilities include calculating tile areas, perimeters, and adjacency information, as well as implementing Lloyd's algorithm for centroidal Voronoi tessellations.

## Installation
To install the package from CRAN:
```R
install.packages("deldir")
```

## Core Workflow

### 1. Basic Triangulation and Tessellation
The primary function is `deldir()`, which accepts x and y coordinates.
```R
library(deldir)

# Sample data
set.seed(42)
x <- runif(20)
y <- runif(20)

# Compute triangulation and tessellation
vt <- deldir(x, y)

# The result contains:
# vt$delsgs: Delaunay segments
# vt$dirsgs: Dirichlet (Voronoi) segments
# vt$summary: Summary of each tile (area, etc.)
```

### 2. Visualization
The package provides specialized plotting methods for the objects returned by `deldir()`.
```R
# Plot both triangulation and tessellation
plot(vt, wlines="both", pch=16)

# Plot only Voronoi tiles
plot(vt, wlines="tess", col=c(1,2))

# Plot only Delaunay triangulation
plot(vt, wlines="triang", lty=2)
```

### 3. Extracting Tile Information
Use `tile.list()` to extract individual tile geometries, which is useful for calculating perimeters or centroids.
```R
tiles <- tile.list(vt)

# Calculate perimeters of all tiles
perims <- tilePerim(tiles)

# Get area of the 5th tile
area_5 <- vt$summary$dir.area[5]
```

### 4. Centroidal Voronoi Tessellation (Lloyd's Algorithm)
To create more "even" partitions, use `centroid.evolve()` or the `cvt()` function.
```R
# Perform 10 iterations of Lloyd's algorithm
cvt_result <- cvt(x, y, ntiles=20, iters=10)
plot(cvt_result)
```

## Advanced Features

### Clipping to Windows
By default, `deldir` uses the bounding box of the points. You can specify a custom rectangular window using the `rw` argument.
```R
# Define rectangular window: c(xmin, xmax, ymin, ymax)
vt_clipped <- deldir(x, y, rw=c(0, 1, 0, 1))
```

### Handling Dummy Points
You can include "dummy points" to influence the tessellation at the boundaries without them being part of the primary data set using the `dpx` and `dpy` arguments.

## Tips and Best Practices
- **Duplicate Points:** `deldir` will automatically remove duplicate points and issue a warning.
- **Precision:** For very large coordinates or very small distances, consider scaling your data to avoid numerical instability in the underlying Fortran code.
- **Spatial Integration:** While `deldir` is standalone, its outputs are often converted for use in `spatstat` or `sf` for more complex spatial modeling.

## Reference documentation
- [deldir: Delaunay Triangulation and Dirichlet (Voronoi) Tessellation](./references/home_page.md)