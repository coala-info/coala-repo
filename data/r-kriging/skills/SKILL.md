---
name: r-kriging
description: An implementation of a simple and highly optimized ordinary kriging algorithm to plot geographical data.</p>
homepage: https://cloud.r-project.org/web/packages/kriging/index.html
---

# r-kriging

## Overview
The `kriging` package provides a simple and highly optimized implementation of the ordinary kriging algorithm. It is designed to interpolate values from a set of points with known coordinates (x, y) and values (z) onto a regular grid, which is essential for creating smooth contour plots or heatmaps from scattered geographical data.

## Installation
```R
install.packages("kriging")
```

## Main Functions

### `kriging(x, y, response, ...)`
The primary function to perform ordinary kriging.
- `x`: Vector of x-coordinates (longitude/easting).
- `y`: Vector of y-coordinates (latitude/northing).
- `response`: Vector of values at the specified coordinates.
- `model`: The variogram model to use (default is "spherical"). Options include "spherical", "exponential", "gaussian".
- `pixels`: Number of pixels for the output grid (default is 40).
- `polygons`: Optional polygons to clip the interpolation grid.

### `image(x, ...)`
The package provides an S3 method for `image` to quickly visualize the results of a kriging object.

## Workflow Example

### Basic Interpolation and Plotting
```R
library(kriging)

# 1. Prepare data
x <- runif(20)
y <- runif(20)
z <- x + y + rnorm(20, 0, 0.1)

# 2. Perform ordinary kriging
# This creates a grid of interpolated values
krig_res <- kriging(x, y, z, pixels = 50, model = "spherical")

# 3. Visualize the result
image(krig_res, main = "Ordinary Kriging Interpolation")
```

### Accessing Results
The object returned by `kriging()` contains:
- `map`: A data frame containing the grid coordinates (`x`, `y`) and the predicted values (`z`).
- `model`: Details about the fitted variogram model.

## Tips
- **Optimization**: This package is specifically optimized for speed compared to more complex spatial packages like `gstat`, making it ideal for simple interpolation tasks.
- **Grid Density**: Increase the `pixels` argument for smoother visualizations, though this increases computation time.
- **Data Scaling**: Ensure that x and y coordinates are in the same units (e.g., meters or decimal degrees) for accurate distance calculations within the kriging algorithm.

## Reference documentation
- [kriging: Ordinary Kriging](./references/home_page.md)