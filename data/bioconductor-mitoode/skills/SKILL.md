---
name: bioconductor-mitoode
description: This package fits cell-cycle models to cell count data from live-cell imaging assays. Use when user asks to fit a cell-cycle model on cell count data, model phenotypes in RNAi live-cell imaging assays, or reproduce results from the Pau et al. (2013) study.
homepage: https://bioconductor.org/packages/3.8/bioc/html/mitoODE.html
---


# bioconductor-mitoode

## Overview

Use the Bioconductor R package **mitoODE** for: The package contains the methods to fit a cell-cycle model on cell count data and the code to reproduce the results shown in our paper "Dynamical modelling of phenotypes in a genome-wide RNAi live-cell imaging assay" by Pau, G., Walter, T., Neumann, B., Heriche, J.-K., Ellenberg, J., & Huber, W., BMC Bioinformatics (2013), 14(1), 308. doi:10.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mitoODE")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.