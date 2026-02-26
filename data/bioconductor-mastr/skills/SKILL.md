---
name: bioconductor-mastr
description: This tool generates refined lists of signature genes from multiple group comparisons using differential expression analysis results. Use when user asks to generate signature gene lists, identify group markers, or account for tissue-specific background noise in differential expression data.
homepage: https://bioconductor.org/packages/release/bioc/html/mastR.html
---


# bioconductor-mastr

## Overview

Use the Bioconductor R package **mastR** for: The package is developed for generating refined lists of signature genes from multiple group comparisons based on the results from edgeR and limma differential expression (DE) analysis workflow. It also takes into account the background noise of tissue-specificity, which is often ignored by other marker generation tools. This package is particularly useful for the identification of group markers in various biological and medical applications, including cancer research and developmental biology.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mastR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.