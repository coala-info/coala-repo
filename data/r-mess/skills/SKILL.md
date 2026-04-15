---
name: r-mess
description: The MESS package provides a collection of miscellaneous statistical functions for GEE model selection, power calculations, and efficient matrix manipulations. Use when user asks to compute QIC for GEE models, perform power calculations for unequal group sizes, calculate area under the curve, or create residual diagnostic plots.
homepage: https://cloud.r-project.org/web/packages/MESS/index.html
---

# r-mess

## Overview
The `MESS` package is a collection of diverse statistical functions ranging from computational utilities to advanced analysis tools. It is particularly strong in providing extensions for Generalized Estimating Equations (GEE), specialized power calculations, and efficient matrix manipulations.

## Installation
To install the stable version from CRAN:
```r
install.packages("MESS")
```

## Key Functions and Workflows

### Statistical Analysis & GEE Extensions
`MESS` provides essential tools for working with `geepack` and `geem` objects:
* **Model Selection**: Use `QIC(model)` to compute the Quasi Information Criterion for GEE.
* **Variable Selection**: Use `drop1(geeglm_object, test="Wald")` or `drop1(geem_object)` to perform marginal null hypothesis tests for model terms.
* **GEE with Fixed Correlation**: Use `geekin()` to fit GEE models with a fixed additive correlation structure (useful for genetic or pedigree data).

### Power Calculations
The package extends standard R power functions to handle more realistic scenarios:
* **Unequal Groups**: `power_t_test()` and `power_prop_test()` allow for different sample sizes in each group.
* **McNemar Test**: `power_mcnemar_test()` for paired 2x2 tables.
* **Exact Binomial**: `power_binom_test()` for exact tests of a simple null hypothesis.

### Utility & Data Cleaning
* **Age Calculation**: `age(birthdate, currentdate)` accurately calculates age in years.
* **Last Observation Carried Forward**: `filldown(vector)` replaces `NA` values with the most recent non-missing value.
* **AUC**: `auc(x, y)` computes the area under the curve using the trapezoidal rule, handling missing values and specific ranges.
* **Factor Conversion**: `fac2num(x)` safely converts factors to their numeric representations.

### Graphics & Diagnostics
* **Residual Evaluation**: `wallyplot(model)` creates a "Wally plot" (a lineup of plots) to help determine if a residual plot shows a genuine pattern or just random noise.
* **Distribution Comparison**: `rootonorm(x)` creates a hanging rootogram to compare an empirical distribution against a normal distribution.
* **Color Manipulation**: Use `col.alpha()`, `col.shade()`, and `col.tint()` for fine-tuning plot aesthetics.

### Computational Efficiency
For large-scale data or simulations, use these optimized functions:
* **Fast Matrix Ops**: `qdiag()` (fast diagonal extraction), `quadform()` (quadratic form computation), and `tracemp()` (trace of matrix product).
* **Screening**: `screen_variables()` for pre-screening variables before penalized regression.

## Reference documentation
- [The MESS package](./references/MESS.Rmd)
- [MESS: Miscellaneous Esoteric Statistical Scripts](./references/README.md)