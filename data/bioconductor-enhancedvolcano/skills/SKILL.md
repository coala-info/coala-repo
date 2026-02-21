---
name: bioconductor-enhancedvolcano
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/EnhancedVolcano.html
---

# bioconductor-enhancedvolcano

name: bioconductor-enhancedvolcano
description: Create highly-configurable, publication-ready volcano plots from differential expression results. Use when the user needs to visualize gene expression data (log2 fold changes vs. p-values) with advanced labeling, custom coloring, or specific highlighting of genes of interest.

# bioconductor-enhancedvolcano

## Overview

EnhancedVolcano is a Bioconductor package designed to produce professional volcano plots from differential expression data. It offers extensive customization for point colors, shapes, sizes, and labeling. It handles label overlapping automatically and allows for specific gene highlighting through connectors, boxes, and encircling.

## Installation

Install the package using BiocManager:

```r
if (!requireNamespace('BiocManager', quietly = TRUE))
    install.packages('BiocManager')
BiocManager::install('EnhancedVolcano')
```

## Basic Workflow

To generate a plot, provide a data frame containing log fold changes and p-values.

```r
library(EnhancedVolcano)

# res is a data frame or DESeqResults object
EnhancedVolcano(res,
    lab = rownames(res),
    x = 'log2FoldChange',
    y = 'pvalue',
    title = 'Differential Expression',
    pCutoff = 10e-6,
    FCcutoff = 2.0)
```

## Key Customization Patterns

### Labeling Specific Genes
Use `selectLab` to only show labels for specific genes of interest, regardless of significance.

```r
EnhancedVolcano(res,
    lab = rownames(res),
    x = 'log2FoldChange',
    y = 'pvalue',
    selectLab = c('GeneA', 'GeneB', 'GeneC'),
    drawConnectors = TRUE,
    widthConnectors = 0.75)
```

### Custom Coloring and Shading
Override default colors using `colCustom` with a named vector.

```r
keyvals <- ifelse(
    res$log2FoldChange < -2.5, 'royalblue',
    ifelse(res$log2FoldChange > 2.5, 'gold', 'black'))
names(keyvals)[keyvals == 'gold'] <- 'high'
names(keyvals)[keyvals == 'black'] <- 'mid'
names(keyvals)[keyvals == 'royalblue'] <- 'low'

EnhancedVolcano(res,
    lab = rownames(res),
    x = 'log2FoldChange',
    y = 'pvalue',
    colCustom = keyvals)
```

### Visual Enhancements
- **Connectors**: Set `drawConnectors = TRUE` to link labels to points.
- **Boxed Labels**: Set `boxedLabels = TRUE` for better readability.
- **Encircling**: Use `encircle` with a vector of gene names to draw a boundary around specific points (requires `ggalt`).
- **Shading**: Use `shade` to highlight a region of points.

### Adjusting Thresholds and Appearance
- `pCutoff`: Statistical significance threshold (default 10e-6).
- `FCcutoff`: Log2 fold change threshold (default 2.0).
- `pointSize` and `labSize`: Control the size of dots and text.
- `colAlpha`: Control transparency (0 to 1).
- `legendPosition`: Change to 'top', 'bottom', 'left', 'right', or 'none'.

## Tips for Success
- **Data Preparation**: Ensure the input data frame does not have `NA` values in the columns mapped to `x` and `y`.
- **Label Parsing**: Set `parseLabels = TRUE` if using mathematical expressions or italics in gene labels.
- **Coordinate Flip**: Add `+ coord_flip()` to the function call to rotate the plot.
- **Integration**: The output is a `ggplot2` object, so it can be further modified using standard ggplot2 layers (e.g., `+ theme_bw()`).

## Reference documentation
- [EnhancedVolcano: publication-ready volcano plots with enhanced colouring and labeling](./references/EnhancedVolcano.Rmd)
- [EnhancedVolcano Vignette](./references/EnhancedVolcano.md)