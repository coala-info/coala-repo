---
name: bioconductor-parathyroidse
description: This package provides a SummarizedExperiment object containing RNA-Seq data from a parathyroid cancer study. Use when user asks to load the parathyroidSE dataset, access RNA-Seq data from NCBI GSE37211, or analyze parathyroid gene and exon features.
homepage: https://bioconductor.org/packages/release/data/experiment/html/parathyroidSE.html
---


# bioconductor-parathyroidse

## Overview

Use the Bioconductor R package **parathyroidSE** for: The package vignette describes the creation of the object from raw sequencing data provided by NCBI Gene Expression Omnibus under accession number GSE37211.  The gene and exon features are the GRCh37 Ensembl annotations.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("parathyroidSE")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.