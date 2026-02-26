---
name: bioconductor-ringo
description: Ringo is a Bioconductor package for the primary analysis, quality assessment, and visualization of ChIP-chip data. Use when user asks to read in ChIP-chip data, perform quality assessment, visualize genomic enrichment, or identify enriched genomic regions.
homepage: https://bioconductor.org/packages/3.18/bioc/html/Ringo.html
---


# bioconductor-ringo

## Overview

Use the Bioconductor R package **Ringo** for: The package Ringo facilitates the primary analysis of ChIP-chip data. The main functionalities of the package are data read-in, quality assessment, data visualisation and identification of genomic regions showing enrichment in ChIP-chip. The package has functions to deal with two-color oligonucleotide microarrays from NimbleGen used in ChIP-chip projects, but also contains more general functions for ChIP-chip data analysis, given that the data is supplied as RGList (raw) or ExpressionSet (pre- processed). The package employs functions from various other packages of the Bioconductor project and provides additional ChIP-chip-specific and NimbleGen-specific functionalities.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Ringo")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.