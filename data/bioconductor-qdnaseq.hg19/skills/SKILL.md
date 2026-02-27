---
name: bioconductor-qdnaseq.hg19
description: This package provides pre-calculated bin annotations for the human genome build hg19 for use in copy number analysis workflows. Use when user asks to load hg19 bin metadata, retrieve GC content and mappability for specific bin sizes, or prepare annotations for QDNAseq analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/QDNAseq.hg19.html
---


# bioconductor-qdnaseq.hg19

name: bioconductor-qdnaseq.hg19
description: Provides pre-calculated bin annotations for the human genome build hg19 for use with the QDNAseq package. Use this skill when performing copy number analysis on human hg19 sequencing data to load essential bin metadata including GC content, mappability, and blacklisted regions for various bin sizes (1kbp to 1000kbp).

# bioconductor-qdnaseq.hg19

## Overview
The `QDNAseq.hg19` package is a data-only experiment package that provides bin annotations for the human genome build hg19. These annotations are specifically formatted for use with the `QDNAseq` package workflow. Each dataset contains information about non-overlapping bins, including GC content, mappability, and ENCODE blacklisted regions, which are critical for normalizing and filtering shallow whole-genome sequencing data.

## Available Bin Sizes
The package supports the following bin sizes (all using 50bp read length simulations, denoted by SR50):
- 1 kbp
- 5 kbp
- 10 kbp
- 15 kbp
- 30 kbp
- 50 kbp
- 100 kbp
- 500 kbp
- 1000 kbp

## Loading Bin Annotations
There are two primary ways to load the bin annotations into an R session.

### Method 1: Using the data() function
This method loads the object directly from the package namespace.
```R
library(QDNAseq.hg19)
data("hg19.30kbp.SR50")
bins <- hg19.30kbp.SR50
```

### Method 2: Using getBinAnnotations()
The `QDNAseq` package provides a wrapper function that identifies the correct annotation package based on the genome build and bin size.
```R
library(QDNAseq)
library(QDNAseq.hg19)
bins <- getBinAnnotations(binSize=30, genome="hg19")
```

## Typical Workflow Integration
Once loaded, the `bins` object (an `AnnotatedDataFrame`) is passed to the `binReadCounts` function in the `QDNAseq` pipeline.

```R
library(QDNAseq)
library(QDNAseq.hg19)

# 1. Load annotations
bins <- getBinAnnotations(binSize=15, genome="hg19")

# 2. Use annotations to process BAM files
# readCounts <- binReadCounts(bins, path="/path/to/bams")
```

## Annotation Content
Each bin annotation object contains the following columns:
- **chromosome**: Chromosome name.
- **start/end**: Base pair coordinates.
- **bases**: Percentage of non-N nucleotides.
- **gc**: Percentage of C and G nucleotides.
- **mappability**: Average mappability (50mers, max 2 mismatches).
- **blacklist**: Percent overlap with ENCODE blacklisted regions.
- **residual**: Median loess residual calculated from 1000 Genomes data.
- **use**: A logical flag indicating if the bin is recommended for analysis (based on filtering criteria like mappability and blacklisting).

## Reference documentation
- [QDNAseq.hg19 Reference Manual](./references/reference_manual.md)