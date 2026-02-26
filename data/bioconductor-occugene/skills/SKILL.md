---
name: bioconductor-occugene
description: This package provides functions for multinomial occupancy distribution analysis and essential gene estimation in random transposon mutagenesis libraries. Use when user asks to estimate the number of essential genes, analyze multinomial occupancy distributions, or evaluate data from transposon mutagenesis experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/occugene.html
---


# bioconductor-occugene

## Overview

Use the Bioconductor R package **occugene** for: The package has functions for handling the occupancy distribution for a multinomial and for estimating the number of essential genes in random transposon mutagenesis libraries.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("occugene")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.