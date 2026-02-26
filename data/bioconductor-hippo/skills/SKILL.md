---
name: bioconductor-hippo
description: bioconductor-hippo performs hierarchical clustering and feature selection on single-cell RNA-seq data using Poisson-based modeling. Use when user asks to diagnose cell heterogeneity, perform iterative hierarchical clustering, conduct feature selection based on zero-inflation, or visualize clustering results with UMAP and t-SNE.
homepage: https://bioconductor.org/packages/release/bioc/html/HIPPO.html
---


# bioconductor-hippo

name: bioconductor-hippo
description: Use this skill to perform feature selection and hierarchical clustering on single-cell RNA-seq data using the HIPPO package. It is specifically designed for identifying cell heterogeneity through zero-inflation and Poisson-based modeling. Use this skill when you need to: (1) Diagnose cell heterogeneity via zero-inflation plots, (2) Perform iterative hierarchical clustering, (3) Conduct feature selection based on deviance or zero-inflation, (4) Visualize clustering results with UMAP/t-SNE, or (5) Perform differential expression analysis between clusters.

## Overview

HIPPO (Hierarchical Iterative Poisson Propagation Object) is an R package for single-cell RNA-seq analysis that leverages the observation that zero-inflation in gene expression is often driven by cell heterogeneity. It iteratively selects features and clusters cells, providing a natural hierarchy of cell types. Unlike methods that rely on highly variable genes, HIPPO focuses on genes that deviate from a Poisson distribution (expected under a homogeneous population).

## Core Workflow

### 1. Data Preparation
HIPPO requires a `SingleCellExperiment` object. Ensure the count matrix is located in the `@assays@data$counts` slot.

```r
library(HIPPO)
library(SingleCellExperiment)

# If starting from a matrix X
sce <- SingleCellExperiment(assays = list(counts = X))

# Note: If counts are in @assays$data$counts, re-assign them:
# sce <- SingleCellExperiment(assays = list(counts = counts(sce)))
```

### 2. Diagnostic Analysis
Use the diagnostic plot to determine if the dataset exhibits zero-inflation beyond what is expected from a Poisson distribution.

```r
hippo_diagnostic_plot(sce, show_outliers = TRUE, zvalue_thresh = 2)
```
If most genes do not align with the black Poisson line, significant cell heterogeneity is present, justifying further clustering.

### 3. Iterative Clustering and Feature Selection
The `hippo` function performs the main analysis. It continues to split clusters until stopping criteria are met.

```r
sce <- hippo(sce, 
             K = 10,                      # Maximum number of clusters
             feature_method = "zero_inflation", # Or "deviance"
             z_threshold = 2,             # Significance threshold for outliers
             outlier_proportion = 0.01)   # Stop if < 1% of genes are outliers
```

### 4. Dimension Reduction and Visualization
HIPPO provides wrappers for UMAP and t-SNE that integrate with its clustering results.

```r
# Compute and plot UMAP
sce <- hippo_dimension_reduction(sce, method = "umap")
hippo_umap_plot(sce)

# Compute and plot t-SNE
sce <- hippo_dimension_reduction(sce, method = "tsne")
hippo_tsne_plot(sce)
```

### 5. Feature Inspection
Visualize how zero-inflation decreases as clustering progresses and identify top features for specific clusters.

```r
# Plot zero-inflation decrease across rounds
zero_proportion_plot(sce)

# Heatmap of top features for a specific cluster level k
hippo_feature_heatmap(sce, k = 3, top.n = 20)
```

### 6. Differential Expression
Perform differential expression analysis between the clusters identified by HIPPO.

```r
# Perform DE using Poisson or Gaussian methods
sce <- hippo_diffexp(sce, method = "pois", top.n = 10)

# Retrieve DE results for a specific round
de_results <- get_hippo_diffexp(sce, round = 1)
```

## Key Parameters and Tips

- **K**: This is the maximum number of clusters. HIPPO generates results for all k from 2 to K. It is better to overestimate K as the algorithm can stop early based on `outlier_proportion`.
- **Gene Names**: Many functions support `switch_to_hgnc = TRUE` if provided with a reference data frame (e.g., `data(ensg_hgnc)`).
- **Accessing Results**: Use `get_hippo(sce)` to extract the label matrix and other internal metadata.
- **Stopping Criterion**: If the clustering stops too early, decrease `z_threshold` or `outlier_proportion`.

## Reference documentation

- [Example analysis](./references/example.Rmd)
- [Feature Selection and Hierarchical Clustering of cells in Zhengmix4eq](./references/example.md)