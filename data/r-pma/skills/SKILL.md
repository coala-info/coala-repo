---
name: r-pma
description: Skill for using the CRAN R package r-pma.
homepage: https://cloud.r-project.org/web/packages/PMA/index.html
---

# r-pma

name: r-pma
description: Perform Penalized Multivariate Analysis (PMA) in R, including Sparse Principal Component Analysis (SPC), Sparse Canonical Correlation Analysis (CCA), and Sparse Linear Discriminant Analysis. Use this skill to find interpretable, sparse structures in high-dimensional data (p >> n) where traditional PCA or CCA would fail or produce non-sparse results.

## Overview
The `PMA` package implements methods for Penalized Multivariate Analysis based on the Penalized Matrix Decomposition (PMD). It is designed for datasets where the number of variables is much larger than the number of observations. Key applications include:
- **Sparse PCA (SPC):** Finding principal components with many zero loadings.
- **Sparse CCA:** Identifying correlations between two or more sets of variables using sparsity constraints.
- **Sparse LDA:** Performing classification with feature selection.

## Installation
```R
install.packages("PMA")
library(PMA)
```

## Main Functions and Workflows

### Sparse Principal Component Analysis (SPC)
Use `SPC` to find sparse loadings for principal components.
```R
# x: data matrix (n x p)
# sumabsv: L1 bound on v (sparsity parameter, > 1)
# K: number of components
out <- SPC(x, sumabsv = 2, K = 3)

# View sparse loadings
print(out$v)
```
To choose the tuning parameter `sumabsv` via cross-validation:
```R
cv.out <- SPC.cv(x)
out <- SPC(x, sumabsv = cv.out$bestsumabsv)
```

### Sparse Canonical Correlation Analysis (CCA)
Use `CCA` to find sparse linear combinations of two sets of variables that are highly correlated.
```R
# x: first data matrix (n x p)
# z: second data matrix (n x q)
# sumabsx: L1 bound on u (0 to 1, or > 1 depending on type)
# sumabsy: L1 bound on v
out <- CCA(x, z, sumabsx = 0.3, sumabsy = 0.3)

# View results
print(out$u) # weights for x
print(out$v) # weights for z
```
To choose tuning parameters via permutation:
```R
perm.out <- CCA.permute(x, z)
out <- CCA(x, z, sumabsx = perm.out$bestsumabsx, sumabsy = perm.out$bestsumabsy)
```

### Sparse Multi-dataset CCA (MultiCCA)
For more than two datasets (e.g., Transcriptomics, Proteomics, and Metabolomics on the same samples):
```R
# xlist: list of data matrices (n x p1, n x p2, ...)
out <- MultiCCA(xlist, penalty = 0.2)
```

## Tips and Best Practices
- **Standardization:** It is generally recommended to center and scale your data before using `PMA` functions.
- **Sparsity Control:** The `sumabsv` (for SPC) or `sumabs` (for CCA) parameters control the number of non-zero elements. Smaller values result in more sparsity (fewer non-zero variables).
- **Rank-1 Updates:** PMD works by finding the best rank-1 approximation and then deflating the matrix. For multiple components, the package handles this iteratively.
- **Missing Data:** The `PMD` function (the engine behind SPC and CCA) can handle missing values in the input matrices.

## Reference documentation
- [README](./references/README.md)