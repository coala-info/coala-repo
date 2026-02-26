---
name: bioconductor-trnascanimport
description: This R package imports tRNAscan-SE output files into R as GRanges objects. Use when user asks to import tRNAscan-SE results, convert tRNA predictions into GRanges objects, or load tRNA annotations for Bioconductor analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/tRNAscanImport.html
---


# bioconductor-trnascanimport

## Overview

Use the Bioconductor R package **tRNAscanImport** for: The package imports the result of tRNAscan-SE as a GRanges object.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("tRNAscanImport")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.