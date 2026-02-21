---
name: bioconductor-cnordt
description: the package CellNOptR handles time-course data, as opposed to steady state data in CellNOptR. It scales the simulation step to allow comparison and model fitting for time-course data. Future versions will optimize delays and strengths for each edge.
homepage: https://bioconductor.org/packages/release/bioc/html/CNORdt.html
---

# bioconductor-cnordt

## Overview

Use the Bioconductor R package **CNORdt** for: the package CellNOptR handles time-course data, as opposed to steady state data in CellNOptR. It scales the simulation step to allow comparison and model fitting for time-course data. Future versions will optimize delays and strengths for each edge.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("CNORdt")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.