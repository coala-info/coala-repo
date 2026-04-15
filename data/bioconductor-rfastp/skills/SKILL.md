---
name: bioconductor-rfastp
description: Rfastp provides an R interface to the fastp C++ toolkit for high-speed FASTQ data preprocessing and quality control. Use when user asks to perform quality filtering, trim adapters, handle UMIs, merge paired-end reads, or generate sequencing quality reports.
homepage: https://bioconductor.org/packages/release/bioc/html/Rfastp.html
---

# bioconductor-rfastp

## Overview

`Rfastp` is an R interface to the `fastp` C++ toolkit. It provides a comprehensive solution for FASTQ data preprocessing, including quality filtering, adapter trimming, polyG tail trimming, and UMI (Unique Molecular Identifier) handling. It is significantly faster than many traditional tools and generates both R-based reports (data frames and ggplot2 objects) and standard JSON/HTML reports.

## Core Workflow

### 1. Basic Quality Control
The primary function is `rfastp()`. It accepts file paths and returns a list containing the JSON report data.

```r
library(Rfastp)

# Single-end QC
se_report <- rfastp(
    read1 = "sample_R1.fastq.gz",
    outputFastq = "trimmed_se",
    thread = 4
)

# Paired-end QC
pe_report <- rfastp(
    read1 = "sample_R1.fastq.gz",
    read2 = "sample_R2.fastq.gz",
    outputFastq = "trimmed_pe"
)
```

### 2. Advanced Trimming and Merging
You can customize trimming thresholds and merge overlapping paired-end reads into single longer reads.

```r
# Merging paired-end reads
merged_report <- rfastp(
    read1 = "R1.fq.gz", 
    read2 = "R2.fq.gz",
    merge = TRUE,
    outputFastq = "unpaired_output",
    mergeOut = "merged_output.fastq.gz"
)

# Custom quality filtering
custom_report <- rfastp(
    read1 = "sample.fq.gz",
    outputFastq = "custom_out",
    cutLowQualFront = TRUE,
    cutFrontWindowSize = 20,
    cutFrontMeanQual = 20,
    adapterSequenceRead1 = "AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC"
)
```

### 3. UMI Processing
`Rfastp` can extract UMIs and append them to the read identifier.

```r
umi_report <- rfastp(
    read1 = "R1.fq.gz", 
    read2 = "R2.fq.gz",
    umi = TRUE,
    umiLoc = "read1",
    umiLength = 16,
    umiPrefix = "UMI"
)
```

### 4. Handling Multiple Files
If a sample is split across multiple lanes, pass a character vector to `read1` and `read2`. `Rfastp` will concatenate them automatically before processing.

```r
r1_files <- c("lane1_R1.fq.gz", "lane2_R1.fq.gz")
r2_files <- c("lane1_R2.fq.gz", "lane2_R2.fq.gz")

combined_report <- rfastp(read1 = r1_files, read2 = r2_files, outputFastq = "combined")
```

## Reporting and Visualization

After running `rfastp()`, use helper functions to extract data for downstream analysis or visualization.

*   **Summary Statistics**: `qcSummary(report_object)` returns a data frame of total reads, bases, and GC content.
*   **Trimming Statistics**: `trimSummary(report_object)` provides details on filtered reads and adapter trimming.
*   **Plotting**: `curvePlot(report_object, curve = "content_curves")` generates ggplot2 objects for Base Quality or GC Content.

## Tips
*   **Threads**: Always set the `thread` parameter (default is 1) to take advantage of multi-core processors.
*   **Memory**: Since `Rfastp` wraps a C++ executable, it is memory efficient, but ensure your R session has permissions to write to the `outputFastq` path.
*   **File Concatenation**: Use `catfastq()` if you only need to merge files without performing QC.

## Reference documentation
- [Rfastp](./references/Rfastp.md)