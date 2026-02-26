---
name: bioconductor-scgps
description: The scGPS package implements algorithms for stable clustering to identify subpopulations and analyze the relationships between them. Use when user asks to find subpopulations, investigate relationships between cell clusters, or perform stable clustering at optimal resolution.
homepage: https://bioconductor.org/packages/release/bioc/html/scGPS.html
---


# bioconductor-scgps

## Overview

Use the Bioconductor R package **scGPS** for: The package implements two main algorithms to answer two key questions: a SCORE (Stable Clustering at Optimal REsolution) to find subpopulations, followed by scGPS to investigate the relationships between subpopulations.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scGPS")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.