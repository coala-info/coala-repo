---
name: bioconductor-tigre
description: This tool infers transcription factor protein concentrations and ranks candidate targets from gene expression measurements. Use when user asks to infer unobserved transcription factor protein concentrations or rank candidate targets of a transcription factor.
homepage: https://bioconductor.org/packages/release/bioc/html/tigre.html
---


# bioconductor-tigre

## Overview

Use the Bioconductor R package **tigre** for: The package can be used for inferring unobserved transcription factor (TF) protein concentrations from expression measurements of known target genes, or for ranking candidate targets of a TF.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("tigre")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.