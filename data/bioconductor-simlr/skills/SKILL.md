---
name: bioconductor-simlr
description: "SIMLR performs clustering, visualization, and feature ranking for single-cell RNA-seq data by learning a multi-kernel distance metric. Use when user asks to estimate the number of clusters, perform single-cell clustering, generate 2D visualizations of cell populations, or rank genes based on their contribution to similarity structure."
homepage: https://bioconductor.org/packages/release/bioc/html/SIMLR.html
---


# bioconductor-simlr

## Overview

SIMLR (Single-cell Interpretation via Multi-kernel LeaRning) is an R package designed to handle the high levels of noise, outliers, and dropouts inherent in single-cell RNA-seq data. It learns an appropriate distance metric from the data by combining multiple kernels, which is then used for downstream tasks like clustering (K-means), visualization (t-SNE), and identifying significant genes.

## Core Workflow

### 1. Data Preparation
SIMLR expects a gene expression matrix `X` where rows are genes and columns are cells.

```r
library(SIMLR)
# X is your expression matrix
# c is the expected number of clusters
```

### 2. Estimating Cluster Numbers
If the number of clusters is unknown, use heuristics to estimate the optimal value for `c`.

```r
set.seed(123)
# Test a range of clusters, e.g., 2 to 10
results = SIMLR_Estimate_Number_of_Clusters(X, NUMC = 2:10, cores.ratio = 0)

# Identify best K using K1 or K2 heuristics (look for minimum values)
best_k1 = (2:10)[which.min(results$K1)]
best_k2 = (2:10)[which.min(results$K2)]
```

### 3. Running SIMLR
For standard datasets, use the primary `SIMLR` function. For very large datasets, use `SIMLR_Large_Scale`.

**Standard Version:**
```r
# cores.ratio = 0 uses a single core; increase for parallel processing
example = SIMLR(X = X, c = best_k1, cores.ratio = 0)

# Access results
clusters = example$y$cluster  # Cluster assignments
vis_data = example$ydata      # 2D coordinates for plotting
```

**Large Scale Version:**
```r
# kk is the number of nearest neighbors
example_large = SIMLR_Large_Scale(X = X, c = best_k1, kk = 10)
```

### 4. Visualization
SIMLR generates 2D embeddings that can be plotted using standard R graphics.

```r
plot(example$ydata, 
     col = example$y$cluster, 
     pch = 20, 
     main = "SIMLR 2D Visualization",
     xlab = "Component 1", ylab = "Component 2")
```

### 5. Feature Ranking
Identify which genes contribute most to the learned similarity structure.

```r
# A is the similarity matrix from SIMLR results
ranks = SIMLR_Feature_Ranking(A = example$results$S, X = X)

# View top ranked genes by p-value
head(ranks$pval)
head(ranks$aggR) # Aggregated ranking
```

## Tips and Best Practices
- **Parallelization**: Set `cores.ratio` between 0 and 1 to utilize multiple CPU cores (e.g., 0.5 uses 50% of available cores).
- **Validation**: Use the `compare` function from the `igraph` package to calculate Normalized Mutual Information (NMI) if ground truth labels are available.
- **Large Data**: `SIMLR_Large_Scale` uses a fast PCA and k-nearest neighbor approach to maintain efficiency on high-cell-count datasets.

## Reference documentation

- [Introduction](./references/v1_introduction.md)
- [Running SIMLR](./references/v2_running_SIMLR.md)