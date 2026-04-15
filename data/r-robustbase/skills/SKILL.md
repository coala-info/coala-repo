---
name: r-robustbase
description: The robustbase package provides reliable and efficient tools for performing robust statistical methods such as regression and multivariate estimation. Use when user asks to perform robust linear regression, estimate robust multivariate location and scatter, or fit robust generalized linear models.
homepage: https://cloud.r-project.org/web/packages/robustbase/index.html
---

# r-robustbase

## Overview
The `robustbase` package provides highly reliable and efficient tools for robust statistics, implementing methods described in "Robust Statistics, Theory and Methods" (Maronna, Martin, and Yohai). Its primary strengths are robust regression via `lmrob()` and robust multivariate estimation via `covMcd()`.

## Installation
```R
install.packages("robustbase")
library(robustbase)
```

## Core Workflows

### 1. Robust Linear Regression (MM-estimation)
The `lmrob()` function is the recommended tool for robust linear regression. It uses MM-estimators which provide both high breakdown point and high efficiency.

```R
# Basic usage
model <- lmrob(Y ~ X1 + X2, data = mydata)

# Summary with robust standard errors and Wald tests
summary(model)

# Setting specific psi-functions (e.g., 'ks2011' for small samples)
model_ks <- lmrob(Y ~ X1 + X2, data = mydata, setting = "KS2011")
```

**Key Settings:**
- `setting = "KS2011"`: Recommended for small samples to sharpen Wald-type inference.
- `psi`: Choose between "bisquare", "lqq", "optimal", "hampel", or "ggw".

### 2. Robust Multivariate Location and Scatter (MCD)
The Minimum Covariance Determinant (MCD) estimator is used to find a robust center and covariance matrix, which is essential for outlier detection in multivariate data.

```R
# Compute MCD
mcd <- covMcd(x)

# Robust distances (Mahalanobis-like)
dist <- mcd$mah

# Plotting to identify outliers (Distance-Distance plot)
plot(mcd, which = "dd")
```

**Parameters:**
- `alpha`: The proportion of observations kept (default is ~0.5 for maximum robustness).
- `nsamp`: Number of subsets for the FastMCD algorithm.

### 3. Robust Generalized Linear Models (GLM)
Use `glmrob()` for robust estimation of Generalized Linear Models (e.g., Logistic or Poisson regression).

```R
# Robust Logistic Regression
fit <- glmrob(y ~ x1, family = binomial, data = mydata, method = "Mqle")
```

## Psi-Functions and Tuning
The package supports various redescending psi-functions. Tuning constants are typically set to achieve 95% efficiency at the normal model.

- **Bisquare (Tukey)**: Standard redescender.
- **LQQ**: Linear-Quadratic-Quadratic; provides better control over the rejection point.
- **Optimal**: Minimizes maximum bias.

Use `.Mpsi.tuning.default("psi_name")` to see default constants.

## Tips for AI Agents
- When `lmrob` fails to converge, suggest increasing `max.it` in `lmrob.control()`.
- For high-dimensional data ($p > n$), standard MCD will fail; suggest robust PCA or alternative methods.
- Always check the "Robustness Weights" (`model$rweights`) to identify which observations were downweighted as outliers.

## Reference documentation
- [covMcd() – Considerations about Generalizing the FastMCD](./references/fastMcd-kmini.md)
- [Simulations for Sharpening Wald-type Inference in Robust Regression for Small Samples](./references/lmrob_simulation.md)
- [Definitions of ψ-Functions Available in Robustbase](./references/psi_functions.md)