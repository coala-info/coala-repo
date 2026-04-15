---
name: bioconductor-iseehex
description: This tool creates hexagonal binning plots within the iSEE interactive visualization framework to summarize large-scale Bioconductor data. Use when user asks to visualize large datasets without overplotting, create interactive hexagonal binning dashboards, or use the ReducedDimensionHexPlot class for SingleCellExperiment objects.
homepage: https://bioconductor.org/packages/release/bioc/html/iSEEhex.html
---

# bioconductor-iseehex

name: bioconductor-iseehex
description: Specialized for using the iSEEhex R package to create hexagonal binning plots within the iSEE interactive visualization framework. Use this skill when a user needs to visualize large-scale Bioconductor data (SummarizedExperiment or SingleCellExperiment) using density-based hexagonal bins to avoid overplotting in interactive dashboards.

## Overview

The `iSEEhex` package extends the `iSEE` (Interactive SummarizedExperiment Explorer) ecosystem by providing specialized panels that summarize data points into hexagonal bins. This is particularly useful for large datasets (e.g., single-cell RNA-seq) where standard scatter plots suffer from extreme overplotting. These panels integrate seamlessly with the standard `iSEE` interface, allowing for interactive filtering, coloring, and linking between hexagonal and point-based plots.

## Core Workflows

### 1. Loading the Package
Ensure both the base framework and the hex extension are loaded:
```r
library(iSEE)
library(iSEEhex)
```

### 2. Using Hexagonal Panels
The primary contribution of this package is the `ReducedDimensionHexPlot` class. It is used within the `initial` argument of the `iSEE()` function.

**Example: Comparing Standard vs. Hexagonal Plots**
```r
# Assuming 'sce' is a SingleCellExperiment object with PCA/TSNE
initialPanels <- list(
    # Standard point-based plot
    ReducedDimensionPlot(
        Type = "PCA", 
        ColorBy = "Feature name", 
        ColorByFeatureName = "Cux2", 
        PanelWidth = 6L
    ),
    # Hexagonal binning plot
    ReducedDimensionHexPlot(
        Type = "PCA",
        ColorBy = "Feature name", 
        ColorByFeatureName = "Cux2", 
        PanelWidth = 6L,
        BinResolution = 30 # Adjusts the size/number of hexagons
    )
)

iSEE(se = sce, initial = initialPanels)
```

### 3. Key Parameters
- `BinResolution`: Controls the granularity of the hexagonal grid. Higher values result in smaller, more numerous bins.
- `ColorBy`: Determines how bins are colored (e.g., "Feature name", "Column data", or "None" for density).
- `ColorByFeatureName`: The specific gene/feature used for color gradients within the bins.

## Typical Data Preparation
Before launching the app, ensure your `SingleCellExperiment` or `SummarizedExperiment` object is properly processed:
1. **Normalization**: Use `scater::logNormCounts()`.
2. **Dimensional Reduction**: Run `scater::runPCA()` or `scater::runTSNE()`.
3. **Metadata**: Ensure `colData` and `rowData` contain the variables you wish to visualize or color by.

## Tips for Effective Use
- **Performance**: Use `ReducedDimensionHexPlot` when dealing with >50,000 cells to improve rendering performance and visual clarity.
- **Hybrid Dashboards**: Mix `ReducedDimensionHexPlot` with standard `ColumnDataPlot` or `RowDataPlot` to maintain the ability to inspect individual metadata distributions alongside binned spatial coordinates.
- **Resolution Tuning**: If the plot looks too "blocky," increase `BinResolution`. If it looks like a standard scatter plot, decrease it.

## Reference documentation

- [The iSEEhex package](./references/iSEEhex.md)