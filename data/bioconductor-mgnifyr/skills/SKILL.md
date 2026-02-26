---
name: bioconductor-mgnifyr
description: MGnifyR imports microbial data from the MGnify database into R for analysis within the TreeSummarizedExperiment format. Use when user asks to fetch microbiome datasets from MGnify, import microbial data into TreeSummarizedExperiment objects, or integrate MGnify data with the miaverse framework.
homepage: https://bioconductor.org/packages/release/bioc/html/MGnifyR.html
---


# bioconductor-mgnifyr

## Overview

Use the Bioconductor R package **MGnifyR** for: The package can be used to import microbial data for instance into TreeSummarizedExperiment (TreeSE). In TreeSE format, the data is directly compatible with miaverse framework.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MGnifyR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.