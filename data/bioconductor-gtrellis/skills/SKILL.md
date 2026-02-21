---
name: bioconductor-gtrellis
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/gtrellis.html
---

# bioconductor-gtrellis

## Overview

The `gtrellis` package provides a flexible framework for arranging genomic categories (like chromosomes or genes) into a Trellis layout. Unlike standard `ggplot2` or `lattice` facets, `gtrellis` handles varying chromosome lengths efficiently, supports multiple tracks per category, and allows for high customization using the `grid` graphics system.

## Core Workflow

### 1. Initialize Layout
The layout must be initialized before adding any graphics. This defines the number of tracks, rows/columns, and the genomic categories to be displayed.

```r
library(gtrellis)

# Default: hg19, all chromosomes in one row
gtrellis_layout()

# Custom: Multiple tracks, specific species, and layout grid
gtrellis_layout(
    species = "hg19",
    n_track = 3,
    nrow = 3,
    byrow = FALSE,
    track_height = c(1, 2, 1),
    track_ylim = c(0, 1, -4, 4, 0, 100),
    track_ylab = c("Track A", "Track B", "Track C"),
    add_name_track = TRUE,
    add_ideogram_track = TRUE
)
```

### 2. Add Graphics to Tracks
Graphics are added sequentially to tracks. You can use pre-defined functions for common plots or `add_track` for custom `grid`-based drawing.

**Pre-defined Track Functions:**
*   `add_points_track(data, value)`: Adds points at the midpoint of genomic regions.
*   `add_lines_track(data, value, area = TRUE)`: Adds lines or area plots.
*   `add_rect_track(data, h1, h2)`: Adds rectangles (useful for bar plots).
*   `add_segments_track(data, value)`: Adds horizontal segments.
*   `add_heatmap_track(data, matrix, fill)`: Adds a heatmap filling the track height.

**Custom Track Drawing:**
Use `add_track` with a `panel_fun` to define custom graphics using `grid` functions.

```r
add_track(bed, panel_fun = function(gr) {
    # gr is the subset of data for the current panel
    x = (gr[[2]] + gr[[3]]) / 2
    y = gr[[4]]
    grid.points(x, y, pch = 16, size = unit(1, "mm"))
})
```

### 3. Managing Cells and Metadata
Inside `panel_fun`, use `get_cell_meta_data()` to retrieve information about the current plotting region.

*   `get_cell_meta_data("name")`: Current category (e.g., "chr1").
*   `get_cell_meta_data("xlim")`: X-axis limits for the current cell.
*   `get_cell_meta_data("track")`: Current track index.

## Key Parameters

*   **category**: Subset and order of chromosomes (e.g., `c("chr1", "chr2")`).
*   **compact**: If `TRUE`, chromosomes are placed side-by-side without strict column alignment to save space.
*   **equal_width**: If `TRUE`, all panels have the same width regardless of chromosome length.
*   **use_raster**: Set to `TRUE` in `add_track` to render complex plots (many points) as bitmaps to reduce PDF file size.

## Common Recipes

### Rainfall Plot
```r
library(circlize)
rainfall = rainfallTransform(DMR_data)
gtrellis_layout(n_track = 1, track_ylim = c(0, 8))
add_points_track(rainfall, log10(rainfall[[4]]), gp = gpar(col = "red"))
```

### Karyogram View
To create a vertical stack of chromosomes:
```r
gtrellis_layout(ncol = 1, track_axis = FALSE, add_ideogram_track = TRUE)
add_track(data, panel_fun = function(gr) {
    # Custom drawing for genomic regions
})
```

### Adding Legends
Legends are added via the `legend` argument in `gtrellis_layout` using `ComplexHeatmap::Legend` or `grid::legendGrob`.
```r
library(ComplexHeatmap)
lgd = Legend(at = c("A", "B"), title = "Type", type = "points")
gtrellis_layout(legend = lgd)
```

## Reference documentation
- [The gtrellis package](./references/gtrellis.md)
- [Make Genome-level Trellis Graph (Rmd Source)](./references/gtrellis.Rmd)
- [Full Package Vignette](./references/gtrellis_full.Rmd)