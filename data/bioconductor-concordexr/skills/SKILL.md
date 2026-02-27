---
name: bioconductor-concordexr
description: concordexR evaluates the quality and homogeneity of cell clusters by calculating the proportion of k-nearest neighbors that share the same label. Use when user asks to validate cell clusters, calculate concordex scores, identify spatial homogeneous regions, or generate a cluster similarity matrix.
homepage: https://bioconductor.org/packages/release/bioc/html/concordexR.html
---


# bioconductor-concordexr

## Overview

`concordexR` is an R implementation of the `concordex` algorithm, designed to provide a quantitative alternative to UMAP for visualizing and validating cell clusters. While UMAP can often show spurious clusters or distort distances, `concordex` calculates the proportion of a cell's k-nearest neighbors that share the same label. This results in a "concordex" score and a similarity matrix. If clusters are well-defined, the similarity matrix will be diagonally dominant. In spatial contexts, it identifies Spatial Homogeneous Regions (SHRs).

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("concordexR")
```

## Typical Workflow

### 1. Prepare Data
`concordexR` works with `SingleCellExperiment` (SCE) or `SpatialFeatureExperiment` (SFE) objects. Ensure your data is normalized and dimensionality reduction (like PCA) has been performed.

```r
library(concordexR)
# Assuming 'sce' is a SingleCellExperiment object with 'PCA' and 'cluster' labels
```

### 2. Calculate Concordex
The primary function is `calculateConcordex`. It can compute the metric based on existing dimensionality reduction or a pre-computed neighbor graph.

**Using Dimensionality Reduction:**
```r
res <- calculateConcordex(
    sce, 
    labels = "cluster", 
    use.dimred = "PCA",
    k = 10,
    compute_similarity = TRUE
)
```

**Using a Spatial/Neighbor Graph:**
If working with spatial data or a specific kNN graph:
```r
# For SFE objects
res <- calculateConcordex(sfe, labels = colData(sfe)[["cell_type"]])
```

### 3. Interpret Results
The function returns a list containing:
- `CONCORDEX`: The mean concordex score (average of the diagonal of the similarity matrix).
- `SIMILARITY`: A cluster-by-cluster matrix showing the proportion of neighbors belonging to each label.

```r
# View the similarity matrix
sim_matrix <- res[["SIMILARITY"]]
round(sim_matrix, 2)

# High diagonal values indicate well-separated, homogeneous clusters.
# High off-diagonal values indicate mixing or poorly defined boundaries between specific clusters.
```

## Tips for Success
- **Choosing K**: The number of neighbors (`k`) should generally match the `k` used during the initial graph-based clustering (e.g., Leiden or Louvain) to ensure consistency.
- **Permutations**: For statistical significance, `calculateConcordex` can perform permutations of labels to generate a null distribution (default `n_permutations = 100`).
- **Input Formats**: While SCE/SFE objects are preferred, you can also pass a matrix of coordinates or a pre-computed adjacency matrix directly to the underlying engine.

## Reference documentation

- [Using concordex to assess cluster boundaries in scRNA-seq](./references/concordex-nonspatial.md)
- [Overview of concordexR](./references/overview.md)