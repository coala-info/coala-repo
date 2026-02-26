---
name: bioconductor-bloodcancermultiomics2017
description: This package provides data from the Primary Blood Cancer Encyclopedia project and code to reproduce the statistical analysis from the associated study on blood cancer stratification. Use when user asks to access PACE project multi-omics data, reproduce figures from the Dietrich et al. 2018 paper, or analyze drug-perturbation-based stratification of blood cancer.
homepage: https://bioconductor.org/packages/release/data/experiment/html/BloodCancerMultiOmics2017.html
---


# bioconductor-bloodcancermultiomics2017

## Overview

Use the Bioconductor R package **BloodCancerMultiOmics2017** for: The package contains data of the Primary Blood Cancer Encyclopedia (PACE) project together with a complete executable transcript of the statistical analysis and reproduces figures presented in the paper "Drug-perturbation-based stratification of blood cancer" by Dietrich S, Oleś M, Lu J et al., J. Clin. Invest. (2018) 128(1):427-445. doi:10.1172/JCI93801.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BloodCancerMultiOmics2017")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.