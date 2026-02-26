---
name: r-floral
description: FLORAL performs log-ratio lasso regression for compositional data to predict continuous, binary, or survival outcomes. Use when user asks to fit penalized regression models on microbiome data, perform feature selection with zero-sum constraints, or analyze longitudinal compositional covariates.
homepage: https://cran.r-project.org/web/packages/floral/index.html
---


# r-floral

name: r-floral
description: Fit LOg-RAtio Lasso (FLORAL) regression for compositional data. Use this skill when performing microbiome analysis or working with compositional covariates to predict continuous, binary, or survival outcomes. It supports zero-sum constraint optimization, two-stage feature screening, and longitudinal data handling.

# r-floral

## Overview

The `FLORAL` package provides tools for log-ratio lasso regression, specifically designed for compositional data like microbiome abundances. It addresses the unit-sum constraint of compositional data by using a zero-sum constraint in the lasso optimization. Key features include:
- Support for multiple outcome types: Gaussian (continuous), Binomial (binary), Cox (survival), and Fine-Gray (competing risks).
- A two-stage screening process to identify predictive log-ratios and control false positives.
- Handling of longitudinal microbiome data with time-dependent features.
- Integration with `phyloseq` objects.

## Installation

```R
install.packages("FLORAL")
```

## Core Workflow

### 1. Data Preparation
FLORAL requires a feature matrix `x` (counts or relative abundances) and an outcome vector/object `y`.
- **Binary outcomes**: `y` must be 0 or 1.
- **Survival outcomes**: `y` must be a `survival::Surv` object.
- **Filtering**: It is recommended to filter low-abundance taxa before running the model.

### 2. Basic Model Fitting
Use the `FLORAL()` function as the primary interface.

```R
library(FLORAL)

# Linear regression example
fit <- FLORAL(x = x_matrix, y = y_vector, family = "gaussian", ncv = 10)

# Logistic regression example
fit_bin <- FLORAL(x = x_matrix, y = y_binary, family = "binomial", ncv = 10)

# Cox model for survival data
library(survival)
fit_cox <- FLORAL(x = x_matrix, y = Surv(time, status), family = "cox", ncv = 10)
```

### 3. Interpreting Results
The fit object contains several key components:
- `fit$selected.feature`: Lists features selected at `min` (MSE minimizing) and `1se` (most parsimonious within 1 standard error) penalties.
- `fit$step2.ratios`: Specific log-ratios identified by the two-stage procedure.
- `fit$step2.tables`: Summary tables for the multivariable stepwise regression models of the selected ratios.
- `fit$pmse` and `fit$pcoef`: Plots for cross-validation error and coefficient trajectories.

### 4. Longitudinal Data
For longitudinal data, provide subject IDs and observation times.

```R
fit_long <- FLORAL(
  x = x_matrix, 
  y = Surv(unique_patient_time, unique_patient_status),
  family = "cox",
  longitudinal = TRUE,
  id = subject_ids,
  tobs = observation_times
)
```

### 5. Phyloseq Integration
Use the helper function `phy_to_floral_data` to prepare data from a `phyloseq` object.

```R
dat <- FLORAL::phy_to_floral_data(
  phy_obj, 
  covariates = c("Var1", "Var2"), 
  y = "OutcomeColumn"
)
res <- FLORAL::FLORAL(y = dat$y, x = dat$xcount, ncov = dat$ncov, family = "gaussian")
```

## Advanced Features

- **Elastic Net**: Adjust the `a` parameter (0 for Ridge, 1 for Lasso, or in-between). Use `a.FLORAL()` to test multiple alpha values.
- **Stability Selection**: Use `mcv.FLORAL()` to repeat cross-validation multiple times and calculate taxa selection probabilities.

## Reference documentation

- [FLORAL Home Page](./references/home_page.md)
- [Using FLORAL for Microbiome Analysis](./references/Using-FLORAL-for-Microbiome-Analysis.html.md)
- [Using FLORAL for survival models with longitudinal microbiome data](./references/Using-FLORAL-for-survival-models-with-longitudinal.md)
- [Using FLORAL with phyloseq data](./references/Using-FLORAL-with-phyloseq.html.md)