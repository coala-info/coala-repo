---
name: bioconductor-standr
description: standR provides tools for the quality control, normalization, and visualization of spatial transcriptomics data. Use when user asks to perform quality control, normalize data, correct batch effects, or visualize spatial transcriptomics experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/standR.html
---


# bioconductor-standr

## Overview

Use the Bioconductor R package **standR** for: the package are built based on the SpatialExperiment object, allowing integration into various spatial transcriptomics-related packages from Bioconductor. standR allows data inspection, quality control, normalization, batch correction and evaluation with informative visualizations.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("standR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.