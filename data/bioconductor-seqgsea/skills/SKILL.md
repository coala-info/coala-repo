---
name: bioconductor-seqgsea
description: SeqGSEA performs gene set enrichment analysis of RNA-Seq data by integrating differential expression and differential splicing. Use when user asks to perform gene set enrichment analysis, integrate differential expression and splicing results, or model RNA-Seq read counts for statistical significance.
homepage: https://bioconductor.org/packages/release/bioc/html/SeqGSEA.html
---


# bioconductor-seqgsea

## Overview

Use the Bioconductor R package **SeqGSEA** for: The package generally provides methods for gene set enrichment analysis of high-throughput RNA-Seq data by integrating differential expression and splicing. It uses negative binomial distribution to model read count data, which accounts for sequencing biases and biological variation. Based on permutation tests, statistical significance can also be achieved regarding each gene's differential expression and splicing, respectively.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SeqGSEA")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.