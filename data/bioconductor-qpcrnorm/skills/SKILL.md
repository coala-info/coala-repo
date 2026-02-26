---
name: bioconductor-qpcrnorm
description: "This package provides functions for the normalization and processing of high-throughput qPCR data. Use when user asks to normalize qPCR data, process raw Ct values, or generate diagnostic plots for qPCR experiments."
homepage: https://bioconductor.org/packages/release/bioc/html/qpcrNorm.html
---


# bioconductor-qpcrnorm

## Overview

Use the Bioconductor R package **qpcrNorm** for: The package contains functions to perform normalization of high-throughput qPCR data. Basic functions for processing raw Ct data plus functions to generate diagnostic plots are also available.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("qpcrNorm")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.