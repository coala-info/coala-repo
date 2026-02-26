---
name: bioconductor-rlseq
description: RLSeq provides a comprehensive pipeline for the analysis and reporting of R-loop mapping data. Use when user asks to analyze R-loop mapping data, run an RL-seq analysis pipeline, or generate an HTML report for R-loop experiments.
homepage: https://bioconductor.org/packages/3.14/bioc/html/RLSeq.html
---


# bioconductor-rlseq

## Overview

Use the Bioconductor R package **RLSeq** for: The package is intended to provide a simple pipeline, called with the `RLSeq()` function, which performs all main analyses. Individual functions are also accessible and provide custom analysis capabilities. Finally an HTML report is generated with `report()`.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RLSeq")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.