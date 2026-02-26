---
name: bioconductor-mbased
description: MBASED detects allele-specific gene expression from RNA count data by integrating individual loci counts into gene-specific measures. Use when user asks to detect allele-specific expression, integrate SNV-level counts into gene-level measures, or assess the statistical significance of ASE using simulations.
homepage: https://bioconductor.org/packages/release/bioc/html/MBASED.html
---


# bioconductor-mbased

## Overview

Use the Bioconductor R package **MBASED** for: The package implements MBASED algorithm for detecting allele-specific gene expression from RNA count data, where allele counts at individual loci (SNVs) are integrated into a gene-specific measure of ASE, and utilizes simulations to appropriately assess the statistical significance of observed ASE.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MBASED")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.