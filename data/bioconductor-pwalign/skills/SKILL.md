---
name: bioconductor-pwalign
description: "The bioconductor-pwalign package performs global, local, and overlap pairwise sequence alignments and computes string distances. Use when user asks to perform pairwise sequence alignment, calculate Levenshtein edit distances, or generate alignment score matrices."
homepage: https://bioconductor.org/packages/release/bioc/html/pwalign.html
---


# bioconductor-pwalign

## Overview

Use the Bioconductor R package **pwalign** for: the package are pairwiseAlignment() and stringDist(). The former solves (Needleman-Wunsch) global alignment, (Smith-Waterman) local alignment, and (ends-free) overlap alignment problems. The latter computes the Levenshtein edit distance or pairwise alignment score matrix for a set of strings.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pwalign")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.