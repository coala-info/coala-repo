---
name: bioconductor-organismdbi
description: OrganismDbi provides a unified interface to access and query multiple Bioconductor annotation packages simultaneously. Use when user asks to integrate genomic annotations from different sources, query multiple database schemas at once, or retrieve organism-level metadata.
homepage: https://bioconductor.org/packages/release/bioc/html/OrganismDbi.html
---


# bioconductor-organismdbi

## Overview

Use the Bioconductor R package **OrganismDbi** for: The package enables a simple unified interface to several annotation packages each of which has its own schema by taking advantage of the fact that each of these packages implements a select methods.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("OrganismDbi")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.