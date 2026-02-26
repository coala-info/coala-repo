---
name: r-fmsb
description: This tool provides specialized functions for medical statistics, demographic analysis, and health data visualization in R. Use when user asks to create radar charts, calculate epidemiological indices like odds ratios and risk ratios, construct life tables, or analyze Japanese demographic data.
homepage: https://cloud.r-project.org/web/packages/fmsb/index.html
---


# r-fmsb

name: r-fmsb
description: Specialized functions for medical statistics, demographic analysis, and health data visualization. Use this skill when performing medical data analysis in R, specifically for creating radar charts (spider plots), calculating epidemiological indices (odds ratios, risk ratios, Mantel-Haenszel estimates), demographic life tables, and Japanese demographic data analysis.

## Overview

The `fmsb` package (Functions for Medical Statistics Book) provides a comprehensive suite of tools originally developed for "Practices of Medical and Health Data Analysis using R". It is widely recognized for its `radarchart()` function and its robust implementation of epidemiological and demographic methods.

## Installation

To install the package from CRAN:

```R
install.packages("fmsb")
library(fmsb)
```

## Core Functions and Workflows

### Radar Charts (Spider Plots)

The `radarchart()` function is the package's most popular feature for visualizing multivariate data.

```R
# Data must be a data frame where:
# Row 1: Maximum values for each variable
# Row 2: Minimum values for each variable
# Row 3+: Actual data to plot
data <- as.data.frame(matrix(runif(30, 0, 10), ncol=10))
max_min <- data.frame(matrix(c(rep(10, 10), rep(0, 10)), nrow=2, byrow=TRUE))
colnames(max_min) <- colnames(data)
df <- rbind(max_min, data)

# Basic radar chart
radarchart(df)

# Circular radar chart (added in version 0.7.5+)
radarchartcirc(df)
```

### Epidemiological Statistics

Calculate effect measures with confidence intervals for 2x2 tables or raw counts.

- **Odds Ratios**: `oddsratio(a, b, c, d)` or `oddsratio(matrix_obj)`
- **Risk Ratios**: `riskratio(a, b, c, d)`
- **Risk Difference**: `riskdifference(a, b, c, d)`
- **Mantel-Haenszel**: `ORMH()`, `RRMH()`, `RDMH()` for pooled estimates across strata.
- **ROC Analysis**: `ROC(test, state)` calculates sensitivity, specificity, and AUC.

### Demographic Analysis

The package includes functions for formal demography and life table construction.

- **Life Tables**: `lifetable(x, nax, nmx)` or `lifetable2()`.
- **Demographic Models**: `CM()` (Coale-McNeil marriage model), `fitGM()` (Gompertz-Makeham), and `fitSiler()`.
- **Indices**: `WhipplesIndex()`, `CaretakerRatio()`, and `IndexOfDissimilarity()`.

### Japanese Demographic Datasets

`fmsb` contains extensive historical and recent Japanese health data:
- `Jpop`, `Jpopl`: Population data (including 2020 census).
- `Jvital`: Vital statistics (births, deaths, MMR) updated through 2024.
- `Jlife`: Complete life tables.
- `PrefYLL2020`: Years of Life Lost by prefecture and cause.

## Tips and Best Practices

- **Radar Chart Scaling**: Always ensure the first two rows of your data frame represent the theoretical or observed max and min to ensure proper scaling.
- **Missing Data**: Functions like `spearman.ci.sas()`, `truemedian()`, and `geary.test()` are designed to handle `NA` values in recent versions.
- **Welch's T-test**: The package author recommends using Welch's method (`t.test(..., var.equal=FALSE)`) by default for two-sample mean comparisons rather than preliminary variance testing.
- **P-value Plots**: Use `pvalueplot()` to visualize the distribution of p-values or to add comparisons using the `add=TRUE` parameter.

## Reference documentation

- [fmsb: Functions for Medical Statistics Book with some Demographic Data](./references/home_page.md)