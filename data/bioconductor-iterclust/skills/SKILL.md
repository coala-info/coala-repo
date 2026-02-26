---
name: bioconductor-iterclust
description: This package provides a framework for performing iterative clustering to identify subtle sub-populations within heterogeneous biological datasets. Use when user asks to perform recursive clustering, evaluate cluster heterogeneity, or identify nested cell types in expression data.
homepage: https://bioconductor.org/packages/3.8/bioc/html/iterClust.html
---


# bioconductor-iterclust

## Overview

The `iterClust` package provides a framework for iterative clustering. In biological datasets, large differences between major cell types often mask subtle differences within a specific lineage. `iterClust` solves this by clustering data, evaluating heterogeneity, and then recursively clustering the resulting subsets until no further heterogeneity is detected or user-defined thresholds are met.

## Installation

```r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("iterClust")
library(iterClust)
```

## Core Workflow

The `iterClust()` function is the primary interface. It requires several user-defined functions to control the behavior of each iteration.

### 1. Define Component Functions

You must define functions for feature selection, clustering, and evaluation.

*   **Feature Selection**: Returns features to use for the current iteration.
    ```r
    featureSelect <- function(dset, iteration, feature) return(rownames(dset))
    ```
*   **Core Clustering**: Returns a list of clustering schemes (e.g., using PAM).
    ```r
    library(cluster)
    coreClust <- function(dset, iteration){
      dist <- as.dist(1 - cor(dset))
      range <- 2:5 # Search for 2 to 5 clusters
      clust <- lapply(range, function(k) pam(dist, k)$clustering)
      return(clust)
    }
    ```
*   **Cluster Evaluation**: Picks the optimal scheme from the list provided by `coreClust`.
    ```r
    clustEval <- function(dset, iteration, clust){
      dist <- as.dist(1 - cor(dset))
      # Calculate mean silhouette score for each scheme
      scores <- sapply(clust, function(x) mean(silhouette(x, dist)[, "sil_width"]))
      return(scores)
    }
    ```
*   **Heterogeneity Check**: Determines if a cluster should be split further.
    ```r
    clustHetero <- function(clustEval, iteration){
      return(clustEval > 0.15) # Split if silhouette score > 0.15
    }
    ```

### 2. Run Iterative Clustering

Pass the defined functions and data (expression matrix) to `iterClust`.

```r
results <- iterClust(exp_matrix, 
                     maxIter = 3, 
                     minFeatureSize = 100, 
                     minClustSize = 5,
                     featureSelect = featureSelect,
                     coreClust = coreClust,
                     clustEval = clustEval,
                     clustHetero = clustHetero)
```

### 3. Interpret Results

The output is a list containing:
*   `cluster`: A nested list organized by iteration (`Iter1`, `Iter2`, etc.) containing observation names for each cluster.
*   `feature`: The features used to split clusters in previous iterations.
*   `clustEval`: Evaluation scores for the clustering schemes.
*   `obsEval`: Evaluation scores for individual observations.

## Tips for Success

*   **Internal Variables (IV)**: The functions can access `depth` (current iteration round) and `cluster` (previous results) to dynamically adjust parameters.
*   **Outlier Removal**: Use `obsEval` and `obsOutlier` functions within `iterClust` to remove poorly clustered observations at each step to improve downstream purity.
*   **Comparison**: `iterClust` is specifically designed to find sub-populations (like purified vs. unpurified B-cells) that standard PAM or Consensus Clustering might miss or incorrectly group.

## Reference documentation

- [Introduction to Iterative Clustering Analysis Using iterClust](./references/introduction.md)