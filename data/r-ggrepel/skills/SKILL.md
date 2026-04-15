---
name: r-ggrepel
description: The r-ggrepel tool provides ggplot2 geometries that automatically position text labels to prevent them from overlapping with each other or data points. Use when user asks to add non-overlapping text labels to R plots, prevent label collisions in ggplot2, or replace geom_text and geom_label with repelling versions.
homepage: https://cloud.r-project.org/web/packages/ggrepel/index.html
---

# r-ggrepel

name: r-ggrepel
description: Use the ggrepel R package to automatically position non-overlapping text labels in ggplot2 visualizations. This skill should be used when creating R plots where data labels or text annotations overlap with each other, data points, or plot boundaries. It provides replacements for geom_text() and geom_label() that "repel" labels away from points and other labels.

# r-ggrepel

## Overview

The `ggrepel` package provides geoms for `ggplot2` that help prevent overlapping text labels. Labels repel away from each other, away from data points, and away from the edges of the plotting area.

The two primary functions are:
- `geom_text_repel()`: Adds text directly to the plot.
- `geom_label_repel()`: Adds text within a rectangular box (label).

## Installation

To install the stable version from CRAN:

```r
install.packages("ggrepel")
```

## Usage

### Basic Workflow

Replace standard `ggplot2` text layers with `ggrepel` equivalents. The syntax is designed to be a drop-in replacement for `geom_text()` and `geom_label()`.

```r
library(ggplot2)
library(ggrepel)

ggplot(mtcars, aes(wt, mpg, label = rownames(mtcars))) +
  geom_point(color = "red") +
  geom_text_repel()
```

### Key Parameters

You can fine-tune the repelling behavior using these arguments:

- `box.padding`: Amount of padding around the text box (e.g., `0.5`).
- `point.padding`: Amount of padding around the labeled data point (e.g., `0.3`).
- `segment.color`: Color of the line connecting the label to the point.
- `segment.size`: Thickness of the connector line.
- `force`: Force of repulsion between overlapping points (default is 1).
- `max.overlaps`: Exclude labels that overlap too many things (default is 10). Set to `Inf` to force all labels to show.
- `direction`: Restrict label movement to `"both"`, `"x"`, or `"y"`.
- `nudge_x` / `nudge_y`: Provide a starting offset for the labels.

### Example: Customizing Connectors

```r
ggplot(mtcars, aes(wt, mpg, label = rownames(mtcars))) +
  geom_point() +
  geom_text_repel(
    min.segment.length = 0, # Always draw segments
    seed = 42,              # Ensure reproducible layout
    box.padding = 0.5,
    segment.color = "grey50"
  )
```

## Tips for Success

1. **Reproducibility**: Because the repelling algorithm uses a random seed, set `seed` within the function (e.g., `geom_text_repel(seed = 42)`) to ensure the labels stay in the same place every time you render the plot.
2. **Performance**: If you have thousands of points, `ggrepel` may be slow. Consider labeling only a subset of data using the `data` argument within the geom.
3. **Clipping**: If labels are cut off at the plot edges, use `coord_cartesian(clip = "off")` or increase the plot margins.
4. **Hidden Labels**: If some labels are missing, check the `max.overlaps` parameter. `ggrepel` hides labels by default if they are too crowded to prevent a messy plot.

## Reference documentation

- [Getting started with ggrepel](./references/ggrepel.Rmd)