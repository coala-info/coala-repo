---
name: bioconductor-mumosa
description: The mumosa package provides utilities for integrating and analyzing multi-modal single-cell data through joint clustering, dimensionality reduction, and feature correlation. Use when user asks to perform multi-modal data integration, rescale modalities by neighbors, run multi-metric UMAP, intersect clusterings or graphs, and find correlations between different feature types.
homepage: https://bioconductor.org/packages/release/bioc/html/mumosa.html
---

# bioconductor-mumosa

## Overview

The `mumosa` package provides utilities for integrating multi-modal single-cell data (e.g., CITE-seq, RNA-seq + Proteomics, or Epigenomics). It focuses on sharing information across modalities to perform joint clustering, dimensionality reduction, and feature correlation without requiring one modality to dominate the analysis.

## Core Workflows

### 1. Data Integration by Rescaling
When combining different modalities (like RNA and ADT), differences in feature counts and variance can cause one modality to dominate. `rescaleByNeighbors()` equalizes the "noise" based on the median distance to the $k$-th nearest neighbor.

```r
library(mumosa)
# list of matrices (e.g., PCA results from different modalities)
rescaled_combined <- rescaleByNeighbors(list(reducedDim(sce, "PCA"), reducedDim(altExp(sce), "PCA")))

# Use the output for joint clustering or visualization
library(bluster)
clusters <- clusterRows(rescaled_combined, NNGraphParam())
```

### 2. Intersecting Clusters
If you have independent clusterings for each modality, `intersectClusters()` performs a refined intersection. It merges small, noisy clusters while ensuring that the within-cluster sum of squares does not exceed the original per-modality clustering.

```r
# rna_clusters and adt_clusters are vectors of cluster assignments
refined_clusters <- intersectClusters(
    clusters = list(rna_clusters, adt_clusters),
    latent = list(reducedDim(sce, "PCA"), reducedDim(altExp(sce), "PCA"))
)
```

### 3. Multi-metric UMAP
`calculateMultiUMAP()` (or the `SingleCellExperiment` wrapper `runMultiUMAP()`) integrates modalities by intersecting nearest-neighbor graphs. Cells are considered neighbors only if they are close in all modalities.

```r
# Using the SCE wrapper
sce <- runMultiUMAP(sce, 
                    dimred="PCA", 
                    extras=list(reducedDim(altExp(sce), "PCA")),
                    name="MultiUMAP")

plotReducedDim(sce, "MultiUMAP", colour_by="column_name")
```

### 4. Intersecting Graphs
For graph-based clustering, `intersectGraphs()` combines SNN graphs from different modalities by multiplying edge weights.

```r
g.rna <- buildSNNGraph(sce, use.dimred="PCA")
g.adt <- buildSNNGraph(altExp(sce), use.dimred="PCA")

g.combined <- intersectGraphs(g.rna, g.adt)
combined_clusters <- igraph::cluster_walktrap(g.combined)$membership
```

### 5. Correlation Analysis
To find relationships between features of different modalities (e.g., which genes correlate with which proteins):

*   **Exact Correlation:** `computeCorrelations()` computes Spearman's rho for all pairs.
*   **Approximate Search:** `findTopCorrelations()` uses PCA-based compression to quickly find the top $N$ most correlated features.

```r
# Find top 10 ADT features correlated to each RNA feature
top_cor <- findTopCorrelations(sce, y=altExp(sce), number=10)

# Access positive or negative correlations
pos_cor <- top_cor$positive
```

## Tips and Best Practices
*   **Batch Correction:** Use the `block=` argument in `computeCorrelations()` or `findTopCorrelations()` to account for batch effects; this ensures correlations are calculated within batches and then averaged.
*   **Weighting:** In `rescaleByNeighbors()`, use the `weights=` argument if you want to manually prioritize one modality over another (e.g., giving more weight to the RNA component).
*   **Preprocessing:** Always perform independent QC and normalization (e.g., `logNormCounts`) on each modality before attempting integration with `mumosa`.

## Reference documentation
- [Utilities for multi-modal single-cell analyses](./references/overview.md)