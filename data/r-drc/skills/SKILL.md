---
name: r-drc
description: This tool provides expert assistance for dose-response curve analysis using the R package drc. Use when user asks to fit non-linear models to bioassay data, calculate effective doses, perform lack-of-fit tests, compare multiple curves, or analyze mixture toxicity.
homepage: https://cloud.r-project.org/web/packages/drc/index.html
---


# r-drc

name: r-drc
description: Expert assistance for dose-response curve analysis using the R package 'drc'. Use this skill when you need to fit non-linear models to bioassay data, calculate effective doses (ED/EC50), perform lack-of-fit tests, compare multiple curves, or analyze mixture toxicity (isoboles).

## Overview

The `drc` package is the industry standard in R for analyzing dose-response data. It provides a unified framework for fitting, model selection, and after-fitting analysis (like ED estimation and potency comparisons) for continuous, binomial, Poisson, and event-time data.

## Installation

```R
install.packages("drc")
library(drc)
```

## Core Workflow

### 1. Fitting a Model
The primary function is `drm()`. You must specify a model function (e.g., `LL.4()` for a 4-parameter log-logistic model).

```R
# Basic 4-parameter log-logistic fit
# Parameters: b (slope), c (lower limit), d (upper limit), e (ED50)
model <- drm(response ~ dose, data = my_data, fct = LL.4())

# For binomial data (e.g., dead/total)
model_bin <- drm(dead/total ~ dose, weights = total, data = my_data, 
                 fct = LL.2(), type = "binomial")
```

### 2. Model Evaluation
Check the fit quality and parameter significance.

```R
summary(model)      # Parameter estimates and p-values
modelFit(model)     # Lack-of-fit test (ANOVA-based)
plot(model)         # Visual inspection
```

### 3. Estimating Effective Doses (ED/EC)
Calculate the dose required to reach a specific effect level (e.g., 10%, 50%, 90%).

```R
# Calculate ED50 with delta-method confidence intervals
ED(model, c(10, 50, 90), interval = "delta")

# For hormesis models, use bound = FALSE if looking for stimulation effects
ED(hormesis_model, -10, bound = FALSE)
```

### 4. Comparing Curves
Compare parameters or relative potencies between different groups/treatments.

```R
# Fit model with different curves for each 'Treatment'
model_multi <- drm(response ~ dose, curveid = Treatment, data = my_data, fct = LL.4())

# Compare ED50 values (Relative Potency)
EDcomp(model_multi, c(50, 50))

# Compare specific parameters (e.g., slope 'b')
compParm(model_multi, "b", "-")
```

## Common Model Functions

- `LL.4()`: Log-logistic (4 parameters: b, c, d, e).
- `LL.3()`: Log-logistic (3 parameters: lower limit fixed at 0).
- `W1.4()` / `W2.4()`: Weibull type I and II.
- `BC.5()`: Brain-Cousens model for U-shaped hormesis.
- `AR.3()`: Asymptotic regression.
- `EXD.3()`: Exponential decay.

## Tips and Best Practices

- **Starting Values**: If `drm()` fails to converge, provide manual starting values using the `start` argument or use `getInitial(model)` to see what was attempted.
- **Transformations**: Use `boxcox(model)` to find the optimal lambda for a Box-Cox transformation if residuals show non-constant variance.
- **Log Scale**: When plotting, use `plot(model, broken = TRUE)` to handle dose 0 on a logarithmic x-axis.
- **Data Types**: Always specify `type` in `drm()` if your data is not continuous (e.g., `type = "binomial"`, `"Poisson"`, or `"event"` for germination/survival time).

## Reference documentation

- [Package ‘drc’ Reference Manual](./references/reference_manual.md)