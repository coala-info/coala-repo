---
name: bioconductor-iseeu
description: The bioconductor-iseeu package provides specialized panels and pre-configured application modes to extend the iSEE framework for interactive bioinformatics visualization. Use when user asks to visualize differential expression with volcano or MA plots, perform dynamic dimensionality reduction on selected data subsets, compute marker statistics in real-time, or launch pre-configured interactive app modes.
homepage: https://bioconductor.org/packages/release/bioc/html/iSEEu.html
---


# bioconductor-iseeu

## Overview

The `iSEEu` (iSEE Universe) package extends the `iSEE` framework by providing specialized panel classes and pre-configured application modes. While `iSEE` provides general-purpose panels, `iSEEu` implements domain-specific visualizations common in bioinformatics, such as volcano plots for differential expression and dynamic panels that recalculate dimensionality reductions or marker statistics based on user-defined cell selections in real-time.

## Core Workflows

### 1. Differential Expression Visualization
`iSEEu` provides panels that automatically interface with `rowData` containing statistics (e.g., from `edgeR` or `limma`).

*   **MAPlot**: Plots log-fold change vs. average expression.
*   **VolcanoPlot**: Plots -log10(P-value) vs. log-fold change.
*   **LogFCLogFCPlot**: Compares log-fold changes between two different contrasts.

```r
library(iSEEu)
library(iSEE)

# Assuming 'se' has logFC and PValue in rowData
ma_panel <- MAPlot(PanelWidth=6L)
vol_panel <- VolcanoPlot(PanelWidth=6L)

iSEE(se, initial=list(ma_panel, vol_panel))
```

### 2. Dynamic Recalculation Panels
These panels react to selections made in other panels (the `ColumnSelectionSource`) to perform on-the-fly analysis.

*   **DynamicReducedDimensionPlot**: Performs PCA, t-SNE, or UMAP specifically on the subset of selected samples/cells.
*   **DynamicMarkerTable**: Computes differential expression statistics (using `scran::findMarkers`) comparing the active selection against unselected points or other saved selections.

```r
# Receives selection from 'ReducedDimensionPlot1'
dyn_res <- DynamicReducedDimensionPlot(
    Type="UMAP", 
    Assay="logcounts",
    ColumnSelectionSource="ReducedDimensionPlot1"
)

iSEE(sce, initial=list(ReducedDimensionPlot(PanelId=1L), dyn_res))
```

### 3. Feature Set Integration
The `FeatureSetTable` allows users to click on a biological pathway or gene set to highlight all constituent genes in other row-based panels.

```r
# Setup gene set commands (e.g., for Ensembl)
setFeatureSetCommands(createGeneSetCommands(identifier="ENSEMBL"))

gs_table <- FeatureSetTable(PanelWidth=6L)
vol_panel <- VolcanoPlot(RowSelectionSource="FeatureSetTable1", ColorBy="Row selection")

iSEE(se, initial=list(gs_table, vol_panel))
```

### 4. Pre-configured App Modes
Instead of manually defining panels, use "modes" for common tasks:

*   `modeEmpty()`: Launches an empty interface for data uploading.
*   `modeGating()`: Sets up linked FeatureAssayPlots for flow-like gating.
*   `modeReducedDim()`: Configures multiple dimensionality reduction views.

## Specialized Panels

*   **AggregatedDotPlot**: Visualizes average expression and detection rate across groups (similar to dot plots in Seurat/Scanpy).
*   **MarkdownBoard**: Displays rendered HTML from Markdown text, useful for providing instructions or notes within the app.

## Tips for Success
*   **Data Preparation**: For DE plots, ensure your `rowData` column names match expected patterns (e.g., "logFC", "PValue") or specify them explicitly in the panel constructor (e.g., `YAxis="alt.logFC"`).
*   **Selection Sources**: Always ensure the `ColumnSelectionSource` or `RowSelectionSource` string matches the `PanelId` of the transmitting panel (e.g., "ReducedDimensionPlot1").
*   **Panel Width**: Use `PanelWidth` (1-12) to control the layout of the dashboard.

## Reference documentation
- [Universe of iSEE panels](./references/iSEEu.md)