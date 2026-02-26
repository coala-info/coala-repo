---
name: bioconductor-crisprscore
description: The crisprScore package provides a unified interface for calculating on-target and off-target efficiency scores for CRISPR guide RNAs across various nucleases. Use when user asks to calculate gRNA efficiency scores, predict frameshift probabilities for Cas9, or evaluate guide performance using scoring algorithms like Lindel, DeepHF, and DeepCpf1.
homepage: https://bioconductor.org/packages/release/bioc/html/crisprScore.html
---


# bioconductor-crisprscore

## Overview

Use the Bioconductor R package **crisprScore** for: The package also provides a Lindel-derived score to predict the probability of a gRNA to produce indels inducing a frameshift for the Cas9 nuclease. Note that DeepHF, DeepCpf1 and enPAM+GB are not available on Windows machines.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("crisprScore")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.