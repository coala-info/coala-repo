---
name: bioconductor-graper
description: The graper package implements a Bayesian penalized regression model that automatically learns group-specific shrinkage and sparsity levels for high-dimensional data. Use when user asks to perform group-aware penalized regression, fit spike-and-slab models with feature annotations, or estimate group-wise importance and inclusion probabilities.
homepage: https://bioconductor.org/packages/release/bioc/html/graper.html
---


# bioconductor-graper

## Overview

The `graper` package implements a Bayesian approach for penalized regression that accounts for feature grouping. It automatically learns the importance (shrinkage) and sparsity (inclusion probability) of different feature groups using Variational Bayes. This is particularly useful in high-dimensional biological data where features have prior annotations (like gene sets or functional categories).

## Core Workflow

### 1. Data Preparation
The package requires a numeric matrix `X` (samples x features), a response vector `y`, and an annotation vector `annot` that maps each feature to a group.

```r
library(graper)

# X: matrix of predictors
# y: response vector (numeric for linear, 0/1 for binomial)
# annot: vector of group labels for each column in X
```

### 2. Fitting the Model
The main function is `graper()`. It supports both linear (default) and logistic regression.

```r
# Linear Regression (default)
fit <- graper(X, y, annot, n_rep = 3)

# Logistic Regression (experimental)
fit_log <- graper(X, y, annot, family = "binomial", calcELB = FALSE)
```

**Key Parameters:**
- `spikeslab`: Logical; if TRUE (default), uses a spike-and-slab prior for sparsity.
- `n_rep`: Number of random initializations to avoid local optima (returns the one with the highest ELBO).
- `standardize`: Logical; whether to standardize predictors.
- `verbose`: Logical; set to FALSE to suppress training logs.

### 3. Interpreting Results
The fitted object contains group-wise parameters and feature-level estimates.

```r
# Print summary of group-wise shrinkage and sparsity
print(fit)

# Get feature coefficients (excluding intercept)
beta <- coef(fit, include_intercept = FALSE)

# Get Posterior Inclusion Probabilities (PIPs) for features
pips <- getPIPs(fit)

# Get the intercept
intercept <- fit$intercept
```

### 4. Visualization
`graper` provides built-in plotting functions to diagnose convergence and visualize learned parameters.

```r
# Check convergence (ELBO should increase and flatten)
plotELBO(fit)

# Visualize learned group penalties and sparsity levels
plotGroupPenalties(fit)

# Plot posterior distributions for group-wise parameters (gamma or pi)
plotPosterior(fit, "gamma")
plotPosterior(fit, "pi")
```

### 5. Prediction
Use the standard `predict` interface for new data.

```r
# Predict on new matrix Xtest
preds <- predict(fit, Xtest)
```

## Tips and Limitations
- **Logistic Regression**: The logistic implementation is experimental. It does not currently calculate the ELBO for convergence monitoring and may require a high number of iterations (`max_iter`).
- **Group Information**: The power of `graper` comes from the `annot` vector. Ensure that the group labels in `annot` correspond exactly to the columns in `X`.
- **Variational Bayes**: VB provides point estimates quickly but can produce overly concentrated posterior distributions; use them for selection and prediction rather than strict confidence intervals.

## Reference documentation
- [Vignette illustrating the use of graper in linear regression](./references/example_linear.md)
- [Vignette illustrating the use of graper in logistic regression](./references/example_logistic.md)