---
name: bioconductor-rcaspar
description: RCASPAR predicts survival times using high-dimensional covariates through a piecewise baseline hazard Cox regression model. Use when user asks to predict survival times, perform survival analysis on high-dimensional data, or identify relevant covariates using an Lq-norm based prior.
homepage: https://bioconductor.org/packages/release/bioc/html/RCASPAR.html
---


# bioconductor-rcaspar

## Overview

Use the Bioconductor R package **RCASPAR** for: The package is the R-version of the C-based software \bold{CASPAR} (Kaderali,2006: \url{http://bioinformatics.oxfordjournals.org/content/22/12/1495}). It is meant to help predict survival times in the presence of high-dimensional explanatory covariates. The model is a piecewise baseline hazard Cox regression model with an Lq-norm based prior that selects for the most important regression coefficients, and in turn the most relevant covariates for survival analysis. It was primarily tried on gene expression and aCGH data, but can be used on any other type of high-dimensional data and in disciplines other than biology and medicine.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RCASPAR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.