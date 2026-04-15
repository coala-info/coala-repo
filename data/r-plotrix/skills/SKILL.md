---
name: r-plotrix
description: The plotrix package provides a wide array of specialized functions for creating non-standard axes, scientific diagrams, and enhanced annotations in R. Use when user asks to create plots with axis breaks, generate Taylor diagrams, plot dual-scale graphs, or add tables and boxed labels to R graphics.
homepage: https://cloud.r-project.org/web/packages/plotrix/index.html
---

# r-plotrix

## Overview
The `plotrix` package provides a large collection of specialized functions for R graphics. It extends base R capabilities by offering tools for non-standard axes (breaks, gaps, dual scales), specialized scientific diagrams (Taylor diagrams, radial plots), and enhanced annotation (adding tables to plots, boxed labels, and color scaling).

## Installation
Install the package from CRAN:
```R
install.packages("plotrix")
```

## Main Functions and Workflows

### Axis and Scale Management
- `axis.break`: Places a "break" mark on an axis to indicate a discontinuity.
- `gap.barplot` / `gap.plot`: Creates plots with a gap in one of the axes to handle outliers or disparate data ranges.
- `twoord.plot`: Plots two sets of data with different y-axis scales on the same graph.
- `rescale`: Linearly transforms a vector of numbers into a new range.

### Specialized Chart Types
- `radial.plot`: Creates polar/radar charts for cyclic or directional data.
- `taylor.diagram`: Standard tool for evaluating model performance by plotting correlation, RMS error, and standard deviation.
- `pyramid.plot`: Useful for population pyramids or back-to-back bar charts.
- `staircase.plot`: Creates "waterfall" charts often used in financial or process flow analysis.
- `ladderplot`: Visualizes changes between groups or time points (paired data).
- `hierarchic.chart`: Draws nested flowcharts or tree-like structures.

### Annotation and Labeling
- `addtable2plot`: Embeds a data frame or matrix as a formatted table directly within a plot.
- `boxed.labels`: Places text labels with a background box to improve legibility over complex backgrounds.
- `draw.circle` / `draw.ellipse`: Adds geometric shapes to existing plots using user coordinates.
- `color.scale`: Maps numeric values to a color gradient, useful for heatmaps or custom color coding.

### Data Visualization Enhancements
- `sizeplot`: A scatter plot where the size of the points represents the frequency of overlapping data points.
- `bin.wind.records`: Classifies wind direction and speed, often used before plotting wind roses.
- `weighted.hist`: Calculates and plots histograms where each observation has a weight.

## Tips for Usage
- **Coordinate Returns**: Many `plotrix` functions return the coordinates of the elements they draw. Capture these return values if you need to add further annotations (like text or lines) precisely on top of the generated elements.
- **Base Graphics Compatibility**: `plotrix` functions generally work with the base R graphics system. You can often call `plot()` or `plot.new()` first, then use `plotrix` functions to layer additional information.
- **Color Scaling**: Use `color.scale` to quickly generate hex codes for values when creating custom heatmaps or color-coded scatter plots without needing complex ggplot2 scales.

## Reference documentation
- [README](./references/README.html.md)
- [Home Page](./references/home_page.md)