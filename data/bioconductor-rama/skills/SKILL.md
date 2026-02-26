---
name: bioconductor-rama
description: This package provides robust estimation for genomic data using a Bayesian hierarchical model that explicitly accounts for outliers. Use when user asks to perform robust estimation, model outliers with t-distributions, or address normalization and design effects in microarray data.
homepage: https://bioconductor.org/packages/3.5/bioc/html/rama.html
---


# bioconductor-rama

## Overview

Use the Bioconductor R package **rama** for: The package uses a Bayesian hierarchical model for the robust estimation. Outliers are modeled explicitly using a t-distribution, and the model also addresses classical issues such as design effects, normalization, transformation, and nonconstant variance.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rama")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.