---
name: bioconductor-padog
description: PADOG performs gene set analysis by down-weighting genes that appear in multiple pathways to improve the sensitivity and ranking of relevant pathways. Use when user asks to perform pathway analysis, down-weight overlapping genes, or benchmark gene set analysis methods using public datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/PADOG.html
---


# bioconductor-padog

## Overview

Use the Bioconductor R package **PADOG** for: The package provides also a benchmark for gene set analysis methods in terms of sensitivity and ranking using 24 public datasets from KEGGdzPathwaysGEO package.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("PADOG")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.