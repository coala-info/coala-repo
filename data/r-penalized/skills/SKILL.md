---
name: r-penalized
description: The penalized package fits penalized regression models including Lasso, Ridge, and Elastic Net for high-dimensional data in R. Use when user asks to fit penalized linear, logistic, or Cox models, perform cross-validation for penalty parameters, or visualize coefficient paths.
homepage: https://cloud.r-project.org/web/packages/penalized/index.html
---


# r-penalized

## Overview
The `penalized` package provides tools for fitting penalized regression models in R. It supports L1 (Lasso), L2 (Ridge), and Fused Lasso penalties, as well as combinations (Elastic Net). It is compatible with linear, logistic, and Poisson regression, and the Cox Proportional Hazards model. It is particularly useful for high-dimensional data where the number of predictors exceeds the number of observations.

## Installation
```R
install.packages("penalized")
library(penalized)
```

## Core Workflow

### 1. Fitting a Model
Use the `penalized()` function to fit models with fixed penalty parameters.
- `lambda1`: L1 (Lasso) penalty.
- `lambda2`: L2 (Ridge) penalty.
- `fusedl`: Set to `TRUE` for Fused Lasso.

```R
# Logistic Regression with Ridge Penalty (lambda2 = 1)
fit <- penalized(response, penalized = ~var1 + var2, data = mydata, lambda2 = 1)

# Cox Model with Lasso Penalty (lambda1 = 10)
fit <- penalized(Surv(time, event) ~ ., data = high_dim_data, lambda1 = 10)

# Elastic Net (Both L1 and L2)
fit <- penalized(response ~ ., data = mydata, lambda1 = 1, lambda2 = 1)
```

### 2. Unpenalized Covariates
To include variables that should not be shrunk (e.g., clinical confounders), use the `unpenalized` argument.
```R
fit <- penalized(Surv(time, event), penalized = gene_matrix, unpenalized = ~age + sex, data = nki70, lambda1 = 2)
```

### 3. Cross-Validation and Optimization
Use `cvl()` to calculate the cross-validated log-likelihood for specific lambdas, or `optL1()`/`optL2()` to find the optimal tuning parameters.

```R
# 10-fold Cross-validation for a specific lambda
cv_result <- cvl(Surv(time, event) ~ ., data = mydata, lambda1 = 2, fold = 10)

# Optimize lambda1 (Lasso)
opt <- optL1(Surv(time, event) ~ ., data = mydata, fold = 10)
best_lambda1 <- opt$lambda
```

### 4. Visualizing the Penalty Path
Use the `steps` argument in `penalized()` or the `profL1()`/`profL2()` functions to generate paths, then plot with `plotpath()`.

```R
# Generate path for Lasso
fit_path <- penalized(response ~ ., data = mydata, lambda1 = 1, steps = 50)
plotpath(fit_path, log = "x")
```

## Key Functions and Objects
- `penfit`: The object returned by `penalized()`. Use `coefficients(fit)`, `residuals(fit)`, and `fitted(fit)` to extract data.
- `coefficients(fit, which = "nonzero")`: Extracts only the variables selected by the Lasso.
- `predict()`: Generates predictions for new data. For Cox models, this returns a `breslow` object.
- `basesurv()`: Extracts the baseline survival curve from a Cox model fit.

## Tips and Constraints
- **Standardization**: Use `standardize = TRUE` if covariates are on different scales. The returned coefficients are automatically scaled back to the original units.
- **Positivity**: Set `positive = TRUE` to constrain all penalized coefficients to be non-negative.
- **Factors**: Unordered factors are converted to dummy variables symmetrically; ordered factors are coded for differences between successive levels.
- **Convergence**: If the algorithm is slow or fails to converge, increase the value of `lambda1` or `lambda2`.
- **Standard Errors**: The package does not provide standard errors for penalized estimates because they are biased; use standard GLM tools on a reduced model if inference is required.

## Reference documentation
- [L1 and L2 Penalized Regression Models](./references/penalized.md)