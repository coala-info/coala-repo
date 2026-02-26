---
name: bioconductor-rhtslib
description: This package provides the HTSlib C library for high-throughput sequencing data processing within the R environment. Use when user asks to develop R packages that require HTSlib, access C-level functions for high-throughput sequencing data, or include HTSlib headers in an R project.
homepage: https://bioconductor.org/packages/release/bioc/html/Rhtslib.html
---


# bioconductor-rhtslib

## Overview

Use the Bioconductor R package **Rhtslib** for: The package is primarily useful to developers of other R packages who wish to make use of HTSlib. Motivation and instructions for use of this package are in the vignette, vignette(package="Rhtslib", "Rhtslib").

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Rhtslib")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.