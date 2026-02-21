---
name: r-qpcr
description: R package qpcr (documentation from project home).
homepage: https://cran.r-project.org/web/packages/qpcr/index.html
---

# r-qpcr

## Overview
The `qpcR` package is a comprehensive toolset for the analysis of quantitative real-time PCR data. It focuses on mechanistic and sigmoidal modeling of amplification curves rather than simple threshold-based methods. It allows for the estimation of amplification efficiency, quantification cycles (Cq/Ct), and initial template amounts using various models (e.g., 4-parameter logistic, 5-parameter logistic, and exponential models).

## Installation
To install the package from CRAN:
```R
install.packages("qpcR")
```

## Core Workflow

### 1. Data Preparation
`qpcR` expects data where one column represents the cycle numbers and subsequent columns represent fluorescence values for different wells.
```R
library(qpcR)
# Example using internal data 'reps'
data(reps)
# First column is cycles, others are fluorescence
```

### 2. Model Fitting
Use the `pcrfit` function to fit a specific model to a single curve.
```R
# Fit a 4-parameter logistic model to the first sample
fit1 <- pcrfit(reps, cyc = 1, fluo = 2, model = l4)
plot(fit1)
```

### 3. Batch Processing
Use `modlist` to fit models to multiple curves simultaneously.
```R
# Fit models to all columns in the dataset
ml <- modlist(reps, model = l5)
```

### 4. Parameter Extraction
Extract essential qPCR parameters like the Second Derivative Maximum (SDM) or Take-off Point (TOP) using `efficiency`.
```R
# Calculate efficiency and Cq values
res <- efficiency(fit1)
# Access Cq (Second Derivative Maximum)
res$cpD2
```

## Key Functions
- `pcrfit`: Fits a single PCR curve using non-linear regression.
- `modlist`: Creates a list of model fits for high-throughput analysis.
- `mselect`: Performs automated model selection to find the best-fitting kinetic model (e.g., comparing `l4`, `l5`, `b4`).
- `efficiency`: The primary function for calculating Cq values, amplification efficiency, and initial fluorescence ($F_0$).
- `ratio`: Calculates relative expression ratios between samples and controls.

## Tips for Success
- **Model Selection**: If unsure which model to use, `mselect` can rank models based on AIC or BIC.
- **Baseline Subtraction**: Ensure your data is baseline-subtracted or use the `check` and `offset` arguments in `pcrfit` to handle background fluorescence.
- **Sigmoidal vs. Linear**: `qpcR` excels at sigmoidal modeling. For standard curve-based analysis (linear regression of Cq vs. log-concentration), use the `calib` function.

## Reference documentation
- [qpcR: Modelling and Analysis of Real-Time PCR Data](./references/home_page.md)