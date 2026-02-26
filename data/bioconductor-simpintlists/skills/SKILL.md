---
name: bioconductor-simpintlists
description: This package provides BioGRID protein-protein interaction data for various model organisms formatted as simple lists. Use when user asks to retrieve protein-protein interactions, find interactors for specific genes, or access BioGRID data for organisms such as human, mouse, and yeast.
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