---
name: bioconductor-iseetree
description: bioconductor-iseetree provides an interactive interface for visualizing and exploring hierarchical microbiome and phylogenetic data stored in TreeSummarizedExperiment objects. Use when user asks to launch interactive dashboards for compositional analysis, visualize phylogenetic trees, perform ordination exploration, or analyze community structure through specialized iSEE panels.
homepage: https://bioconductor.org/packages/release/bioc/html/iSEEtree.html
---

# bioconductor-iseetree

name: bioconductor-iseetree
description: Interactive visualization and exploration of hierarchical data (microbiome, phylogenetics) using TreeSummarizedExperiment objects. Use this skill to launch iSEE interfaces with specialized panels for compositional analysis, ordination (RDA, Scree, Loading plots), and structural analysis (Row/Column trees and graphs).

## Overview
iSEEtree is a Bioconductor package that extends the `iSEE` interactive ecosystem specifically for hierarchical data stored in `TreeSummarizedExperiment` (TreeSE) containers. It integrates statistical tools from the `mia` and `miaViz` packages into a GUI, allowing users to explore community composition, dimensionality reduction, and phylogenetic/network structures without writing complex plotting code.

## Core Workflow

### 1. Data Preparation
iSEEtree requires a `TreeSummarizedExperiment` object. Common preprocessing steps include transforming assays (e.g., to relative abundance) and calculating reduced dimensions.

```r
library(iSEEtree)
library(mia)
library(scater)

# Load example data
data("Tengeler2020", package = "mia")
tse <- Tengeler2020

# Transform assay to relative abundance
tse <- transformAssay(tse, method = "relabundance")

# Calculate MDS/PCoA for ordination panels
tse <- runMDS(tse, assay.type = "relabundance")
```

### 2. Launching the Interface
The primary function is `iSEE()`. When called on a `TreeSE` object with `iSEEtree` loaded, specialized panels become available.

```r
if (interactive()) {
  iSEE(tse)
}
```

## Specialized Panels

### Compositional Analysis
*   **AbundancePlot**: Barplots of feature composition per sample. Supports taxonomic rank selection and absolute vs. relative abundance.
*   **AbundanceDensityPlot**: Visualizes feature distribution across samples using jitter, density, or dot plots.
*   **PrevalencePlot**: Shows feature abundance vs. prevalence with adjustable detection thresholds.

### Ordination Analysis
*   **RDAPlot**: Visualizes supervised Redundancy Analysis (requires `runRDA` to be performed on the object first).
*   **ScreePlot**: Displays variance explained by each component.
*   **LoadingPlot**: Shows feature contributions to specific dimensions (barplot, heatmap, or lollipop layouts).

### Structural Analysis
*   **RowTreePlot / ColumnTreePlot**: Visualizes the phylogenetic or hierarchical tree of features or samples. Supports collapsing clades and labeling nodes.
*   **RowGraphPlot / ColumnGraphPlot**: Visualizes network relationships between features or samples.

## Tips for Effective Use
*   **Pre-calculate Statistics**: While the UI is interactive, complex calculations like RDA or UMAP should be performed on the `TreeSE` object using `mia` or `scater` functions before launching `iSEE` to ensure smooth performance.
*   **Panel Communication**: Like standard `iSEE`, you can transmit selections from a `RowDataTable` or `ColumnDataTable` to filter the data shown in specialized `iSEEtree` plots.
*   **Taxonomic Ranks**: Ensure your `TreeSE` object has `rowData` populated with taxonomic information to utilize the rank-switching features in `AbundancePlot`.

## Reference documentation
- [iSEEtree: interactive explorer for hierarchical data](./references/iSEEtree.md)
- [iSEEtree Panel Catalogue](./references/panels.md)