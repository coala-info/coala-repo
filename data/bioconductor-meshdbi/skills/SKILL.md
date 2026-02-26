---
name: bioconductor-meshdbi
description: MeSHDbi provides a unified interface for MeSH databases and tools to construct Gene-MeSH annotation packages. Use when user asks to access MeSH database implementations, construct Gene-MeSH packages, or generate MeSH annotation databases from SQLite files.
homepage: https://bioconductor.org/packages/release/bioc/html/MeSHDbi.html
---


# bioconductor-meshdbi

## Overview

Use the Bioconductor R package **MeSHDbi** for: The package is unified implementation of MeSH.db, MeSH.AOR.db, and MeSH.PCR.db and also is interface to construct Gene-MeSH package (MeSH.XXX.eg.db). loadMeSHDbiPkg import sqlite file and generate MeSH.XXX.eg.db.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MeSHDbi")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.