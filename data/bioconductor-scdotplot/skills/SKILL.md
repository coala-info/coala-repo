---
name: bioconductor-scdotplot
description: This tool creates hierarchical clustered dot plots with integrated dendrograms and annotations for single-cell RNA-seq data. Use when user asks to create clustered dot plots, visualize marker gene expression across cell clusters, or add dendrograms and metadata annotations to single-cell visualizations.
homepage: https://bioconductor.org/packages/release/bioc/html/scDotPlot.html
---

# bioconductor-scdotplot

name: bioconductor-scdotplot
description: Create hierarchical clustered dot plots for single-cell RNA-seq data using SingleCellExperiment or Seurat objects. Use this skill when you need to visualize relationships between cell groupings (clusters) and marker gene expression with integrated dendrograms and row/column annotations.

## Overview

The `scDotPlot` package provides a unified interface for generating publication-quality dot plots that incorporate hierarchical clustering. It extends the functionality of `scater::plotDots()` and `Seurat::DotPlot()` by using the `aplot` and `ggtree` packages to add dendrograms and metadata annotations to the plot axes.

## Core Workflow

### 1. Data Preparation
The package supports `SingleCellExperiment` and `Seurat` objects. Ensure your object is normalized and contains the necessary metadata for grouping.

```r
library(scDotPlot)

# For SingleCellExperiment
# Ensure logcounts assay exists
# For Seurat
# Ensure DefaultAssay is set correctly
```

### 2. Feature Selection
Identify the genes (features) you wish to plot. It is often helpful to map these features to specific categories (e.g., cell-type markers) to enable row annotations.

### 3. Generating the Plot
The primary function is `scDotPlot()`. Key arguments include:

*   `features`: A character vector of gene IDs or a named vector where names represent categories for annotation.
*   `group`: The metadata column used for the x-axis (e.g., "cluster" or "cell_type").
*   `groupAnno`: Metadata column for column-side color annotations.
*   `featureAnno`: Metadata column or vector names for row-side color annotations.
*   `scale`: Logical. Set to `TRUE` to plot Z-scores (recommended for better clustering results).
*   `annoColors`: A named list of color vectors for the annotations.

## Example Usage

### With SingleCellExperiment
```r
scDotPlot(sce,
          features = marker_genes,
          group = "cluster_id",
          groupAnno = "broad_type",
          featureAnno = "Marker_Category",
          scale = TRUE,
          annoColors = list("broad_type" = c("TypeA" = "red", "TypeB" = "blue")))
```

### With Seurat
```r
scDotPlot(seurat_obj,
          features = top_markers,
          group = "seurat_clusters",
          groupAnno = "orig.ident",
          scale = TRUE)
```

## Tips for Success
*   **Clustering Quality**: If the dendrograms look messy, ensure `scale = TRUE` is used. This calculates Z-scores, preventing high-abundance genes from dominating the clustering distance matrix.
*   **Annotation Width**: Use the `annoWidth` argument (default is often small) to adjust the thickness of the color bars next to the dendrograms.
*   **Legends**: If the plot area is too crowded, use `groupLegends = FALSE` to hide annotation legends.
*   **Integration**: Since the output uses `aplot`, you can further manipulate the resulting object using standard `ggplot2` logic or `aplot` alignment functions.

## Reference documentation
- [scDotPlot](./references/scDotPlot.md)