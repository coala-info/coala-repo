---
name: bioconductor-qdnaseq.mm10
description: This package provides pre-calculated bin annotations for the mouse genome build mm10 for use in copy number analysis. Use when user asks to load mouse bin annotations, perform copy number analysis with QDNAseq, or retrieve GC content and mappability data for mm10 genomic bins.
homepage: https://bioconductor.org/packages/release/data/experiment/html/QDNAseq.mm10.html
---

# bioconductor-qdnaseq.mm10

name: bioconductor-qdnaseq.mm10
description: Provides QDNAseq bin annotations for the mouse genome build mm10. Use this skill when performing copy number analysis on Mus musculus sequencing data with the QDNAseq package to load pre-calculated bin annotations for various resolutions (1kbp to 1000kbp).

## Overview

The QDNAseq.mm10 package is a data-only Bioconductor package that provides essential bin annotations for the mouse genome (build mm10). These annotations are specifically formatted for use with the `QDNAseq` workflow, including information on GC content, mappability, and residuals required for normalization and filtering of sequencing data.

## Available Bin Sizes

The package provides annotations for non-overlapping bins at the following resolutions:
- 1 kbp
- 5 kbp
- 10 kbp
- 15 kbp
- 30 kbp
- 50 kbp
- 100 kbp
- 500 kbp
- 1000 kbp

## Usage Instructions

### Loading Bin Annotations

There are two primary ways to load the bin annotations into an R session:

1. **Using the `data()` function:**
```R
library(QDNAseq.mm10)
# Load 30kbp bins
data("mm10.30kbp.SR50")
bins <- mm10.30kbp.SR50
```

2. **Using the `getBinAnnotations()` function (Recommended for workflows):**
```R
library(QDNAseq)
library(QDNAseq.mm10)
# Retrieve bins by specifying size and genome
bins <- getBinAnnotations(binSize=30, genome="mm10")
```

### Integrating with QDNAseq Workflow

Once loaded, the `bins` object (an `AnnotatedDataFrame`) is passed directly to the `binReadCounts` function to process BAM files:

```R
# Example workflow
readCounts <- binReadCounts(bins=bins, path="./bam_directory")
```

### Annotation Content

Each bin annotation object contains the following columns:
- **chromosome, start, end**: Genomic coordinates.
- **bases**: Percentage of non-N nucleotides.
- **gc**: Percentage of C and G nucleotides.
- **mappability**: Average mappability (50mers, max 2 mismatches).
- **blacklist**: Percent overlap with blacklisted regions (Note: ENCODE blacklist is generally unavailable for mouse in this version).
- **residual**: Median loess residual calculated from normal C57BL/6J samples.
- **use**: A logical flag indicating if the bin should be used in downstream analysis based on quality metrics.

## Reference documentation

- [QDNAseq.mm10 Reference Manual](./references/reference_manual.md)