---
name: bioconductor-octad
description: This package provides a pipeline for drug discovery and repositioning through deep-learning based tissue selection and disease signature analysis. Use when user asks to select reference tissues, create disease gene expression signatures, perform pathway enrichment analysis, score drug reversal potency, select cancer cell lines, or conduct drug enrichment analysis and in silico hit validation.
homepage: https://bioconductor.org/packages/release/bioc/html/octad.html
---


# bioconductor-octad

## Overview

Use the Bioconductor R package **octad** for: The package offers deep-learning based reference tissue selection, disease gene expression signature creation, pathway enrichment analysis, drug reversal potency scoring, cancer cell line selection, drug enrichment analysis and in silico hit validation. It currently covers ~20,000 patient tissue samples covering 50 cancer types, and expression profiles for ~12,000 distinct compounds.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("octad")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.