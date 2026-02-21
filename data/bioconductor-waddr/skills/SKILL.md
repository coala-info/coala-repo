---
name: bioconductor-waddr
description: The package offers statistical tests based on the 2-Wasserstein distance for detecting and characterizing differences between two distributions given in the form of samples. Functions for calculating the 2-Wasserstein distance and testing for differential distributions are provided, as well as a specifically tailored test for differential expression in single-cell RNA sequencing data.
homepage: https://bioconductor.org/packages/release/bioc/html/waddR.html
---

# bioconductor-waddr

## Overview

Use the Bioconductor R package **waddR** for: The package offers statistical tests based on the 2-Wasserstein distance for detecting and characterizing differences between two distributions given in the form of samples. Functions for calculating the 2-Wasserstein distance and testing for differential distributions are provided, as well as a specifically tailored test for differential expression in single-cell RNA sequencing data.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("waddR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.