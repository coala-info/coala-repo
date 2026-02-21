---
name: bioconductor-simpintlists
description: The package contains BioGRID interactions for arabidopsis(thale cress), c.elegans, fruit fly, human, mouse, yeast( budding yeast ) and S.pombe (fission yeast) . Entrez ids, official names and unique ids can be used to find proteins. The format of interactions are lists. For each gene/protein, there is an entry in the list with "name" containing name of the gene/protein and "interactors" containing the list of genes/proteins interacting with it.
homepage: https://bioconductor.org/packages/release/data/experiment/html/simpIntLists.html
---

# bioconductor-simpintlists

## Overview

Use the Bioconductor R package **simpIntLists** for: The package contains BioGRID interactions for arabidopsis(thale cress), c.elegans, fruit fly, human, mouse, yeast( budding yeast ) and S.pombe (fission yeast) . Entrez ids, official names and unique ids can be used to find proteins. The format of interactions are lists. For each gene/protein, there is an entry in the list with "name" containing name of the gene/protein and "interactors" containing the list of genes/proteins interacting with it.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("simpIntLists")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.