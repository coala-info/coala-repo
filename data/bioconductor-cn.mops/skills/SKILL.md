---
name: bioconductor-cn.mops
description: cn.mops detects copy number variations from next-generation sequencing data by modeling read depth across multiple samples using a Bayesian approach. Use when user asks to detect copy number variations, convert BAM files into read count matrices, or perform multi-sample CNV analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/cn.mops.html
---


# bioconductor-cn.mops

## Overview

Use the Bioconductor R package **cn.mops** for: The package supplies functions to convert BAM files into read count matrices or genomic ranges objects, which are the input objects for cn.mops. cn.mops models the depths of coverage across samples at each genomic position. Therefore, it does not suffer from read count biases along chromosomes. Using a Bayesian approach, cn.mops decomposes read variations across samples into integer copy numbers and noise by its mixture components and Poisson distributions, respectively. cn.mops guarantees a low FDR because wrong detections are indicated by high noise and filtered out. cn.mops is very fast and written in C++.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("cn.mops")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.