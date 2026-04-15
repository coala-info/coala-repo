---
name: r-corpcor
description: This tool provides efficient estimation of covariance and partial correlation matrices using James-Stein-type shrinkage for high-dimensional data. Use when user asks to estimate shrinkage covariance or correlation, compute partial correlations, perform fast singular value decomposition, or calculate efficient matrix inverses and powers.
homepage: https://cloud.r-project.org/web/packages/corpcor/index.html
---

# r-corpcor

name: r-corpcor
description: Efficient estimation of covariance and (partial) correlation using James-Stein-type shrinkage. Use this skill when working with high-dimensional data (small n, large p), requiring positive definite covariance matrices, or needing fast computation of matrix inverses and powers for large-scale correlation analysis.

## Overview

The `corpcor` package provides a statistically and computationally efficient approach to estimating covariance and correlation matrices. It is particularly powerful for "small n, large p" problems where empirical estimators are often singular or ill-conditioned. The package uses an analytic shrinkage approach that requires no tuning parameters and guarantees a positive definite, well-conditioned result.

## Installation

```R
install.packages("corpcor")
library("corpcor")
```

## Core Workflows

### 1. Shrinkage Estimation
Use these functions to obtain stable estimates from data matrices where the number of variables exceeds the number of observations.

- `cov.shrink(x)`: Estimates the covariance matrix.
- `cor.shrink(x)`: Estimates the correlation matrix.
- `var.shrink(x)`: Estimates variances (shrunk toward the median).

### 2. Partial Correlations
Partial correlations represent direct interactions between variables conditioned on all others.

- `pcor.shrink(x)`: Directly computes the shrinkage estimate of partial correlations (recommended over `cor2pcor`).
- `cor2pcor(m)`: Converts a correlation or covariance matrix into a partial correlation matrix.
- `pvar.shrink(x)`: Estimates partial variances.

### 3. Efficient Matrix Inversion and Powers
For high-dimensional data, `corpcor` uses specialized identities to compute inverses and powers much faster than standard R functions like `solve()`.

- `invcov.shrink(x)`: Efficiently computes the inverse of the shrinkage covariance matrix.
- `invcor.shrink(x)`: Efficiently computes the inverse of the shrinkage correlation matrix.
- `powcor.shrink(x, alpha)`: Computes the alpha-th power (e.g., `alpha = -0.5` for inverse square root) of the shrinkage correlation matrix.

### 4. Fast SVD and Pseudoinverse
- `fast.svd(m)`: A significantly faster SVD for "fat" (small n, large p) or "thin" (large n, small p) matrices.
- `pseudoinverse(m)`: Computes the Moore-Penrose generalized inverse using SVD.

## Key Functions and Parameters

| Function | Key Arguments | Description |
| :--- | :--- | :--- |
| `cov.shrink` | `lambda`, `lambda.var` | If omitted, shrinkage intensities are estimated analytically. |
| `rank.condition` | `m` | Returns the rank and condition number of a matrix. |
| `is.positive.definite` | `m` | Checks if a matrix is positive definite. |
| `rebuild.cov` | `r, v` | Reconstructs a covariance matrix from correlations `r` and variances `v`. |
| `sm2vec` | `m, diag=FALSE` | Extracts the lower triangle of a symmetric matrix into a vector. |

## Usage Tips

- **Automatic Tuning**: By default, `corpcor` estimates the optimal shrinkage intensity (`lambda`) analytically. You do not need to perform cross-validation.
- **Computational Efficiency**: Always prefer `invcov.shrink(x)` over `solve(cov.shrink(x))` for large datasets, as it avoids the explicit construction of the large matrix where possible.
- **Weights**: Most shrinkage functions accept a weight vector `w` to account for non-uniform data importance.
- **Conditioning**: If you encounter "singular matrix" errors in other R packages, passing your data through `cov.shrink` first will provide a well-conditioned, invertible alternative.

## Reference documentation

- [Package ‘corpcor’ Reference Manual](./references/reference_manual.md)