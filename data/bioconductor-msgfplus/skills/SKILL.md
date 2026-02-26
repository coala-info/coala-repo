---
name: bioconductor-msgfplus
description: This package provides an R interface for running the MS-GF+ peptide identification algorithm and managing its search parameters. Use when user asks to identify peptides from mass spectrometry data, configure MS-GF+ parameters, or execute the MS-GF+ algorithm in batches.
homepage: https://bioconductor.org/packages/3.8/bioc/html/MSGFplus.html
---


# bioconductor-msgfplus

## Overview

Use the Bioconductor R package **MSGFplus** for: The package contains functionality for building up a parameter set both in code and through a simple GUI, as well as running the algorithm in batches, potentially asynchronously.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MSGFplus")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.