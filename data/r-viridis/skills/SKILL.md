---
name: r-viridis
description: The r-viridis package provides colorblind-friendly and perceptually-uniform color maps for R visualizations. Use when user asks to create accessible color scales, apply viridis palettes to ggplot2 or base R plots, or improve the readability of heatmaps and high-density data visualizations.
homepage: https://cloud.r-project.org/web/packages/viridis/index.html
---


# r-viridis

name: r-viridis
description: Colorblind-friendly and perceptually-uniform color maps for R. Use this skill when creating or modifying R visualizations (base R or ggplot2) that require accessible, high-contrast, and print-friendly color scales. It is particularly useful for heatmaps, choropleths, and plots with high data density where color readability is critical.

## Overview

The `viridis` package provides eight color maps ("viridis", "magma", "plasma", "inferno", "cividis", "mako", "rocket", and "turbo") designed to be:
- **Perceptually uniform**: Changes in data values correspond to uniform changes in perceived color.
- **Colorblind friendly**: Readable by viewers with common forms of color vision deficiency (deuteranopia, protanopia).
- **Print friendly**: Maintains information integrity when converted to black-and-white.

## Installation

```R
install.packages("viridis")
library(viridis)
```

## Main Functions

### Base R Palettes
Generate a character vector of hex colors by specifying the number of colors `n`.

- `viridis(n, alpha = 1, begin = 0, end = 1, direction = 1, option = "D")`
- Convenience functions for other scales: `magma()`, `plasma()`, `inferno()`, `cividis()`, `mako()`, `rocket()`, `turbo()`.

**Parameters:**
- `n`: Number of colors to return.
- `alpha`: Opacity (0 to 1).
- `begin`/`end`: The range in the palette to use (0 to 1).
- `direction`: `1` for normal order, `-1` to reverse.
- `option`: A character string indicating the colormap (e.g., "A" for magma, "D" for viridis).

### ggplot2 Scales
Integrate directly with ggplot2 using scale functions.

- `scale_color_viridis()` / `scale_fill_viridis()`: Default continuous scales.
- `scale_color_viridis_d()` / `scale_fill_viridis_d()`: Discrete scales.
- `scale_color_viridis_c()` / `scale_fill_viridis_c()`: Explicit continuous scales.

**Key Arguments:**
- `discrete`: Set to `TRUE` in `scale_fill_viridis()` if the data is categorical (if not using the `_d` variant).
- `option`: Choose the map ("magma", "plasma", "inferno", "viridis", "cividis", "mako", "rocket", "turbo").

## Common Workflows

### Using with Base R Plots
```R
# Example: Filled Contour Plot
x <- y <- seq(-8*pi, 8*pi, len = 40)
r <- sqrt(outer(x^2, y^2, "+"))
filled.contour(cos(r^2)*exp(-r/(2*pi)), 
               color.palette = viridis)
```

### Using with ggplot2
```R
library(ggplot2)

# Continuous scale (default)
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Petal.Length)) +
  geom_point() +
  scale_color_viridis(option = "plasma")

# Discrete scale
ggplot(mtcars, aes(wt, mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  scale_color_viridis(discrete = TRUE, option = "viridis")
```

## Tips for Accessibility
- **Cividis**: Specifically optimized for those with color vision deficiency; it is the most robust across all types of color blindness.
- **Turbo**: Use when a rainbow-like appearance is desired without the perceptual flaws of the traditional "jet" palette.
- **Magma/Inferno**: Excellent for heatmaps or plots with dark backgrounds where high-intensity highlights are needed.

## Reference documentation
- [Introduction to the viridis color maps](./references/intro-to-viridis.Rmd)