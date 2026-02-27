---
name: bioconductor-splots
description: The splots package visualizes high-throughput assay data from microtitre plates or slides using a grid of heatmaps. Use when user asks to visualize plate-based screen data, create heatmaps of microtitre plates, or use the plotScreen function.
homepage: https://bioconductor.org/packages/release/bioc/html/splots.html
---


# bioconductor-splots

## Overview

The `splots` package is a legacy Bioconductor tool designed for the visualization of high-throughput assay data arranged in microtitre plates or slides. Its primary function, `plotScreen`, produces a grid of heatmaps representing multiple plates. While still maintained for compatibility, the package authors recommend using `ggplot2` or the `platetools` package for new development.

## Core Function: plotScreen

The `plotScreen` function visualizes a list of plate data.

### Data Preparation
The function requires a list where each element represents a single plate. Each element must be a numeric vector of length `nx * ny` (total number of wells).

```r
# Example: Preparing a list for 2 plates (384-well format: 24 columns x 16 rows)
nx <- 24
ny <- 16
plate_list <- list(
  Plate1 = runif(nx * ny),
  Plate2 = runif(nx * ny)
)
```

### Basic Usage
```r
library(splots)

plotScreen(plate_list, 
           nx = 24, 
           ny = 16, 
           ncol = 2, 
           fill = c("white", "darkblue"),
           main = "Screen Visualization",
           legend.label = "Intensity")
```

### Key Arguments
- `xs`: A list of numeric vectors (one per plate).
- `nx`, `ny`: Number of columns and rows in the plate layout.
- `ncol`: Number of columns in the output plot grid (how many plates per row).
- `fill`: A character vector of colors for the gradient.
- `zrange`: (Optional) A numeric vector of length 2 specifying the data range for the color scale.

## Modern Workflow (Recommended)

The package vignette suggests using `ggplot2` with `geom_raster` for better flexibility and integration with modern R workflows.

```r
library(ggplot2)
library(dplyr)

# Assuming a tidy dataframe 'df' with columns: plate, row, col, value
ggplot(df, aes(x = col, y = row, fill = value)) + 
  geom_raster() +
  facet_wrap(~plate) +
  scale_fill_gradient(low = "white", high = "darkblue") +
  theme_minimal()
```

## Tips and Best Practices
- **Legacy Status**: `plotScreen` is considered obsolete. Use it primarily for maintaining older codebases or quick legacy visualizations.
- **Data Alignment**: Ensure that the numeric vectors in your list are ordered correctly (usually row-major or column-major depending on how you mapped the indices).
- **Missing Values**: `plotScreen` handles `NA` values by leaving the corresponding well blank or using the background color.
- **Layout**: If your plates have different dimensions, `plotScreen` may not be suitable as it expects a uniform `nx` and `ny` for the entire list.

## Reference documentation
- [splots: visualization of data from assays in microtitre plate or slide format](./references/splots.md)