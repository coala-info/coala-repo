---
name: bioconductor-karyoploter
description: karyoploteR is a Bioconductor package for creating highly customizable visualizations of genomic data along the chromosomes of any organism. Use when user asks to plot genomic data, create karyotypes, visualize regions or coverage, draw links between genomic locations, or generate multi-track genome plots.
homepage: https://bioconductor.org/packages/release/bioc/html/karyoploteR.html
---


# bioconductor-karyoploter

## Overview

karyoploteR is a Bioconductor package designed for the visualization of genomic data along the genome. It follows a "painter's model" similar to base R graphics: you initialize a plot with `plotKaryotype()` and then layer data using specific functions (`kpPoints`, `kpLines`, `kpPlotRegions`, etc.). It is highly flexible, supporting any organism with a known genome and allowing for complex multi-panel layouts.

## Core Workflow

1.  **Initialize Plot**: Use `plotKaryotype()` to define the genome, chromosomes, and layout.
2.  **Add Data Panels (Optional)**: Use `kpDataBackground()` or `kpAxis()` to provide visual context.
3.  **Plot Data**: Call low-level (e.g., `kpPoints`) or high-level (e.g., `kpPlotCoverage`) functions.
4.  **Customize**: Adjust parameters like `r0`, `r1` (vertical positioning within a panel) and `ymin`, `ymax` (data scaling).

## Key Functions

### Initialization
- `plotKaryotype(genome="hg19", chromosomes="canonical", plot.type=1, zoom=NULL)`: The entry point. 
    - `plot.type`: 1 (data above), 2 (above and below), 3-5 (single level variants).
    - `zoom`: A `GRanges` object to focus on a specific genomic region.
- `getDefaultPlotParams(plot.type)`: Returns a list of margins and sizes for customization.

### Low-Level Plotting
These functions mimic base R and require `chr`, `x`, and `y` (or a `data` object with these columns).
- `kpPoints(kp, chr, x, y, ...)`: Standard scatter plots.
- `kpLines(kp, chr, x, y, ...)`: Connected data points.
- `kpBars(kp, chr, x0, x1, y1, ...)`: Vertical bars for values.
- `kpRect(kp, chr, x0, x1, y0, y1, ...)`: Arbitrary rectangles.
- `kpText(kp, chr, x, y, labels, ...)`: Text annotations.
- `kpAbline(kp, h, v, ...)`: Horizontal or vertical reference lines.

### High-Level Plotting
Specialized for genomic objects (usually `GRanges`).
- `kpPlotRegions(kp, data, ...)`: Plots genomic intervals; automatically stacks overlapping regions.
- `kpPlotCoverage(kp, data, ...)`: Calculates and plots coverage from a set of regions.
- `kpPlotDensity(kp, data, ...)`: Plots the density of features along the genome.
- `kpPlotMarkers(kp, data, labels, ...)`: Adds text labels with leader lines to specific positions.
- `kpPlotLinks(kp, data, data2, ...)`: Draws arcs connecting two genomic locations.

## Positioning and Scaling

karyoploteR uses a relative coordinate system within data panels:
- **r0 and r1**: Define the vertical boundaries of the data within a panel (0 to 1). Use these to create "tracks."
- **ymin and ymax**: Define the data scale. Data values outside this range are clipped by default.
- **Data Panels**: In `plot.type=2`, `data.panel=1` is above the ideogram, and `data.panel=2` is below.

## Examples

### Basic Region Plot
```r
library(karyoploteR)
kp <- plotKaryotype(genome="hg19")
kpPlotRegions(kp, my_granges_object, col="red")
```

### Multi-Track Plot
```r
kp <- plotKaryotype(genome="hg19", plot.type=2)
# Track 1: Points in the upper panel
kpPoints(kp, data=df_points, r0=0, r1=0.5, ymin=0, ymax=1, data.panel=1)
# Track 2: Lines in the upper panel
kpLines(kp, data=df_lines, r0=0.6, r1=1, ymin=0, ymax=1, data.panel=1)
# Track 3: Coverage in the lower panel
kpPlotCoverage(kp, data=my_regions, data.panel=2)
```

## Tips for Success
- **Object Return**: Every `kp` function returns the `KaryoPlot` object. This allows for piping using `magrittr` (`%>%`).
- **Clipping**: If data points disappear at the edges of a zoom, set `clipping=FALSE` in the plotting function.
- **Coordinate Conversion**: Use `kp$latest.plot$computed.values` if you need to extract internal coordinates for advanced custom plotting.
- **Data Input**: Most functions accept either individual vectors (`chr`, `x`, `y`) or a `GRanges` object with metadata columns.

## Reference documentation
- [karyoploteR](./references/karyoploteR.md)