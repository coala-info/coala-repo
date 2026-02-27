---
name: bioconductor-scmap
description: This tool projects single-cell RNA-seq data from a query experiment onto cell-type clusters or individual cells of a reference dataset. Use when user asks to map cells to a reference, perform feature selection for cross-dataset comparisons, or project query cells onto predefined clusters or individual cells.
homepage: https://bioconductor.org/packages/release/bioc/html/scmap.html
---


# bioconductor-scmap

name: bioconductor-scmap
description: Projection of single-cell RNA-seq data across datasets. Use when Claude needs to map cells from a query scRNA-seq experiment onto cell-type clusters or individual cells of a reference dataset, perform feature selection for cross-dataset comparisons, or visualize cell mapping results.

# bioconductor-scmap

## Overview

`scmap` is a tool for projecting cells from a query scRNA-seq dataset onto a reference dataset. It supports two main workflows: `scmap-cluster` (mapping cells to clusters/cell-types) and `scmap-cell` (mapping cells to individual cells using a product quantizer algorithm). It relies on the `SingleCellExperiment` (SCE) class.

## Data Preparation

Ensure your data is in a `SingleCellExperiment` object.

1.  **Required Slots**: The object must contain a `logcounts` assay.
2.  **Feature Symbols**: Store gene names in `rowData(sce)$feature_symbol`.
3.  **Cell Labels**: For reference datasets, cluster labels must be in `colData(sce)$cell_type1`.

```r
library(SingleCellExperiment)
library(scmap)

# Example setup
sce <- SingleCellExperiment(assays = list(logcounts = as.matrix(your_data)))
rowData(sce)$feature_symbol <- rownames(sce)
```

## Feature Selection

Select the most informative genes for projection. By default, `scmap` selects 500 features.

```r
# Select features and store in rowData(sce)$scmap_features
sce <- selectFeatures(sce, n_features = 500, suppress_plot = FALSE)
```

## scmap-cluster Workflow

Use this to project query cells onto predefined clusters in a reference.

### 1. Indexing the Reference
Create an index by calculating the median gene expression for each cluster.

```r
# Uses colData(sce)$cell_type1 by default
sce <- indexCluster(sce)

# View the index
head(metadata(sce)$scmap_cluster_index)
```

### 2. Projection
Project the query dataset onto the reference index.

```r
scmapCluster_results <- scmapCluster(
  projection = query_sce, 
  index_list = list(ref_name = metadata(ref_sce)$scmap_cluster_index)
)

# Access labels and similarity scores
labels <- scmapCluster_results$scmap_cluster_labs
similarities <- scmapCluster_results$scmap_cluster_siml
```

## scmap-cell Workflow

Use this to project query cells onto individual cells in a reference. This method is stochastic; set a seed for reproducibility.

### 1. Indexing the Reference
Uses a product quantizer algorithm to index individual cells.

```r
set.seed(1)
sce <- indexCell(sce)
```

### 2. Projection
Find the nearest neighbors in the reference for each query cell.

```r
scmapCell_results <- scmapCell(
  query_sce, 
  list(ref_name = metadata(ref_sce)$scmap_cell_index)
)
```

### 3. Cluster Annotation
Convert cell-to-cell mappings into cluster assignments based on the nearest neighbors.

```r
scmapCell_clusters <- scmapCell2Cluster(
  scmapCell_results, 
  list(as.character(colData(ref_sce)$cell_type1))
)
```

## Visualization

Visualize the mapping between query clusters and reference clusters using a Sankey diagram.

```r
# Requires both datasets to have cluster labels
plot(
  getSankey(
    colData(query_sce)$cell_type1, 
    scmapCluster_results$scmap_cluster_labs[,'ref_name'],
    plot_height = 400
  )
)
```

## Tips and Best Practices

- **Thresholds**: `scmap` assigns "unassigned" if the maximum similarity is below the threshold (default 0.7 for cluster, 0.5 for cell). Adjust these in `scmapCluster` or `scmapCell2Cluster` if needed.
- **Multiple References**: Both `scmapCluster` and `scmapCell` accept a list of indexes, allowing simultaneous projection against multiple reference datasets.
- **Feature Consistency**: Ensure that the `feature_symbol` names used in the query and reference datasets are compatible (e.g., same case, same nomenclature).

## Reference documentation

- [scmap package vignette](./references/scmap.Rmd)
- [scmap package vignette (Markdown)](./references/scmap.md)