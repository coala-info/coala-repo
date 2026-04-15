---
name: bioconductor-biocsingular
description: The BiocSingular package provides a unified interface for performing singular value decomposition and principal component analysis using exact or approximate algorithms. Use when user asks to perform SVD or PCA, run approximate matrix decompositions like IRLBA or randomized SVD, or manage memory-efficient low-rank matrix approximations.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocSingular.html
---

# bioconductor-biocsingular

## Overview

The `BiocSingular` package provides a unified interface for singular value decomposition (SVD) and principal component analysis (PCA) in R. It allows users to easily switch between exact and approximate algorithms (like IRLBA or randomized SVD) by changing a single parameter object. It is designed to work seamlessly with Bioconductor objects, supporting parallelization via `BiocParallel` and efficient handling of large or sparse matrices.

## Core Workflows

### 1. Running SVD

The primary function for SVD is `runSVD()`. You control the algorithm by passing a specific `BiocSingularParam` object to the `BSPARAM` argument.

```r
library(BiocSingular)

# Create dummy data
mat <- matrix(rnorm(10000), ncol=25)

# Exact SVD (Default)
svd_exact <- runSVD(mat, k=10, BSPARAM=ExactParam())

# Approximate SVD using irlba
svd_irlba <- runSVD(mat, k=10, BSPARAM=IrlbaParam())

# Randomized SVD using rsvd
svd_rand <- runSVD(mat, k=10, BSPARAM=RandomParam())
```

### 2. Running PCA

The `runPCA()` function is a wrapper around `runSVD()` specifically for principal component analysis. It returns an object containing standard deviations (`sdev`), rotation vectors (`rotation`), and PC scores (`x`).

```r
# Perform PCA with 5 components
pca_out <- runPCA(mat, rank=5, BSPARAM=IrlbaParam())

# Access results
pc_scores <- pca_out$x
rotation <- pca_out$rotation
```

### 3. Centering and Scaling

You can perform centering and scaling directly within the functions. For large sparse matrices, use `deferred=TRUE` in the parameter object to maintain sparsity during calculations, which significantly improves speed.

```r
# Centering and scaling with deferred computation for speed
param <- IrlbaParam(deferred=TRUE)
pca_out <- runPCA(mat, rank=10, center=TRUE, scale=TRUE, BSPARAM=param)
```

### 4. Optimization Techniques

*   **Cross-product:** For "tall" or "fat" matrices, `BiocSingular` can compute the SVD on the cross-product to save time. This is controlled by the `fold` argument in the parameter constructor (default is 5).
*   **Parallelization:** Use the `BPPARAM` argument to distribute matrix multiplications across multiple cores.
*   **Partial Results:** Use `nu` and `nv` in `runSVD()` to specify exactly how many left and right singular vectors to return, avoiding unnecessary computation.

```r
library(BiocParallel)

# Parallelized approximate SVD
svd_fast <- runSVD(mat, k=10, 
                   BSPARAM=IrlbaParam(), 
                   BPPARAM=MulticoreParam(workers=4))
```

### 5. Low-Rank Approximation

The `LowRankMatrix` class allows you to represent the reconstruction of the original matrix (Rotation * Scores) without actually expanding it into a dense memory-heavy matrix.

```r
# Create a memory-efficient low-rank representation
recon <- LowRankMatrix(pca_out$rotation, pca_out$x)

# Extract specific rows/columns without full expansion
col_1 <- recon[, 1]
```

## Reference documentation

- [Singular value decomposition for Bioconductor packages](./references/decomposition.md)
- [Matrix representations to support decomposition](./references/representations.md)