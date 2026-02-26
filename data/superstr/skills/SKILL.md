---
name: superstr
description: superSTR is an alignment-free bioinformatics utility that identifies reads containing repetitive sequences directly from raw genomic or transcriptomic data. Use when user asks to process raw reads for repeat content, screen for specific repeat motifs, or perform outlier detection to identify repeat expansion disorders.
homepage: https://github.com/bahlolab/superSTR
---


# superstr

## Overview

superSTR is a lightweight, alignment-free bioinformatics utility designed to identify reads containing repetitive sequences directly from raw data. By avoiding the computationally expensive step of sequence alignment, it enables rapid screening of large-scale genomic and transcriptomic datasets. The tool is particularly effective for identifying pathogenic motifs and detecting samples that act as statistical outliers regarding repeat content, which often indicates a repeat expansion disorder.

## Installation

The most efficient way to install superSTR is via Bioconda:

```bash
conda install -c bioconda superstr
```

## Core Workflow and CLI Patterns

The superSTR workflow generally follows a three-step process: processing, screening, and outlier detection.

### 1. Processing Raw Reads
Use the primary `superstr` command to process FASTQ or BAM files. This step identifies reads that contain repeats and generates compressed intermediate files (e.g., `per_read.txt.gz`).

*   **Input types**: Supports short-read WGS, WES, and RNA-seq.
*   **Alignment-free**: You do not need to align your reads to a reference genome before running this.

### 2. Motif Screening
Use `superstr-screen.py` to analyze the processed output for specific repeat motifs.

*   **Common Pattern**:
    ```bash
    superstr-screen.py --input [processed_files] --output [output_directory] --manifest [sample_manifest]
    ```
*   **Note**: Ensure the manifest file correctly maps sample IDs to their respective processed data files.

### 3. Outlier Detection
Use `outliers.py` to compare cases against controls or to find samples with significantly higher repeat counts than the cohort average.

*   **Pathogenic Motifs**: The tool includes specific flags for known pathogenic motifs. For example, the `AAATG` motif is often used in outlier screening for specific neurological disorders.
*   **Standardized Flags**: Recent versions use standardized `--input`, `--output`, and `--manifest` flags across all Python utilities.

## Best Practices and Tips

*   **Resource Management**: While superSTR is "lightweight," processing 80GB+ BAM files can still take several hours. Ensure you have sufficient disk I/O and memory for large-scale batch processing.
*   **Manifest Files**: Always double-check your manifest file formatting. Many execution errors (like "No such file or directory") stem from absolute vs. relative path mismatches in the manifest.
*   **RNA-seq Specifics**: When using RNA-seq data, superSTR is particularly useful for detecting repeats that are expressed in the transcriptome, which can be a faster proxy for identifying expansions than whole-genome analysis.
*   **Downsampling**: For very large cohorts, consider downsampling cases or controls using the internal script options to speed up the bootstrap/statistical phases of outlier detection.

## Reference documentation
- [superSTR Overview](./references/anaconda_org_channels_bioconda_packages_superstr_overview.md)
- [GitHub Repository and Usage](./references/github_com_bahlolab_superSTR.md)
- [Issue Tracker and Troubleshooting](./references/github_com_bahlolab_superSTR_issues.md)