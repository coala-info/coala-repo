---
name: bioconductor-schex
description: This tool provides hexagonal binning and visualization to summarize cell density, metadata, and gene expression in large single-cell RNA-seq datasets. Use when user asks to overcome overplotting in reduced dimension plots, create hexagonal bins for SingleCellExperiment or Seurat objects, or plot summarized feature expression and metadata.
homepage: https://bioconductor.org/packages/release/bioc/html/schex.html
---


# bioconductor-schex

name: bioconductor-schex
description: Hexagonal binning and visualization for single-cell RNA-seq data. Use this skill to overcome overplotting in large single-cell datasets by summarizing cell information (density, metadata, or gene expression) into hexagonal bins for SingleCellExperiment or Seurat objects.

# bioconductor-schex

## Overview

The `schex` package provides a solution for the "overplotting" problem in single-cell data visualization. When plotting thousands of cells on reduced dimension plots (like UMAP or t-SNE), points overlap, obscuring the true density and distribution of features. `schex` bins cells into hexagons and calculates summary statistics (mean, median, majority) for each bin, providing a clearer representation of the data. It integrates seamlessly with `SingleCellExperiment` and `Seurat` objects.

## Core Workflow

### 1. Prepare the Data
Ensure your single-cell object has a reduced dimension representation (e.g., PCA, UMAP, TSNE) already calculated.

```r
library(schex)
library(Seurat)
library(SingleCellExperiment)

# For Seurat objects, it is often recommended to convert to SingleCellExperiment
sce <- as.SingleCellExperiment(seurat_obj)
```

### 2. Calculate Hexagonal Bins
Use `make_hexbin` to create the hexagonal grid. The `nbins` parameter is critical: higher values create smaller, more numerous bins (better for high cell counts).

```r
# Calculate hexbins based on UMAP coordinates
sce <- make_hexbin(sce, nbins = 40, dimension_reduction = "UMAP")
```

### 3. Visualization Functions

`schex` provides three primary plotting functions, all of which return `ggplot2` objects.

#### Plot Cell Density
Visualizes how many cells fall into each hexagon. This helps verify if the `nbins` parameter is appropriate.
```r
plot_hexbin_density(sce)
```

#### Plot Metadata
Summarize categorical or continuous metadata (e.g., cluster ID, total counts).
```r
# For categorical data (e.g., clusters), use action = "majority"
plot_hexbin_meta(sce, col = "cluster", action = "majority")

# For continuous data (e.g., library size), use action = "median" or "mean"
plot_hexbin_meta(sce, col = "total_counts", action = "median")
```

#### Plot Gene Expression (Features)
Summarize the expression of specific genes across the bins.
```r
plot_hexbin_feature(sce, 
                    type = "logcounts", 
                    feature = "CD1C", 
                    action = "mean", 
                    title = "Mean CD1C Expression")
```

### 4. Advanced Plotting and Customization
Since the output is a `ggplot` object, you can extend it using standard `ggplot2` syntax.

*   **Labeling Clusters:** Use `make_hexbin_label` to find the center of clusters for labeling with `ggrepel`.
*   **Combined Plots:** Use `plot_hexbin_feature_plus` to overlay feature expression with cluster boundaries.
*   **Theming:** Add `+ theme_void()` or other themes to customize the look.

```r
# Example: Adding labels to a hexbin plot
label_df <- make_hexbin_label(sce, col = "cluster")
p <- plot_hexbin_meta(sce, col = "cluster", action = "majority")
p + ggrepel::geom_label_repel(data = label_df, aes(x = x, y = y, label = label))
```

## Tips for Success
*   **Choosing nbins:** If the hexagons look too "blocky," increase `nbins`. If they are too sparse (many bins with only 1 cell), decrease `nbins`.
*   **Action Parameter:** Always match the `action` to the data type. Use "majority" for factors/clusters and "mean" or "median" for numerical values like gene expression or QC metrics.
*   **Object Compatibility:** While `schex` can work with Seurat objects directly in some versions, converting to `SingleCellExperiment` via `as.SingleCellExperiment()` ensures maximum compatibility with all `schex` functions.

## Reference documentation

- [Using schex with Seurat](./references/Seurat_to_SCE.md)
- [Plotting single cell data with schex](./references/using_schex.md)