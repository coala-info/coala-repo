---
name: bioconductor-pasilla
description: This package provides RNA-Seq data from Drosophila melanogaster for Bioconductor vignettes and tutorials. Use when user asks to access the pasilla dataset, perform RNA-Seq analysis examples, or follow Bioconductor differential expression tutorials.
homepage: https://bioconductor.org/packages/release/data/experiment/html/pasilla.html
---


# bioconductor-pasilla

## Overview

Use the Bioconductor R package **pasilla** for: The package vignette describes how the data provided here were derived from the RNA-Seq read sequence data that are provided by NCBI Gene Expression Omnibus under accession numbers GSM461176 to GSM461181.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pasilla")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.