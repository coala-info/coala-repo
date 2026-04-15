---
name: r-viridislite
description: The r-viridislite tool generates colorblind-friendly and perceptually-uniform color palettes for R programming. Use when user asks to generate accessible color maps, create hex color codes for R graphics, or implement lightweight viridis scales that remain readable in grayscale.
homepage: https://cloud.r-project.org/web/packages/viridisLite/index.html
---

# r-viridislite

name: r-viridislite
description: Create colorblind-friendly, perceptually-uniform color maps using the viridisLite R package. Use this skill when a user needs to generate color palettes for R graphics (base R, ggplot2, lattice) that remain readable in black-and-white and are accessible to individuals with color vision deficiencies.

# r-viridislite

## Overview

The `viridisLite` package provides the base functionality for the viridis color scales. These scales are designed to be:
1. **Perceptually uniform**: Changes in the data map to equal changes in perceived color.
2. **Colorblind friendly**: Optimized for various forms of color blindness.
3. **Print friendly**: Maintain structure and contrast when converted to grayscale.

This "Lite" version contains the core color generators without the heavy dependencies of the full `viridis` package (like `ggplot2` specific scales), making it ideal for lightweight applications and package development.

## Installation

```R
install.packages("viridisLite")
```

## Core Functions

All functions return a character vector of hex color codes.

### The viridis() Function
The primary function for generating colors.
```R
viridis(n, alpha = 1, begin = 0, end = 1, direction = 1, option = "D")
```
- `n`: Number of colors to return.
- `alpha`: Transparency (0 to 1).
- `begin`/`end`: The range within the palette to use (0 to 1).
- `direction`: `1` for dark-to-light (default), `-1` to reverse.
- `option`: A string or letter code for the palette.

### Available Palettes
You can use the `option` argument in `viridis()` or use the convenience functions:
- `magma()` (Option "A"): Darker, high contrast (purple-orange-yellow).
- `inferno()` (Option "B"): Similar to magma but "hotter" (black-red-yellow).
- `plasma()` (Option "C"): High intensity (blue-violet-red-yellow).
- `viridis()` (Option "D"): The standard green-blue-yellow scale.
- `cividis()` (Option "E"): Optimized specifically for color vision deficiency.
- `rocket()` (Option "F"): Dark purple to pale yellow.
- `mako()` (Option "G"): Dark blue to pale green.
- `turbo()` (Option "H"): An improved, perceptually uniform rainbow map.

## Usage Examples

### Base R Plotting
```R
library(viridisLite)

# Use in a standard image plot
n <- 100
image(matrix(1:n^2, n), col = viridis(256))

# Use in a scatter plot
plot(iris$Sepal.Length, iris$Sepal.Width, 
     col = viridis(3)[as.numeric(iris$Species)], 
     pch = 19)
```

### Integration with ggplot2
While `viridisLite` doesn't contain `scale_fill_viridis_d()`, you can use the hex codes directly:
```R
library(ggplot2)
library(viridisLite)

ggplot(mtcars, aes(x = mpg, y = wt, color = factor(cyl))) +
  geom_point(size = 3) +
  scale_color_manual(values = viridis(3, option = "E"))
```

### Extracting RGB Values
To get a data frame of raw RGB values instead of hex codes:
```R
# Returns a data frame with R, G, B, and alpha columns
color_data <- viridisMap(n = 256, option = "D")
```

## Tips for Effective Use
- **Continuous Data**: Use a high `n` (e.g., 256) to create smooth gradients.
- **Discrete Data**: Use a low `n` corresponding to the number of categories.
- **Direction**: Use `direction = -1` if you want lighter colors to represent lower values, though the default dark-to-light is standard for these maps.
- **Subsetting**: Use `begin` and `end` to avoid the extreme ends of a scale if they clash with your background or if you need to narrow the color range.

## Reference documentation
- [viridisLite: Colorblind-Friendly Color Maps (Lite Version)](./references/reference_manual.md)