---
name: r-bma
description: "Package for Bayesian model averaging and variable selection for linear models,         generalized linear models and survival models (cox         regression).</p>"
homepage: https://cloud.r-project.org/web/packages/BMA/index.html
---

# r-bma

name: r-bma
description: Bayesian Model Averaging (BMA) for variable selection and model uncertainty in linear models, generalized linear models (GLM), and survival models (Cox regression). Use this skill when Claude needs to perform model averaging, identify important predictors via posterior probabilities, or handle high-dimensional data where model uncertainty is a concern.

## Overview

The `BMA` package provides tools to account for model uncertainty by averaging over a set of "best" models. Instead of selecting a single "best" model, BMA provides posterior probabilities for each model and each variable, leading to more robust inferences and predictions.

## Installation

```R
install.packages("BMA")
library(BMA)
```

## Core Workflows

### 1. Linear Regression (bicreg)
Use `bicreg` for standard linear models with Gaussian errors.

```R
# Basic usage
library(MASS)
data(UScrime)
x <- UScrime[, -16]
y <- log(UScrime[, 16])
# Log-transform predictors as needed
x[, -2] <- log(x[, -2])

bma_lin <- bicreg(x, y, strict = FALSE, OR = 20)
summary(bma_lin)
imageplot.bma(bma_lin)
```

### 2. Generalized Linear Models (bic.glm)
Use `bic.glm` for logistic, Poisson, or Gamma regression.

```R
# Logistic Regression Example
data(birthwt)
y <- birthwt$lo
x <- data.frame(birthwt[, -1])
# Ensure factors are handled correctly
x$race <- as.factor(x$race)

bma_glm <- bic.glm(x, y, glm.family = "binomial", factor.type = TRUE)
summary(bma_glm)
predict(bma_glm, newdata = x)
```

### 3. Survival Analysis (bic.surv)
Use `bic.surv` for Cox proportional hazards models.

```R
library(survival)
data(veteran)
bma_surv <- bic.surv(Surv(time, status) ~ ., data = veteran, factor.type = TRUE)
summary(bma_surv)
plot(bma_surv)
```

### 4. Iterated BMA (iBMA)
Use `iBMA` functions when the number of variables is large (e.g., gene expression data). It iterates through variables to find a manageable set for BMA.

```R
# For GLMs
i_bma <- iBMA.glm(x, y, glm.family = "binomial", thresProbne0 = 5)
orderplot(i_bma)
```

## Key Parameters

- `strict`: If `TRUE`, models with more likely submodels are eliminated (Occam's Window).
- `OR`: Odds ratio for Occam's Window. Models with posterior probability less than `1/OR` of the best model are excluded.
- `factor.type`: If `TRUE`, factor levels are dropped or kept as a group. If `FALSE`, individual dummy variables can be selected.
- `prior.param`: Vector of prior probabilities for each variable (default is 0.5).

## Visualization and Summary

- `summary(object)`: Displays posterior probabilities of variables (`probne0`) and model-averaged coefficients.
- `imageplot.bma(object)`: Visualizes which variables are included in which models (red = positive coef, blue = negative coef).
- `plot(object)`: Plots the posterior distributions of the coefficients.

## Tips
- **Prediction**: Use `predict()` on `bic.glm` or `bicreg` objects to get model-averaged predictions.
- **Outliers**: For linear regression with simultaneous outlier detection, use `MC3.REG`.
- **Large Data**: If `bicreg` or `bic.glm` is slow, ensure `maxCol` is set to a reasonable limit (default is ~30).

## Reference documentation
- [BMA Reference Manual](./references/reference_manual.md)