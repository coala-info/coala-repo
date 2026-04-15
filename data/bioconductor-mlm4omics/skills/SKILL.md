---
name: bioconductor-mlm4omics
description: bioconductor-mlm4omics provides Bayesian multilevel models for analyzing omics data with missing and left-censored values. Use when user asks to fit multilevel models for clinical proteomics, handle missing not at random data, or perform variance decomposition with censored observations.
homepage: https://bioconductor.org/packages/3.9/bioc/html/mlm4omics.html
---

# bioconductor-mlm4omics

## Overview

The `mlm4omics` package provides specialized Bayesian multilevel models designed for omics data, particularly clinical proteomics. It addresses the common issue of Missing Not At Random (MNAR) data, where the probability of a value being missing depends on the unobserved value itself (e.g., low protein abundance falling below detection limits). The package implements selection models within a Stan framework to perform variance decomposition across data hierarchies while simultaneously modeling missingness and left-censoring.

## Core Functions

The package relies on two primary modeling functions:

- `mlmc()`: For data containing both missing values and **left-censored** values (values known to be below a specific threshold).
- `mlmm()`: For data containing missing values but **no censored** values.

## Typical Workflow

### 1. Data Preparation
Ensure your dataset contains indicators for missingness and censoring. These must be mutually exclusive.

```r
library(mlm4omics)
data(pdata)

# Check for overlap between missing (1) and censor (1) indicators
table(pdata$miss, pdata$censor)

# If indicators overlap, ensure they are exclusive
n <- dim(pdata)[1]
for (i in seq_len(n)) {
  if (pdata$miss[i] == 1 && pdata$censor[i] == 1) pdata$miss[i] = 0
}
```

### 2. Defining Formulas
You must define formulas for the completed data, the missingness mechanism, and the hierarchical structure.

```r
# Response ~ Predictors
formula_completed <- var1 ~ var2 + treatment

# Missingness indicator ~ Predictors
formula_missing <- miss ~ var2

# Censoring indicator (usually ~ 1)
formula_censor <- censor ~ 1

# Subject/Grouping level
formula_subject <- ~ sid
```

### 3. Fitting the Model
Models use Stan for MCMC sampling. It is recommended to use at least 1000 iterations for production runs.

**Using mlmc() (with censoring):**
```r
model_fit <- mlmc(
  formula_completed = var1 ~ var2 + treatment,
  formula_missing = miss ~ var2,
  formula_censor = censor ~ 1,
  formula_subject = ~sid,
  pdata = pdata,
  response_censorlim = 0.002, # The detection limit
  respond_dep_missing = TRUE,  # Missingness depends on abundance
  pidname = "geneid",          # Protein/Feature ID
  sidname = "sid",             # Subject ID
  iterno = 1000,
  chains = 2
)
```

**Using mlmm() (no censoring):**
```r
model_fit <- mlmm(
  formula_completed = var1 ~ var2 + treatment,
  formula_missing = miss ~ var2,
  formula_subject = ~sid,
  pdata = pdata,
  respond_dep_missing = FALSE,
  pidname = "geneid",
  sidname = "sid",
  iterno = 1000,
  chains = 2
)
```

### 4. Providing Priors
You can provide informative priors for the precision matrix (`prec_prior`) and the logistic regression coefficients for missingness (`alpha_prior`).

```r
# Example precision matrix prior
prec_mat <- matrix(c(0.01, 0.001, 0.001, 0.01), nrow=2)

# Example alpha prior (intercept and predictor)
alpha_p <- c(0, 0.001)

model_prior <- mlmc(..., prec_prior = prec_mat, alpha_prior = alpha_p)
```

## Diagnostics and Results

The functions return Stan objects. You can evaluate convergence using Rhat (should be near 1.0) and the number of effective samples (`n_eff`).

- **Summary**: Use `print(model_fit)` to see posterior means and credible intervals.
- **Traceplots**: If `savefile = TRUE` was used, the package generates `samples_1.csv`, `samples_2.csv`, etc., which can be read to plot trajectories.
- **Quantiles**: The `outsummary.csv` file contains the summary statistics for all chains.

## Reference documentation

- [Introduction of mlm4omics](./references/vigettes_mlm4omics.md)