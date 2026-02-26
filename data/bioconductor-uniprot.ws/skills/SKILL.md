---
name: bioconductor-uniprot.ws
description: This Bioconductor package provides an interface to the UniProt REST API for retrieving protein data and mapping identifiers across various biological databases. Use when user asks to retrieve protein information from UniProt, map identifiers between different databases, or query UniProt data using R.
homepage: https://bioconductor.org/packages/release/bioc/html/UniProt.ws.html
---


# bioconductor-uniprot.ws

## Overview

Use the Bioconductor R package **UniProt.ws** for: The package makes use of UniProt's modernized REST API and allows mapping of identifiers accross different databases.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("UniProt.ws")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.