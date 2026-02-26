---
name: bioconductor-csar
description: CSAR provides statistical methods for calculating genomic single-nucleotide read-enrichment values and comparing sequencing samples using a Poisson distribution. Use when user asks to calculate read-enrichment values, compare sample and control sequencing data, or control the false discovery rate through random permutation.
homepage: https://bioconductor.org/packages/release/bioc/html/CSAR.html
---


# bioconductor-csar

## Overview

Use the Bioconductor R package **CSAR** for: The package includes the statistical method described in Kaufmann et al. (2009) PLoS Biology: 7(4):e1000090. Briefly, Taking the average DNA fragment size subjected to sequencing into account, the software calculates genomic single-nucleotide read-enrichment values. After normalization, sample and control are compared using a test based on the Poisson distribution. Test statistic thresholds to control the false discovery rate are obtained through random permutation.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("CSAR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.