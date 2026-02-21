---
name: ggplot
description: The `ggplot2` skill enables the creation of professional, complex data visualizations in R.
homepage: https://github.com/tidyverse/ggplot2
---

# ggplot

## Overview
The `ggplot2` skill enables the creation of professional, complex data visualizations in R. Instead of providing step-by-step drawing instructions, you define how data variables map to visual properties (aesthetics) and add layers of graphical primitives (geoms). This skill is essential for producing publication-quality graphics, performing exploratory data analysis, and utilizing the vast ecosystem of R visualization extensions.

## Core Workflow
The standard `ggplot2` workflow follows a specific sequence:
1. **Initialize**: Call `ggplot()` and provide a data frame.
2. **Map**: Define global aesthetics using `aes()` (e.g., x, y, color, fill).
3. **Layer**: Add geometric objects using `geom_*()` functions.
4. **Refine**: Add scales, facets, labels, and themes.

```r
library(ggplot2)

# Basic template
ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +
  <GEOM_FUNCTION>() +
  <SCALE_FUNCTION>() +
  <FACET_FUNCTION>() +
  <THEME_FUNCTION>()
```

## High-Utility Instructions

### 1. Mapping vs. Setting
*   **Mapping**: Use `aes()` when the visual property (color, size, shape) should vary based on a variable in your data.
*   **Setting**: Define the property outside of `aes()` within a `geom_*()` call if you want it to be a constant value (e.g., `color = "red"`).

### 2. Common Geoms
*   **Scatter**: `geom_point()`
*   **Line**: `geom_line()` or `geom_path()`
*   **Bar/Column**: `geom_bar()` (counts) or `geom_col()` (values)
*   **Distribution**: `geom_histogram()`, `geom_density()`, or `geom_boxplot()`
*   **Smoothing**: `geom_smooth(method = "lm")` for regression lines.

### 3. Faceting (Subplots)
*   **facet_wrap(~variable)**: Creates a ribbon of panels wrapped into 2D.
*   **facet_grid(rows ~ cols)**: Creates a formula-based grid of panels.

### 4. Scales and Labels
*   Use `labs(title = "...", x = "...", y = "...", color = "...")` to set text.
*   Use `scale_*` functions to control the mapping between data and aesthetics (e.g., `scale_y_log10()`, `scale_color_brewer(palette = "Set1")`).

### 5. Themes and Fine-Tuning
*   Use pre-set themes for instant styling: `theme_minimal()`, `theme_bw()`, `theme_classic()`.
*   Use `theme()` for granular control over non-data elements like `axis.text`, `legend.position`, and `panel.grid`.

## Expert Tips
*   **Tidy Data**: `ggplot2` works best with "long" format data where every column is a variable and every row is an observation.
*   **Layer Order**: Layers are drawn in the order they are added. Put `geom_point()` after `geom_line()` if you want points to appear on top of lines.
*   **Saving Plots**: Use `ggsave("plot.png", width = 6, height = 4)` to export the last displayed plot. It automatically detects the file format from the extension.
*   **Composition**: You can store a plot in a variable (e.g., `p <- ggplot(...)`) and add layers to it later (`p + geom_point()`).

## Reference documentation
- [ggplot2 Overview](./references/github_com_tidyverse_ggplot2.md)
- [Tips and Tricks](./references/github_com_tidyverse_ggplot2_wiki.md)