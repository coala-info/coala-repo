---
name: bioconductor-nbsplice
description: NBSplice evaluates differential splicing using negative binomial generalized linear models based on isoform quantification. Use when user asks to evaluate differential splicing, infer changes in isoform relative expression, or analyze isoform quantification data.
homepage: https://bioconductor.org/packages/3.8/bioc/html/NBSplice.html
---


# bioconductor-nbsplice

## Overview

Use the Bioconductor R package **NBSplice** for: The package proposes a differential splicing evaluation method based on isoform quantification. It applies generalized linear models with negative binomial distribution to infer changes in isoform relative expression.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("NBSplice")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.