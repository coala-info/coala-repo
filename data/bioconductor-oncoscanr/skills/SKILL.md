---
name: bioconductor-oncoscanr
description: oncoscanR is a Bioconductor package for analyzing genomic data from the ThermoFisher OncoScan assay. Use when user asks to analyze OncoScan assay data, process Chromosome Alteration Suite outputs, or identify copy number alterations.
homepage: https://bioconductor.org/packages/release/bioc/html/oncoscanR.html
---


# bioconductor-oncoscanr

## Overview

Use the Bioconductor R package **oncoscanR** for: the package is tailored for the ThermoFisher Oncoscan assay analyzed with their Chromosome Alteration Suite (ChAS) but can be adapted to any input.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("oncoscanR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.