---
name: r-rcppgsl
description: R package rcppgsl (documentation from project home).
homepage: https://cran.r-project.org/web/packages/rcppgsl/index.html
---

# r-rcppgsl

## Overview
The `rcppgsl` package provides an interface between R and the GNU Scientific Library (GSL). It allows R users to leverage GSL's extensive collection of numerical routines (over 1000 functions) by providing C++ classes that wrap GSL data structures (vectors and matrices) in a way that is compatible with `Rcpp`. This is particularly useful for performance-critical applications like linear algebra, optimization, and specialized mathematical functions.

## Installation
To install the package from CRAN:
```R
install.packages("rcppgsl")
```
Note: The system must have the GNU GSL library installed (e.g., `libgsl-dev` on Debian/Ubuntu).

## Core Workflows

### 1. Using GSL Vectors and Matrices in C++
The package provides `RcppGSL::Vector` and `RcppGSL::Matrix` classes. These act as smart pointers to GSL types (`gsl_vector` and `gsl_matrix`), handling memory allocation and deallocation automatically.

**Example: Column Norms using BLAS**
```cpp
#include <RcppGSL.h>
#include <gsl/gsl_matrix.h>
#include <gsl/gsl_blas.h>

// [[Rcpp::export]]
Rcpp::NumericVector colNorm(const RcppGSL::Matrix & G) {
    int k = G.ncol();
    Rcpp::NumericVector n(k);
    for (int j = 0; j < k; j++) {
        // Create a view of the column
        RcppGSL::VectorView colview = gsl_matrix_const_column(G, j);
        // Use GSL BLAS function
        n[j] = gsl_blas_dnrm2(colview);
    }
    return n;
}
```

### 2. Fast Linear Regression (fastLm)
A primary use case is implementing faster versions of standard R functions. The `fastLm` implementation uses GSL's multi-fit linear regression routines.

**Key Steps in C++:**
1.  Pass `RcppGSL::Matrix X` and `RcppGSL::Vector y`.
2.  Allocate a GSL workspace: `gsl_multifit_linear_alloc(n, k)`.
3.  Execute the fit: `gsl_multifit_linear(X, y, coef, cov, &chisq, work)`.
4.  Free the workspace: `gsl_multifit_linear_free(work)`.

### 3. Package Development with RcppGSL
To use `rcppgsl` in your own R package:
- Add `Imports: Rcpp`, `LinkingTo: Rcpp, RcppGSL` to your `DESCRIPTION` file.
- Use `// [[Rcpp::depends(RcppGSL)]]` in your C++ source files if using `sourceCpp`.
- Include the header: `#include <RcppGSL.h>`.

## Tips for Efficiency
- **Memory Management**: `RcppGSL` classes automatically free GSL memory when they go out of scope. However, manual GSL workspaces (like `gsl_multifit_linear_workspace`) must still be explicitly freed using the appropriate GSL `_free` function.
- **Views**: Use `VectorView` or `MatrixView` to reference sub-sections of data without copying.
- **Sugar Integration**: You can mix `RcppGSL` types with Rcpp "Sugar" functions (e.g., `Rcpp::sqrt()`) for concise code.

## Reference documentation
- [RcppGSL README](./references/README.html.md)
- [RcppGSL Project Home](./references/home_page.md)