---
name: bioconductor-fmrs
description: The package obtains parameter estimation, i.e., maximum likelihood estimators (MLE), via the Expectation-Maximization (EM) algorithm for the Finite Mixture of Regression (FMR) models with Normal distribution, and MLE for the Finite Mixture of Accelerated Failure Time Regression (FMAFTR) subject to right censoring with Log-Normal and Weibull distributions via the EM algorithm and the Newton-Raphson algorithm (for Weibull distribution). More importantly, the package obtains the maximum penalized likelihood (MPLE) for both FMR and FMAFTR models (collectively called FMRs). A component-wise tuning parameter selection based on a component-wise BIC is implemented in the package. Furthermore, this package provides Ridge Regression and Elastic Net.
homepage: https://bioconductor.org/packages/release/bioc/html/fmrs.html
---

# bioconductor-fmrs

name: bioconductor-fmrs
description: Parameter estimation and variable selection for Finite Mixture of Regression (FMR) and Finite Mixture of Accelerated Failure Time Regression (FMAFTR) models. Use this skill to perform MLE, MPLE, Ridge Regression, and Elastic Net for mixture models with Normal, Log-Normal, or Weibull distributions, including handling right-censored data.

# bioconductor-fmrs

## Overview
The `fmrs` package provides a robust framework for fitting Finite Mixture of Regression (FMR) models and Finite Mixture of Accelerated Failure Time (FMAFTR) models. It is particularly useful for heterogeneous data where the relationship between covariates and a response variable differs across unobserved subpopulations. The package supports maximum likelihood estimation (MLE) via EM and Newton-Raphson algorithms, as well as variable selection through penalized likelihood (MPLE) using various penalties (Lasso, SCAD, MCP, etc.).

## Core Workflow

### 1. Data Preparation and Generation
Data can be generated for simulation purposes using `fmrs.gendata`. For real data, ensure you have a response vector `y`, a covariate matrix `x`, and a censoring indicator vector `delta` (1 for observed, 0 for censored).

```r
library(fmrs)

# Generate synthetic data (e.g., Log-Normal AFT mixture)
dat <- fmrs.gendata(nObs = 500, nComp = 2, nCov = 10,
                    coeff = c(intercepts, coefficients),
                    dispersion = c(1, 1), mixProp = c(0.4, 0.6),
                    disFamily = "lnorm")
```

### 2. Maximum Likelihood Estimation (MLE)
Use `fmrs.mle` to obtain parameter estimates without variable selection. This is often used to provide initial values for more complex variable selection procedures.

```r
res.mle <- fmrs.mle(y = dat$y, x = dat$x, delta = dat$delta,
                    nComp = 2, disFamily = "lnorm",
                    initCoeff = rnorm(nComp * nCov + nComp),
                    initDispersion = rep(1, nComp),
                    initmixProp = rep(1/nComp, nComp))
summary(res.mle)
```

### 3. Tuning Parameter Selection
Before performing variable selection, identify optimal tuning parameters ($\lambda$) using `fmrs.tunsel`. It supports component-wise selection based on BIC.

```r
res.lam <- fmrs.tunsel(y = dat$y, x = dat$x, delta = dat$delta,
                       nComp = 2, disFamily = "lnorm",
                       initCoeff = c(coefficients(res.mle)),
                       initDispersion = dispersion(res.mle),
                       initmixProp = mixProp(res.mle),
                       penFamily = "adplasso")
```

### 4. Variable Selection (MPLE)
Use `fmrs.varsel` to obtain sparse solutions. This function performs parameter estimation and variable selection simultaneously.

```r
res.var <- fmrs.varsel(y = dat$y, x = dat$x, delta = dat$delta,
                       nComp = ncomp(res.mle), disFamily = "lnorm",
                       initCoeff = c(coefficients(res.mle)),
                       initDispersion = dispersion(res.mle),
                       initmixProp = mixProp(res.mle),
                       penFamily = "adplasso",
                       lambPen = slot(res.lam, "lambPen"))

# View selected variables (non-zero coefficients)
slot(res.var, "selectedset")
```

## Key Parameters and Options

### Distribution Families (`disFamily`)
- `"norm"`: Normal distribution (standard FMR).
- `"lnorm"`: Log-Normal distribution (AFT mixture).
- `"weibull"`: Weibull distribution (AFT mixture).

### Penalty Families (`penFamily`)
Supported penalties for `fmrs.varsel`:
- `"adplasso"` (Adaptive Lasso)
- `"lasso"`
- `"mcp"`
- `"scad"`
- `"sica"`
- `"hard"`

### Ridge Regression
To perform Ridge Regression, set the `lambRidge` argument in `fmrs.mle` to a non-zero value.

## Tips for Success
- **Initialization**: Mixture models are sensitive to initial values. It is highly recommended to run `fmrs.mle` first and pass its results as `init` values to `fmrs.tunsel` and `fmrs.varsel`.
- **Censoring**: For standard regression (non-censored), use `disFamily = "norm"`. For survival/time-to-event data, use `lnorm` or `weibull` and provide the `delta` vector.
- **Component Switching**: Be aware that the order of components in the output may switch relative to your initial values; always check the `summary` or `coefficients` to interpret which component is which.

## Reference documentation
- [Using fmrs package](./references/usingfmrs.Rmd)
- [Using fmrs package](./references/usingfmrs.md)