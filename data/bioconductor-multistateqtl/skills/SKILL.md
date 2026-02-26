---
name: bioconductor-multistateqtl
description: This package provides tools for analyzing multi-state quantitative trait loci (QTL) data and categorizing features as global, multi-state, or unique. Use when user asks to identify significant QTL associations, categorize features across multiple states, or manage missing data in QTLExperiment objects.
homepage: https://bioconductor.org/packages/release/bioc/html/multistateQTL.html
---


# bioconductor-multistateqtl

## Overview

Use the Bioconductor R package **multistateQTL** for: The package 'multistateQTL' contains functions which can remove or impute missing data, identify significant associations, as well as categorise features into global, multi-state or unique. The analysis results are stored in a 'QTLExperiment' object, which is based on the 'SummarisedExperiment' framework.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("multistateQTL")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.