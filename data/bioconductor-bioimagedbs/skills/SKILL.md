---
name: bioconductor-bioimagedbs
description: This package provides bioimage datasets with supervised labels for machine learning and deep learning analysis in R. Use when user asks to access microscopy imaging data, load bioimage datasets for deep learning, or use supervised image labels in Keras or TensorFlow.
homepage: https://bioconductor.org/packages/release/data/experiment/html/BioImageDbs.html
---


# bioconductor-bioimagedbs

## Overview

Use the Bioconductor R package **BioImageDbs** for: The package provides a bioimage dataset for the image analysis using machine learning and deep learning. The dataset includes microscopy imaging data with supervised labels. The data is provided as R list data that can be loaded to Keras/tensorflow in R.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BioImageDbs")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.