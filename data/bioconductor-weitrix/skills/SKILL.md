---
name: bioconductor-weitrix
description: the package "limma". Calibrate weights to account for known predictors of precision. Find rows with excess variability. Perform differential testing and find rows with the largest confident differences. Find PCA-like components of variation even with many missing values, rotated so that individual components may be meaningfully interpreted. DelayedArray matrices and BiocParallel are supported.
homepage: https://bioconductor.org/packages/release/bioc/html/weitrix.html
---

# bioconductor-weitrix

## Overview

Use the Bioconductor R package **weitrix** for: the package "limma". Calibrate weights to account for known predictors of precision. Find rows with excess variability. Perform differential testing and find rows with the largest confident differences. Find PCA-like components of variation even with many missing values, rotated so that individual components may be meaningfully interpreted. DelayedArray matrices and BiocParallel are supported.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("weitrix")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.