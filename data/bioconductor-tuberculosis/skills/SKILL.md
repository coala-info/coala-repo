---
name: bioconductor-tuberculosis
description: This Bioconductor package provides access to over 10,000 standardized tuberculosis gene expression samples from microarray and sequencing studies. Use when user asks to retrieve processed tuberculosis transcriptomic data, access standardized sequencing datasets, or analyze tuberculosis microarray studies.
homepage: https://bioconductor.org/packages/release/data/experiment/html/tuberculosis.html
---


# bioconductor-tuberculosis

## Overview

Use the Bioconductor R package **tuberculosis** for: The package has more than 10,000 samples from both microarray and sequencing studies that have been processed from raw data through a hyper-standardized, reproducible pipeline.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("tuberculosis")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.