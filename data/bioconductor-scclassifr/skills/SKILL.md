---
name: bioconductor-scclassifr
description: scClassifR uses pretrained machine learning models to classify and annotate cell types in single-cell datasets. Use when user asks to predict immune cell types, annotate cell types in a dataset, or train custom models for new cell type classification.
homepage: https://bioconductor.org/packages/3.13/bioc/html/scClassifR.html
---


# bioconductor-scclassifr

## Overview

Use the Bioconductor R package **scClassifR** for: The package comprises a set of pretrained machine learning models to predict basic immune cell types. This enables all users to quickly get a first annotation of the cell types present in their dataset without requiring prior knowledge. scClassifR also allows users to train their own models to predict new cell types based on specific research needs.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scClassifR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.