---
name: bioconductor-mirage
description: MiRaGE infers miRNA-mediated regulation of target genes using only gene expression profiles. Use when user asks to infer miRNA regulation, analyze miRNA activity from expression data, or identify target gene regulation by miRNAs.
homepage: https://bioconductor.org/packages/release/bioc/html/MiRaGE.html
---


# bioconductor-mirage

## Overview

Use the Bioconductor R package **MiRaGE** for: The package contains functions for inferece of target gene regulation by miRNA, based on only target gene expression profile.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MiRaGE")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.