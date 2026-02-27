---
name: bioconductor-rqc
description: bioconductor-rqc performs quality control and assessment of high-throughput sequencing data from FASTQ files. Use when user asks to generate quality reports, visualize cycle-specific statistics like GC content and base calls, or perform parallelized quality assessment on sequencing batches.
homepage: https://bioconductor.org/packages/release/bioc/html/Rqc.html
---


# bioconductor-rqc

name: bioconductor-rqc
description: Quality control and assessment of high-throughput sequencing data (FASTQ files). Use this skill to generate quality reports, visualize cycle-specific statistics (GC content, base calls, quality scores), and perform parallelized QA on sequencing batches.

# bioconductor-rqc

## Overview

The `Rqc` package is an optimized tool for the quality control (QC) of high-throughput sequencing data. It processes FASTQ files (including compressed `.gz` files) to produce high-resolution graphics and HTML reports. It is designed for simplicity, offering a one-function interface for standard workflows while allowing granular access to underlying statistics for custom analysis.

## Basic Workflow

The simplest way to use `Rqc` is the `rqc()` function, which automates file processing and report generation.

```r
library(Rqc)

# 1. Define the directory and file pattern
folder <- "path/to/fastq/files"
pattern <- ".fastq.gz"

# 2. Run the full QA and generate an HTML report
# By default, it samples 1 million reads per file
rqc(path = folder, pattern = pattern, sample = TRUE, n = 1e6)
```

## Advanced Workflow

For more control, or to work with the data objects directly in R without immediately opening a browser, use the step-by-step approach.

### 1. Processing Files
Use `rqcQA` to process files and return an `RqcResultSet` object.

```r
# List specific files
files <- c("sample1_R1.fastq.gz", "sample1_R2.fastq.gz")

# Process files (workers = 1 for serial, or set for parallel processing)
qa <- rqcQA(files, workers = 4)
```

### 2. Generating Reports
If you have an existing `qa` object, you can generate the report later.

```r
reportFile <- rqcReport(qa, outdir = "QC_Reports")
```

### 3. Accessing Statistics
The `qa` object is a list of `RqcResultSet` objects. You can extract data frames for custom plotting.

```r
# Get file information table
info <- perFileInformation(qa)

# Calculate cycle-specific average quality data frame
df_qual <- rqcCycleAverageQualityCalc(qa)
```

## Visualization Functions

`Rqc` provides several functions to visualize specific aspects of the sequencing data. These functions typically take the `qa` object as input:

*   **Quality Distribution**: `rqcReadQualityBoxPlot(qa)` or `rqcReadQualityPlot(qa)`
*   **Cycle-specific Quality**: `rqcCycleAverageQualityPlot(qa)` or `rqcCycleQualityPlot(qa)` (bar plot)
*   **Base Composition**: `rqcCycleBaseCallsPlot(qa)` or `rqcCycleGCPlot(qa)`
*   **Read Length**: `rqcReadWidthPlot(qa)`
*   **Read Frequency**: `rqcReadFrequencyPlot(qa)`
*   **PCA**: `rqcCycleAverageQualityPcaPlot(qa)` to identify outlier files based on quality profiles.

## Tips and Best Practices

*   **Sampling**: By default, `rqc` samples 1 million reads. For a complete analysis of the entire file, set `sample = FALSE`.
*   **Parallelization**: `Rqc` uses `BiocParallel`. Use the `workers` argument in `rqc` or `rqcQA` to speed up processing of multiple files.
*   **Custom Templates**: You can provide your own R Markdown template to `rqcReport(qa, templateFile = "my_template.Rmd")` to customize the output.
*   **Subsetting**: You can run plots on a subset of your samples by subsetting the list: `rqcCycleQualityPlot(qa[1:2])`.

## Reference documentation

- [Rqc - Quality Control Tool for High-Throughput Sequencing Data](./references/Rqc.Rmd)
- [Rqc - Quality Control Tool for High-Throughput Sequencing Data](./references/Rqc.md)