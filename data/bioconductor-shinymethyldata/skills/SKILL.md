---
name: bioconductor-shinymethyldata
description: This package provides example DNA methylation data from TCGA for use with the shinyMethyl package. Use when user asks to access example 450k methylation array datasets, test the shinyMethyl package, or explore TCGA tumor and normal sample data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/shinyMethylData.html
---


# bioconductor-shinymethyldata

## Overview

Use the Bioconductor R package **shinyMethylData** for: the package shinyMethyl. Original samples are from 450k methylation arrays, and were obtained from The Cancer Genome Atlas (TCGA). 310 samples are from tumor, 50 are matched normals and 9 are technical replicates of a control cell line.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("shinyMethylData")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.