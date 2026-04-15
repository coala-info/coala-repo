---
name: fastqmetrics
description: fastqmetrics generates detailed per-read length and quality statistics from sequencing data. Use when user asks to extract read-level metrics, calculate average or median quality scores, or generate a tab-separated report of FASTQ statistics.
homepage: https://github.com/wdecoster/fastqmetrics
metadata:
  docker_image: "quay.io/biocontainers/fastqmetrics:0.1.0--py36_1"
---

# fastqmetrics

## Overview
`fastqmetrics` is a lightweight bioinformatics utility designed to generate detailed per-read statistics from sequencing data. While many tools provide aggregate summaries of a library, `fastqmetrics` produces a granular, tab-separated report containing the specific length and quality metrics for every individual read. It is optimized for efficiency, supporting multithreaded processing and native streaming of compressed files to minimize memory overhead and storage requirements.

## Installation
The tool can be installed via Conda or Pip:
- `conda install bioconda::fastqmetrics`
- `pip install fastqmetrics`

## Usage Patterns

### Basic Metric Extraction
To process a standard FASTQ file and save the results to a tab-separated file:
`fastqmetrics input.fastq > metrics.tsv`

### Processing Compressed Data
The tool natively supports gzipped files, allowing you to analyze compressed data directly:
`fastqmetrics reads.fastq.gz > metrics.tsv`

### High-Performance Execution
For large datasets, use the `--threads` (or `-t`) flag to enable parallel processing:
`fastqmetrics --threads 12 input.fastq.gz > metrics.tsv`

## Output Format
The tool generates a tab-separated (TSV) output with four columns:
1. **Read Name**: The identifier from the FASTQ header.
2. **Read Length**: The number of bases in the sequence.
3. **Average Read Quality**: The mean Phred quality score.
4. **Median Read Quality**: The median Phred quality score.

## Expert Tips and Best Practices
- **Stream Processing**: Because `fastqmetrics` writes to standard output, it is highly effective in piped workflows. You can pipe the output directly into filtering tools like `awk` to identify reads below a certain quality threshold without creating intermediate files.
- **Resource Management**: When running in a cluster environment (e.g., SLURM or SGE), ensure the value passed to `--threads` matches the number of CPU cores requested in your job submission to prevent resource contention.
- **Quality Control**: Use the median quality score column for a more robust measure of read quality in datasets with highly variable quality at the ends of reads (common in Nanopore or older Illumina runs), as the median is less sensitive to outliers than the average.

## Reference documentation
- [fastqmetrics Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastqmetrics_overview.md)
- [fastqmetrics GitHub Repository](./references/github_com_wdecoster_fastqmetrics.md)