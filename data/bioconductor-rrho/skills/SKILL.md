---
name: bioconductor-rrho
description: This tool performs Rank-Rank Hypergeometric Overlap tests to evaluate the agreement between two sorted lists. Use when user asks to compare ranked gene lists, perform RRHO analysis, or assess overlap between differential expression results.
homepage: https://bioconductor.org/packages/release/bioc/html/RRHO.html
---


# bioconductor-rrho

## Overview

Use the Bioconductor R package **RRHO** for: The package is aimed at inference on the amount of agreement in two sorted lists using the Rank-Rank Hypergeometric Overlap test.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RRHO")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.