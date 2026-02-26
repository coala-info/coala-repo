---
name: bioconductor-rarevariantvis
description: RareVariantVis is a Bioconductor package for calling homozygous regions and analyzing rare variants in whole human genome sequencing data. Use when user asks to call homozygous regions, analyze whole human genomes for rare variants, or identify causative variants for monogenic disorders.
homepage: https://bioconductor.org/packages/release/bioc/html/RareVariantVis.html
---


# bioconductor-rarevariantvis

## Overview

Use the Bioconductor R package **RareVariantVis** for: The package includes homozygous region caller and allows to analyse whole human genomes in less than 30 minutes on a desktop computer. RareVariantVis disclosed novel causes of several rare monogenic disorders, including one with non-coding causative variant - keratolythic winter erythema.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RareVariantVis")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.