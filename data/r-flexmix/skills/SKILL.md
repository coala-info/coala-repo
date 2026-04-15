---
name: r-flexmix
description: The r-flexmix package provides a comprehensive framework for fitting finite mixture models and latent class regressions using the Expectation-Maximization algorithm in R. Use when user asks to perform model-based clustering, fit finite mixtures of regression models, conduct latent class analysis with concomitant variables, or estimate parameters for unobserved heterogeneity.
homepage: https://cloud.r-project.org/web/packages/flexmix/index.html
---

# r-flexmix

name: r-flexmix
description: Comprehensive framework for finite mixture modeling and latent class regression in R. Use when performing: (1) Model-based clustering, (2) Finite mixtures of regression models (GLMs), (3) Latent class analysis with concomitant variables, (4) EM algorithm-based parameter estimation for unobserved heterogeneity, or (5) Resampling-based diagnostics for mixture models.

# r-flexmix

## Overview
The `flexmix` package implements a general framework for finite mixtures of regression models using the Expectation-Maximization (EM) algorithm. It supports various component-specific models (drivers), including standard linear models, generalized linear models (GLMs), and model-based clustering. It allows for concomitant variables that influence component weights and supports grouped data for repeated measurements.

## Installation
Install the package from CRAN:
```R
install.packages("flexmix")
library(flexmix)
```

## Core Workflow

### 1. Basic Model Fitting
Use `flexmix()` to fit a model with a fixed number of components ($k$).
```R
# Fit a 2-component Gaussian mixture regression
m1 <- flexmix(y ~ x1 + x2, data = mydata, k = 2)

# Inspect results
summary(m1)
parameters(m1)
clusters(m1) # Get cluster assignments
```

### 2. Using Model Drivers
Drivers define the M-step. `FLXMRglm` is the standard driver for GLMs.
```R
# Poisson mixture regression
m2 <- flexmix(y ~ x, data = mydata, k = 2, 
              model = FLXMRglm(family = "poisson"))
```

### 3. Model Selection (Finding k)
Use `stepFlexmix()` to fit models over a range of $k$ and select based on BIC/AIC.
```R
# Fit k=1 to k=5, repeating each 5 times with random starts
s1 <- stepFlexmix(y ~ x, data = mydata, k = 1:5, nrep = 5)
best_model <- getModel(s1, "BIC")
```

### 4. Concomitant Variables
Model component weights using external variables (e.g., demographics).
```R
# Weights depend on variable 'z'
m3 <- flexmix(y ~ x, data = mydata, k = 2,
              concomitant = FLXPmultinom(~ z))
```

### 5. Fixed and Varying Parameters
Use `FLXMRglmfix` to specify parameters that are constant across all components versus those that vary.
```R
# 'x1' has a constant effect, 'x2' varies by component
m4 <- flexmix(y ~ 1, data = mydata, k = 2,
              model = FLXMRglmfix(fixed = ~ x1, nested = list(k = c(1, 1), formula = c(~ x2, ~ x2))))
```

## Diagnostics and Inference

### Rootograms
Visualize cluster separation using posterior probabilities.
```R
plot(m1)
```

### Refitting for Significance
The EM algorithm doesn't provide standard errors directly. Use `refit()` to obtain them via the Hessian.
```R
rm1 <- refit(m1)
summary(rm1)
plot(rm1) # Plot confidence intervals for coefficients
```

### Bootstrapping
Assess model stability and identifiability using resampling.
```R
# Parametric bootstrap
set.seed(123)
m1_boot <- boot(m1, R = 200, sim = "parametric")
plot(m1_boot)
```

## Tips for Success
- **Random Starts**: The EM algorithm is sensitive to initial values. Always use `nrep > 1` in `stepFlexmix()` to avoid local optima.
- **Grouped Data**: For repeated measurements, use the `| ID` syntax in the formula: `flexmix(y ~ x | ID, ...)`.
- **Convergence**: If models fail to converge, increase `iter.max` or adjust `tol` in the `control` argument: `control = list(iter.max = 1000, tol = 1e-8)`.
- **Small Components**: Use `minprior` in `control` to automatically remove components that fall below a certain size threshold (default is 0.05).

## Reference documentation
- [Finite Mixture Model Diagnostics Using Resampling Methods](./references/bootstrapping.md)
- [FlexMix: A General Framework for Finite Mixture Models and Latent Class Regression in R](./references/flexmix-intro.md)
- [FlexMix Version 2: Finite Mixtures with Concomitant Variables and Varying and Constant Parameters](./references/mixture-regressions.md)
- [Regression Examples for FlexMix](./references/regression-examples.md)