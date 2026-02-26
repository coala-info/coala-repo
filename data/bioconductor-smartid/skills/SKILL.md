---
name: bioconductor-smartid
description: This tool generates signature gene lists using modified TF-IDF methods and provides gene-set scoring and data transformation. Use when user asks to generate signature gene lists, perform gene-set scoring, transform data, or visualize gene expression results.
homepage: https://bioconductor.org/packages/release/bioc/html/smartid.html
---


# bioconductor-smartid

## Overview

Use the Bioconductor R package **smartid** for: The package is developed for generating specifc lists of signature genes based on Term Frequency-Inverse Document Frequency (TF-IDF) modified methods. It can also be used as a new gene-set scoring method or data transformation method. Multiple visualization functions are implemented in this package.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("smartid")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.