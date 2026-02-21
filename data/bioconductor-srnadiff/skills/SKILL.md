---
name: bioconductor-srnadiff
description: the package implements the identify-then-annotate methodology that builds on the idea of combining two pipelines approachs differential expressed regions detection and differential expression quantification. It reads BAM files as input, and outputs a list differentially regions, together with the adjusted p-values.
homepage: https://bioconductor.org/packages/release/bioc/html/srnadiff.html
---

# bioconductor-srnadiff

## Overview

Use the Bioconductor R package **srnadiff** for: the package implements the identify-then-annotate methodology that builds on the idea of combining two pipelines approachs differential expressed regions detection and differential expression quantification. It reads BAM files as input, and outputs a list differentially regions, together with the adjusted p-values.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("srnadiff")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.