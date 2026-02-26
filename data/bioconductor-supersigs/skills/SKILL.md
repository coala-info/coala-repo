---
name: bioconductor-supersigs
description: This package learns supervised mutational signatures from genomic data and applies them to new datasets. Use when user asks to learn supervised mutational signatures or apply these signatures to new genomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/supersigs.html
---


# bioconductor-supersigs

## Overview

Use the Bioconductor R package **supersigs** for: the package allow the user to learn supervised mutational signatures from their data and apply them to new data. The methodology is based on the one described in Afsari (2021, ELife).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("supersigs")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.