---
name: r-misctools
description: R package misctools (documentation from project home).
homepage: https://cran.r-project.org/web/packages/misctools/index.html
---

# r-misctools

## Overview
The `miscTools` package is a collection of miscellaneous utilities developed as part of the `micEcon` project. It provides essential helper functions for econometric analysis, particularly for handling the mathematical structures common in microeconomic modeling, such as Hessian matrices and elasticity calculations.

## Installation
To install the package from CRAN:
```r
install.packages("miscTools")
```

## Main Functions and Workflows

### Matrix Manipulation
`miscTools` provides functions to modify matrices without manual indexing:
* `insertCol(m, col, v)`: Inserts a vector `v` as a new column into matrix `m` at position `col`.
* `insertRow(m, row, v)`: Inserts a vector `v` as a new row into matrix `m` at position `row`.

### Symmetric Matrix Utilities
These functions are critical for working with variance-covariance or Hessian matrices:
* `vech(m)`: Extracts the unique (lower triangular) elements of a symmetric matrix into a vector.
* `invVech(v)`: Reconstructs a symmetric matrix from a vector of its unique elements.
* `symMatrix(v)`: Creates a symmetric matrix from a vector.

### Matrix Properties
Test the properties of matrices, often used to check second-order conditions in optimization:
* `isSemidefinite(m)`: Checks if a matrix is positive or negative semidefinite.
* `semidefiniteness(m)`: Returns the status of the matrix (positive semidefinite, negative semidefinite, or indefinite).

### Statistical Helpers
* `colGmeans(x)`: Calculates the geometric means of the columns of a matrix or data frame.
* `rowGmeans(x)`: Calculates the geometric means of the rows.
* `stdEr(x)`: A generic function to extract standard errors from model objects.
* `compMargins(x)`: Computes marginal effects (often used in conjunction with other `micEcon` packages).

## Tips for Usage
* **Integration**: This package is a dependency for many microeconomic analysis packages like `micEconAids` and `micEconSNQP`. Use it to prepare data or check model assumptions (like curvature) for these higher-level packages.
* **Efficiency**: When storing large symmetric matrices, use `vech()` to save space and `invVech()` to restore the matrix for calculations.
* **Semidefiniteness**: Always ensure your matrix is symmetric before using `isSemidefinite()`, as these tests are designed for symmetric matrices.

## Reference documentation
- [The micEcon Project Home Page](./references/home_page.md)