---
name: bioconductor-redseq
description: The package includes functions to build restriction enzyme cut site (RECS) map, distribute mapped sequences on the map with five different approaches, find enriched/depleted RECSs for a sample, and identify differentially enriched/depleted RECSs between samples.
homepage: https://bioconductor.org/packages/release/bioc/html/REDseq.html
---

# bioconductor-redseq

## Overview

Use the Bioconductor R package **REDseq** for: The package includes functions to build restriction enzyme cut site (RECS) map, distribute mapped sequences on the map with five different approaches, find enriched/depleted RECSs for a sample, and identify differentially enriched/depleted RECSs between samples.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("REDseq")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.