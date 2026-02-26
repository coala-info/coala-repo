---
name: bioconductor-corral
description: This package performs correspondence analysis for dimensionality reduction and integration of single-cell and high-dimensional data. Use when user asks to perform correspondence analysis, reduce dimensionality of count data, or apply CA-style processing to continuous proteomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/corral.html
---


# bioconductor-corral

## Overview

Use the Bioconductor R package **corral** for: The package also includes additional options, including variations of CA to address overdispersion in count data (e.g., Freeman-Tukey chi-squared residual), as well as the option to apply CA-style processing to continuous data (e.g., proteomic TOF intensities) with the Hellinger distance adaptation of CA.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("corral")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.