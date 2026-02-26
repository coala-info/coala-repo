---
name: bioconductor-ptairdata
description: This package provides raw PTR-TOF-MS datasets in HDF5 format for use in mass spectrometry data pre-processing examples. Use when user asks to access example PTR-TOF-MS data, load raw mass spectrometry datasets, or run vignettes for the ptairMS package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ptairData.html
---


# bioconductor-ptairdata

## Overview

Use the Bioconductor R package **ptairData** for: The package ptairData contains two raw datasets from Proton-Transfer-Reaction Time-of-Flight mass spectrometer acquisitions (PTR-TOF-MS), in the HDF5 format. One from the exhaled air of two volunteer healthy individuals with three replicates, and one from the cell culture headspace from two mycobacteria species and one control (culture medium only) with two replicates. Those datasets are used in the examples and in the vignette of the ptairMS package (PTR-TOF-MS data pre-processing).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ptairData")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.