---
name: r-gam
description: This tool fits and analyzes Generalized Additive Models in R to model non-linear relationships using smoothing splines or local regression. Use when user asks to fit a GAM, model non-linear effects with smoothing splines or loess, visualize partial residual plots, or perform stepwise model selection for additive models.
homepage: https://cloud.r-project.org/web/packages/gam/index.html
---


# r-gam

name: r-gam
description: Fitting and working with Generalized Additive Models (GAMs) in R. Use this skill when you need to model non-linear relationships between a response variable and multiple predictors using smoothing splines or local regression. It is ideal for exploratory data analysis and creating interpretable models where the contribution of each predictor is visualized through partial residual plots.

## Overview
The `gam` package provides functions for fitting Generalized Additive Models as described in "Statistical Models in S" (Chambers and Hastie) and "Generalized Additive Models" (Hastie and Tibshirani). It extends Generalized Linear Models (GLMs) by allowing the linear predictor to be a sum of smooth functions of the covariates. The package uses the backfitting algorithm to fit these models.

## Installation
To install the package from CRAN:
```R
install.packages("gam")
library(gam)
```

## Core Functions
- `gam(formula, family, data, ...)`: The main function to fit a GAM. It supports standard R formulas and exponential family distributions (gaussian, binomial, poisson, etc.).
- `s(x, df = 4)`: Defines a smoothing spline term for a numeric predictor `x` within a formula.
- `lo(x, span = 0.5, degree = 1)`: Defines a local regression (loess) term for a numeric predictor `x` within a formula.
- `plot.gam(object, ...)`: Produces partial residual plots for each term in the model, showing the estimated non-linear effect of each predictor.
- `summary.gam(object)`: Provides a summary of the model, including analysis of deviance and non-parametric significance tests.
- `predict.gam(object, newdata, type = c("link", "response", "terms"))`: Predicts values for new data.
- `step.gam(object, scope, direction)`: Performs stepwise model selection for GAMs.

## Basic Workflow

### 1. Fitting a Model
Combine parametric terms with smooth terms (`s` or `lo`) in the formula.
```R
# Fit a GAM with a smoothing spline for 'temp' and a loess term for 'wind'
fit <- gam(Ozone ~ s(Temp, df = 5) + lo(Wind, span = 0.5) + Solar.R, 
           data = airquality, family = gaussian)
```

### 2. Model Interpretation
Use the `plot` function to visualize the non-linear components.
```R
# Plot the smooth terms with standard error bands
par(mfrow = c(1, 3))
plot(fit, se = TRUE, col = "red", lwd = 2)
```

### 3. Model Comparison and Selection
Use `anova` to compare a GAM against a GLM or other GAMs.
```R
fit_glm <- glm(Ozone ~ Temp + Wind + Solar.R, data = airquality)
anova(fit_glm, fit, test = "F")
```

## Tips and Best Practices
- **Degrees of Freedom**: In `s(x, df)`, the `df` argument controls the smoothness. A higher `df` allows for more flexibility (wiggliness), while `df = 1` results in a linear fit.
- **gam vs. mgcv**: Note that R has two primary GAM packages. This package (`gam`) uses the backfitting algorithm. The `mgcv` package uses integrated smoothness estimation. Use `gam` when you want to explicitly specify degrees of freedom or use loess terms.
- **Categorical Predictors**: Factors are handled automatically as parametric terms. Do not wrap them in `s()` or `lo()`.
- **Stepwise Selection**: The `step.gam` function requires a `scope` argument, which is a list of formulas defining the candidate terms for each variable (e.g., `list("Temp" = ~1 + Temp + s(Temp, 3) + s(Temp, 5))`).

## Reference documentation
- [README](./references/README.html.md)
- [Home Page](./references/home_page.md)