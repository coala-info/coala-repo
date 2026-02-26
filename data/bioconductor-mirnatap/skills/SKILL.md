---
name: bioconductor-mirnatap
description: The miRNAtap package integrates and aggregates ranked miRNA target predictions from multiple online sources to improve prediction accuracy. Use when user asks to predict miRNA targets, aggregate miRNA target data from multiple databases, or perform miRNA target analysis for human, mouse, and rat.
homepage: https://bioconductor.org/packages/release/bioc/html/miRNAtap.html
---


# bioconductor-mirnatap

## Overview

Use the Bioconductor R package **miRNAtap** for: The package facilitates implementation of workflows requiring miRNA predictions, it allows to integrate ranked miRNA target predictions from multiple sources available online and aggregate them with various methods which improves quality of predictions above any of the single sources. Currently predictions are available for Homo sapiens, Mus musculus and Rattus norvegicus (the last one through homology translation).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("miRNAtap")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.