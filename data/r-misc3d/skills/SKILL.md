---
name: r-misc3d
description: The r-misc3d package provides functions for creating 3D plots, isosurfaces, and interactive volumetric slices from 3D data. Use when user asks to render 3D contours, visualize volumetric data using the marching cubes algorithm, plot parametric surfaces, or interactively slice 3D and 4D arrays.
homepage: https://cloud.r-project.org/web/packages/misc3d/index.html
---

# r-misc3d

## Overview
The `misc3d` package provides functions for creating various 3D plots. Its primary strength is rendering isosurfaces (3D contours) from volumetric data using the marching cubes algorithm. It also supports interactive slicing of 3D/4D data and plotting parametric surfaces. It can output to `rgl` (interactive), standard R graphics, or `grid` graphics.

## Installation
```R
install.packages("misc3d")
```

## Core Functions

### Isosurfaces and 3D Contours
`contour3d` is the primary function for rendering surfaces where a 3D array equals a specific value.
- **Basic Usage**: `contour3d(f, level, ...)` where `f` is a 3D array.
- **Engine**: Use `engine = "rgl"` for interactive plots, `engine = "standard"` for static plots, or `engine = "grid"`.
- **Color/Alpha**: Supports `color` and `alpha` (transparency) for layering multiple isosurfaces.

### Volumetric Slicing
`slices3d` provides an interactive Tcl/Tk interface to view slices of 3D or 4D data (like MRI scans).
- **Usage**: `slices3d(vol)`
- **Interaction**: Allows clicking through different planes (axial, sagittal, coronal).

### Parametric Surfaces
`parametric3d` plots surfaces defined by functions of two parameters (u, v).
- **Usage**: `parametric3d(fx, fy, fz, umin, umax, vmin, vmax)`
- **Example**: Useful for tori, spheres, or custom mathematical shapes.

### 3D Image Plots
`image3d` is a 3D analog to the `image()` function.
- It plots points on a 3D grid.
- It uses alpha blending to make "outside" points (lower values) more transparent, highlighting the "core" of the data.

## Common Workflows

### Visualizing a 3D Density
```R
library(misc3d)
# Create a 3D grid
x <- seq(-2, 2, len=30)
g <- expand.grid(x=x, y=x, z=x)
# Calculate a distance-based volume
v <- array(sqrt(g$x^2 + g$y^2 + g$z^2), c(30,30,30))
# Render isosurface at distance 1.5
contour3d(v, level=1.5, color="red", alpha=0.5, engine="rgl")
```

### Combining Multiple Isosurfaces
You can layer surfaces to show nested structures:
```R
contour3d(v, level=c(1, 1.5), color=c("blue", "red"), 
          alpha=c(0.3, 0.5), engine="rgl")
```

## Tips and Best Practices
- **Dependencies**: For interactive 3D, ensure the `rgl` package is installed. For `slices3d`, the `tkrplot` package is required.
- **Memory**: Large 3D arrays can be memory-intensive. Downsample data if the marching cubes algorithm is too slow.
- **Lighting**: When using `engine = "standard"`, use `light` and `shade` arguments to improve depth perception.
- **Exporting**: Surfaces created with `contour3d` can be converted to mesh objects for further manipulation or export to formats like STL.

## Reference documentation
- [README](./references/README.md)
- [home_page](./references/home_page.md)