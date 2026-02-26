---
name: bioconductor-probamr
description: This package generates SAM files from shotgun proteomics data and prepares genome annotations from GTF files. Use when user asks to build SAM files from proteomics data or prepare annotations from GTF files.
homepage: https://bioconductor.org/packages/release/bioc/html/proBAMr.html
---


# bioconductor-probamr

## Overview

Use the Bioconductor R package **proBAMr** for: The package builds SAM file from shotgun proteomics data The package also provides function to prepare annotation from GTF file.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("proBAMr")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.