---
name: bioconductor-metcirc
description: MetCirc calculates and visualizes similarities between MS/MS spectra using circular layouts and various similarity metrics. Use when user asks to calculate similarity between precursors, visualize MS/MS spectra similarities in a circular layout, or annotate MS/MS features based on similarity.
homepage: https://bioconductor.org/packages/release/bioc/html/MetCirc.html
---


# bioconductor-metcirc

## Overview

Use the Bioconductor R package **MetCirc** for: the package Spectra that stores MS/MS spectra. MetCirc offers functionality to calculate similarity between precursors based on the normalised dot product, neutral losses or user-defined functions and visualise similarities in a circular layout. Within the interactive framework the user can annotate MS/MS features based on their similarity to (known) related MS/MS features.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MetCirc")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.