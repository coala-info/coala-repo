---
name: r-locfit
description: Local regression, likelihood and density estimation methods as described in the 1999 book by Loader.</p>
homepage: https://cloud.r-project.org/web/packages/locfit/index.html
---

# r-locfit

name: r-locfit
description: Local regression, likelihood, and density estimation using the locfit R package. Use this skill when performing non-parametric smoothing, local polynomial regression, or density estimation, especially for complex datasets where global models fail to capture local structures.

## Overview

The `locfit` package implements local regression and likelihood methods as described in Loader (1999). It is designed for flexibility in fitting curves and surfaces to data without assuming a rigid global functional form. It supports various response types (Gaussian, Poisson, Binomial), kernel functions, and bandwidth selection methods (fixed, nearest neighbor, or adaptive).

## Installation

Install the package from CRAN:

```R
install.packages("locfit")
library(locfit)
```

## Main Functions

- `locfit()`: The primary model fitting function. Uses a formula interface similar to `lm()`.
- `lp()`: Defines local polynomial terms within the formula (e.g., `locfit(y ~ lp(x))`).
- `predict.locfit()`: Computes predicted values and standard errors from a fitted model.
- `plot.locfit()`: Visualizes the fitted model, including confidence intervals.
- `lcv()`: Performs likelihood cross-validation for parameter selection.
- `density.lf()`: Specialized interface for local density estimation.

## Workflows

### Local Regression (Smoothing)
To fit a local polynomial to a scatterplot:
```R
# Basic local regression with 70% nearest neighbor bandwidth
fit <- locfit(dist ~ lp(speed, nn = 0.7), data = cars)
plot(fit, get.data = TRUE)
```

### Local Density Estimation
To estimate the probability density of a variable:
```R
data(geyser)
fit <- locfit(~ lp(duration, nn = 0.1, h = 0.8), data = geyser)
plot(fit)
```

### Local Likelihood (Poisson/Binomial)
For non-Gaussian responses, specify the `family`:
```R
# Local Poisson regression
fit <- locfit(deaths ~ lp(age), family = "poisson", data = my_data)
```

## Tips and Best Practices

- **Bandwidth Selection**: The `nn` (nearest neighbor) and `h` (fixed) parameters in `lp()` are critical. Use `nn` for adaptive smoothing where data density varies, and `h` for constant smoothing.
- **Degree of Polynomial**: The default degree is 2 (local quadratic). Use `deg = 1` for local linear or `deg = 0` for local constant (Nadaraya-Watson).
- **Evaluation Points**: By default, `locfit` uses an evaluation structure (grid/tree) for efficiency. For exact fits at every data point, use `ev = "data"`.
- **Multivariate Smoothing**: You can smooth over multiple variables using `lp(x1, x2)`.

## Reference documentation

- [locfit: Local Regression, Likelihood and Density Estimation](./references/home_page.md)
- [Package README](./references/README.md)