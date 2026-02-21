---
name: bioconductor-netomics
description: The package can be combined with timeOmics to incorporate time-course expression data and build sub-networks from multi-omics kinetic clusters. Finally, from the generated multi-omics networks, propagation analyses allow the identification of missing biological functions (1), multi-omics mechanisms (2) and molecules between kinetic clusters (3). This helps to resolve complex regulatory mechanisms.
homepage: https://bioconductor.org/packages/3.14/bioc/html/netOmics.html
---

# bioconductor-netomics

## Overview

Use the Bioconductor R package **netOmics** for: The package can be combined with timeOmics to incorporate time-course expression data and build sub-networks from multi-omics kinetic clusters. Finally, from the generated multi-omics networks, propagation analyses allow the identification of missing biological functions (1), multi-omics mechanisms (2) and molecules between kinetic clusters (3). This helps to resolve complex regulatory mechanisms.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("netOmics")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.