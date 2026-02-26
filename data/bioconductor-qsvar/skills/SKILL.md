---
name: bioconductor-qsvar
description: This package generates principal components associated with RNA degradation to remove its effects during differential expression analysis. Use when user asks to generate quality surrogate variables, account for RNA degradation in transcriptomic studies, or adjust differential expression models for sample quality.
homepage: https://bioconductor.org/packages/release/bioc/html/qsvaR.html
---


# bioconductor-qsvar

## Overview

Use the Bioconductor R package **qsvaR** for: The package is equipped to help users generate principal components associated with degradation. The components can be used in differential expression analysis to remove the effects of degradation.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("qsvaR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.