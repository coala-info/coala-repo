---
name: r-bbmle
description: Methods and functions for fitting maximum likelihood models in R. This package modifies and extends the 'mle' classes in the 'stats4' package.</p>
homepage: https://cloud.r-project.org/web/packages/bbmle/index.html
---

# r-bbmle

## Overview
The `bbmle` package provides a flexible and robust framework for general maximum likelihood estimation in R. It extends the standard `stats4::mle` functionality through the `mle2` function, offering a formula interface, support for various optimizers, and comprehensive tools for model selection and profiling.

## Installation
To install the package from CRAN:
```R
install.packages("bbmle")
```

## Core Workflow: Fitting Models with mle2
The primary function is `mle2()`. You can specify models using either a negative log-likelihood (NLL) function or a formula.

### 1. Function Interface
Use this for complex logic or when parameters are passed as a list.
```R
library(bbmle)
# Define NLL function
nll_func <- function(prob, size, theta) {
  -sum(emdbook::dbetabinom(x, prob, size, theta, log = TRUE))
}

# Fit model
fit <- mle2(nll_func, start = list(prob = 0.2, theta = 9), data = list(size = 50))
```

### 2. Formula Interface
The formula interface is often more concise and automatically handles categorical predictors.
```R
# Simple formula
fit_form <- mle2(x ~ dbetabinom(prob, size = 50, theta), 
                 start = list(prob = 0.2, theta = 9), 
                 data = data.frame(x))

# Formula with linear predictors (parameters argument)
fit_linear <- mle2(m ~ dbetabinom(prob, size = n, theta),
                   parameters = list(prob ~ dilution),
                   start = list(prob = 0.5, theta = 1),
                   data = orob1)
```

## Model Analysis and Comparison
`bbmle` provides methods for standard R model generics and specialized table summaries.

### Summary and Confidence Intervals
*   `summary(fit)`: Coefficients, standard errors (Wald), and NLL.
*   `confint(fit, method = "spline")`: Profile likelihood CIs (default).
*   `confint(fit, method = "quad")`: Quadratic (Wald) approximation.
*   `confint(fit, method = "uniroot")`: Exact root-finding for CIs.

### Likelihood Profiles
Profiling is essential for checking if the quadratic approximation holds.
```R
prof <- profile(fit)
plot(prof) # V-shape indicates good quadratic approximation
```

### Information Criteria Tables
Compare multiple models easily using `AICtab`, `BICtab`, or `AICctab`.
```R
AICtab(model1, model2, model3, weights = TRUE, delta = TRUE)
```

## Advanced Features
*   **Optimizers**: Change the engine using the `method` argument (e.g., "Nelder-Mead", "BFGS", "L-BFGS-B", "nlminb").
*   **Parameter Transformation**: Fit models on transformed scales (e.g., log for variance, logit for probability) to maintain boundaries without using constrained optimization.
*   **Quasi-AIC (QAIC)**: Use the `dispersion` argument in `ICtab` to account for overdispersion.
*   **Hessian Control**: Use `skip.hessian = TRUE` if the Hessian is problematic and you only need point estimates.

## Tips for Convergence
1.  **Scaling**: Use `control = list(parscale = ...)` if parameters differ by orders of magnitude.
2.  **Starting Values**: Good starting values are critical. Use `as.list(coef(simpler_model))` to initialize complex models.
3.  **Warnings**: `mle2` is more verbose than `mle`. "NaNs produced" often indicates the optimizer explored invalid parameter space; consider constraints or transformations.

## Reference documentation
- [Maximum likelihood estimation and analysis with the bbmle package](./references/mle2.md)
- [Dealing with quasi- models in R](./references/quasi.md)