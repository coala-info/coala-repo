---
name: bioconductor-synaptome.db
description: The package contains local copy of the Synaptic proteome database. On top of this it provide a set of utility R functions to query and analyse its content. It allows extraction of information for specific genes and building the protein-protein interaction graph for gene sets, synaptic compartments, and brain regions.
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