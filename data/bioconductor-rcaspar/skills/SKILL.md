---
name: bioconductor-rcaspar
description: "RCASPAR performs survival analysis on high-dimensional datasets using a piecewise baseline hazard Cox regression model with Lq-norm regularization. Use when user asks to predict survival times from genomic data, perform k-fold cross-validation for survival models, or evaluate survival predictions using Kaplan-Meier plots and ROC analysis."
homepage: https://bioconductor.org/packages/release/bioc/html/RCASPAR.html
---


# bioconductor-rcaspar

## Overview

RCASPAR is an R package for survival analysis on high-dimensional datasets. It implements a piecewise baseline hazard Cox regression model. A key feature is the use of an Lq-norm based prior for regularization, which effectively selects the most relevant covariates (e.g., genes) for predicting survival times. It is particularly useful when the number of covariates far exceeds the number of samples.

## Data Preparation

RCASPAR requires two main inputs:

1.  **Covariate Data (e.g., Gene Expression):** A matrix where rows are patients and columns are covariates. Missing values should be filled with zeros.
2.  **Survival Data:** A data frame with at least two specific columns:
    *   `True_STs`: Survival times (numeric).
    *   `censored`: Censorship status (0 for uncensored/event occurred, 1 for censored).

## Core Workflows

### 1. Training and Prediction (Manual Split)
Use `STpredictor_BLH` when you have pre-defined training and validation sets.

```r
library(RCASPAR)

# Example using built-in data
data(Bergamaschi)
data(survData)

result <- STpredictor_BLH(
  geDataS = Bergamaschi[1:27, ],  # Validation covariates
  survDataS = survData[1:27, ],   # Validation survival info
  geDataT = Bergamaschi[28:82, ], # Training covariates
  survDataT = survData[28:82, ],  # Training survival info
  q = 1, s = 1,                   # Prior parameters (L1-norm like)
  a = 1.558, b = 0.179,           # Gamma prior for baseline hazard
  cut.off = 3,                    # Threshold to define long/short survivors
  groups = 3,                     # Number of baseline hazard intervals
  method = "CG"                   # Optimization: "CG", "BFGS", "L-BFGS-B", or "SANN"
)
```

### 2. K-fold Cross-Validation
Use `STpredictor_xvBLH` to perform cross-validation on a single dataset.

```r
result_xv <- STpredictor_xvBLH(
  geData = Bergamaschi, 
  survData = survData, 
  k = 5, 
  q = 1, s = 1, a = 1.558, b = 0.179, 
  groups = 3, 
  cut.off = 3
)
```

## Visualizing and Evaluating Results

### Kaplan-Meier Plots
Compare the survival of predicted "long" vs "short" survivors.

```r
kmplt_svrl(
  long = result$long_survivors, 
  short = result$short_survivors, 
  title = "Survival Comparison"
)
```

### Statistical Significance
Perform a log-rank test to compare the predicted groups.

```r
logrnk(dataL = result$long_survivors, dataS = result$short_survivors)
```

### Performance Metrics (ROC and AURC)
Evaluate the predictor at specific time points or across the entire time range.

```r
# ROC at a specific time point
survivROC(
  Stime = result$predicted_STs$True_STs,
  status = result$predicted_STs$censored,
  marker = result$predicted_STs$Predicted_STs,
  predict.time = 5,
  plot = TRUE
)

# Area Under the ROC Curve (AURC) over time
survivAURC(
  Stime = result$predicted_STs$True_STs,
  status = result$predicted_STs$censored,
  marker = result$predicted_STs$Predicted_STs,
  time.max = 10
)
```

## Parameter Tuning Tips

*   **Prior (q, s):** Use `pltprior(q, s)` to visualize the weight prior. `q=1` corresponds to a Lasso-like effect.
*   **Baseline Hazard (a, b):** Use `pltgamma(a, b)` to visualize the gamma distribution used as a prior for the baseline hazards.
*   **Optimization:** If the algorithm terminates too early at the origin, increase the `noprior` argument to run initial iterations without the weight prior.
*   **Extracting Weights:** 
    *   For `STpredictor_BLH`: `result$log_optimization$par` (first elements are baseline hazards, subsequent are covariate weights).
    *   For `STpredictor_xvBLH`: `result$weights` and `result$baselineHs`.

## Reference documentation
- [RCASPAR: A package for survival time analysis using high-dimensional data](./references/RCASPAR.md)