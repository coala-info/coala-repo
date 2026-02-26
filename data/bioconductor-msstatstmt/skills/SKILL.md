---
name: bioconductor-msstatstmt
description: MSstatsTMT provides statistical tools for protein quantification and differential abundance analysis in TMT-labeled mass spectrometry experiments. Use when user asks to detect differentially abundant proteins, perform protein quantification, or normalize TMT-labeled proteomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/MSstatsTMT.html
---


# bioconductor-msstatstmt

## Overview

Use the Bioconductor R package **MSstatsTMT** for: The package provides statistical tools for detecting differentially abundant proteins in shotgun mass spectrometry-based proteomic experiments with tandem mass tag (TMT) labeling. It provides multiple functionalities, including aata visualization, protein quantification and normalization, and statistical modeling and inference. Furthermore, it is inter-operable with other data processing tools, such as Proteome Discoverer, MaxQuant, OpenMS and SpectroMine.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MSstatsTMT")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.