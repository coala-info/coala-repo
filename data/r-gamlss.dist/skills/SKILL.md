---
name: r-gamlss.dist
description: Skill for using the CRAN R package r-gamlss.dist.
homepage: https://cloud.r-project.org/web/packages/gamlss.dist/index.html
---

# r-gamlss.dist

name: r-gamlss.dist
description: Comprehensive suite of over 100 probability distributions for Generalized Additive Models for Location, Scale, and Shape (GAMLSS). Use this skill when Claude needs to: (1) Select or implement distributions for distributional regression, (2) Use d, p, q, r functions for specialized distributions (e.g., Box-Cox Cole-Green, Johnson's SU), (3) Define truncated, censored, or finite mixture distributions, or (4) Identify parameterizations for location (mu), scale (sigma), skewness (nu), and kurtosis (tau).

# r-gamlss.dist

## Overview
The `gamlss.dist` package provides the distributional infrastructure for the GAMLSS framework in R. Unlike classical regression which only models the mean, GAMLSS allows modeling all parameters of a distribution (location, scale, skewness, and kurtosis) as functions of explanatory variables. The package includes continuous, discrete, and mixed distributions, along with utilities to create truncated and censored versions.

## Installation
To install the package from CRAN:
```R
install.packages("gamlss.dist")
library(gamlss.dist)
```

## Main Functions and Workflows

### Distribution Functions
Each distribution family (e.g., `NO` for Normal, `BCCG` for Box-Cox Cole-Green) follows the standard R naming convention:
- `dFAMILY(x, mu, sigma, nu, tau)`: Density function.
- `pFAMILY(q, mu, sigma, nu, tau)`: Cumulative distribution function.
- `qFAMILY(p, mu, sigma, nu, tau)`: Quantile function.
- `rFAMILY(n, mu, sigma, nu, tau)`: Random generation.

### Family Objects
To use a distribution within a GAMLSS model, use the family constructor:
```R
# Example: Box-Cox Cole-Green distribution
BCCG(mu.link = "identity", sigma.link = "log", nu.link = "identity")
```

### Generating New Distributions
Use these utilities to extend existing distributions:
- `gen.family()`: Generates the d, p, q, r functions for a family.
- `trun()`: Creates a truncated version of an existing GAMLSS distribution.
- `cens()`: Creates a censored version of an existing GAMLSS distribution.
- `LogitT()`: Creates a logit-transformed version of a distribution (for data on (0,1)).

### Identifying Distributions
To see available distributions by type:
- `show.link(family)`: Shows the available link functions for a specific family.
- `gamlss.family`: A list of all available families in the package.

## Common Distributions by Data Type

### Continuous (Real Line)
- `NO`: Normal (mu, sigma)
- `TF`: t-distribution (mu, sigma, nu)
- `PE`: Power Exponential (mu, sigma, nu)
- `JSU`: Johnson's SU (mu, sigma, nu, tau)

### Continuous (Positive Real Line)
- `GA`: Gamma (mu, sigma)
- `IG`: Inverse Gaussian (mu, sigma)
- `BCCG`: Box-Cox Cole-Green (mu, sigma, nu)
- `BCPE`: Box-Cox Power Exponential (mu, sigma, nu, tau)
- `BCT`: Box-Cox t (mu, sigma, nu, tau)

### Discrete (Counts)
- `PO`: Poisson (mu)
- `NBI` / `NBII`: Negative Binomial type I and II (mu, sigma)
- `PIG`: Poisson-Inverse Gaussian (mu, sigma)
- `SI`: Sichel (mu, sigma, nu)
- `ZIPO` / `ZINBI`: Zero-inflated Poisson or Negative Binomial.

### Binomial/Proportions
- `BI`: Binomial (mu)
- `BB`: Beta Binomial (mu, sigma)

## Tips for Usage
- **Parameter Order**: Most distributions follow the order `mu` (location), `sigma` (scale), `nu` (skewness), and `tau` (kurtosis). Always check the specific family documentation as some only use a subset.
- **Link Functions**: Each parameter has a default link function (e.g., `log` for `sigma` to ensure positivity). You can override these in the family constructor.
- **Initial Values**: When fitting models using these distributions, providing sensible initial values for `mu`, `sigma`, `nu`, and `tau` can prevent convergence issues.

## Reference documentation
- [GAMLSS Distributions Overview](./references/home_page.md)