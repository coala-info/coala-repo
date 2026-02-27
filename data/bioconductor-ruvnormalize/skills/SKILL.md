---
name: bioconductor-ruvnormalize
description: This tool removes unwanted variation from gene expression microarray data to correct for batch effects and technical biases. Use when user asks to normalize gene expression data, remove unwanted variation or batch effects, perform unsupervised normalization for clustering or PCA, and use negative control genes or replicate samples for dataset correction.
homepage: https://bioconductor.org/packages/release/bioc/html/RUVnormalize.html
---


# bioconductor-ruvnormalize

name: bioconductor-ruvnormalize
description: Normalize gene expression microarray data by removing unwanted variation (RUV) when the factor of interest is unobserved or undefined. Use this skill to perform unsupervised normalization for clustering, PCA, or general dataset correction using negative control genes and replicate samples.

## Overview

The `RUVnormalize` package implements methods to estimate and remove unwanted variation (e.g., batch effects, platform differences, or laboratory bias) from microarray data. It is particularly useful in unsupervised settings where the primary biological signal of interest is not known beforehand. The package provides three main approaches:
1. **Naive RUV-2**: Uses negative control genes to estimate unwanted factors.
2. **Replicate-based RUV**: Uses replicate samples to identify variation that should be removed.
3. **Iterative RUV**: Alternates between estimating unwanted variation and the signal of interest using sparse dictionary learning (requires the `spams` package).

## Core Workflow

### 1. Data Preparation
The input expression matrix `Y` should be organized with samples in rows and genes in columns. It is recommended to center the gene expressions before processing.

```r
library(RUVnormalize)
# Y is a matrix: samples x genes
Y <- scale(Y, scale = FALSE) 

# Identify negative control genes (indices)
# These are genes known NOT to be associated with the biological factor of interest
cIdx <- which(featureData(data)$isNegativeControl)
```

### 2. Handling Replicates
If using replicate-based normalization, you must provide a matrix `scIdx` where each row contains the indices of samples that are replicates of each other.

```r
# Example: 3 samples are replicates, others are not. 
# Use -1 to pad rows if the number of replicates varies.
scIdx <- matrix(-1, nrow = 10, ncol = 3)
scIdx[1, 1:2] <- c(1, 5) # Sample 1 and 5 are replicates
```

### 3. Normalization Methods

#### Naive RUV-2 (with or without shrinkage)
Use `naiveRandRUV` when you have negative control genes.
- `k`: The number of unwanted factors to estimate.
- `nu.coeff`: Shrinkage parameter. Set to 0 for no shrinkage (standard RUV-2).

```r
# Without shrinkage (Rank reduction)
corrected_Y <- naiveRandRUV(Y, cIdx, k = 20, nu.coeff = 0)

# With shrinkage (Ridge-type)
corrected_Y_shrink <- naiveRandRUV(Y, cIdx, k = nrow(Y), nu.coeff = 1e-3)
```

#### Replicate-based RUV
Use `naiveReplicateRUV` when you have technical or biological replicates.

```r
res <- naiveReplicateRUV(Y, cIdx, scIdx, k = 20)
corrected_Y_rep <- res$cY
```

#### Iterative RUV
Use `iterativeRUV` for a more refined estimation that attempts to separate the signal of interest from noise iteratively. This requires a list of parameters for the `spams` sparse modeling library.

```r
# Requires library(spams)
paramXb <- list(K = 20, batch = TRUE, iter = 1, mode = 'PENALTY', lambda = 0.25)
iRes <- iterativeRUV(Y, cIdx, scIdx, paramXb, k = 20, nu.coeff = 0, Wmethod = 'rep')
corrected_Y_iter <- iRes$cY
```

### 4. Visualization and Evaluation
Use `svdPlot` to visualize the data in the space of the first two principal components to check if batch effects (like Lab or Region) have been removed.

```r
# Plotting the first two PCs
svdRes <- svdPlot(corrected_Y[, top_genes_idx], 
                  annot = sample_annotations, 
                  labels = batch_labels)

# Evaluate clustering quality if ground truth is known
score <- clScore(vclust, ground_truth_factor)
```

## Tips and Best Practices
- **Gene Selection**: For clustering and PCA visualization, it is often better to use only the top 10-20% of genes with the highest variance after normalization.
- **Parameter Selection**: The choice of `k` (number of factors) is critical. If `k` is too small, unwanted variation remains; if too large, biological signal may be removed.
- **Pre-processing**: If a known strong batch effect exists (like a platform difference), centering the data within those specific batches before running RUV can improve results.

## Reference documentation
- [RUV for normalization of expression array data](./references/RUVnormalize.md)