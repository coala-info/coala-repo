---
name: bioconductor-tenxbusdata
description: TENxBUSData provides utility functions and example datasets for loading BUS format single-cell RNA-seq data into R as sparse matrices. Use when user asks to load BUS format data, convert BUS files to sparse matrices, or access example datasets for BUSpaRse.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TENxBUSData.html
---


# bioconductor-tenxbusdata

## Overview

Use the Bioconductor R package **TENxBUSData** for: the package BUSpaRse, which can load BUS format into R as a sparse matrix, and which has utility functions related to using the C++ command line package bustools.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("TENxBUSData")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.