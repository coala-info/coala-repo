---
name: bioconductor-dittoseq
description: "bioconductor-dittoseq provides color-blind friendly visualization and analysis for single-cell and bulk RNA-sequencing data. Use when user asks to create dimensionality reduction plots, analyze cell composition with bar plots, generate heatmaps, or visualize gene expression distributions from Seurat and Bioconductor objects."
homepage: https://bioconductor.org/packages/release/bioc/html/dittoSeq.html
---


# bioconductor-dittoseq

name: bioconductor-dittoseq
description: Visualization and analysis of single-cell and bulk RNA-sequencing data using dittoSeq. Use this skill to create color-blind friendly plots (dim plots, bar plots, heatmaps, violin plots) from Seurat, SingleCellExperiment, or SummarizedExperiment objects.

# bioconductor-dittoseq

## Overview
`dittoSeq` is an R package designed for the visualization of single-cell and bulk RNA-sequencing data. It is specifically built to be accessible to novice coders and is optimized for color-blind friendliness by default. It works natively with common Bioconductor and Seurat objects, providing a consistent interface for generating publication-quality figures like UMAPs, dot plots, and heatmaps.

## Core Workflows

### 1. Data Compatibility
`dittoSeq` functions accept the following objects as the `object` argument:
- **Single-Cell:** `Seurat` (v2+) and `SingleCellExperiment` (SCE).
- **Bulk:** `SummarizedExperiment`, `DESeqDataSet`, and `DGEList`.
- **Importing Bulk:** Use `importDittoBulk(x, metadata, reductions)` to convert matrices or DGELists into a `dittoSeq`-compatible SCE structure.

### 2. Essential Visualization Functions
Most functions follow a standard naming convention: `ditto[PlotType]`.

- **Dimensionality Reduction:** `dittoDimPlot(object, var, reduction.use)`
  - Visualizes metadata or gene expression on UMAP/tSNE/PCA.
  - Use `do.label = TRUE` or `do.ellipse = TRUE` for cluster annotations.
- **Composition Analysis:** `dittoBarPlot(object, var, group.by)`
  - Shows cell type frequencies across samples. Use `scale = "count"` for raw numbers instead of percentages.
- **Expression Distributions:** `dittoPlot(object, var, group.by)`
  - A versatile function for violin, box, and jitter plots.
  - Wrappers: `dittoRidgePlot()` and `dittoBoxPlot()`.
- **Heatmaps:** `dittoHeatmap(object, genes, annot.by)`
  - Wrapper for `pheatmap`. Use `scaled.to.max = TRUE` to normalize expression [0,1].
- **Multi-variable Summaries:**
  - `dittoDotPlot()`: Summarizes expression level (color) and percent of cells expressing (size).
  - `multi_dittoDimPlot()`: Generates a grid of plots for multiple genes.

### 3. Helper Functions
Use these to explore your object before plotting:
- `getMetas(object)`: List all available metadata slots.
- `getGenes(object)`: List all available genes.
- `getReductions(object)`: List available dimensionality reductions (e.g., "PCA", "UMAP").
- `isBulk(object)`: Check if the object is flagged as bulk or single-cell.

## Key Parameters and Customization

### Common Inputs
- `var`: The metadata or gene to plot.
- `group.by`: The metadata used to group cells on the x-axis.
- `split.by`: Creates facets (sub-plots) based on metadata.
- `cells.use`: Subset the plot to specific cells (accepts names, indices, or logical vectors).
- `color.panel`: Provide a custom vector of colors.
- `data.out = TRUE`: Returns a list containing the ggplot object (`$p`) and the underlying data frame (`$data`).

### Interactive and Large Data Features
- **Interactivity:** Set `do.hover = TRUE` to create a `plotly` object. Specify `hover.data` to choose which metadata appears on hover.
- **Rasterization:** For large datasets (>50k cells), use `do.raster = TRUE` and `raster.dpi = 300` to keep file sizes manageable while preserving vector axes.

## Reference documentation
- [Using dittoSeq to visualize (sc)RNAseq data](./references/dittoSeq.md)