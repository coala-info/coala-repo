---
name: bioconductor-rnaseqrdata
description: This package provides mini example datasets including FASTQ, FASTA, and GTF files for the RNASeqR workflow. Use when user asks to load sample RNA-Seq data for testing, benchmark RNA-Seq pipelines, or follow RNASeqR vignettes.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/RNASeqRData.html
---


# bioconductor-rnaseqrdata

name: bioconductor-rnaseqrdata
description: Provides access to the RNASeqRData experiment data package, which contains mini example datasets for the RNASeqR workflow. Use this skill when a user needs to load sample RNA-Seq data (FASTQ, FASTA, GTF, and phenodata) for testing, benchmarking, or following RNASeqR vignettes.

## Overview

`RNASeqRData` is a Bioconductor experiment data package designed to support the `RNASeqR` software package. It provides a "mini" version of *Saccharomyces cerevisiae* (yeast) RNA-Seq data, specifically focusing on a 100kb region of chromosome XV. This reduced dataset allows for rapid testing of RNA-Seq pipelines without the computational overhead of full-sized genomic files.

## Loading the Data

To use the data provided by this package, you must first locate the file paths within your R library.

```r
# Load the package
library(RNASeqRData)

# Find the path to the input_files directory
input_files_path <- system.file("extdata", "input_files", package = "RNASeqRData")

# List the contents to verify structure
list.files(input_files_path, recursive = TRUE)
```

## Data Structure and Criteria

The package provides a specific directory structure required by the `RNASeqR` workflow. If you are using this data to test other tools, note the following components:

1.  **Reference Genome**: `Saccharomyces_cerevisiae_XV_Ensembl.fa` (FASTA format, chromosome XV only).
2.  **Gene Annotation**: `Saccharomyces_cerevisiae_XV_Ensembl.gtf` (GTF format).
3.  **Raw Reads**: Located in the `raw_fastq.gz/` subdirectory.
    *   Contains paired-end reads: `sample_1.fastq.gz` and `sample_2.fastq.gz`.
    *   Samples included: SRR3396381, SRR3396382, SRR3396384, SRR3396385, SRR3396386, and SRR3396387.
4.  **Phenodata**: `phenodata.csv`
    *   **ids**: Matches the `sample.pattern` in the FASTQ filenames.
    *   **independent.variable**: Defines the experimental groups (e.g., case vs. control).
5.  **Indices (Optional)**: The `indices/` directory contains pre-built HISAT2 index files (`.ht2`) for the included reference genome to accelerate alignment steps.

## Usage in RNASeqR

When using this data with the `RNASeqR` package, you typically pass the path to the `input_files` directory as the `input.path.prefix` parameter:

```r
# Example of setting up the path for RNASeqR
input.path.prefix <- system.file("extdata", "input_files", package = "RNASeqRData")

# This path can then be used in RNASeqR initialization functions
# RNASeqRParam(input.path.prefix = input.path.prefix, ...)
```

## Reference documentation

- [RNASeqRData: RNASeqR vignette sample data explanation](./references/RNASeqRData.md)