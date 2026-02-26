---
name: bioconductor-rhdf5filters
description: This package provides HDF5 compression filters for seamless integration with rhdf5 and external applications. Use when user asks to install HDF5 compression filters, use Blosc or LZ4 filters in R, or manage data compression within HDF5 files.
homepage: https://bioconductor.org/packages/release/bioc/html/rhdf5filters.html
---


# bioconductor-rhdf5filters

## Overview

Use the Bioconductor R package **rhdf5filters** for: The package is intended to provide seemless integration with rhdf5, however the compiled filters can also be used with external applications.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rhdf5filters")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.