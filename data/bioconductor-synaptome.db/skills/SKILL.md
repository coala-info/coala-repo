---
name: bioconductor-synaptome.db
description: This package provides a local copy of the Synaptic proteome database and tools to query and analyze its content. Use when user asks to extract gene information, build protein-protein interaction graphs, or analyze synaptic compartments and brain regions.
homepage: https://bioconductor.org/packages/release/data/annotation/html/synaptome.db.html
---


# bioconductor-synaptome.db

## Overview

Use the Bioconductor R package **synaptome.db** for: The package contains local copy of the Synaptic proteome database. On top of this it provide a set of utility R functions to query and analyse its content. It allows extraction of information for specific genes and building the protein-protein interaction graph for gene sets, synaptic compartments, and brain regions.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("synaptome.db")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.