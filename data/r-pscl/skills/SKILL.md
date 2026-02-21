---
name: r-pscl
description: "Bayesian analysis of item-response theory (IRT) models,   roll call analysis; computing highest density regions;    maximum likelihood estimation of zero-inflated and hurdle models for count data;   goodness-of-fit measures for GLMs;   data sets used in writing	and teaching; seats-votes curves.</p>"
homepage: https://cloud.r-project.org/web/packages/pscl/index.html
---

# r-pscl

name: r-pscl
description: Bayesian analysis of item-response theory (IRT) models, roll call analysis, and specialized regression models for count data (zero-inflated and hurdle models). Use this skill when performing political science research, analyzing legislative voting patterns, or fitting count data models where over-dispersion or excess zeros are present.

# r-pscl

## Overview
The `pscl` (Political Science Computational Laboratory) package provides tools for the statistical analysis of political science data. It is most widely used for its implementation of zero-inflated and hurdle regression models for count data, as well as tools for analyzing roll call votes and item-response theory (IRT) models.

## Installation
To install the package from CRAN:
```R
install.packages("pscl")
```

## Count Data Regression
The package provides two primary functions for handling count data with excess zeros: `zeroinfl()` and `hurdle()`.

### Zero-Inflated Models
Zero-inflated models (`zeroinfl`) are mixture models combining a point mass at zero with a count distribution (Poisson or Negative Binomial).
```R
library(pscl)
# Fit a zero-inflated Poisson model
m1 <- zeroinfl(art ~ . | fem + mar, data = bioChemists, dist = "poisson")

# Fit a zero-inflated Negative Binomial model
m2 <- zeroinfl(art ~ . | ., data = bioChemists, dist = "negbin")

summary(m2)
```

### Hurdle Models
Hurdle models (`hurdle`) use a two-component structure: a truncated count component for positive counts and a binary component for the "hurdle" (zero vs. non-zero).
```R
# Fit a hurdle Negative Binomial model
h1 <- hurdle(ofp ~ . | hosp + numchron, data = DebTrivedi, dist = "negbin")

# Predict probabilities or means
predict(h1, type = "prob")
```

### Model Comparison and Diagnostics
- `vuong()`: Performs the Vuong non-nested test to compare zero-inflated/hurdle models against standard GLMs.
- `odTest()`: Likelihood ratio test for over-dispersion in count data.
- `residuals(model, type = "pearson")`: Standardized residuals for checking fit.

## Roll Call Analysis and IRT
`pscl` provides the `rollcall` class and Bayesian IRT models for analyzing legislative behavior.

### Working with Roll Call Data
```R
# Create a rollcall object
rc <- rollcall(data_matrix, yea=1, nay=0, missing=NA, notInLegis=9)

# Summary of voting patterns
summary(rc)
```

### Ideal Point Estimation
The `ideal()` function uses Markov Chain Monte Carlo (MCMC) to estimate the "ideal points" (latent preferences) of legislators.
```R
# Estimate 1-dimensional ideal points
id1 <- ideal(rc, d = 1)

# Plot results
plot(id1)
```

## Workflow Tips
1. **Formula Syntax**: In `zeroinfl` and `hurdle`, the formula `y ~ x | z` specifies `x` as the regressors for the count part and `z` as the regressors for the zero/hurdle part. If `|` is omitted, the same regressors are used for both.
2. **Starting Values**: For complex models that fail to converge, use `zeroinfl.control(method = "BFGS", EM = TRUE)` to use the EM algorithm for initial parameter estimates.
3. **Distribution Choice**: Use `dist = "negbin"` if the data shows over-dispersion beyond what the Poisson distribution can handle.

## Reference documentation
- [Regression Models for Count Data in R](./references/countreg.md)