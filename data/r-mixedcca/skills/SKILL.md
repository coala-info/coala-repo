---
name: r-mixedcca
description: This tool performs sparse canonical correlation analysis for datasets containing mixed data types such as continuous, binary, and truncated variables. Use when user asks to estimate canonical correlations, find sparse canonical vectors for mixed-type data, or calculate latent correlation matrices using semiparametric methods.
homepage: https://cran.r-project.org/web/packages/mixedcca/index.html
---


# r-mixedcca

name: r-mixedcca
description: Sparse canonical correlation analysis (CCA) for mixed data types (continuous, binary, and zero-truncated/truncated continuous). Use this skill when you need to estimate canonical correlations and sparse canonical vectors for datasets containing different variable types using semiparametric methods.

# r-mixedcca

## Overview
The `mixedcca` package provides tools for performing sparse canonical correlation analysis on mixed-type data. It utilizes a semiparametric approach based on latent correlations to handle continuous, binary, and zero-inflated (truncated continuous) variables. This allows for robust feature selection and correlation estimation in high-dimensional settings where data does not follow a standard multivariate normal distribution.

## Installation
To install the package from CRAN:
```R
install.packages("mixedcca")
```
To install the development version:
```R
# install.packages("devtools")
devtools::install_github("irinagain/mixedCCA")
```

## Main Functions

### mixedCCA
The primary function for performing sparse semiparametric CCA.
```R
mixedCCA(X1, X2, type1, type2, BICtype = 1, ...)
```
- **X1, X2**: Input data matrices.
- **type1, type2**: Data types for each dataset. Options: `"continuous"`, `"binary"`, or `"trunc"` (for zero-truncated/zero-inflated).
- **BICtype**: Selection criterion for sparsity parameters (1 or 2).

### estimateR and estimateR_mixed
Functions to estimate the latent correlation matrix without running the full CCA.
- `estimateR(X, type)`: Estimates the latent correlation matrix for a single dataset.
- `estimateR_mixed(X1, X2, type1, type2)`: Estimates the combined latent correlation matrix for two datasets.

### GenerateData
A utility for simulating mixed-type data with known canonical structures.
```R
GenerateData(n, trueidx1, trueidx2, maxcancor, Sigma1, Sigma2, type1, type2, ...)
```

## Workflow Example

```R
library(mixedCCA)

# 1. Prepare data (Example using truncated continuous data)
n <- 100; p1 <- 15; p2 <- 10
trueidx1 <- c(rep(1, 3), rep(0, p1-3))
trueidx2 <- c(rep(1, 2), rep(0, p2-2))

# 2. Generate simulated mixed data
simdata <- GenerateData(n=n, trueidx1=trueidx1, trueidx2=trueidx2, 
                        maxcancor=0.9, type1="trunc", type2="trunc")
X1 <- simdata$X1
X2 <- simdata$X2

# 3. Run Sparse Mixed CCA
result <- mixedCCA(X1, X2, type1="trunc", type2="trunc", BICtype=1)

# 4. Access results
result$w1      # Sparse canonical vector for X1
result$w2      # Sparse canonical vector for X2
result$cancor  # Estimated canonical correlation
result$KendallR # Estimated latent correlation matrix
```

## Tips
- **Data Types**: Ensure you correctly specify `type1` and `type2`. If a dataset has multiple types within it, the package generally expects a uniform type per matrix or specific handling via the latent correlation functions.
- **Speed**: The package implements a fast computation method for latent correlations, making it suitable for relatively high-dimensional data.
- **Sparsity**: The sparse vectors (`w1`, `w2`) automatically perform variable selection, identifying which features contribute most to the correlation between the two sets.

## Reference documentation
- [README.Rmd](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)