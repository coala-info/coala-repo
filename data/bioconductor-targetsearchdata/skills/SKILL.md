---
name: bioconductor-targetsearchdata
description: This package provides example GC-MS data, including NetCDF files and peak lists, for demonstrating the TargetSearch analysis pipeline. Use when user asks to access sample GC-MS datasets, run TargetSearch tutorials, or practice metabolite profiling with E. coli salt stress experiment data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TargetSearchData.html
---


# bioconductor-targetsearchdata

## Overview

Use the Bioconductor R package **TargetSearchData** for: The package contains raw NetCDF files from a E.coli salt stress experiment, extracted peak lists, and sample metadata required for a GC-MS analysis. The raw data has been restricted for demonstration purposes.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("TargetSearchData")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.