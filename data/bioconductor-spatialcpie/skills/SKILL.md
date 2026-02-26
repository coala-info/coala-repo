---
name: bioconductor-spatialcpie
description: SpatialCPie provides an interactive Shiny gadget for exploring spatial transcriptomics data across multiple cluster resolutions. Use when user asks to interactively explore spatial transcriptomics data, visualize clusters at different resolutions, or use a Shiny interface for spatial data analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/SpatialCPie.html
---


# bioconductor-spatialcpie

## Overview

Use the Bioconductor R package **SpatialCPie** for: The package is built around a shiny "gadget" to allow the exploration of the data with multiple plots in parallel and an interactive UI. The user can easily toggle between different cluster resolutions in order to choose the most appropriate visual cues.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SpatialCPie")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.