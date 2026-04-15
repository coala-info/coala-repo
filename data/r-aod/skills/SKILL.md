---
name: r-aod
description: This tool analyzes overdispersed counts or proportions in R by fitting beta-binomial and negative-binomial models. Use when user asks to fit models for overdispersed data, calculate intraclass correlation coefficients, perform Donner's tests, or execute Wald tests for hypothesis testing on model parameters.
homepage: https://cloud.r-project.org/web/packages/aod/index.html
---

# r-aod

name: r-aod
description: Analysis of overdispersed counts or proportions in R. Use this skill to fit beta-binomial and negative-binomial models, calculate intraclass correlation coefficients (ICC), perform Donner's tests, and execute Wald tests for hypothesis testing on model parameters. It is specifically designed for data where the observed variance exceeds the theoretical variance of standard Binomial or Poisson distributions.

## Overview
The `aod` package provides specialized functions for analyzing overdispersed data. It serves as a complement to Generalized Estimating Equations (GEE) and Generalized Linear Mixed Models (GLMM). It is particularly effective for cluster-correlated data and experiments where the probability of success varies between groups or individuals beyond what a standard GLM can capture.

## Installation
To install the package from CRAN:
```R
install.packages("aod")
```

## Main Functions and Workflows

### Fitting Models for Overdispersed Data
- `betabin()`: Fits a beta-binomial regression model using maximum likelihood. Use this for overdispersed binary/proportion data.
- `negbin()`: Fits a negative-binomial regression model. Use this for overdispersed count data.
- `quasibin()` / `quasipois()`: Fits quasi-binomial or quasi-Poisson models to account for overdispersion via a scale parameter.

### Hypothesis Testing
- `wald.test()`: A powerful function to test linear hypotheses about model parameters. It requires a variance-covariance matrix (`varb`) and a vector of coefficients (`b`).
  - Example: `wald.test(b = coef(model), varb = vcov(model), Terms = 2:3)` tests if the 2nd and 3rd coefficients are zero.
  - Use the `L` argument for custom contrast matrices.

### Cluster Data Analysis
- `donner()`: Performs Donner's test to compare proportions between groups while accounting for clustering.
- `icc()`: Estimates the Intraclass Correlation Coefficient (ICC) for binary data in a clustered design.
- `split_p()`: Splits a proportion into its components (successes and trials) for use in models.

### Model Evaluation
- `AIC()` and `logLik()`: Standard methods are implemented for `aod` model objects to facilitate model selection.
- `summary()`: Provides detailed output including estimates of the overdispersion parameter (phi).

## Tips and Best Practices
- **Parameterization**: In `betabin`, the overdispersion parameter `phi` represents the correlation between individual responses within a cluster. If `phi = 0`, the model reduces to a standard binomial GLM.
- **Wald Test Flexibility**: `wald.test` is not restricted to `aod` objects; it can be used with any model that provides a coefficient vector and a variance-covariance matrix (e.g., `glm`, `lme4`, `survival`).
- **Convergence**: If `betabin` or `negbin` fails to converge, try providing better starting values via the `start` argument or check for extreme sparsity in the data.
- **Data Structure**: Ensure your data for `betabin` is structured with a formula like `cbind(success, failure) ~ predictors`.

## Reference documentation
- [aod: Analysis of Overdispersed Data](./references/home_page.md)