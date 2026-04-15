---
name: bioconductor-coveb
description: This tool implements an empirical Bayes approach to estimate and refine covariance and correlation matrices for high-dimensional biological data. Use when user asks to improve covariance matrix estimation, perform robust network inference, or shrink gene-specific variances toward a common variance.
homepage: https://bioconductor.org/packages/release/bioc/html/covEB.html
---

# bioconductor-coveb

## Overview

The `covEB` package implements an empirical Bayes approach to improve covariance and correlation matrix estimation. It is particularly effective for high-dimensional biological data (like gene expression) where sample sizes are small. The method assumes a block diagonal structure for the covariance matrix and shrinks gene-specific variances toward a common variance, leading to more robust network inference and reduced false discovery rates in differential expression or co-expression analysis.

## Core Workflow

### 1. Data Preparation
The input to `covEB` is typically a sample covariance matrix calculated from gene expression data (rows = genes, columns = samples).

```r
library(covEB)
# Assuming 'edata' is a matrix of expression values
# Genes must be rows for cov() to work on t(edata)
covmat <- cov(t(edata))
n_samples <- ncol(edata)
```

### 2. Covariance Estimation
The primary function is `EBsingle()`. It can be used in two ways:

**Option A: Automatic Block Detection**
Use `startlambda` to let the algorithm determine the block diagonal structure via thresholding.
```r
# startlambda is the thresholding parameter (e.g., 0.5)
out_cov <- EBsingle(covmat, startlambda = 0.5, n = n_samples)
```

**Option B: Pre-defined Groups**
If you have prior knowledge of gene groupings (e.g., pathways or clusters), pass them as a list.
```r
# groups is a list of character vectors matching rownames(covmat)
group_list <- list(c("GeneA", "GeneB"), c("GeneC", "GeneD"))
out_cov <- EBsingle(covmat, groups = group_list, n = n_samples)
```

### 3. Downstream Analysis
The output is a refined covariance matrix. You can convert this to a correlation matrix or an adjacency matrix for network visualization.

```r
# Convert to correlation matrix
eb_cor <- cov2cor(out_cov)

# Create an adjacency matrix for a network (thresholding at 0.5)
adj_matrix <- eb_cor
adj_matrix[abs(eb_cor) < 0.5] <- 0
adj_matrix[abs(eb_cor) >= 0.5] <- 1
diag(adj_matrix) <- 0
```

## Tips for Success

- **Filtering**: Before calculating the covariance matrix, filter your expression data to include only the most variable genes (e.g., top 20th percentile). This reduces computational load and focuses on informative signals.
- **Sample Size**: Always ensure the `n` parameter in `EBsingle` matches the actual number of biological samples used to generate the initial covariance matrix.
- **Interpretability**: Using `covEB` typically results in "cleaner" networks with fewer spurious edges compared to standard Pearson correlations, making biological interpretation easier.
- **Visualizing Results**: Use the `igraph` package to plot the resulting adjacency matrices to compare the standard sample correlation network vs. the `covEB` refined network.

## Reference documentation

- [covEB](./references/covEB.md)