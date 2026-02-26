---
name: bioconductor-visiumio
description: "VisiumIO imports spatial transcriptomics data from 10X Genomics or Space Ranger into SpatialExperiment objects. Use when user asks to import spatial data, load 10X Genomics files, or convert Space Ranger output to SpatialExperiment objects."
homepage: https://bioconductor.org/packages/release/bioc/html/VisiumIO.html
---


# bioconductor-visiumio

## Overview

Use the Bioconductor R package **VisiumIO** for: The package allows users to readily import spatial data obtained from either the 10X website or from the Space Ranger pipeline. Supported formats include tar.gz, h5, and mtx files. Multiple files can be imported at once with *List type of functions. The package represents data mainly as SpatialExperiment objects.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("VisiumIO")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.