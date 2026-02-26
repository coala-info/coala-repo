---
name: bioconductor-mlm4omics
description: This Bioconductor package fits regression models to handle not-missing-at-random and left-censored responses using Stan. Use when user asks to handle not-missing-at-random missing responses, analyze left-censored data, or perform Bayesian regression for omics data.
homepage: https://bioconductor.org/packages/3.9/bioc/html/mlm4omics.html
---


# bioconductor-mlm4omics

## Overview

Use the Bioconductor R package **mlm4omics** for: The package has two main functions to handle not-missing-at-random missing responses and left-censored with not-missing-at random responses. The purpose is to provide a similar format as the other R regression functions but using 'Stan' models.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mlm4omics")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.