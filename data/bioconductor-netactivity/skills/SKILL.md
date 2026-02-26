---
name: bioconductor-netactivity
description: NetActivity computes gene set scores from transcriptomic data using pre-trained or custom models to measure pathway activity. Use when user asks to prepare summarized experiment data, compute gene set scores, or apply pre-trained models to analyze network activity.
homepage: https://bioconductor.org/packages/release/bioc/html/NetActivity.html
---


# bioconductor-netactivity

## Overview

Use the Bioconductor R package **NetActivity** for: The package contains a function to prepare the data (`prepareSummarizedExperiment`) and a function to compute the gene set scores (`computeGeneSetScores`). The package `NetActivityData` contains different pre-trained models to be directly applied to the data. Alternatively, the users might use the package to compute gene set scores using custom models.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("NetActivity")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.