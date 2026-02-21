---
name: bioconductor-methylscaper
description: The package supports both single-cell and single-molecule data, and a common interface for jointly visualizing both data types through the generation of ordered representational methylation-state matrices. The Shiny app allows for an interactive seriation process of refinement and re-weighting that optimally orders the cells or DNA molecules to discover methylation patterns and nucleosome positioning.
homepage: https://bioconductor.org/packages/release/bioc/html/methylscaper.html
---

# bioconductor-methylscaper

## Overview

Use the Bioconductor R package **methylscaper** for: The package supports both single-cell and single-molecule data, and a common interface for jointly visualizing both data types through the generation of ordered representational methylation-state matrices. The Shiny app allows for an interactive seriation process of refinement and re-weighting that optimally orders the cells or DNA molecules to discover methylation patterns and nucleosome positioning.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("methylscaper")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.