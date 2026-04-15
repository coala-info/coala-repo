---
name: bioconductor-simulatorz
description: This tool generates realistic simulations of genomic data and performs cross-study validation for predictive modeling. Use when user asks to resample genomic datasets, balance covariate distributions, simulate survival outcomes, or perform training and validation of prediction algorithms across independent datasets.
homepage: https://bioconductor.org/packages/3.8/bioc/html/simulatorZ.html
---

# bioconductor-simulatorz

name: bioconductor-simulatorz
description: Generate realistic simulations of genomic data (ExpressionSet or SummarizedExperiment) and perform cross-study validation (CSV) for predictive modeling. Use this skill when you need to: (1) Resample genomic datasets using non-parametric or parametric bootstrap, (2) Balance covariate distributions across simulated sets, (3) Simulate time-to-event (survival) outcomes based on real experimental data, or (4) Perform training and validation of prediction algorithms across independent datasets.

## Overview

The `simulatorZ` package provides a framework for simulating genomic data collections based on real reference datasets. It is particularly useful for investigating the performance of risk prediction algorithms across independent studies. It supports `ExpressionSet` and `SummarizedExperiment` objects and implements a three-step resampling scheme: set-level bootstrap, patient-level bootstrap, and parametric survival time simulation using Cox models.

## Core Workflows

### 1. Data Simulation

The primary function for simulation is `simData()`. It performs non-parametric bootstrap resampling.

```r
library(simulatorZ)

# Basic two-step bootstrap (samples datasets, then samples patients)
sim_results <- simData(esets_list, n.samples = 500)

# One-step bootstrap (samples patients from each original dataset without resampling sets)
sim_results <- simData(esets_list, n.samples = 500, type = "one-step")

# Accessing simulated objects
simulated_esets <- sim_results$obj
```

### 2. Balancing Covariates

To ensure simulated datasets have similar clinical characteristics (e.g., tumor stage) to the source population, use the `balance.variables` argument.

```r
# Balance the distribution of 'tumorstage' and 'grade'
sim_balanced <- simData(esets_list, 
                        n.samples = 500, 
                        balance.variables = c("tumorstage", "grade"))
```

### 3. Simulating Survival Outcomes

To generate realistic survival times, you must first extract a "true model" from reference data and then apply it to simulated features.

```r
# 1. Prepare response list (Surv objects)
y_list <- lapply(esets_list, function(eset) {
  Surv(eset$days_to_death, eset$vital_status == "deceased")
})

# 2. Fit the true model (using CoxBoost)
true_mod <- getTrueModel(esets_list, y_list, parstep = 100)

# 3. Simulate times for new data
sim_with_time <- simTime(sim_results, y_list, true_mod)
```

### 4. The Driver Function

For a complete workflow (resampling + time simulation) in one call, use `simBootstrap()`.

```r
# Complete 3-step simulation
sim_complete <- simBootstrap(esets_list, y_list, n.samples = 500, parstep = 100)
```

## Training and Validation

### Cross-Study Validation (CSV)

The `zmatrix()` function automates the process of training on one dataset and validating on others using the C-index.

```r
# Generate a matrix of C-indices
# Diagonal elements represent internal cross-validation
z_results <- zmatrix(obj = esets_list, 
                     y.vars = y_list, 
                     fold = 3, 
                     trainingFun = plusMinus) # plusMinus is a built-in algorithm
```

### Manual Validation Example

```r
# Calculate C-index for a linear predictor (lp) against survival data (y)
library(Hmisc)
c_index <- rcorr.cens(-predicted_lp, y_val)[1]
```

## Tips and Best Practices

- **Feature Consistency**: When performing parametric bootstrap across multiple datasets, ensure all `ExpressionSet` objects contain the same features (rows). Use a cleaning function to find the intersection of `featureNames`.
- **Discrete Covariates**: The balancing mechanism is designed for discrete variables. Continuous variables should be discretized before being passed to `balance.variables`.
- **Algorithm Support**: While `plusMinus` is built-in, you can use other algorithms like `superpc` by manually extracting the simulated matrices (`exprs(sim_complete$obj[[1]])`).
- **Object Types**: The package seamlessly handles both `Biobase::ExpressionSet` and `SummarizedExperiment::RangedSummarizedExperiment`.

## Reference documentation

- [simulatorZ-vignette](./references/simulatorZ-vignette.md)