---
name: bioconductor-trigger
description: "The package includes functions to: (1) construct global linkage maps between genetic markers and gene expression; (2) analyze multiple-locus linkage (epistasis) for gene expression; (3) quantify the proportion of genome-wide variation explained by each locus and identify eQTL hotspots; (4) estimate pair-wise causal gene regulatory probabilities and construct gene regulatory networks; and (5) identify causal genes for a quantitative trait of interest."
homepage: https://bioconductor.org/packages/3.6/bioc/html/trigger.html
---

# bioconductor-trigger

## Overview

Use the Bioconductor R package **trigger** for: The package includes functions to: (1) construct global linkage maps between genetic markers and gene expression; (2) analyze multiple-locus linkage (epistasis) for gene expression; (3) quantify the proportion of genome-wide variation explained by each locus and identify eQTL hotspots; (4) estimate pair-wise causal gene regulatory probabilities and construct gene regulatory networks; and (5) identify causal genes for a quantitative trait of interest.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("trigger")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.