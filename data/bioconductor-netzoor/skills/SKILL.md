---
name: bioconductor-netzoor
description: The netZooR package provides a suite of methods for biological network inference, analysis, and data processing. Use when user asks to reconstruct gene regulatory networks, perform single-sample network inference, detect differential communities, or estimate network transition states.
homepage: https://bioconductor.org/packages/release/bioc/html/netZooR.html
---


# bioconductor-netzoor

## Overview

Use the Bioconductor R package **netZooR** for: the package has 3 methods for network inference including PANDA and its optimized implementation OTTER (network reconstruction using mutliple lines of biological evidence), LIONESS (single-sample network inference), and EGRET (genotype-specific networks). Network analysis methods include CONDOR (community detection), ALPACA (differential community detection), CRANE (significance estimation of differential modules), MONSTER (estimation of network transition states). In addition, YARN allows to process gene expresssion data for tissue-specific analyses and SAMBAR infers missing mutation data based on pathway information.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("netZooR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.