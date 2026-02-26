---
name: bioconductor-iseefier
description: The iSEEfier package automates the configuration of iSEE dashboards by providing predefined recipes for complex visualization layouts. Use when user asks to generate initial dashboard states, visualize specific gene expression patterns, explore gene set enrichment results, or identify and display marker genes.
homepage: https://bioconductor.org/packages/release/bioc/html/iSEEfier.html
---


# bioconductor-iseefier

## Overview

The `iSEEfier` package simplifies the setup of `iSEE` dashboards by providing "recipes" for initial configurations. Instead of manually configuring panels in the `iSEE` interface, you can use `iSEEfier` to generate `initial` objects that define specific layouts (e.g., linking reduced dimension plots to feature assays for specific genes). It is particularly useful for automating the visualization of marker genes, gene set enrichment results, and cluster-specific expression patterns.

## Core Workflows

### 1. Gene Expression Visualization with `iSEEinit()`
Use `iSEEinit()` to create a dashboard focused on a specific list of features (genes).

```r
library(iSEEfier)
library(iSEE)

# Requirement: A SingleCellExperiment (sce) with reduced dims and logcounts
initial_state <- iSEEinit(
  sce = sce,
  features = c("Gcg", "Ins1"),      # Genes of interest
  reddim_type = "TSNE",             # Embedding to show
  clusters = "label",               # colData column for coloring
  groups = "strain",                # colData column for grouping
  add_markdown_panel = TRUE         # Optional: include text panel
)

# Launch iSEE with the generated configuration
iSEE(sce, initial = initial_state)
```

### 2. Feature Set Exploration with `iSEEnrich()`
Use `iSEEnrich()` to visualize gene sets (GO/KEGG) and their constituent genes.

```r
results <- iSEEnrich(
  sce = sce,
  collection = "GO",
  gene_identifier = "SYMBOL",
  organism = "org.Mm.eg.db",
  clusters = "label",
  reddim_type = "PCA"
)

# iSEEnrich returns a list containing the updated sce and the initial state
iSEE(results$sce, initial = results$initial)
```

### 3. Marker Gene Exploration with `iSEEmarker()`
Use `iSEEmarker()` to automatically identify markers (via `scran::findMarkers`) and set up a `DynamicMarkerTable` linked to visualization panels.

```r
initial_marker <- iSEEmarker(
  sce = sce,
  clusters = "label",
  groups = "strain",
  selection_plot_format = "ColumnDataPlot"
)

iSEE(sce, initial = initial_marker)
```

## Configuration Management

### Merging Configurations
You can combine multiple initial states into a single dashboard using `glue_initials()`.

```r
combined_config <- glue_initials(initial_state, results$initial)
iSEE(results$sce, initial = combined_config)
```

### Previewing Layouts
Before launching the Shiny app, you can visualize the panel layout or the communication network between panels.

```r
# View panel tiles (requires ggplot2)
view_initial_tiles(initial = initial_state)

# View panel dependencies/links
g <- view_initial_network(initial_state, plot_format = "igraph")
plot(g)
```

## Tips for Success
- **Object Compatibility**: Ensure your `SingleCellExperiment` object has the necessary `reducedDims` (PCA, TSNE, UMAP) and `assays` (logcounts) before calling `iSEEfier` functions.
- **Column Names**: The `clusters` and `groups` arguments must exactly match column names in `colData(sce)`.
- **Feature Identifiers**: When using `iSEEnrich`, ensure the `gene_identifier` matches the rownames of your `sce` object (e.g., "SYMBOL" vs "ENSEMBL").
- **iSEE vs iSEEu**: While `iSEEu` provides fixed "modes", `iSEEfier` creates "initial" objects that are more tailored to your specific data and gene lists.

## Reference documentation
- [The iSEEfier User's Guide](./references/iSEEfier_userguide.md)
- [iSEEfier Rmarkdown Source](./references/iSEEfier_userguide.Rmd)