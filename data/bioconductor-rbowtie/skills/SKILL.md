---
name: bioconductor-rbowtie
description: Rbowtie provides an R interface for the Bowtie short read aligner to map genetic sequences to a reference genome. Use when user asks to align short sequencing reads, map sequences to a reference genome, or run Bowtie within the R environment.
homepage: https://bioconductor.org/packages/release/bioc/html/Rbowtie.html
---


# bioconductor-rbowtie

## Overview

Use the Bioconductor R package **Rbowtie** for: The package is used by the QuasR bioconductor package. We recommend to use the QuasR package instead of using Rbowtie directly.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Rbowtie")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.