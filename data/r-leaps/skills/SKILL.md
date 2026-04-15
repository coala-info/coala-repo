---
name: r-leaps
description: This tool performs regression subset selection and exhaustive search to identify the best-fitting linear models. Use when user asks to perform feature selection, find the best subsets of regressors, or evaluate models using criteria like R-squared, Adjusted R-squared, Mallows' Cp, and BIC.
homepage: https://cloud.r-project.org/web/packages/leaps/index.html
---

# r-leaps

name: r-leaps
description: Perform regression subset selection and exhaustive search for the best subsets of regressors. Use this skill when you need to identify the best-fitting linear models using criteria like R-squared, Adjusted R-squared, or Mallows' Cp. It is particularly useful for feature selection in linear regression, handling cases with more predictors than observations, and performing efficient searches using branch-and-bound algorithms.

## Overview

The `leaps` package provides functions for subset selection in linear regression. Its primary tool is the `regsubsets` function, which performs an exhaustive search, forward selection, backward elimination, or sequential replacement to find the best models of each size. It is based on Alan Miller's Fortran code and is designed to be more flexible and efficient than older implementations, supporting non-full rank matrices and integration with the `biglm` package for large datasets.

## Installation

To install the package from CRAN:

```R
install.packages("leaps")
```

## Core Functions and Workflows

### Model Selection with regsubsets

The `regsubsets` function is the main interface. It returns an object of class `regsubsets` containing the best models found.

```R
library(leaps)

# Basic usage with formula
models <- regsubsets(y ~ x1 + x2 + x3 + x4, data = my_data)

# Usage with design matrix
models <- regsubsets(x = design_matrix, y = response_vector)

# Specify search method: "exhaustive" (default), "forward", "backward", or "seqrep"
models_fwd <- regsubsets(y ~ ., data = my_data, method = "forward")

# Limit the maximum size of subsets to save time
models_small <- regsubsets(y ~ ., data = my_data, nvmax = 5)
```

### Analyzing Results

Use `summary()` to extract statistics for the best models of each size.

```R
res.sum <- summary(models)

# Access statistics
res.sum$rsq    # R-squared
res.sum$adjr2  # Adjusted R-squared
res.sum$cp     # Mallows' Cp
res.sum$bic    # Bayesian Information Criterion
res.sum$outmat # Logical matrix showing which variables are in each model
```

### Visualization

The package includes a `plot` method for `regsubsets` objects to visualize model performance across different subset sizes.

```R
# Plot models ranked by Adjusted R-squared
plot(models, scale = "adjr2")

# Plot models ranked by Mallows' Cp
plot(models, scale = "Cp")

# Plot models ranked by BIC
plot(models, scale = "bic")
```

## Advanced Usage

### Handling Large Datasets

When the number of observations is very large, use the `biglm` package to compute the cross-product matrix first, then pass it to `regsubsets`.

```R
library(biglm)
b <- biglm(y ~ x1 + x2 + x3, data = my_data)
models_big <- regsubsets(b)
```

### Non-Full Rank Predictors

`leaps` can handle predictors that are not of full rank, which is common when the number of predictors ($p$) exceeds the number of cases ($n$). It will identify the best "small" models even in these high-dimensional settings.

## Tips

- **nvmax**: Always consider setting `nvmax` if you have many predictors, as exhaustive search complexity grows exponentially.
- **really.big**: If you have more than 50 variables, you must set `really.big = TRUE` in `regsubsets` to acknowledge the computational cost.
- **Intercept**: By default, an intercept is included. Use `intercept = FALSE` if a no-intercept model is required.

## Reference documentation

- [README](./references/README.md)
- [Home Page](./references/home_page.md)