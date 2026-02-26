---
name: bioconductor-rrdpdata
description: This package provides the bacterial and archaeal taxonomy training data for the RDP Classifier. Use when user asks to access the RDP training set No. 19 or perform taxonomic classification of microbial sequences.
homepage: https://bioconductor.org/packages/release/data/experiment/html/rRDPData.html
---


# bioconductor-rrdpdata

## Overview

Use the Bioconductor R package **rRDPData** for: The package provides the data for the RDP Classifier 2.14 released in August 2023. It contains the latest bacterial and archaeal taxonomy training set No. 19 as described in Wang Q, Cole JR. 2024. Updated RDP taxonomy and RDP Classifier for more accurate taxonomic classification. Microbiol Resour Announc 0:e01063-23.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rRDPData")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.