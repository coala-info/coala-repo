---
name: r-fastica
description: R package fastica (documentation from project home).
homepage: https://cran.r-project.org/web/packages/fastica/index.html
---

# r-fastica

## Overview
The `fastICA` package provides an efficient implementation of the FastICA algorithm. ICA is a statistical and computational technique for revealing hidden factors that underlie sets of random variables, measurements, or signals. It is widely used for "blind source separation" (e.g., the cocktail party problem) and for decomposing complex datasets into independent features.

## Installation
To install the package from CRAN:
```R
install.packages("fastICA")
```

## Main Functions
The package primarily revolves around a single main function:

### fastICA(X, n.comp, alg.typ, fun, alpha, method, row.norm, maxit, tol, verbose, w.init)
- **X**: A data matrix with $n$ rows (observations) and $p$ columns (variables).
- **n.comp**: Number of components to extract.
- **alg.typ**: Algorithm type; "parallel" (default) or "deflation".
- **fun**: The functional form of the $G$ function used in the approximation to negentropy; "logcosh" (default) or "exp".
- **method**: If "R" (default), all computations are in R. If "C", some stages are in C (faster).
- **row.norm**: Logical; if TRUE, rows of X are standardized.

## Standard Workflow

### 1. Data Preparation
Ensure your data is in a matrix format where rows are observations and columns are variables.
```R
library(fastICA)
# Example: 2000 observations of 3 mixed signals
S <- matrix(runif(2000*3), 2000, 3) # Source signals
A <- matrix(c(1, 1, 1, 1, 2, 3, 0, 1, 1), 3, 3) # Mixing matrix
X <- S %*% A # Mixed signals
```

### 2. Running ICA
Execute the algorithm to recover the independent components.
```R
# Extract 3 components using the parallel algorithm
ica_result <- fastICA(X, n.comp = 3, alg.typ = "parallel", fun = "logcosh")
```

### 3. Accessing Results
The returned object is a list containing:
- `X`: The pre-processed data matrix.
- `K`: The pre-whitening matrix ($k \times p$).
- `W`: The estimated un-mixing matrix ($n.comp \times k$).
- `A`: The estimated mixing matrix ($k \times n.comp$).
- `S`: The estimated source signals ($n \times n.comp$).

```R
# Plot the estimated independent components
plot(ica_result$S[,1], ica_result$S[,2])
```

## Tips and Best Practices
- **Centering and Whitening**: `fastICA` automatically centers and whitens the data. Whitening transforms the observed vector so its components are uncorrelated and their variances equal unity.
- **Choosing n.comp**: If you don't know the number of sources, you may need to use PCA first to estimate the number of significant components or experiment with different values.
- **Convergence**: If the algorithm fails to converge, try increasing `maxit` or adjusting the `tol` (tolerance) parameter.
- **Parallel vs. Deflation**: The "parallel" algorithm estimates all components simultaneously, while "deflation" estimates them one by one (similar to PCA). Parallel is generally preferred for its symmetry.

## Reference documentation
- [fastICA Home Page](./references/home_page.md)