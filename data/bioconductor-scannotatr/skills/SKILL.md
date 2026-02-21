---
name: bioconductor-scannotatr
description: The package comprises a set of pretrained machine learning models to predict basic immune cell types. This enables all users to quickly get a first annotation of the cell types present in their dataset without requiring prior knowledge. scAnnotatR also allows users to train their own models to predict new cell types based on specific research needs.
homepage: https://bioconductor.org/packages/release/bioc/html/scAnnotatR.html
---

# bioconductor-scannotatr

## Overview

Use the Bioconductor R package **scAnnotatR** for: The package comprises a set of pretrained machine learning models to predict basic immune cell types. This enables all users to quickly get a first annotation of the cell types present in their dataset without requiring prior knowledge. scAnnotatR also allows users to train their own models to predict new cell types based on specific research needs.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scAnnotatR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.