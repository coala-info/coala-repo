---
name: bioconductor-omada
description: The omada package provides an automated pipeline for unsupervised clustering and feature selection in high-dimensional genomic data. Use when user asks to perform automated clustering analysis, select optimal clustering algorithms, identify stable feature subsets, or estimate the number of clusters in a dataset.
homepage: https://bioconductor.org/packages/release/bioc/html/omada.html
---

# bioconductor-omada

## Overview
The `omada` package provides an automated pipeline for unsupervised clustering of high-dimensional genomic data. It simplifies complex machine learning decisions by offering tools for feasibility analysis, algorithm selection (Spectral, K-means, Hierarchical), feature selection based on stability, and ensemble-based estimation of the optimal number of clusters.

## Core Workflow: The Automated Cascade
The most efficient way to use the package is the `omada()` function, which executes the full suite of tools in a single call.

```r
library(omada)

# Run the full automated analysis
# method.upper.k defines the maximum number of clusters to test
omada.analysis <- omada(toy_genes, method.upper.k = 6)

# Extract key results
optimal_k <- get_sample_memberships(omada.analysis)
optimal_features <- get_feature_selection_optimal_features(omada.analysis)
agreement_scores <- get_partition_agreement_scores(omada.analysis)

# Visualize the decision process
plot_partition_agreement(omada.analysis)
plot_feature_selection(omada.analysis)
plot_cluster_voting(omada.analysis)
```

## Modular Analysis Steps

### 1. Feasibility Analysis
Before clustering, determine if your dataset dimensions (samples vs. features) are likely to yield stable partitions.
*   `feasibilityAnalysis()`: For theoretical dimensions.
*   `feasibilityAnalysisDataBased()`: Uses statistics from your actual data.

### 2. Algorithm Selection
Compare Spectral ("sc"), K-means ("km"), and Hierarchical ("hr") clustering to see which produces the most consistent internal partitions.
```r
method.results <- clusteringMethodSelection(toy_genes, method.upper.k = 3, number.of.comparisons = 10)
plot_partition_agreement(method.results)
```

### 3. Feature Selection
Identify the subset of features that maximizes clustering stability.
```r
fs_results <- featureSelection(toy_genes, min.k = 2, max.k = 5, step = 10)
best_features <- get_optimal_features(fs_results)
```

### 4. Cluster Voting
Estimate the optimal number of clusters (k) using an ensemble of internal metrics.
```r
# algorithm options: "sc", "km", "hr"
cv_results <- clusterVoting(toy_genes, min.k = 2, max.k = 8, algorithm = "sc")
plot_vote_frequencies(cv_results)
```

### 5. Final Optimal Clustering
Once parameters are decided, run the final partitioning which also optimizes algorithm-specific parameters (e.g., kernels for spectral clustering).
```r
final_clusters <- optimalClustering(toy_genes, k = 4, algorithm = "spectral")
memberships <- get_optimal_memberships(final_clusters)
```

## Implementation Tips
*   **Data Preparation**: Ensure data is a dataframe or matrix. `omada` requires the removal or imputation of all `NA` values before processing.
*   **Computational Cost**: Increasing `number.of.comparisons` in selection functions improves robustness but significantly increases runtime.
*   **Feature Step**: In `featureSelection`, the `step` parameter dictates how many features are added in each iteration. A smaller step is more precise but slower.

## Reference documentation
- [Omada Vignette](./references/omada-vignette.md)