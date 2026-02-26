---
name: bioconductor-pvac
description: This package filters genes based on the proportion of variation accounted for by the first principal component. Use when user asks to filter genes by PVAC score, identify consistent gene expression patterns, or perform gene filtering in Bioconductor.
homepage: https://bioconductor.org/packages/release/bioc/html/pvac.html
---


# bioconductor-pvac

## Overview

Use the Bioconductor R package **pvac** for: The package contains the function for filtering genes by the proportion of variation accounted for by the first principal component (PVAC).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pvac")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.