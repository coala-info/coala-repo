---
name: bioconductor-ctsv
description: CTSV identifies cell-type-specific spatially variable genes in spatial transcriptomics data. Use when user asks to identify cell-type-specific spatially variable genes or calculate p-values for gene expression across different cell types in spatial datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/CTSV.html
---


# bioconductor-ctsv

## Overview

Use the Bioconductor R package **CTSV** for: The package outputs p-values and q-values for genes in each cell type, and CTSV is scalable to datasets with tens of thousands of genes measured on hundreds of spots. CTSV can be installed in Windows, Linux, and Mac OS.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("CTSV")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.