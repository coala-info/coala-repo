---
name: bioconductor-motifcounter
description: the package relies on a compound Poisson distribution or alternatively a combinatorial model. These distribution account for self-overlapping motif structures as exemplified by repeat-like or palindromic motifs, and allow to determine the p-value and fold-enrichment for a set of observed motif matches.
homepage: https://bioconductor.org/packages/release/bioc/html/motifcounter.html
---

# bioconductor-motifcounter

## Overview

Use the Bioconductor R package **motifcounter** for: the package relies on a compound Poisson distribution or alternatively a combinatorial model. These distribution account for self-overlapping motif structures as exemplified by repeat-like or palindromic motifs, and allow to determine the p-value and fold-enrichment for a set of observed motif matches.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("motifcounter")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.