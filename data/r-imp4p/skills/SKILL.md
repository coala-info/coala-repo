---
name: r-imp4p
description: The r-imp4p package provides tools for estimating and imputing missing values in MS-based proteomics data by distinguishing between MCAR and MNAR mechanisms. Use when user asks to estimate missing value probabilities, perform SLSA or IGSA imputation, or handle missing data in proteomics datasets using hybrid or multiple imputation strategies.
homepage: https://cran.r-project.org/web/packages/imp4p/index.html
---

# r-imp4p

## Overview
The `imp4p` package provides a specialized suite of tools for handling missing values in bottom-up MS-based proteomics. It is designed to distinguish between different missing value mechanisms:
- **MCAR (Missing Completely At Random)**: Often due to stochastic processes in the MS instrument.
- **MNAR (Missing Not At Random)**: Often due to the "left-censoring" effect where low-abundance peptides fall below the instrument's detection limit.

The package offers algorithms like **SLSA** (Structured Least Square Adaptative) and **IGSA** (Imputation by Grouped Selection of Adjacents) which are tailored for the specific structure of proteomics data.

## Installation
To install the package from CRAN:
```R
install.packages("imp4p")
```

## Core Workflows

### 1. Data Preparation
Data should typically be a matrix of intensities (log-transformed) where rows represent proteins/peptides and columns represent samples. A grouping vector is required to define experimental conditions.

```R
library(imp4p)
# Example: data(simul)
# intensities <- simul$mat
# conditions <- simul$conditions
```

### 2. Estimating Missing Value Mechanisms
Before imputation, estimate the probability that a missing value is MCAR vs. MNAR.
- `prob.mcar.tab`: Estimates the proportion of MCAR values in a dataset.
- `estim.bound`: Estimates the boundary between MCAR and MNAR values.

```R
# Estimate probability of being MCAR for each missing value
probs <- prob.mcar.tab(dat = intensities, conditions = conditions)
```

### 3. Imputation Algorithms
The package provides several strategies depending on the assumed mechanism:

- **SLSA (Structured Least Square Adaptative)**: Good for MCAR values, taking into account the experimental design.
  ```R
  imp_slsa <- impslsa(dat = intensities, conditions = conditions)
  ```
- **IGSA (Imputation by Grouped Selection of Adjacents)**: An alternative approach for MCAR.
  ```R
  imp_igsa <- impigsa(dat = intensities, conditions = conditions)
  ```
- **Hybrid Imputation**: The recommended approach. It uses the estimated probabilities to combine algorithms suited for MCAR (like SLSA) and MNAR (like quantile regression or small value imputation).
  ```R
  # Complete workflow using the 'impute.mixed' function
  res_mixed <- impute.mixed(dat = intensities, conditions = conditions, q = 0.025)
  ```

### 4. Multiple Imputation
For estimating uncertainty related to imputation, `imp4p` supports generating multiple imputed datasets.
- `mi.mix`: Performs multiple imputations using a mixture of MCAR and MNAR models.

## Tips for Proteomics
- **Log-Transformation**: Always ensure data is log-transformed (usually base 2) before using these functions, as the algorithms assume a normal-like distribution for observed values.
- **Condition Vector**: Ensure the `conditions` factor correctly reflects your biological replicates, as `imp4p` uses this to calculate within-group and between-group variance.
- **Filtering**: It is common practice to filter out proteins with too many missing values across all samples before running imputation.

## Reference documentation
- [imp4p: Imputation for Proteomics](./references/home_page.md)