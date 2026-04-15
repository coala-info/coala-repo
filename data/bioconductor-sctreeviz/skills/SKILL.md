---
name: bioconductor-sctreeviz
description: scTreeViz provides an interactive dashboard for exploring hierarchical structures and gene expression in single-cell RNA sequencing data. Use when user asks to visualize cluster hierarchies, create interactive heatmaps for scRNA-seq data, or explore linked dimensionality reduction plots.
homepage: https://bioconductor.org/packages/release/bioc/html/scTreeViz.html
---

# bioconductor-sctreeviz

## Overview

`scTreeViz` is a Bioconductor package designed for the interactive exploration of single-cell RNA sequencing (scRNA-seq) data. It specializes in visualizing hierarchical features, such as clusters at multiple resolutions or taxonomic hierarchies. The package wraps data into a `TreeViz` object (extending `SummarizedExperiment`) and provides a linked-view dashboard featuring facet zooms for hierarchy navigation, heatmaps for expression, and scatter plots for dimensionality reductions.

## Core Workflow

### 1. Data Preparation

The package supports direct conversion from common single-cell objects.

**From SingleCellExperiment:**
```r
library(scTreeViz)
library(scater)

# Ensure dimensionality reductions exist
sce <- runUMAP(sce)
sce <- runPCA(sce)

# Option A: No clusters in colData (generates walktrap hierarchy automatically)
treeViz <- createFromSCE(sce, reduced_dim = c("UMAP", "PCA"))

# Option B: Using existing clusters in colData
# col_regex identifies columns containing cluster assignments at different resolutions
treeViz <- createFromSCE(sce, check_coldata = TRUE, col_regex = "clust", reduced_dim = c("UMAP", "PCA"))
```

**From Seurat:**
```r
library(Seurat)

# Find clusters at multiple resolutions
pbmc <- FindClusters(pbmc, resolution = seq(0, 1, by = 0.1))
pbmc <- RunUMAP(pbmc, dims = 1:10)

# Convert to TreeViz
treeViz <- createFromSeurat(pbmc, check_metadata = TRUE, reduced_dim = c("umap", "pca"))
```

**From Raw Matrices:**
```r
# counts: gene x cell matrix
# hierarchy_df: cell x resolution dataframe
treeViz <- createTreeViz(hierarchy_df, counts)
```

### 2. Interactive Visualization

Launch the interactive dashboard to explore the data.

```r
# Start the app with the top 500 most variable genes in the heatmap
app <- startTreeviz(treeViz, top_genes = 500)
```

### 3. Programmatic Interaction

While the app is running, you can push specific visualizations from the R session to the browser.

```r
# Plot expression of a specific gene across the cluster hierarchy
app$plotGene(gene = "AIF1")

# Stop the app and close the websocket connection
app$stop_app()
```

## Key Functions

- `createFromSCE()`: Converts `SingleCellExperiment` objects; can auto-generate hierarchies if missing.
- `createFromSeurat()`: Converts `Seurat` objects, preserving metadata and reductions.
- `createTreeViz()`: Constructor for manual creation from count matrices and hierarchy data frames.
- `startTreeviz()`: Launches the Epiviz-based interactive web application.
- `plotGene()`: Method within the app object to visualize specific gene expression boxplots.

## Tips for Success

- **Dimensionality Reductions**: Always ensure that UMAP, TSNE, or PCA coordinates are computed and named correctly in the source object before conversion.
- **Cluster Naming**: When using `check_coldata = TRUE`, ensure your cluster columns share a common prefix (e.g., "cluster_res_0.1", "cluster_res_0.2") so `col_regex` can identify them.
- **Memory Management**: For very large datasets, limit the `top_genes` parameter in `startTreeviz` to maintain dashboard responsiveness.

## Reference documentation

- [Interactively explore and visualize Single Cell RNA seq data](./references/ExploreTreeViz.md)