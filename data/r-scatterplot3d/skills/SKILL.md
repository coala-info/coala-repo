---
name: r-scatterplot3d
description: This R package generates 3D scatter plots and point clouds using parallel projection. Use when user asks to visualize three-dimensional data, add regression planes to 3D space, or create 3D barplots.
homepage: https://cloud.r-project.org/web/packages/scatterplot3d/index.html
---

# r-scatterplot3d

name: r-scatterplot3d
description: Create 3D scatter plots and point clouds in R using parallel projection. Use this skill when visualizing multivariate data with three continuous variables, adding regression planes to 3D space, or creating 3D barplots.

## Overview
The `scatterplot3d` package provides a high-level function for visualizing 3D data in a 2D graphics device using parallel projection. It is designed to be consistent with base R graphics and is highly extensible through function closures returned by the main call.

## Installation
```R
install.packages("scatterplot3d")
library(scatterplot3d)
```

## Core Function: scatterplot3d()
The primary function is `scatterplot3d(x, y, z, ...)`. It accepts individual vectors, a formula (`z ~ x + y`), a matrix with 3 columns, or a data frame.

### Key Arguments
- `type`: Plot type ("p" for points, "l" for lines, "h" for vertical lines to x-y plane).
- `highlight.3d`: Logical; if TRUE, points are colored based on their y-coordinates.
- `angle`: Angle between x and y axis (default 40). Adjust to change the viewing perspective.
- `scale.y`: Scale of y-axis relative to x and z (default 1).
- `pch`: Plotting symbol. Use `pch = 16` or `pch = 20` for solid circles.
- `grid`: Logical; whether to draw a grid on the x-y plane.
- `box`: Logical; whether to draw a box around the plot.

## Extensibility and Function Closures
A unique feature of `scatterplot3d` is that it returns a list of functions (closures) that "know" the projection of the current plot. Assign the output to a variable to use them:

```R
s3d <- scatterplot3d(x, y, z)
```

### Returned Functions
- `s3d$xyz.convert(x, y, z)`: Converts 3D coordinates to 2D projection coordinates. Useful for adding custom text or legends.
- `s3d$points3d(x, y, z, ...)`: Adds points or lines to the existing 3D plot.
- `s3d$plane3d(Intercept, x.coef, y.coef, ...)`: Adds a regression plane. Can accept an `lm` object directly.
- `s3d$box3d()`: Refreshes or redraws the box around the plot.

## Common Workflows

### Basic 3D Plot with Highlighting
```R
z <- seq(-10, 10, 0.01)
x <- cos(z)
y <- sin(z)
scatterplot3d(x, y, z, highlight.3d = TRUE, pch = 20, main = "3D Helix")
```

### Adding a Regression Plane
```R
data(trees)
s3d <- scatterplot3d(trees$Girth, trees$Height, trees$Volume, 
                     type = "h", pch = 16, color = "blue")
fit <- lm(Volume ~ Girth + Height, data = trees)
s3d$plane3d(fit, lty.box = "solid")
```

### Creating a 3D Barplot
To create bars, use `type = "h"` with a large line width and no point symbols.
```R
# Assuming a data frame 'df' with x, y, and z (value)
scatterplot3d(df, type = "h", lwd = 5, pch = " ", 
              main = "3D Barplot", color = "steelblue")
```

### Adding Custom Elements
Use `xyz.convert` to place 2D elements (like legends or text) accurately within the 3D projection.
```R
s3d <- scatterplot3d(x, y, z)
text(s3d$xyz.convert(x_coord, y_coord, z_coord), labels = "Target Point", pos = 4)
```

## Tips for Better Plots
- **Point Clarity**: Use `pch = 16` (solid circle) for better visibility in 3D space.
- **Depth Perception**: Use `type = "h"` (vertical lines) to help the viewer locate points relative to the x-y plane.
- **Margins**: If the plot looks cramped, manually set `mar = c(5, 3, 4, 3) + 0.1` within the function call.
- **Rotation**: Since the plot is static, generate multiple plots with different `angle` values to find the best perspective.

## Reference documentation
- [Scatterplot3d – an R package for Visualizing Multivariate Data](./references/s3d.md)