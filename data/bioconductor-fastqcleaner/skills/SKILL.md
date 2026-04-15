---
name: bioconductor-fastqcleaner
description: FastqCleaner performs quality control and pre-processing of FASTQ files through an interactive interface or programmatic R functions. Use when user asks to filter low-quality reads, remove adapters, trim sequences, eliminate low-complexity reads, or remove duplicates from NGS data.
homepage: https://bioconductor.org/packages/release/bioc/html/FastqCleaner.html
---

# bioconductor-fastqcleaner

name: bioconductor-fastqcleaner
description: Quality control and pre-processing of FASTQ files using FastqCleaner. Use when you need to filter, trim, or analyze the quality of single-end or paired-end NGS reads in R. This skill supports operations like adapter removal, low-complexity filtering, N-base removal, and quality-based trimming.

# bioconductor-fastqcleaner

## Overview

FastqCleaner is a Bioconductor package designed for the quality control and pre-processing of FASTQ files. It provides both an interactive Shiny application and a suite of R functions for programmatic sequence cleaning. The package is particularly useful for removing adapters, filtering low-quality reads, and eliminating low-complexity sequences or duplicates before downstream analysis.

## Interactive Usage

To launch the interactive web-based interface for point-and-click processing:

```r
library(FastqCleaner)
launch_fqc()
```

## Programmatic Workflow

Most functions in FastqCleaner operate on `ShortReadQ` objects from the `ShortRead` package.

### 1. Loading Data
```r
library(ShortRead)
library(FastqCleaner)

# Read a FASTQ file
fq <- readFastq("path/to/file.fastq.gz")
```

### 2. Quality Filtering and Trimming
Apply specific filters to the `ShortReadQ` object. Each function returns a filtered `ShortReadQ` object.

*   **Filter by Ns**: Remove reads with more than `rm.N` ambiguous bases.
    ```r
    fq_filtered <- n_filter(fq, rm.N = 0)
    ```
*   **Filter by Quality**: Remove reads with average Phred score below `minq`.
    ```r
    fq_filtered <- qmean_filter(fq, minq = 30)
    ```
*   **Trim 3' Tails**: Remove 3' bases with quality below `rm.3qual`.
    ```r
    fq_trimmed <- trim3q_filter(fq, rm.3qual = 20)
    ```
*   **Fixed Trimming**: Remove a set number of bases from either end.
    ```r
    fq_trimmed <- fixed_filter(fq, trim5 = 5, trim3 = 5)
    ```

### 3. Sequence Content Filtering
*   **Adapter Removal**: Remove 3' (`Rpattern`) or 5' (`Lpattern`) adapters.
    ```r
    fq_no_adapter <- adapter_filter(fq, Rpattern = "AGATCGGAAGAG")
    ```
*   **Complexity Filter**: Remove low-complexity sequences (e.g., poly-N or simple repeats) based on Shannon entropy.
    ```r
    fq_complex <- complex_filter(fq, threshold = 0.5)
    ```
*   **Length Filter**: Keep reads within a specific length range.
    ```r
    fq_len <- length_filter(fq, rm.min = 50, rm.max = 150)
    ```
*   **Unique Filter**: Remove duplicated sequences.
    ```r
    fq_unique <- unique_filter(fq)
    ```

### 4. Utility Functions
*   **Check Encoding**: Identify the Phred quality encoding (Sanger, Illumina, etc.).
    ```r
    check_encoding(fq)
    ```
*   **Generate Mock Data**: Useful for testing workflows.
    ```r
    # Create 10 random sequences of length 50
    s <- random_seq(10, 50)
    # Create random qualities
    q <- random_qual(10, 50, encod = "Sanger")
    ```

## Best Practices
*   **Order of Operations**: Generally, perform fixed trimming and adapter removal first, followed by quality filtering, and finally length filtering.
*   **Memory Management**: For very large files, process data in chunks using the `ShortRead` iteration framework or use the interactive app which handles chunking automatically.
*   **Paired-end Data**: When processing paired-end data programmatically, ensure you apply the same filtering logic to both R1 and R2 to maintain read pair synchrony, or use the interactive app which handles paired-end synchronization.

## Reference documentation

- [Overview](./references/Overview.md)