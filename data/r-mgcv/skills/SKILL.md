---
name: r-mgcv
description: The r-mgcv package fits Generalized Additive Models and Generalized Additive Mixed Models using penalized regression splines with automatic smoothness selection. Use when user asks to model non-linear relationships with smooth functions, fit GAMs or GAMMs, handle large datasets with penalized splines, or perform spatial smoothing and random effect modeling.
homepage: https://cloud.r-project.org/web/packages/mgcv/index.html
---


# r-mgcv

name: r-mgcv
description: Comprehensive tool for fitting Generalized Additive Models (GAMs) and Generalized Additive Mixed Models (GAMMs). Use when you need to model non-linear relationships using smooth functions, perform automatic smoothness selection (REML/GCV), or handle large datasets with penalized regression splines.

# r-mgcv

## Overview
The `mgcv` package is the standard R library for Generalized Additive Models (GAMs). It provides functions for model fitting, automatic smoothness estimation, and diagnostics. It supports a wide variety of smoothers (splines, Markov Random Fields, Gaussian Processes) and can handle very large datasets via the `bam` function.

## Installation
install.packages("mgcv")

## Core Workflow

### 1. Basic Model Fitting
Use `gam()` for standard datasets. Specify smooth terms using `s()` for univariate effects and `te()` or `t2()` for interactions.

library(mgcv)
# Fit a GAM with REML (recommended for stability)
model <- gam(y ~ s(x0) + s(x1) + s(x2), data = my_data, method = "REML")

# Specify family (e.g., Poisson, Binomial)
model_poi <- gam(y ~ s(x), family = poisson, data = my_data)

### 2. Large Datasets
Use `bam()` for datasets with >10,000 observations. It uses a more memory-efficient algorithm and supports discretization for speed.

# Fast REML for large data
model_large <- bam(y ~ s(x0) + s(x1), data = large_data, discrete = TRUE)

### 3. Mixed Models
Use `gamm()` to integrate with the `nlme` package for complex random effect structures, or use `s(..., bs="re")` within `gam()` for simple random intercepts/slopes.

# Using gam for random effects
model_mixed <- gam(y ~ s(x) + s(subject, bs="re"), data = my_data)

## Smooth Term Selection
- **s(x, bs="tp")**: Thin plate regression splines (default, good for general use).
- **s(x, bs="cr")**: Cubic regression splines (faster for large k).
- **s(x, bs="ps")**: P-splines.
- **s(x, bs="mrf", xt=list(polys=...))**: Markov Random Fields for spatial data.
- **te(x, z)**: Tensor product smooths for interactions where variables are on different scales.

## Diagnostics and Visualization
- **summary(model)**: Provides EDF (Effective Degrees of Freedom), p-values, and R-squared.
- **gam.check(model)**: Essential for checking if the basis dimension `k` is sufficient and inspecting residuals.
- **plot(model, pages=1)**: Visualizes the estimated smooth functions.
- **vis.gam(model, view=c("x","z"), plot.type="persp")**: 3D visualization of interactions.

## Tips for Success
- **Basis Dimension (k)**: If `gam.check` shows a low p-value for `k' index`, increase `k` in the `s()` term (e.g., `s(x, k=20)`).
- **Method Selection**: Use `method="REML"` or `method="ML"` instead of the default `GCV.Cp` for more robust smoothness estimation, especially with small samples.
- **Concurvity**: Use `concurvity(model)` to check for multi-collinearity between smooth terms.
- **Categorical Predictors**: Use the `by` argument in `s()` for factor-smooth interactions: `y ~ factor_var + s(x, by=factor_var)`.

## Reference documentation
- [Package ‘mgcv’ Reference Manual](./references/reference_manual.md)