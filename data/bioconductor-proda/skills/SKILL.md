---
name: bioconductor-proda
description: This tool performs differential abundance analysis for proteomics data using a probabilistic dropout model to handle missing values. Use when user asks to identify differentially abundant proteins, account for missing values in mass spectrometry datasets, or perform statistical testing on protein abundance.
homepage: https://bioconductor.org/packages/release/bioc/html/proDA.html
---


# bioconductor-proda

## Overview

Use the Bioconductor R package **proDA** for: The package implements a probabilistic dropout model that ensures that the information from observed and missing values are properly combined. It adds empirical Bayesian priors to increase power to detect differentially abundant proteins.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("proDA")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.