---
name: bioconductor-methylkit
description: The package is designed to deal with sequencing data from RRBS and its variants, but also target-capture methods and whole genome bisulfite sequencing. It also has functions to analyze base-pair resolution 5hmC data from experimental protocols such as oxBS-Seq and TAB-Seq. Methylation calling can be performed directly from Bismark aligned BAM files.
homepage: https://bioconductor.org/packages/release/bioc/html/methylKit.html
---

# bioconductor-methylkit

## Overview

Use the Bioconductor R package **methylKit** for: The package is designed to deal with sequencing data from RRBS and its variants, but also target-capture methods and whole genome bisulfite sequencing. It also has functions to analyze base-pair resolution 5hmC data from experimental protocols such as oxBS-Seq and TAB-Seq. Methylation calling can be performed directly from Bismark aligned BAM files.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("methylKit")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.