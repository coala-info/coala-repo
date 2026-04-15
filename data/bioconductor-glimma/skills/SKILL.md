---
name: bioconductor-glimma
description: Glimma generates interactive HTML widgets for exploring differential expression analysis results from limma, edgeR, and DESeq2 workflows. Use when user asks to create interactive MDS plots, generate dynamic MA or volcano plots, or explore gene expression across samples through sortable tables and linked visualizations.
homepage: https://bioconductor.org/packages/release/bioc/html/Glimma.html
---

# bioconductor-glimma

## Overview

Glimma is a Bioconductor package that generates interactive HTML widgets for differential expression (DE) analysis. It bridges the gap between static R plots and interactive data exploration by using the Vega and htmlwidgets frameworks. It is primarily used to explore results from `limma`, `edgeR`, and `DESeq2` workflows, allowing users to click on summary plot points to view individual gene expression across samples and search through sortable gene tables.

## Core Workflows

### 1. Multidimensional Scaling (MDS) Plots
Used for unsupervised clustering to explore sample similarities and batch effects.

```r
library(Glimma)

# For edgeR/limma (DGEList or matrix)
glimmaMDS(dge)

# For DESeq2 (DESeqDataSet)
glimmaMDS(dds)

# Customizing the interactive interface
glimmaMDS(dge, 
          groups = dge$samples$group, 
          width = 1000, 
          height = 600,
          continuous.color = TRUE) # Useful for expression-based coloring
```

### 2. MA and Volcano Plots
These plots link a summary statistic (Log Fold Change vs Mean Expression or P-value) to a secondary plot showing individual sample expression for the selected gene.

**Using limma/edgeR:**
```r
# After fitting model (e.g., efit from eBayes or glrt from glmLRT)
glimmaMA(efit, dge = dge)
glimmaVolcano(efit, dge = dge)
```

**Using DESeq2:**
```r
# After running DESeq(dds)
glimmaMA(dds)
```

### 3. Single-Cell Data (Pseudo-bulk)
Glimma is effective for single-cell data when aggregated into pseudo-bulk samples. For raw single-cell visualization, it is recommended to down-sample to a few hundred cells to maintain performance.

```r
# Visualizing pseudo-bulk results with single-cell expression background
glimmaMA(pb_lrt, dge = sc_dge[, sample(1:ncol(sc_dge), 100)])
```

## Key Function Arguments

- `groups`: A vector or data frame for sample metadata (used for coloring/scaling in MDS).
- `status.cols`: A character vector of 3 CSS colors (e.g., `c("blue", "grey", "red")`) to represent Down, Not-Sig, and Up regulated genes.
- `sample.cols`: A vector of colors for individual samples in the expression plot.
- `anno`: A data frame of gene annotations (must match row order of counts).
- `display.columns`: Character vector of annotation columns to show in the interactive table.
- `transform.counts`: Strategy for expression plot: `"logcpm"` (default), `"rpkm"`, `"cpm"`, or `"none"`.

## Saving and Embedding

Glimma plots are htmlwidgets. They embed automatically in R Markdown/Quarto HTML outputs. To save as standalone files:

```r
library(htmlwidgets)
widget <- glimmaMA(dds)
saveWidget(widget, "interactive_ma_plot.html")
```

## Tips for Success

- **Performance**: Interactive plots with tens of thousands of points can be slow. Use `display.columns` to limit table metadata and consider down-sampling for single-cell expression plots.
- **Search**: The interactive search bar in the gene table allows for quick lookup by Gene Symbol or ID, but it is disabled if points are currently selected in the plot.
- **Export**: Users can export the current view as PNG or SVG directly from the HTML widget using the "Save Plot" or "Save Data" buttons.

## Reference documentation

- [DESeq2 Workflow](./references/DESeq2.md)
- [Introduction using limma or edgeR](./references/limma_edger.md)
- [Single Cells with edgeR](./references/single_cell_edger.md)