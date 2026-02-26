---
name: bioconductor-m6aboost
description: m6Aboost is a Bioconductor package that identifies m6A sites from miCLIP2 data using a boosting model. Use when user asks to assign read counts, extract features, or run the m6Aboost model on miCLIP2 data.
homepage: https://bioconductor.org/packages/release/bioc/html/m6Aboost.html
---


# bioconductor-m6aboost

## Overview

Use the Bioconductor R package **m6Aboost** for: The package includes functions to assign the read counts and get the features to run the m6Aboost model. The miCLIP2 data should be stored in a GRanges object. More details can be found in the vignette.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("m6Aboost")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.