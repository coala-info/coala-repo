---
name: bioconductor-pengls
description: This tool performs penalized generalized least squares for high-dimensional data with spatial or temporal autocorrelation. Use when user asks to fit penalized models to dependent data, perform high-dimensional regularization with complex correlation structures, or find optimal penalty parameters via cross-validation.
homepage: https://bioconductor.org/packages/release/bioc/html/pengls.html
---


# bioconductor-pengls

name: bioconductor-pengls
description: Perform penalized generalized least squares (GLS) for high-dimensional data with spatial or temporal autocorrelation. Use this skill when analyzing datasets where observations are dependent (e.g., time-series, spatial grids, or longitudinal data) and the number of predictors (p) is large relative to the sample size (n).

# bioconductor-pengls

## Overview

The `pengls` package implements an iterative algorithm that combines the strengths of the `nlme` package (for modeling complex correlation structures) and the `glmnet` package (for high-dimensional regularization). It is specifically designed for continuous outcomes where the assumption of independent errors is violated due to spatial or temporal proximity.

## Installation

Install the package via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pengls")
library(pengls)
```

## Core Workflow

### 1. Define the Correlation Structure
Before fitting the model, you must specify the functional form of the autocorrelation using `corStruct` objects from the `nlme` package.

*   **Spatial (Gaussian):** `corGaus(form = ~ x + y, nugget = TRUE)`
*   **Temporal (AR1):** `corAR1(form = ~ time)`

### 2. Fit the Model
Use the `pengls()` function. You must provide the data, the outcome variable name, and the names of the predictors.

```r
# Fit with a fixed lambda
fit <- pengls(
  data = df, 
  outVar = "response", 
  xNames = c("gene1", "gene2", ...), 
  glsSt = corStruct, 
  lambda = 0.2
)
```

### 3. Extract Results
Standard R methods are available for `pengls` objects:
*   `coef(fit)`: Returns the penalized coefficients.
*   `predict(fit, newx)`: Predicts outcomes for new data.
*   `print(fit)`: Summarizes the correlation structure and number of non-zero coefficients.

## Cross-Validation

To find the optimal penalty parameter ($\lambda$), use `cv.pengls()`. By default, it uses the 1-standard-error rule.

```r
cv_fit <- cv.pengls(
  data = df, 
  outVar = "response", 
  xNames = predictor_names, 
  glsSt = corStruct, 
  nfolds = 5
)

# Access optimal lambda
cv_fit$lambda.1se
```

### Fold Selection
For dependent data, **blocked cross-validation** is recommended over random selection to maintain the integrity of the correlation structure within folds.
*   `cvType = "blocked"` (Default): Keeps contiguous spatial/temporal blocks together.
*   `cvType = "random"`: Standard random shuffling.

### Performance Metrics
Change the loss function using the `loss` argument:
*   `loss = "R2"` (Default): Maximizes the coefficient of determination.
*   `loss = "MSE"`: Minimizes Mean Squared Error.

## Parallel Processing

For large datasets or high fold counts, use `BiocParallel` to speed up cross-validation:

```r
library(BiocParallel)
register(MulticoreParam(workers = 4))
# cv.pengls will now use parallel backends automatically
```

## Tips for Success

1.  **Starting Values:** The initial values provided to `corStruct` (e.g., `value = c(range = 5, nugget = 0.5)`) are just starting points; the algorithm will optimize these during the iterative fitting process.
2.  **Data Transformation:** Use the `transFun` argument in `cv.pengls` (e.g., `transFun = function(x) x - mean(x)`) to center or scale outcomes within folds, which can be helpful for time-course data with baseline shifts.
3.  **Elastic Net:** You can pass `alpha` to `pengls()` or `cv.pengls()` to perform Elastic Net regularization (e.g., `alpha = 0.5`) instead of the default Lasso (`alpha = 1`).

## Reference documentation

- [Vignette of the pengls package](./references/penglsVignette.md)
- [Vignette of the pengls package (Source)](./references/penglsVignette.Rmd)