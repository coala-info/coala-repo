---
name: bioconductor-anf
description: This tool performs Affinity Network Fusion to integrate multi-view data and identify sample clusters through spectral clustering. Use when user asks to integrate multi-omic data, construct affinity matrices, fuse heterogeneous data sources, or perform patient subtyping.
homepage: https://bioconductor.org/packages/release/bioc/html/ANF.html
---

# bioconductor-anf

name: bioconductor-anf
description: Perform Affinity Network Fusion (ANF) for multi-view data integration and patient clustering. Use this skill when you need to construct affinity matrices from heterogeneous data sources (e.g., multi-omic data like mRNA, miRNA, and methylation), fuse them into a single network, and perform spectral clustering to identify subtypes or groups.

# bioconductor-anf

## Overview

The `ANF` package provides a framework for integrating multi-view data (multiple feature sets for the same group of samples) using Affinity Network Fusion. It is an evolution of the Similarity Network Fusion (SNF) method, optimized for constructing affinity matrices and performing spectral clustering. It is particularly effective in cancer genomics for patient subtyping where different "views" (e.g., gene expression vs. DNA methylation) may provide complementary signals.

## Core Workflow

### 1. Data Preparation
Prepare your data as a list of feature matrices where rows represent samples and columns represent features. Ensure samples are in the same order across all views.

```r
library(ANF)
# Example: feature1 and feature2 are matrices with identical row names
dist1 <- as.matrix(dist(feature1))
dist2 <- as.matrix(dist(feature2))
```

### 2. Construct Affinity Matrices
Convert distance matrices into affinity matrices using the `affinity_matrix` function. The parameter `k` determines the number of nearest neighbors.

```r
# k is the number of neighbors (typically 10-30)
A1 <- affinity_matrix(dist1, k = 20)
A2 <- affinity_matrix(dist2, k = 20)
```

### 3. Network Fusion
Fuse multiple affinity matrices into a single integrated matrix.

```r
# Wall is a list of affinity matrices
fused_matrix <- ANF(Wall = list(A1, A2), K = 20, iterations = 20)
```

### 4. Spectral Clustering
Identify clusters from either a single affinity matrix or the fused matrix.

```r
# k is the number of clusters to find
clusters <- spectral_clustering(fused_matrix, k = 2)
```

## Evaluation and Utilities

### Clustering Evaluation
If ground truth labels are available, use `igraph::compare` to calculate Normalized Mutual Information (NMI) or Adjusted Rand Index (ARI).

```r
library(igraph)
nmi_score <- compare(true_labels, clusters, method = 'nmi')
```

### Streamlined Evaluation
The `eval_clu` function automates clustering and evaluation (NMI, ARI, and survival p-values if survival data is provided).

```r
# project_ids: named vector of true classes
# surv: data.frame with 'time' and 'censored' columns
results <- eval_clu(true_class = project_ids, w = fused_matrix, surv = survival_data)
```

## Tips for Success
- **Feature Scaling**: Since ANF works on affinity (similarity), ensure that features within a single view are appropriately scaled before calculating distances.
- **Choosing K**: The number of neighbors `K` in the `ANF` function affects the local structure of the fused graph. A common starting point is 1/10th of the sample size.
- **Heterogeneous Views**: ANF is superior to simple concatenation (cbind) because it prevents a single high-dimensional view from overwhelming views with fewer features.

## Reference documentation
- [Complex Object (Patient) Clustering with Multi-view Data Using ANF](./references/ANF.md)