---
name: r-ggplot2
description: This tool creates declarative data visualizations in R based on the grammar of graphics. Use when user asks to create plots, customize themes, map data to aesthetics, or programmatically generate visualizations.
homepage: https://cloud.r-project.org/web/packages/ggplot2/index.html
---

# r-ggplot2

name: r-ggplot2
description: Expert guidance for creating elegant data visualizations using the grammar of graphics in R. Use this skill when the user needs to create plots, customize themes, develop new geoms/stats, or programmatically generate visualizations within R packages using ggplot2.

# r-ggplot2

## Overview
ggplot2 is a system for declaratively creating graphics, based on "The Grammar of Graphics". It allows you to build plots by mapping data to aesthetic attributes (color, shape, size) and using geometric objects (points, lines, bars). The fundamental philosophy is that a plot is composed of independent components: data, mapping, layers, scales, facets, coordinates, and themes.

## Installation
To install the package from CRAN:
```r
install.packages("ggplot2")
```

## Core Workflow
A basic ggplot2 call requires three components:
1. **Data**: A tidy data frame.
2. **Mapping**: Defined via `aes()`, linking variables to visual properties.
3. **Layer**: At least one `geom_*()` or `stat_*()` function.

Example:
```r
library(ggplot2)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth(method = "lm")
```

## Key Components

### Aesthetics (aes)
- **Position**: `x`, `y`
- **Color/Fill**: `colour` (outlines), `fill` (interiors). Use hex codes, names, or `NA`.
- **Groups**: `group` defines how data is partitioned for collective geoms.
- **Identity**: Use `after_stat()` to map variables calculated by a stat (e.g., `aes(y = after_stat(density))`).

### Layers (Geoms and Stats)
- **Individual**: `geom_point()`, `geom_line()`, `geom_text()`.
- **Collective**: `geom_polygon()`, `geom_boxplot()`, `geom_area()`.
- **Statistical**: `stat_summary()`, `stat_density()`, `stat_smooth()`.
- **Orientation**: Most geoms automatically detect orientation. Use the `orientation` parameter ("x" or "y") if the mapping is ambiguous.

### Scales and Guides
Scales control the mapping from data space to aesthetic space.
- **Naming**: `scale_{aesthetic}_{type}()` (e.g., `scale_colour_viridis_d()`).
- **Guides**: Use `guides()` or the `guide` argument in scales to customize axes and legends (e.g., `guide_colorbar()`, `guide_legend()`).

### Faceting
Split data into small multiples:
- `facet_wrap(~ variable)`: Wraps a 1D ribbon of panels into 2D.
- `facet_grid(rows ~ cols)`: Creates a 2D grid of panels based on two variables.

### Themes
Control non-data elements (fonts, backgrounds, margins).
- **Complete Themes**: `theme_minimal()`, `theme_light()`, `theme_bw()`.
- **Customization**: Use `theme()` with `element_text()`, `element_rect()`, `element_line()`, or `element_blank()`.
- **Modification**: Use `%+replace%` to override elements in a theme constructor rather than just adding to them.

## Programming with ggplot2
When using ggplot2 inside functions or packages:
- **Referencing Columns**: Use the `.data` pronoun from `rlang` to avoid `R CMD check` notes.
- **Tidy Eval**: Use the curly-curly `{{ }}` operator to pass user-supplied expressions to `aes()`.
- **Example**:
```r
my_plot_func <- function(df, var_x, var_y) {
  ggplot(df, aes(x = {{ var_x }}, y = .data[[var_y]])) +
    geom_point()
}
```

## Extending ggplot2
Create custom components using the `ggproto` object-oriented system:
- **Stats**: Inherit from `Stat`. Implement `compute_group` or `compute_panel`.
- **Geoms**: Inherit from `Geom`. Implement `draw_panel` or `draw_group` using `grid` grobs.
- **Facets**: Inherit from `Facet`. Implement `compute_layout`, `map_data`, and `draw_panels`.

## Reference documentation
- [Extending ggplot2](./references/extending-ggplot2.md)
- [Using ggplot2 in packages](./references/ggplot2-in-packages.md)
- [Aesthetic specifications](./references/ggplot2-specs.md)
- [Introduction to ggplot2](./references/ggplot2.md)
- [Profiling Performance](./references/profiling.md)