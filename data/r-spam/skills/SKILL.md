---
name: r-spam
description: The spam package provides functions for performing fast and scalable sparse matrix algebra using the Compressed Sparse Row format. Use when user asks to create sparse matrices, solve linear systems via Cholesky factorization, or perform efficient matrix operations within MCMC and GMRF frameworks.
homepage: https://cloud.r-project.org/web/packages/spam/index.html
---


# r-spam

## Overview
The `spam` package provides a comprehensive set of functions for sparse matrix algebra. It is designed to be fast and scalable, particularly for MCMC calculations within G(M)RF frameworks. Unlike other sparse packages, `spam` focuses on a single, transparent format (Compressed Sparse Row - CSR) and allows for a unique three-step Cholesky factorization (Permutation -> Symbolic -> Numeric) that significantly speeds up repetitive calculations.

## Installation
To install the package from CRAN:
```R
install.packages("spam")
library(spam)
```
For 64-bit indexing support with extremely large matrices, the extension package `spam64` can be used.

## Core Workflows

### Creating Sparse Matrices
You can create sparse matrices by coercing dense matrices or by specifying dimensions and values directly.
```R
# Coercion
Fmat <- matrix(c(3, 0, 1, 0, 2, 0, 1, 0, 3), 3, 3)
Smat <- as.spam(Fmat)

# Direct creation
Smat <- spam(0, nrow = 10, ncol = 10)
Smat[cbind(1:5, 1:5)] <- 1:5

# Diagonal matrices
Dmat <- diag.spam(1, 10)
```

### Solving Linear Systems
The primary strength of `spam` is solving $Ax = b$ where $A$ is symmetric and positive definite.

**Standard Approach:**
```R
# Cholesky decomposition and backsolve
U <- chol(A)
x <- backsolve(U, forwardsolve(U, b))

# Determinant calculation
det_val <- determinant(U)$modulus
```

**Optimized MCMC Workflow (Constant Sparsity):**
When the sparsity structure of $A$ does not change (common in MCMC), you can reuse the symbolic factorization.
```R
# 1. Initial factorization (includes symbolic step)
U <- chol(A)

# 2. Subsequent updates (numeric step only - much faster)
# update.spam.chol.NgPeyton updates the factor with new values
U_new <- update(U, A_new)
```

### Matrix Operations
`spam` objects behave like standard R matrices for most operations:
- **Multiplication:** `Smat %*% vector` or `Smat1 %*% Smat2`.
- **Diagonal Multiplication:** Use `%d*%` for efficient multiplication of a diagonal matrix (represented as a vector) and a sparse matrix.
- **Transposition:** `t(Smat)`.
- **Binding:** `rbind(Smat1, Smat2)` and `cbind(Smat1, Smat2)`.

## Visualization and Inspection
- `display(Smat)`: Visualizes the sparsity structure (dot plot).
- `image(Smat)`: Creates a grid plot of values with a color scale.
- `summary(Smat)`: Provides density and non-zero (nnz) statistics.

## Tips for Performance
1. **Avoid Full Matrices:** Operations like `range(Smat)` only consider non-zero elements. To include zeros, use `range(as.matrix(Smat))`.
2. **Slot Access:** Advanced users can access the CSR components directly via `@entries`, `@colindices`, `@rowpointers`, and `@dimension`.
3. **Options:** Use `spam.options()` to tune behavior, such as the `printmax` threshold for switching between sparse and dense printing formats.
4. **Foreign Formats:** Use `as.spam.matrix()` or `as.spam.dgCMatrix()` to convert from `Matrix` or `SparseM` objects.

## Reference documentation
- [Illustrations and Examples](./references/spam.Rmd)