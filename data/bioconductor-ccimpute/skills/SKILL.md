---
name: bioconductor-ccimpute
description: bioconductor-ccimpute imputes dropout events in scRNA-seq data using a consensus clustering framework to identify cell similarity. Use when user asks to impute missing values in scRNA-seq data, address dropout noise, or recover gene expression patterns using consensus clustering.
homepage: https://bioconductor.org/packages/release/bioc/html/ccImpute.html
---

# bioconductor-ccimpute

## Overview

`ccImpute` is a Bioconductor package designed to address the "dropout" problem in scRNA-seq data. It uses a consensus clustering framework to determine cell similarity and identifies probable dropout events by looking at expression patterns across similar cells. Unlike some imputation methods that may introduce significant noise, `ccImpute` aims to be conservative, only imputing values where there is strong evidence of a dropout.

## Core Workflow

The package operates primarily on `SingleCellExperiment` objects and expects data to be log-normalized.

### 1. Data Preparation
`ccImpute` does not perform normalization itself. You must provide log-transformed normalized counts.

```r
library(ccImpute)
library(SingleCellExperiment)
library(scater)

# Assuming 'sce' is your SingleCellExperiment object
# Ensure logcounts assay exists
sce <- logNormCounts(sce) 
```

### 2. Basic Imputation
The simplest way to run the tool is calling `ccImpute` directly on the object. By default, it will estimate the number of clusters ($k$) using the Tracy-Widom bound.

```r
library(BiocParallel)

# Recommended: Use parallel processing
bp_param <- MulticoreParam(workers = 2)

# Run imputation
sce <- ccImpute(sce, BPPARAM = bp_param)

# The results are stored in a new assay named "imputed"
imputed_matrix <- assay(sce, "imputed")
```

### 3. Optimized Imputation (Recommended)
If the number of cell types ($k$) is known, providing it significantly improves performance and accuracy.

```r
# If you know there are 5 cell types
sce <- ccImpute(sce, k = 5, BPPARAM = bp_param)
```

## Key Parameters

- `k`: Number of clusters. If unknown, it is estimated, but manual specification is preferred.
- `dist`: A custom distance or correlation matrix. Defaults to weighted Spearman correlation.
- `svdMaxRatio`: Controls dimensionality reduction (default: 0.08).
- `consMin`: Minimum consensus threshold (default: 0.75).
- `BPPARAM`: A `BiocParallelParam` object for parallelization.

## Advanced Control (Step-by-Step)

For finer control, you can run the internal steps manually:

```r
# 1. Compute gene weights and correlation matrix
logX <- logcounts(sce)
w <- rowVars_fast(logX, nCores = 2)
corMat <- getCorM("spearman", logX, w, nCores = 2)

# 2. SVD for dimensionality reduction
v <- doSVD(corMat, svdMaxRatio = 0.08, nCeil = 2000, nCores = 2)

# 3. Generate Consensus Matrix
consMtx <- runKM(logX, v, maxSets = 8, k = 5, BPPARAM = bp_param)

# 4. Identify and Impute
dropIds <- findDropouts(logX, consMtx)
iLogX <- computeDropouts(consMtx, logX, dropIds, fastSolver = TRUE, nCores = 2)

# 5. Save back to object
assay(sce, "imputed") <- iLogX
```

## Performance Tips

- **Feature Selection**: It is often beneficial to perform feature selection (e.g., identifying highly variable genes) before imputation, as `ccImpute` is unlikely to benefit from genes with extremely low expression across the entire dataset.
- **BLAS Libraries**: Using optimized BLAS libraries (like OpenBLAS or MKL) can significantly speed up the matrix operations.
- **Memory**: For very large datasets, ensure you have sufficient RAM, as the consensus matrix and SVD steps can be memory-intensive.

## Reference documentation

- [ccImpute Package Manual](./references/ccImpute.md)