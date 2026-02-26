---
name: bioconductor-rtca
description: The bioconductor-rtca package imports and processes real-time cell electrical impedance data in R. Use when user asks to import RTCA data, apply normalization strategies to cell impedance measurements, or visualize real-time cell analysis results.
homepage: https://bioconductor.org/packages/release/bioc/html/RTCA.html
---


# bioconductor-rtca

## Overview

Use the Bioconductor R package **RTCA** for: The package imports real-time cell electrical impedance data into R. As an alternative to commercial software shipped along the system, the Bioconductor package RTCA provides several unique transformation (normalization) strategies and various visualization tools.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RTCA")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.