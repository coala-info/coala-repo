---
name: bioconductor-escher
description: This tool creates multi-dimensional spatial visualizations for spatially-resolved transcriptomics data using Gestalt principles. Use when user asks to visualize gene expression, map spatial domains, overlay multiple data dimensions, or create hex-binned spatial plots.
homepage: https://bioconductor.org/packages/release/bioc/html/escheR.html
---


# bioconductor-escher

name: bioconductor-escher
description: Create multi-dimensional spatial visualizations for spatially-resolved transcriptomics (SRT) data using Gestalt principles. Use when working with SpatialExperiment, SingleCellExperiment, or data.frame objects to visualize gene expression, spatial domains, and cell types with layered aesthetics (fill, ground, symbol).

# bioconductor-escher

## Overview

The `escheR` package provides a unified framework for visualizing spatially-resolved transcriptomics data. It leverages `ggplot2` and Gestalt principles to allow users to overlay multiple data dimensions (e.g., gene expression on top of spatial clusters) without visual clutter. It supports standard Bioconductor objects like `SpatialExperiment` and `SingleCellExperiment`, as well as generic data frames.

## Core Workflow

### 1. Initialization
Create the base plot object using `make_escheR()`. This function identifies the spatial coordinates (or dimensionality reduction coordinates) and sets up the canvas.

```r
library(escheR)
# For SpatialExperiment
p <- make_escheR(spe)

# For Dimensional Reduction (e.g., PCA, UMAP)
p <- make_escheR(spe, dimred = "PCA")

# For generic data.frame
p <- make_escheR(df, .x = df$x_coord, .y = df$y_coord)
```

### 2. Adding Layers
Unlike standard `ggplot2` which uses `+`, `escheR` uses the pipe operator `|>` to add specific spatial layers.

*   `add_fill(var)`: Adds the primary color layer (usually for continuous variables like gene expression or cell counts).
*   `add_ground(var)`: Adds a "ground" layer, typically used for categorical spatial domains or clusters. It uses a stroke/outline effect.
*   `add_symbol(var)`: Adds a third dimension using shapes/symbols.

**Recommended Order:** Always place `add_fill` first for the best visual layering.

```r
p_layered <- p |>
  add_fill(var = "gene_counts") |>
  add_ground(var = "spatial_domain", stroke = 0.5) |>
  add_symbol(var = "is_tissue")
```

### 3. Hex Binning
To handle overplotting in dense datasets (like Slide-seq), use binning functions:
```r
p_binned <- p |>
  add_ground_bin(var = "cluster") |>
  add_fill_bin(var = "expression")
```

## Customization and Aesthetics

Since `escheR` outputs a `ggplot` object, you can use standard `ggplot2` functions with `+` to refine the plot.

*   **Colors:** Use `scale_fill_*` for the `add_fill` layer and `scale_color_*` for the `add_ground` layer.
*   **Bivariate Palettes:** To avoid visual confusion when using both fill and ground, use high-contrast or minimally overlapping palettes (e.g., a white-to-black gradient for expression over colorful spatial domains).
*   **Subsetting:** To show only specific levels of a category, set unwanted levels to `NA` in the data before plotting.

```r
p_layered +
  scale_fill_gradient(low = "white", high = "black") +
  scale_color_manual(values = my_colors) +
  theme_minimal()
```

## Multi-sample Visualization
`escheR` operates on one sample at a time. For multi-sample objects, use `lapply` to create a list of plots and combine them using `patchwork` or `ggpubr::ggarrange`.

```r
plot_list <- lapply(unique(spe$sample_id), function(s) {
  make_escheR(spe[, spe$sample_id == s]) |> add_fill("gene_x")
})
ggpubr::ggarrange(plotlist = plot_list, common.legend = TRUE)
```

## Reference documentation

- [Getting Started with escheR](./references/SRT_eg.md)
- [Advanced Data Types and Binning](./references/more_than_visium.md)