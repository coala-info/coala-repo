---
name: r-mixtools
description: This tool provides EM algorithms for analyzing parametric, semiparametric, and nonparametric finite mixture models in R. Use when user asks to fit normal or multinomial mixtures, perform mixtures of regressions, analyze nonparametric component densities, or determine the number of components using bootstrapping and information criteria.
homepage: https://cloud.r-project.org/web/packages/mixtools/index.html
---

# r-mixtools

name: r-mixtools
description: Expert guidance for analyzing finite mixture models using the R package 'mixtools'. Use this skill when you need to fit parametric (Normal, Multinomial, Gamma), semiparametric, or nonparametric mixture models, including mixtures-of-regressions, reliability mixture models, and tools for selecting the number of components (bootstrapping LRT, information criteria).

## Overview

The `mixtools` package provides a comprehensive suite of EM (Expectation-Maximization) algorithms for analyzing finite mixture models. It is particularly distinguished by its support for non-traditional mixture settings, such as nonparametric component densities, mixtures of regressions with predictor-dependent mixing proportions, and multinomial cutpoint methods for discretized multivariate data.

## Installation

```R
install.packages("mixtools")
library(mixtools)
```

## Core Workflows

### 1. Parametric Mixtures (Normal)
Use `normalmixEM` for univariate or multivariate normal mixtures.

```R
# Univariate 2-component mixture
data(faithful)
wait_fit <- normalmixEM(faithful$waiting, k = 2)
summary(wait_fit)
plot(wait_fit, which = 2) # Plot density
```

### 2. Mixtures of Regressions
Use `regmixEM` for standard linear regression mixtures and `regmixEM.loc` for predictor-dependent mixing proportions (IGLE algorithm).

```R
# Standard mixture of regressions
data(CO2data)
reg_fit <- regmixEM(y = CO2data$CO2, x = CO2data$GNP, k = 2, addintercept = TRUE)

# Predictor-dependent weights (Nonparametric lambda)
igle_fit <- regmixEM.loc(y = CO2data$CO2, x = CO2data$GNP, kernl.h = 20)
```

### 3. Nonparametric & Semiparametric Mixtures
Use `npEM` for multivariate mixtures with independent coordinates (or blocks) and `spEMsymloc` for univariate location mixtures of symmetric distributions.

```R
# Nonparametric EM for multivariate data
# x is a matrix; mu0 provides initial centers
np_fit <- npEM(x, mu0 = 2, blockid = c(1,1,2,2)) 
plot(np_fit)

# Semiparametric symmetric location mixture
sym_fit <- spEMsymloc(faithful$waiting, mu0 = c(55, 80))
```

### 4. Multinomial Cutpoint Methods
Useful for multivariate data where coordinates are conditionally i.i.d. but the distribution is unknown.

```R
# Discretize data and fit multinomial mixture
data(Waterdata)
cutpts <- 10.5 * (-6:6)
water_mult <- makemultdata(Waterdata, cuts = cutpts)
mult_fit <- multmixEM(water_mult, k = 4)
compCDF(Waterdata, mult_fit$posterior) # Plot estimated CDFs
```

## Model Selection

To determine the number of components ($k$):
- **Information Criteria**: Use `multmixmodel.sel`, `regmixmodel.sel`, or `repnormmixmodel.sel` to compare AIC, BIC, CAIC, and ICL.
- **Bootstrapping**: Use `boot.comp` to perform a parametric bootstrap of the likelihood ratio test statistic.

```R
# Sequential testing for k=1 vs k=2, etc.
boot_test <- boot.comp(faithful$waiting, pmany = c(1, 2, 3), mix.type = "normalmixEM")
```

## Tips and Best Practices

- **Starting Values**: EM algorithms are sensitive to initial values. Use the `lambda`, `mu`, and `sigma` arguments to provide sensible starts, or run the algorithm multiple times with random starts.
- **Label Switching**: When performing bootstrapping (`boot.se`), always check for label switching (where component 1 in one run becomes component 2 in another).
- **Bandwidth Selection**: For `npEM` and `spEMsymloc`, the choice of bandwidth (`bw`) is critical. The default uses Silverman's rule of thumb, but manual tuning is often required for complex densities.
- **Convergence**: If the algorithm fails to converge, increase `maxit` or loosen `epsilon`. If a component variance goes to zero (singularities), the package usually restarts automatically.

## Reference documentation

- [mixtools: An R Package for Analyzing Finite Mixture Models](./references/mixtools.md)