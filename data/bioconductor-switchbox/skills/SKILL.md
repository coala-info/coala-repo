---
name: bioconductor-switchbox
description: This tool provides classifiers based on comparisons of feature pairs using Top-Scoring Pair algorithms. Use when user asks to build classifiers using feature pairs, apply Top-Scoring Pair algorithms, or perform classification based on relative feature rankings.
homepage: https://bioconductor.org/packages/release/bioc/html/switchBox.html
---


# bioconductor-switchbox

## Overview

Use the Bioconductor R package **switchBox** for: The package offer different classifiers based on comparisons of pair of features (TSP), using various decision rules (e.g., majority wins principle).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("switchBox")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.