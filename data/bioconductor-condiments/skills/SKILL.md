---
name: bioconductor-condiments
description: The bioconductor-condiments package analyzes differential topology and progression in single-cell trajectories across multiple experimental conditions. Use when user asks to compare cell lineages between conditions, perform differential trajectory inference, or test for changes in cell fate and progression in scRNA-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/condiments.html
---


# bioconductor-condiments

## Overview

Use the Bioconductor R package **condiments** for: the package is mostly geared toward scRNASeq, it does not place any restriction on the actual input format.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("condiments")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.