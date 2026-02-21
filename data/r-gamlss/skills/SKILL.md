---
name: r-gamlss
description: Skill for using the CRAN R package r-gamlss.
homepage: https://cloud.r-project.org/web/packages/gamlss/index.html
---

# r-gamlss

name: r-gamlss
description: Statistical modeling using Generalized Additive Models for Location, Scale and Shape (GAMLSS). Use this skill to fit distributional regression models where all parameters of the distribution (location, scale, skewness, kurtosis) can be modeled as functions of explanatory variables.

## Overview

GAMLSS is a general framework for univariate regression analysis that extends Generalized Additive Models (GAMs) and Generalized Linear Models (GLMs). It allows for a wide range of distributions (over 100) and provides tools for modeling not just the mean, but also the variance, skewness, and kurtosis of the response variable.

## Installation

To install the core GAMLSS package and its primary dependencies:

```R
install.packages("gamlss")
install.packages("gamlss.dist")
install.packages("gamlss.data")
install.packages("gamlss.add")
```

## Core Workflow

### 1. Basic Model Fitting
The primary function is `gamlss()`. It uses a formula-based interface similar to `glm()`.

```R
library(gamlss)

# Fit a model with Normal distribution (NO)
# mu: location, sigma: scale
mod <- gamlss(y ~ x1 + x2, 
              sigma.formula = ~ x1, 
              family = NO, 
              data = my_data)
```

### 2. Specifying Distributions
GAMLSS supports four parameters: `mu` (location), `sigma` (scale), `nu` (skewness), and `tau` (kurtosis).

```R
# Fit a Box-Cox Power Exponential (BCPE) distribution
mod <- gamlss(y ~ pb(x), 
              sigma.formula = ~ pb(x), 
              nu.formula = ~ x, 
              tau.formula = ~ 1, 
              family = BCPE, 
              data = my_data)
```

### 3. Additive Terms and Smoothers
Use smoothers within formulas to capture non-linear relationships:
- `pb()`: P-splines (recommended for automatic smoothing parameter selection)
- `cs()`: Cubic splines
- `lo()`: Loess curves
- `random()`: Simple random effects

### 4. Model Diagnostics
GAMLSS relies heavily on normalized quantile residuals (z-scores) for diagnostics.

```R
# Summary of coefficients and global deviance
summary(mod)

# Visual diagnostics (worm plot and residual plots)
plot(mod)
wp(mod) # Worm plot - essential for checking distribution fit
```

### 5. Model Selection
Compare models using Generalized Akaike Information Criterion (GAIC).

```R
# Compare two models
GAIC(mod1, mod2)

# Automatic step-wise selection
mod_selected <- stepGAIC(mod)
```

## Key Tips
- **Distribution Choice**: Use `gamlss.dist` to explore available families (e.g., `BCCG`, `LMS`, `ZIF` for zero-inflated).
- **Centile Estimation**: GAMLSS is the gold standard for creating growth charts. Use `centiles()` and `centiles.fan()` to visualize quantiles.
- **Convergence**: If a model fails to converge, try changing the `method` in `gamlss.control()` or providing better starting values.
- **Interpretable Parameters**: Most GAMLSS distributions are parameterized such that parameters relate directly to the moments or specific shapes of the distribution.

## Reference documentation

- [GAMLSS Home Page](./references/home_page.md)