---
name: r-ggalt
description: The r-ggalt package provides specialized geoms, coordinate systems, and statistical transformations as extensions to the ggplot2 visualization framework. Use when user asks to create dumbbell plots, lollipop charts, horizon charts, or encircle specific data points in R.
homepage: https://cloud.r-project.org/web/packages/ggalt/index.html
---


# r-ggalt

## Overview
The `ggalt` package is a ggplot2 extension providing extra coordinate systems, geoms, statistical transformations, and scales. It is particularly useful for specialized charts like dumbbell plots (comparing two points), lollipop charts, and horizon charts for time-series data.

## Installation
```R
install.packages("ggalt")
library(ggalt)
library(ggplot2)
```

## Core Geoms and Workflows

### Dumbbell Plots
Used to show the change between two points (e.g., year-over-year change).
```R
# Requires x and xend aesthetics
ggplot(df, aes(y=category, x=value_start, xend=value_end)) +
  geom_dumbbell(colour="#a3c4dc", size=1.5, colour_xend="#0e668b",
                dot_guide=TRUE, dot_guide_size=0.15)
```

### Lollipop Charts
A cleaner alternative to bar charts, especially for many categories.
```R
# Use horizontal=TRUE for easier label reading
ggplot(df, aes(y=reorder(category, pct), x=pct)) +
  geom_lollipop(point.colour="steelblue", point.size=2, horizontal=TRUE)
```

### Enclircle Points
Automatically draw a polygon around a subset of points.
```R
# Use s_shape and expand to control the tightness of the enclosure
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_encircle(data=subset(mpg, hwy > 40), color="red", spread=0.02)
```

### X-Splines
Connect points with smooth curves rather than straight lines.
```R
# spline_shape: -1 to 1. 0 is a standard spline, >0 is tighter, <0 is looser.
ggplot(dat, aes(x, y, group=group, color=factor(group))) +
  geom_xspline(spline_shape=0.4, size=0.5)
```

### Horizon Charts
Efficiently visualize many time series in a small vertical space.
```R
ggplot(df, aes(time, value)) +
  geom_horizon(bandwidth=0.1) +
  facet_grid(activity ~ .)
```

### Density Estimates (BKDE & ASH)
Provides smoother density estimates using `KernSmooth` (BKDE) or Averaged Shifted Histograms (ASH).
```R
# 1D Density
ggplot(df, aes(x=value)) + geom_bkde()
ggplot(df, aes(x=value)) + stat_ash()

# 2D Density Contours
ggplot(df, aes(x=x, y=y)) + geom_bkde2d(bandwidth=c(0.5, 4))
```

## Specialized Tools
- **coord_proj**: A more robust alternative to `coord_map` for map projections.
- **geom_stateface**: Use the ProPublica StateFace font to display US state shapes as points.
- **stat_stepribbon**: Create ribbons that follow a step function (useful for survival curves or stepped data).
- **annotation_ticks**: Add minor ticks to axes (supports identity, log10, and exponential scales).
- **geom_spikelines**: Draws segments from a point to the X and Y axes.

## Reference documentation
- [README](./references/README.md)
- [ggalt examples](./references/ggalt_examples.Rmd)