---
name: bioconductor-scider
description: the package are built based on the SpatialExperiment object, allowing integration into various spatial transcriptomics-related packages from Bioconductor. After modelling density, the package allows for serveral downstream analysis, including colocalization analysis, boundary detection analysis and differential density analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/scider.html
---

# bioconductor-scider

## Overview

Use the Bioconductor R package **scider** for: the package are built based on the SpatialExperiment object, allowing integration into various spatial transcriptomics-related packages from Bioconductor. After modelling density, the package allows for serveral downstream analysis, including colocalization analysis, boundary detection analysis and differential density analysis.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scider")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.