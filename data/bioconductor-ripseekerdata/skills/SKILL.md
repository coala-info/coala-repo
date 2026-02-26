---
name: bioconductor-ripseekerdata
description: This package provides example RIP-seq datasets for the RIPSeeker R package. Use when user asks to access sample data for RIPSeeker, run RIPSeeker tutorials, or analyze PRC2 and CCNT1 RIP-seq experiments.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/RIPSeekerData.html
---


# bioconductor-ripseekerdata

## Overview

Use the Bioconductor R package **RIPSeekerData** for: the package RIPSeeker. The data correspond to two RIP-seq experiments, namely PRC2 and CCNT1. Raw data from NCBI Gene Expression Omnibus under accession numbers GSE17064 for PRC2 and in-house for CCNT1.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RIPSeekerData")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.