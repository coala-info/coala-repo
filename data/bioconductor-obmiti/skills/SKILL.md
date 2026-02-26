---
name: bioconductor-obmiti
description: This Bioconductor package provides RNA-seq count data for wild-type and Ob/Ob mouse strains across multiple diets and tissues. Use when user asks to access RNA-seq expression data for Ob/Ob mice, compare transcriptomic profiles across chow and high-fat diets, or retrieve count data for specific mouse tissues.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ObMiTi.html
---


# bioconductor-obmiti

## Overview

Use the Bioconductor R package **ObMiTi** for: The package provide RNA-seq count for 2 strains of mus musclus; Wild type and Ob/Ob. Each strain was divided into two groups, and each group received either chow diet or high fat diet. RNA expression was measured after 20 weeks in 7 tissues.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ObMiTi")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.