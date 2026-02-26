---
name: bioconductor-matrixqcvis
description: MatrixQCvis provides interactive visualization and quality control for mass spectrometry-based proteomics and metabolomics data. Use when user asks to assess data quality, visualize mass spectrometry experiments, or perform quality control on SummarizedExperiment objects.
homepage: https://bioconductor.org/packages/release/bioc/html/MatrixQCvis.html
---


# bioconductor-matrixqcvis

## Overview

Use the Bioconductor R package **MatrixQCvis** for: The package is especially tailored towards metabolomics and proteomics mass spectrometry data, but also allows to assess the data quality of other data types that can be represented in a SummarizedExperiment object.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MatrixQCvis")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.