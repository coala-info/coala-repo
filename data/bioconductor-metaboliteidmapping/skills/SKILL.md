---
name: bioconductor-metaboliteidmapping
description: This package provides a mapping table for converting between nine different metabolite ID formats and their common names. Use when user asks to map metabolite IDs, convert between different metabolite identifier formats, or retrieve common names for metabolites.
homepage: https://bioconductor.org/packages/release/data/annotation/html/metaboliteIDmapping.html
---


# bioconductor-metaboliteidmapping

## Overview

Use the Bioconductor R package **metaboliteIDmapping** for: The package provides a comprehensive mapping table of nine different Metabolite ID formats and their common name. The data has been collected and merged from four publicly available source, including HMDB, Comptox Dashboard, ChEBI, and the graphite Bioconductor R package.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("metaboliteIDmapping")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.