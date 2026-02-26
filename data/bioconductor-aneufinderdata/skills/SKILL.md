---
name: bioconductor-aneufinderdata
description: This package provides example whole-genome single-cell sequencing data files for demonstrating and testing AneuFinder workflows. Use when user asks to access example BAM, BED, or aneuHMM files, test copy number variation calling, or perform karyotype analysis demonstrations.
homepage: https://bioconductor.org/packages/release/data/experiment/html/AneuFinderData.html
---


# bioconductor-aneufinderdata

name: bioconductor-aneufinderdata
description: Access and use the AneuFinderData package, which provides whole-genome single-cell sequencing (WGSCS) data for demonstration purposes. Use this skill when a user needs example BAM, BED, or aneuHMM files to test or demonstrate the AneuFinder R package workflows, including copy number variation (CNV) calling and karyotype analysis.

# bioconductor-aneufinderdata

## Overview
AneuFinderData is a specialized data experiment package for Bioconductor. It contains a collection of genomic data files (BAM, BED, and RData) specifically curated to demonstrate the functionality of the `AneuFinder` package. The dataset includes single-cell sequencing results from various sources, such as lung cancer primary tumors, liver metastases, and diploid control cells.

## Loading the Data
To use the data in an R session, first load the library. Since this is a data package, the primary way to interact with it is by locating the file paths of the bundled resources.

```r
library(AneuFinderData)

# List all files included in the package
list.files(system.file("extdata", package="AneuFinderData"))
```

## Accessing Specific Datasets
The package provides raw alignment files and processed results. Use `system.file` to retrieve the full path to these files for use in `AneuFinder` functions.

### 1. Raw Alignment Files (BAM/BED)
These files are used for testing binning and CNV calling workflows.
- **BB150803_IV_074**: A downsampled BAM file from a mouse T-cell Acute Lymphoblastic Leukemia cell.
- **hg19_diploid**: A BAM file from a diploid human brain cell (used as a control).
- **KK150311_VI_07**: A BED file containing Strand-seq reads.

```r
# Get path to a BAM file
bam_file <- system.file("extdata", "BB150803_IV_074.bam", package="AneuFinderData")

# Get path to a BED file
bed_file <- system.file("extdata", "KK150311_VI_07.bed.gz", package="AneuFinderData")
```

### 2. Processed Results (aneuHMM objects)
The package includes pre-computed Hidden Markov Model (HMM) results stored as `.RData` files. These are useful for demonstrating visualization and clustering without running the full pipeline.
- **primary_lung**: Results from a primary small cell lung cancer.
- **metastasis_liver**: Results from a liver metastasis.

```r
# Locate the directory containing pre-computed HMMs
results_dir <- system.file("extdata", "primary-lung", package="AneuFinderData")

# List the RData files in that directory
list.files(results_dir)
```

## Typical Workflow Example
The most common use case is providing these file paths to `AneuFinder` functions like `Aneufinder()` or `binReads()`.

```r
library(AneuFinder)
library(AneuFinderData)

# Define input and output
input_file <- system.file("extdata", "BB150803_IV_074.bam", package="AneuFinderData")
output_dir <- tempdir()

# Run a quick analysis (example parameters)
Aneufinder(inputfolder = input_file, 
           outputfolder = output_dir, 
           numCPU = 1, 
           binsizes = 1e6, 
           assembly = 'mm10')
```

## Reference documentation
- [AneuFinderData Reference Manual](./references/reference_manual.md)