---
name: bioconductor-nem
description: This R package reconstructs signaling pathway hierarchies from the nested structure of high-dimensional perturbation effects. Use when user asks to infer pathway structures, reconstruct signaling networks from perturbation data, or analyze nested phenotypic effects.
homepage: https://bioconductor.org/packages/3.5/bioc/html/nem.html
---


# bioconductor-nem

## Overview

Use the Bioconductor R package **nem** for: The package 'nem' allows to reconstruct features of pathways from the nested structure of perturbation effects. It takes as input (1.) a set of pathway components, which were perturbed, and (2.) phenotypic readout of these perturbations (e.g. gene expression, protein expression). The output is a directed graph representing the phenotypic hierarchy.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("nem")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.