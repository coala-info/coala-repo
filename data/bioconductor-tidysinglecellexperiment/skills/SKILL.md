---
name: bioconductor-tidysinglecellexperiment
description: This package provides a tidy data interface for manipulating and analyzing SingleCellExperiment objects. Use when user asks to apply tidyverse principles to single-cell data, aggregate cell-level data to pseudobulks, or perform data wrangling on single-cell experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/tidySingleCellExperiment.html
---


# bioconductor-tidysinglecellexperiment

## Overview

Use the Bioconductor R package **tidySingleCellExperiment** for: the package provides various utility functions specific to single-cell omics data analysis (e.g., aggregation of cell-level data to pseudobulks).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("tidySingleCellExperiment")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.