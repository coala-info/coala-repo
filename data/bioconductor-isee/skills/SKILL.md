---
name: bioconductor-isee
description: The iSEE package provides an interactive Shiny interface for exploring and visualizing high-dimensional biological data stored in SummarizedExperiment objects. Use when user asks to launch an interactive explorer for single-cell data, visualize dimensionality reduction results, link plots for data filtering, or create interactive heatmaps and metadata tables.
homepage: https://bioconductor.org/packages/release/bioc/html/iSEE.html
---

# bioconductor-isee

## Overview

The `iSEE` (Interactive SummarizedExperiment Explorer) package provides a powerful Shiny interface for exploring high-dimensional biological data. It is designed to work seamlessly with `SummarizedExperiment` objects and its derivatives (like `SingleCellExperiment`). The interface allows for simultaneous visualization of reduced dimensions, feature expression, metadata, and heatmaps, with the ability to link panels so that selections in one plot (e.g., a cluster of cells) filter or highlight data in another.

## Core Workflow

### 1. Data Preparation
Ensure your data is in a `SummarizedExperiment` or `SingleCellExperiment` object. Precompute any dimensionality reduction results (PCA, t-SNE, UMAP) and add them to the `reducedDims` slot.

```r
library(iSEE)
library(scater)
library(scRNAseq)

# Example: Load and prepare a SingleCellExperiment
sce <- ReprocessedAllenData(assays = "tophat_counts")
sce <- logNormCounts(sce, exprs_values="tophat_counts")
sce <- runPCA(sce)
sce <- runTSNE(sce)

# Add custom row metadata for visualization
rowData(sce)$mean_log <- rowMeans(logcounts(sce))
```

### 2. Launching the App
The simplest way to start is by passing the object to the `iSEE()` function.

```r
app <- iSEE(sce)
shiny::runApp(app)
```

### 3. Programmatic Configuration
You can define the starting state of the app using the `initial` argument. This avoids manual setup of panels every time the app is launched.

```r
initial_panels <- list(
    ReducedDimensionPlot(PanelWidth=6L, Type="TSNE"),
    FeatureAssayPlot(PanelWidth=6L, Assay="logcounts", YAxisFeatureName="Zyx"),
    ColumnDataTable(PanelWidth=12L)
)

app <- iSEE(sce, initial = initial_panels)
```

## Key Panel Types

*   **ReducedDimensionPlot**: Visualizes low-dimensional embeddings (PCA, t-SNE).
*   **ColumnDataPlot**: Plots sample metadata (colData) such as QC metrics or cell types.
*   **FeatureAssayPlot**: Visualizes expression levels of a specific feature (gene) across samples.
*   **RowDataTable / ColumnDataTable**: Searchable tables for feature and sample metadata.
*   **ComplexHeatmapPlot**: Displays an interactive heatmap of selected features.
*   **SampleAssayPlot**: Visualizes all features for a specific sample.

## Advanced Features

### Linking Panels
Panels can be linked so that a selection (brush or lasso) in a "sender" panel filters the data in a "receiver" panel.
*   Set `ColumnSelectionSource = "ReducedDimensionPlot1"` in a receiver panel to highlight or restrict data based on the selection in the first Reduced Dimension plot.

### Handling Large Datasets
For datasets that exceed memory, use file-backed matrices (e.g., `HDF5Matrix`). `iSEE` reads only the required data on demand.
*   Enable `Downsample = TRUE` in plot parameters to speed up rendering of millions of points.

### Custom Panels
You can create custom plots or tables that execute R code based on user selections.
*   Use `createCustomPlot(FUN)` or `createCustomTable(FUN)` where `FUN` is a function accepting the SE object and selection vectors.

### Custom Coloring
Use the `ExperimentColorMap` class to define consistent color scales for specific assays or metadata categories across the entire application.

## Reference documentation

- [An introduction to the iSEE interface](./references/basic.md)
- [How to use iSEE with big data](./references/bigdata.md)
- [Configuring iSEE apps](./references/configure.md)
- [Deploying custom panels in the iSEE interface](./references/custom.md)
- [Describing the ExperimentColorMap class](./references/ecm.md)