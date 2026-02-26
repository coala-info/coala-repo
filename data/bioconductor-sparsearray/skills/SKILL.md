---
name: bioconductor-sparsearray
description: The SparseArray package provides memory-efficient representations and standard matrix operations for multidimensional sparse data in R. Use when user asks to create sparse arrays, manipulate multidimensional sparse data using COO or SVT layouts, or perform standard matrix and array computations on sparse objects.
homepage: https://bioconductor.org/packages/release/bioc/html/SparseArray.html
---


# bioconductor-sparsearray

## Overview

Use the Bioconductor R package **SparseArray** for: The package defines the SparseArray virtual class and two concrete subclasses: COO_SparseArray and SVT_SparseArray. Each subclass uses its own internal representation of the nonzero multidimensional data: the "COO layout" and the "SVT layout", respectively. SVT_SparseArray objects mimic as much as possible the behavior of ordinary matrix and array objects in base R. In particular, they suppport most of the "standard matrix and array API" defined in base R and in the matrixStats package from CRAN.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SparseArray")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.