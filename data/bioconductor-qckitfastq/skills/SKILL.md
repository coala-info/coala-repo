---
name: bioconductor-qckitfastq
description: This tool provides comprehensive quality control and metric analysis for FASTQ sequencing files within an R environment. Use when user asks to perform FASTQ quality assessment, generate QC reports, analyze GC content, or identify adapter contamination and overrepresented sequences.
homepage: https://bioconductor.org/packages/release/bioc/html/qckitfastq.html
---

# bioconductor-qckitfastq

name: bioconductor-qckitfastq
description: Comprehensive quality control for FASTQ files using the qckitfastq Bioconductor package. Use this skill when an AI agent needs to perform FASTQ quality assessment, generate QC reports, or analyze sequencing metrics like base quality, GC content, overrepresented sequences, and adapter contamination within an R environment.

# bioconductor-qckitfastq

## Overview
`qckitfastq` is an R package designed for fast and efficient quality control of FASTQ files. It provides a suite of tools to assess sequencing data quality, offering both high-level summary reports and granular access to specific metrics such as per-base quality, GC content, and k-mer overrepresentation.

## Core Workflow

1.  **Load the Library**:
    ```r
    library(qckitfastq)
    ```

2.  **Execute Comprehensive QC**:
    Use `run_all` to generate a complete set of QC metrics and save them to a specified directory.
    ```r
    run_all(fastq_path = "path/to/file.fastq.gz", output_dir = "qc_results")
    ```

3.  **Individual Metric Analysis**:
    If a full report is not needed, call specific functions to retrieve data frames for further analysis.

## Key Functions

### Data Loading and Summary
*   `read_fastq()`: Reads a FASTQ file into a specialized object for processing.
*   `seq_len_distribution()`: Calculates the distribution of read lengths.

### Quality Metrics
*   `per_base_quality()`: Returns a data frame containing quality score statistics for each position across all reads.
*   `per_read_quality()`: Calculates the average quality score for each individual read.
*   `qual_score_per_base()`: Specifically focuses on the distribution of quality scores per base position.

### Sequence Content
*   `gc_content()`: Computes the GC content percentage for each read.
*   `per_base_sequence_content()`: Analyzes the proportion of A, T, C, and G at each position.
*   `overrepresented_sequences()`: Identifies sequences that appear more frequently than expected.
*   `overrepresented_kmer()`: Detects overrepresented k-mers (default k=6) within the reads.

### Contamination and Artifacts
*   `adapter_content()`: Checks for the presence of common sequencing adapters.
*   `read_duplication_level()`: Estimates the level of duplicated reads in the library.

## Usage Examples

### Running a specific QC metric
To analyze GC content and visualize it:
```r
gc_res <- gc_content("sample.fastq.gz")
# gc_res contains a data frame with read-level GC percentages
hist(gc_res$gc_content, main="GC Content Distribution", xlab="GC %")
```

### Extracting Per-Base Quality
To identify where quality drops off in a sequencing run:
```r
base_qual <- per_base_quality("sample.fastq.gz")
# base_qual provides mean, median, and quantiles for each position
```

## Tips for Efficient Usage
*   **Compressed Files**: `qckitfastq` natively supports `.fastq.gz` files; there is no need to decompress them manually.
*   **Large Datasets**: For very large files, use the individual functions rather than `run_all` if you only need specific metrics, as this saves memory and processing time.
*   **Integration**: The output of most functions is a standard R `data.frame`, making it easy to pipe results into `ggplot2` for custom visualizations.

## Reference documentation
- [qckitfastq Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/qckitfastq.html)