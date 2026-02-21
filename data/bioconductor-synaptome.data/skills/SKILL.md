---
name: bioconductor-synaptome.data
description: The package provides access to the copy of the Synaptic proteome database. It was designed as an accompaniment for Synaptome.DB package. Database provides information for specific synaptic genes and allows building the protein-protein interaction graph for gene sets, synaptic compartments, and brain regions. In the current update we added 6 more synaptic proteome studies, which resulted in total of 64 studies. We introduced Synaptic Vesicle as a separate compartment. We also added coding mutations for Autistic Spectral disorder and Epilepsy collected from publicly available databases.
homepage: https://bioconductor.org/packages/release/data/annotation/html/synaptome.data.html
---

# bioconductor-synaptome.data

## Overview

Use the Bioconductor R package **synaptome.data** for: The package provides access to the copy of the Synaptic proteome database. It was designed as an accompaniment for Synaptome.DB package. Database provides information for specific synaptic genes and allows building the protein-protein interaction graph for gene sets, synaptic compartments, and brain regions. In the current update we added 6 more synaptic proteome studies, which resulted in total of 64 studies. We introduced Synaptic Vesicle as a separate compartment. We also added coding mutations for Autistic Spectral disorder and Epilepsy collected from publicly available databases.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("synaptome.data")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.