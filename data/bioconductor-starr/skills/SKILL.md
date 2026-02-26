---
name: bioconductor-starr
description: Starr is a Bioconductor package for the analysis and visualization of ChIP-chip data, including quality assessment and peak-finding using the CMARRT algorithm. Use when user asks to import ChIP-chip data, associate ChIP signals with annotated features, find peaks, or generate microarray probe annotation files.
homepage: https://bioconductor.org/packages/3.5/bioc/html/Starr.html
---


# bioconductor-starr

## Overview

Use the Bioconductor R package **Starr** for: The package provides functions for data import, quality assessment, data visualization and exploration. Furthermore, it includes high-level analysis features like association of ChIP signals with annotated features, correlation analysis of ChIP signals and other genomic data (e.g. gene expression), peak-finding with the CMARRT algorithm and comparative display of multiple clusters of ChIP-profiles. It uses the basic Bioconductor classes ExpressionSet and probeAnno for maximum compatibility with other software on Bioconductor. All functions from Starr can be used to investigate preprocessed data from the Ringo package, and vice versa. An important novel tool is the the automated generation of correct, up-to-date microarray probe annotation (bpmap) files, which relies on an efficient mapping of short sequences (e.g. the probe sequences on a microarray) to an arbitrary genome.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Starr")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.