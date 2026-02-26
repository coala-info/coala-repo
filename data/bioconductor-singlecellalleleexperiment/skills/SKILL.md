---
name: bioconductor-singlecellalleleexperiment
description: SingleCellAlleleExperiment provides a specialized data structure and analysis tools for allele-aware quantification of immune genes in single-cell data. Use when user asks to handle allele-aware quantification data, analyze immune gene diversity, or implement the scIGD workflow for single-cell data analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/SingleCellAlleleExperiment.html
---


# bioconductor-singlecellalleleexperiment

## Overview

Use the Bioconductor R package **SingleCellAlleleExperiment** for: The package is part of a workflow named single-cell ImmunoGenomic Diversity (scIGD), that firstly incorporates allele-aware quantification data for immune genes. This new data can then be used with the here implemented data structure and functionalities for further data handling and data analysis.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SingleCellAlleleExperiment")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.