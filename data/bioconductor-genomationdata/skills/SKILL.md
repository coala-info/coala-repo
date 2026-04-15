---
name: bioconductor-genomationdata
description: This package provides sample ChIP-seq and Bisulfite-seq data from human H1 embryonic stem cells for testing and demonstrating genomic analysis workflows. Use when user asks to load example genomic data, access sample BAM or peak files, or provide test datasets for the genomation package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/genomationData.html
---

# bioconductor-genomationdata

name: bioconductor-genomationdata
description: Access and use the genomationData Bioconductor experiment data package. Use this skill when you need to load sample high-throughput genomic data (ChIP-seq and Bisulfite-seq) for human H1 embryonic stem cells (hg19/GRCh37) to demonstrate or test genomic analysis workflows, particularly those involving the 'genomation' package.

# bioconductor-genomationdata

## Overview
The `genomationData` package is a Bioconductor experiment data package providing raw and processed data from high-throughput genomics experiments. It contains ChIP-seq and Bisulfite-sequencing data from the human H1 embryonic stem cell line, mapped to the hg19 (GRCh37) genome assembly. This data is primarily intended for use with the `genomation` package for demonstrating genomic interval analysis, visualization, and integration.

## Getting Started

To use the data in an R session, load the library:

```r
library(genomationData)
```

## Accessing Data Files
The package stores data in its `extdata` directory. You can list all available files using:

```r
# List all files in the package's external data directory
list.files(system.file("extdata", package = "genomationData"))
```

### Available Data Types
- **.bam files**: Raw ChIP-seq reads (restricted to chromosome 21 to reduce size).
- **.broadPeak / .narrowPeak files**: Processed ChIP-seq peaks.
- **.bedGraph.gz**: Methylation calls for CpG dinucleotides (Bisulfite-seq) on chromosome 21.

## Working with Sample Metadata
The package includes a `SamplesInfo.txt` file that provides detailed metadata for the included experiments.

```r
# Locate and read the sample information table
samp.file <- system.file("extdata/SamplesInfo.txt", package = "genomationData")
samp.info <- read.table(samp.file, header = TRUE, sep = "\t")

# View the metadata
head(samp.info)
```

## Typical Workflow
The data in this package is typically used as input for functions in the `genomation` package, such as `readTallies`, `readGeneric`, or `ScoreMatrix`.

```r
# Example: Getting the path to a specific file for use in an analysis
bam_file <- system.file("extdata", "H1.ChIP-Seq.H3K4me3.chr21.bam", package = "genomationData")
# This path can now be passed to genomic alignment or coverage functions
```

## Reference documentation
- [genomationData-knitr](./references/genomationData-knitr.md)