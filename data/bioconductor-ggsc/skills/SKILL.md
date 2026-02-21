---
name: bioconductor-ggsc
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ggsc.html
---

# bioconductor-ggsc

name: bioconductor-ggsc
description: A specialized skill for visualizing single-cell RNA-seq data using the ggsc R package. Use this skill when you need to create high-quality, ggplot2-based visualizations for single-cell data, specifically for dimension reduction plots (UMAP, t-SNE), spatial transcriptomics, and multi-panel layouts of gene expression.

# bioconductor-ggsc

## Overview
The `ggsc` package is designed to extend the `ggplot2` ecosystem for single-cell data visualization. It provides a streamlined interface for plotting dimension reduction results and spatial transcriptomics data directly from Bioconductor objects (like `SingleCellExperiment`) or Seurat objects. It focuses on performance and aesthetic consistency, allowing for easy customization of point sizes, colors, and multi-gene layouts.

## Core Workflows

### Loading the Package
```r
library(ggsc)
library(ggplot2)
```

### Dimension Reduction Plotting
The primary function for UMAP, t-SNE, or PCA visualization is `sc_dim()`. It automatically detects coordinates from the input object.

```r
# Basic UMAP/t-SNE colored by a specific cluster or metadata column
sc_dim(sce_object, reduction = "UMAP", mapping = aes(color = cluster)) +
    scale_color_manual(values = my_colors)

# Adjusting point size and transparency
sc_dim(sce_object, size = 0.5, alpha = 0.8)
```

### Visualizing Gene Expression
To visualize the expression of specific genes across cells, use `sc_feature()`.

```r
# Plot expression of a single gene
sc_feature(sce_object, features = "CD8A")

# Plot multiple genes in a grid
sc_feature(sce_object, features = c("CD8A", "CD4", "NKG7"), ncol = 2)
```

### Spatial Transcriptomics
For spatial data, `sc_spatial()` allows for plotting cells or spots in their physical coordinates.

```r
# Plot spatial distribution colored by cluster
sc_spatial(spatial_object, mapping = aes(color = cluster))
```

### Customization Tips
- **ggplot2 Compatibility**: Since `ggsc` returns `ggplot` objects, you can append standard layers like `theme_minimal()`, `labs()`, or `facet_wrap()`.
- **Data Integration**: The functions are compatible with `SingleCellExperiment`, `Seurat`, and data frames containing coordinate columns.
- **Performance**: `ggsc` is optimized to handle large datasets more efficiently than standard `geom_point()` calls by utilizing optimized rendering for many points.

## Reference documentation
- [Visualizing single cell data](./references/ggsc.md)