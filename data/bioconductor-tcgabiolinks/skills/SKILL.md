---
name: bioconductor-tcgabiolinks
description: TCGAbiolinks provides methods for the analysis and visualization of cancer genomics data to develop complete analysis pipelines. Use when user asks to perform differential expression analysis, identify differentially methylated regions, or create survival and volcano plots.
homepage: https://bioconductor.org/packages/release/bioc/html/TCGAbiolinks.html
---


# bioconductor-tcgabiolinks

## Overview

Use the Bioconductor R package **TCGAbiolinks** for: the package provides multiple methods for analysis (e.g., differential expression analysis, identifying differentially methylated regions) and methods for visualization (e.g., survival plots, volcano plots, starburst plots) in order to easily develop complete analysis pipelines.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("TCGAbiolinks")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.