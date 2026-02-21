---
name: r-shape
description: "Functions for plotting graphical shapes   such as ellipses, circles, cylinders, arrows, ...</p>"
homepage: https://cloud.r-project.org/web/packages/shape/index.html
---

# r-shape

name: r-shape
description: Specialized functions for plotting graphical shapes (ellipses, circles, cylinders, arrows, etc.) and advanced color transitions in R. Use this skill when the user needs to create diagrams, flowcharts, or complex geometric visualizations that require shaded 3D-like effects, rotated shapes, or custom color palettes.

## Overview

The `shape` package provides a set of functions to draw various graphical shapes and handle color gradients. It is particularly useful for creating professional-looking diagrams where shapes need shading, rotation, or specific orientations. It complements the `diagram` package but functions independently for general geometric plotting.

## Installation

To install the package from CRAN:

```R
install.packages("shape")
library(shape)
```

## Core Workflows

### 1. Color Management
The package offers tools for creating smooth transitions and shading effects.

*   `intpalette(colors, numcol)`: Creates a transition between multiple colors.
*   `shadepalette(n, col1, col2)`: Creates a gradient between two colors, ideal for 3D shading.
*   `greycol(n)`: Generates a range of grey colors.
*   `femmecol(n)`: Generates a palette of feminine colors (reds/pinks).

### 2. Drawing Basic Shapes
Most shape functions include parameters for midpoints (`mid`), radii (`rx`, `ry`), and rotation (`angle`).

*   **Ellipses**: `filledellipse(rx1, rx2, dr = 0.1, col)` creates spheres or donuts.
*   **Cylinders**: `filledcylinder(rx, ry, len, angle, col, mid)` draws 3D-looking cylinders.
*   **Rectangles**: `filledrectangle(wx, wy, mid, angle, col)` draws rotated, shaded rectangles.
*   **Multigonals**: `filledmultigonal(rx, ry, nr, mid, angle)` draws regular polygons (e.g., triangles, hexagons).

### 3. Advanced Shapes and Text
*   **Custom Shapes**: `filledshape(xouter, xyinner, col)` fills the area between an outer boundary and an inner point/shape.
*   **Text Flags**: `textflag(mid, radx, rady, lab)` draws text inside a shaded rectangular box.
*   **Arrows**: `Arrows(x0, y0, x1, y1, arr.type)` provides more sophisticated arrowheads ("triangle", "curved", "circle", "ellipse") than base R.

### 4. Coordinate Manipulation
*   `rotatexy(xy, angle, mid)`: Rotates a matrix of coordinates around a midpoint.
*   `emptyplot(xlim, ylim)`: A helper to initialize a blank plotting canvas with specific constraints.

## Examples

### Creating a Shaded Sphere
```R
library(shape)
emptyplot(c(-1, 1))
col <- c(rev(greycol(30)), greycol(30))
filledellipse(rx1 = 1, rx2 = 0.8, dr = 0.1, col = col)
```

### Drawing a Shaded Cylinder
```R
emptyplot(c(-1, 1))
col <- shadepalette("blue", "black", n = 20)
filledcylinder(rx = 0.2, ry = 0.4, len = 1, angle = 45, col = col)
```

### Using Advanced Arrows
```R
plot(0, type = "n", xlim = c(0, 10), ylim = c(0, 10))
Arrows(x0 = 1, y0 = 1, x1 = 8, y1 = 9, 
       arr.length = 0.5, 
       arr.type = "curved", 
       arr.col = "red")
```

## Tips and Best Practices
*   **Aspect Ratio**: When using `rotatexy`, set `asp = TRUE` or `asp = 1` in the plot to ensure shapes do not distort during rotation.
*   **Shading Depth**: The `dr` parameter in filled shapes controls the step size of the gradient. Smaller values result in smoother transitions but slower rendering.
*   **Layering**: Draw shapes from back to front. The package does not handle 3D depth sorting automatically; it follows the standard R painter's model.

## Reference documentation
- [shape: Functions for Plotting Graphical Shapes, Colors](./references/shape.md)