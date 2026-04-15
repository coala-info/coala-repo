---
name: bioconductor-clustifyr
description: clustifyr automates the annotation of single-cell RNA-seq clusters by comparing query datasets against reference data or marker gene lists. Use when user asks to annotate scRNA-seq clusters, compare single-cell data to reference matrices, or build custom reference profiles from annotated datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/clustifyr.html
---

# bioconductor-clustifyr

## Overview

`clustifyr` is an R package designed to automate the annotation of single-cell RNA-seq (scRNA-seq) clusters. It bypasses the need for manual marker gene inspection by comparing query datasets against reference data (bulk RNA-seq or aggregated scRNA-seq) using correlation-based metrics or marker gene lists. It integrates seamlessly with common scRNA-seq frameworks like `Seurat` and `SingleCellExperiment`.

## Core Workflow

### 1. Data Preparation
The package requires a query object (matrix, Seurat, or SCE) and a reference matrix where columns represent cell types and rows represent genes.

```r
library(clustifyr)

# Load query data (example using Seurat)
# so <- readRDS("seurat_obj.rds")

# Load or create a reference matrix
# ref_mat <- readRDS("reference_matrix.rds")
```

### 2. Automated Annotation (Correlation-based)
The `clustify()` function is the primary interface. It calculates similarity (default: Spearman correlation) between clusters and the reference.

```r
# For Seurat objects
res <- clustify(
  input = so,
  ref_mat = cbmc_ref,
  cluster_col = "seurat_clusters",
  obj_out = TRUE  # Returns Seurat object with 'type' and 'r' in metadata
)

# For Matrix input
res_mat <- clustify(
  input = pbmc_matrix,
  metadata = pbmc_meta,
  cluster_col = "seurat_clusters",
  ref_mat = cbmc_ref,
  query_genes = pbmc_vargenes
)
```

### 3. Annotation using Marker Lists
If a reference matrix is unavailable, use `clustify_lists()` with a table of known marker genes.

```r
# marker_file: columns are cell types, rows are marker genes
list_res <- clustify_lists(
  input = pbmc_matrix,
  metadata = pbmc_meta,
  cluster_col = "seurat_clusters",
  marker = marker_table,
  metric = "pct" # Options: "hyper", "jaccard", "spearman", "gsea"
)
```

### 4. Building References
You can generate your own reference matrices from existing annotated single-cell datasets.

```r
# From a matrix
new_ref <- average_clusters(
  mat = pbmc_matrix,
  metadata = pbmc_meta,
  cluster_col = "classified",
  if_log = TRUE
)

# From Seurat/SCE objects
new_ref_so <- seurat_ref(so, cluster_col = "cell_type")
new_ref_sce <- object_ref(sce, cluster_col = "cell_type")
```

## Interpreting and Visualizing Results

### Converting Correlations to Calls
If `obj_out = FALSE`, use helper functions to assign identities.

```r
# Get best call for each cluster
calls <- cor_to_call(cor_mat = res_mat, cluster_col = "seurat_clusters")

# Add calls back to metadata
pbmc_meta <- call_to_metadata(res = calls, metadata = pbmc_meta, cluster_col = "seurat_clusters")
```

### Visualization
`clustifyr` provides specialized plotting functions to evaluate the confidence of assignments.

```r
# Heatmap of correlation coefficients
plot_cor_heatmap(cor_mat = res_mat)

# Map correlation of a specific cell type onto UMAP
plot_cor(
  cor_mat = res_mat,
  metadata = pbmc_meta,
  data_to_plot = "CD8 T",
  cluster_col = "seurat_clusters"
)

# Label clusters on UMAP with best calls
plot_best_call(res_mat, metadata = pbmc_meta, cluster_col = "seurat_clusters")
```

## Tips for Success
- **Gene Selection**: Using highly variable genes (`query_genes`) significantly improves the signal-to-noise ratio in correlations.
- **Log Transformation**: Ensure the `if_log` parameter in `average_clusters()` matches your input data state.
- **Reference Quality**: The accuracy of `clustifyr` depends heavily on the relevance of the `ref_mat`. Use `clustifyrdata` or GEO-derived metadata to find appropriate references.

## Reference documentation
- [Introduction to clustifyr](./references/clustifyr.md)
- [Improving NCBI GEO submissions](./references/geo-annotations.md)