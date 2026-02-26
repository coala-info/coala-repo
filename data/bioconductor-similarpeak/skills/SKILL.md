---
name: bioconductor-similarpeak
description: This R package provides pseudometrics for detecting pattern similarity between ChIP-Seq profiles. Use when user asks to detect pattern similarity in ChIP-Seq profiles, compare genomic peaks, or calculate metrics for profile similarity.
homepage: https://bioconductor.org/packages/release/bioc/html/similaRpeak.html
---


# bioconductor-similarpeak

## Overview

Use the Bioconductor R package **similaRpeak** for: the package implements six pseudometrics specialized in pattern similarity detection in ChIP-Seq profiles.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("similaRpeak")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.