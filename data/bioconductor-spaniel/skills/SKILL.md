---
name: bioconductor-spaniel
description: Spaniel integrates histological images with spatial transcriptomics data for visualization and analysis in R. Use when user asks to create SingleCellExperiment or Seurat objects from spatial data, load histological images into R, or visualize metrics overlaid on tissue sections.
homepage: https://bioconductor.org/packages/release/bioc/html/Spaniel.html
---


# bioconductor-spaniel

## Overview

Use the Bioconductor R package **Spaniel** for: The package contains functions to create a SingleCellExperiment Seurat object and provides a method of loading a histologial image into R. The spanielPlot function allows visualisation of metrics contained within the S4 object overlaid onto the image of the tissue.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Spaniel")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.