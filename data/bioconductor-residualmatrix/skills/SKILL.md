---
name: bioconductor-residualmatrix
description: The ResidualMatrix package provides a memory-efficient representation of linear model residuals by using delayed evaluation to avoid creating large dense matrices. Use when user asks to regress out covariates, remove batch effects, or perform PCA on model residuals without exhausting memory.
homepage: https://bioconductor.org/packages/release/bioc/html/ResidualMatrix.html
---


# bioconductor-residualmatrix

## Overview

The `ResidualMatrix` package provides a memory-efficient way to handle residuals from linear model fits. In genomic analysis, regressing out covariates (like batch effects) usually results in a dense matrix, which can lead to memory exhaustion for large datasets. `ResidualMatrix` solves this by using delayed evaluation—it stores the original matrix and the design matrix, calculating residuals only when needed. It is highly compatible with `DelayedArray` and `BiocSingular` for downstream applications like PCA.

## Core Workflow

### 1. Creating a ResidualMatrix
The primary constructor takes an input matrix (dense or sparse) and a design matrix.

```r
library(ResidualMatrix)
library(Matrix)

# Example: Sparse input matrix (y) and design matrix
design <- model.matrix(~batch + covariate)
resids <- ResidualMatrix(y, design)
```

### 2. Efficient Downstream Analysis
`ResidualMatrix` implements optimized methods for matrix multiplication and row/column sums, making it ideal for PCA without ever explicitly forming the dense residual matrix.

```r
# Perform PCA efficiently using BiocSingular
# Note: center=FALSE is recommended as residuals are already centered
library(BiocSingular)
pc.out <- runPCA(resids, rank=10, center=FALSE, BSPARAM=RandomParam())
```

### 3. Retaining Specific Factors
If you want to regress out some variables (e.g., batch) but keep the effect of others (e.g., treatment groups) in the residuals, use the `keep` argument. This is analogous to `limma::removeBatchEffect`.

```r
# design2 has 3 columns; keep the first two, regress out the third
resid_kept <- ResidualMatrix(y, design2, keep=1:2)
```

### 4. Restricting Model Fitting
Use the `restrict` argument to estimate the regression coefficients (the "effect" to be removed) based only on a subset of observations (e.g., control samples), then apply that correction to the entire matrix.

```r
# Estimate batch effects using only control samples
resid_restricted <- ResidualMatrix(y, design=model.matrix(~batches), restrict=control_indices)
```

## Implementation Tips
- **Sparsity Preservation**: The underlying matrix remains sparse if the input was sparse; the "denseness" of residuals is handled via delayed math.
- **Matrix Operations**: Standard operations like `rowSums()`, `colMeans()`, and `%*%` are supported and optimized.
- **DelayedArray Integration**: Other operations (like log-transformation) will wrap the `ResidualMatrix` in a `DelayedMatrix` object.
- **Memory Management**: Use `DelayedArray` block processing if you need to realize specific chunks of the residual matrix into memory.

## Reference documentation

- [Using the ResidualMatrix class](./references/ResidualMatrix.Rmd)
- [ResidualMatrix Vignette](./references/ResidualMatrix.md)