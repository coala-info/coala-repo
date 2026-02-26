---
name: bioconductor-prostar
description: Prostar provides a graphical interface for the statistical analysis of quantitative data from label-free proteomics experiments. Use when user asks to analyze proteomics data, perform statistical analysis on label-free experiments, or process quantitative protein datasets without programming.
homepage: https://bioconductor.org/packages/release/bioc/html/Prostar.html
---


# bioconductor-prostar

## Overview

Use the Bioconductor R package **Prostar** for: The package Prostar (Proteomics statistical analysis with R) is a Bioconductor distributed R package which provides all the necessary functions to analyze quantitative data from label-free proteomics experiments. Contrarily to most other similar R packages, it is endowed with rich and user-friendly graphical interfaces, so that no programming skill is required.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Prostar")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.