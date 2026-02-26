---
name: bioconductor-cancer
description: The canceR package provides a user-friendly interface to explore, compare, and analyze multidimensional cancer genomics data from the MSKCC Computational Biology Center. Use when user asks to analyze gene expression, explore clinical data, compare cancer datasets, or visualize genomic alterations.
homepage: https://bioconductor.org/packages/release/bioc/html/canceR.html
---


# bioconductor-cancer

## Overview

Use the Bioconductor R package **canceR** for: The package is user friendly interface based on the cgdsr and other modeling packages to explore, compare, and analyse all available Cancer Data (Clinical data, Gene Mutation, Gene Methylation, Gene Expression, Protein Phosphorylation, Copy Number Alteration) hosted by the Computational Biology Center at Memorial-Sloan-Kettering Cancer Center (MSKCC).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("canceR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.