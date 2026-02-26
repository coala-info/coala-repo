---
name: bioconductor-rbowtie2
description: Rbowtie2 provides R wrapper functions for genome indexing and sequence alignment. Use when user asks to index a genome, align sequencing reads to a reference, or generate BAM files.
homepage: https://bioconductor.org/packages/release/bioc/html/Rbowtie2.html
---


# bioconductor-rbowtie2

## Overview

Use the Bioconductor R package **Rbowtie2** for: The package contains wrapper functions that allow for genome indexing and alignment to those indexes. The package also allows for the creation of .bam files via Rsamtools.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Rbowtie2")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.