---
name: r-gamlss.data
description: "Data used as examples in the books on Generalized Additive Models for Location Scale and Shape:   Stasinopoulos, Rigby, Heller, Voudouris, De Bastiani (2017)."
homepage: https://cloud.r-project.org/web/packages/gamlss.data/index.html
---

# r-gamlss.data

name: r-gamlss.data
description: Access and utilize datasets specifically curated for Generalized Additive Models for Location, Scale, and Shape (GAMLSS). Use this skill when Claude needs to perform distributional regression analysis, centile estimation, or practice GAMLSS modeling using standard benchmark datasets from the GAMLSS textbooks (Stasinopoulos et al., 2017).

## Overview

The `gamlss.data` package is a collection of datasets used as examples in the GAMLSS (Generalized Additive Models for Location, Scale, and Shape) framework. These datasets are designed to demonstrate distributional regression, where not just the mean, but also the variance, skewness, and kurtosis of a response variable can be modeled as functions of explanatory variables.

The package serves as the data foundation for the `gamlss` ecosystem, which includes `gamlss` (fitting engine) and `gamlss.dist` (distribution library).

## Installation

To install the package from CRAN:

```R
install.packages("gamlss.data")
```

## Usage and Workflows

### Loading Datasets

To use a dataset from the package, load the library and use the `data()` function.

```R
library(gamlss.data)

# List all available datasets in the package
data(package = "gamlss.data")

# Load a specific dataset (e.g., abdominal circumference data)
data(abdom)
head(abdom)
```

### Common Datasets and Use Cases

The package contains diverse data types suitable for different GAMLSS modeling tasks:

1.  **Continuous Data (Centile Estimation):**
    *   `abdom`: 610 measurements of fetal abdominal circumference. Used for growth curves.
    *   `dbdist`: Data on the distribution of Dutch boys' height.
2.  **Discrete/Count Data:**
    *   `aids`: Monthly number of AIDS cases in the UK.
    *   `polio`: Number of poliomyelitis cases in the USA.
3.  **Financial/Economic Data:**
    *   `rent`: Munich rent data, often used for modeling price as a function of area and year of construction.
4.  **Survival/Duration Data:**
    *   `parole`: Data on the time to recidivism for parolees.

### Typical Modeling Workflow

While `gamlss.data` only provides the data, it is almost always used in conjunction with the `gamlss` package:

```R
library(gamlss)
library(gamlss.data)

# Load data
data(abdom)

# Fit a GAMLSS model (e.g., Normal distribution, modeling mean and variance)
# y ~ x (mu), ~ x (sigma)
mod <- gamlss(y ~ pb(x), sigma.fo = ~ pb(x), family = NO, data = abdom)

# Summary of the model
summary(mod)

# Plot centile curves
centiles(mod, xvar = abdom$x)
```

## Tips for AI Agents

*   **Data Exploration:** Always check the structure of the data using `str()` or `summary()` as many datasets in this package are specifically chosen for their non-normal characteristics (skewness or heavy tails).
*   **Documentation:** If you need to know the specific units or variable definitions for a dataset, use `?dataset_name` (e.g., `?rent`).
*   **Ecosystem:** Remember that `gamlss.data` provides the *data*, `gamlss.dist` provides the *distributions*, and `gamlss` provides the *fitting functions*.

## Reference documentation

- [GAMLSS Home Page](./references/home_page.md)