---
name: bioconductor-listeretalbsseq
description: This package provides base-resolution bisulfite sequencing data for the H1 and IMR90 human cell lines aligned to the hg18 genome. Use when user asks to access Lister et al. (2009) DNA methylome datasets, load methylation data into methylPipe BSdata objects, or retrieve specific BS-seq data for embryonic stem cells and fetal lung fibroblasts.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ListerEtAlBSseq.html
---

# bioconductor-listeretalbsseq

name: bioconductor-listeretalbsseq
description: Access and load the Lister et al. (2009) base-resolution bisulfite sequencing (BS-seq) data for H1 and IMR90 human cell lines. Use this skill when a user needs to retrieve these specific DNA methylome datasets for analysis with the methylPipe package or for benchmarking methylation studies on the hg18 genome.

## Overview

The `ListerEtAlBSseq` package is an ExperimentData package providing base-resolution bisulfite sequencing data for two human cell lines: H1 (embryonic stem cells) and IMR90 (fetal lung fibroblasts). The data is stored in a format compatible with the `methylPipe` package, specifically designed to be loaded into `BSdata` objects.

Note: This dataset is aligned to the **hg18** (NCBI36) human genome assembly.

## Loading the Data

The package provides tabix-indexed methylation data and RData files containing uncovered genomic regions. To use these datasets, you must also load the `methylPipe` and `BSgenome.Hsapiens.UCSC.hg18` packages.

### Loading H1 Cell Line Data
```r
library(ListerEtAlBSseq)
library(methylPipe)
library(BSgenome.Hsapiens.UCSC.hg18)

# Locate the data files within the package
h1_tabix <- system.file('extdata', 'mc_h1_tabix.txt.gz', package='ListerEtAlBSseq')
h1_uncov_file <- system.file('extdata', 'uncov_GR_h1.Rdata', package='ListerEtAlBSseq')

# Load the uncovered regions GRanges object (loads as 'uncov_GR_h1')
load(h1_uncov_file)

# Create the BSdata object
H1.WGBS <- BSdata(file=h1_tabix, uncov=uncov_GR_h1, org=Hsapiens)
```

### Loading IMR90 Cell Line Data
```r
library(ListerEtAlBSseq)
library(methylPipe)
library(BSgenome.Hsapiens.UCSC.hg18)

# Locate the data files
imr90_tabix <- system.file('extdata', 'mc_i90_tabix.txt.gz', package='ListerEtAlBSseq')
imr90_uncov_file <- system.file('extdata', 'uncov_GR_imr90.Rdata', package='ListerEtAlBSseq')

# Load the uncovered regions GRanges object (loads as 'uncov_GR_imr90')
load(imr90_uncov_file)

# Create the BSdata object
IMR90.WGBS <- BSdata(file=imr90_tabix, uncov=uncov_GR_imr90, org=Hsapiens)
```

## Usage Tips

1.  **Genome Assembly**: Ensure you are using `BSgenome.Hsapiens.UCSC.hg18`. Using hg19 or hg38 will result in coordinate mismatches.
2.  **methylPipe Integration**: Once the `BSdata` object is created, you can use `methylPipe` functions such as `methStats`, `getCoverage`, or `findDMR` to analyze the methylation profiles.
3.  **Data Structure**: The underlying data includes C-positions, methylation context (CG, CHG, CHH), and counts of methylated/unmethylated reads.

## Reference documentation

- [ListerEtAlBSseq Reference Manual](./references/reference_manual.md)