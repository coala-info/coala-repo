---
name: fastplong
description: fastplong is a high-performance tool designed for quality control, filtering, and adapter trimming of long-read sequencing data. Use when user asks to filter reads by quality or length, trim adapter sequences, remove low complexity reads, or generate sequencing quality reports.
homepage: https://github.com/OpenGene/fastplong
---


# fastplong

## Overview
fastplong is a high-performance C++ tool designed specifically for the unique characteristics of long-read sequencing data. Unlike its predecessor `fastp` (which targets short reads), fastplong handles the high error rates and variable lengths of long reads with specialized algorithms for adapter detection, quality-based cutting, and complexity filtering. Use this skill to optimize the "clean-up" phase of genomic workflows before assembly or alignment.

## Basic Usage
The simplest command performs quality and length filtering with default parameters and generates reports:
```bash
fastplong -i input.fastq.gz -o output.fastq.gz
```
*   **Reports**: Defaults to `fastplong.html` and `fastplong.json`. Customize with `-h` and `-j`.
*   **Compression**: Automatically detects `.gz` extensions for both input and output.

## Filtering Strategies

### Quality Filtering
Quality filtering is enabled by default.
*   **Phred Threshold**: Set the minimum qualified quality score (default 15) with `-q`.
*   **Unqualified Percentage**: Set the maximum allowed percentage of unqualified bases (default 40%) with `-u`.
*   **Mean Quality**: Discard reads with an average quality below a threshold using `-m` (e.g., `-m 10`).
*   **Disable**: Use `-Q` to skip quality filtering entirely.

### Length Filtering
*   **Minimum Length**: Set with `-l` (default is 20bp).
*   **Maximum Length**: Use `--length_limit` to discard extremely long reads that might be artifacts.
*   **Disable**: Use `-L` to skip length filtering.

### Low Complexity Filtering
Useful for removing reads dominated by repetitive sequences or homopolymers.
*   **Enable**: Use `-y` or `--low_complexity_filter`.
*   **Threshold**: Adjust the complexity threshold with `-Y` (default 30%).

## Adapter Trimming
fastplong can trim adapters from the start and end of reads.
*   **Manual Sequences**: Specify `-s` for start and `-e` for end adapters.
*   **Automatic Reverse Complement**: If only `-s` is provided, the tool automatically uses its reverse complement for the end adapter.
*   **FASTA Input**: Use `-a` to provide a file containing multiple adapter sequences.
*   **Disable**: Use `-A` to skip adapter trimming.

## Advanced Workflow Patterns

### Streaming and Integration
To integrate fastplong into a pipeline without writing intermediate files:
```bash
# Read from STDIN and pipe to minimap2
cat input.fq | fastplong --stdin --stdout | minimap2 -ax map-ont ref.fa -
```

### Handling Failed Reads
To inspect why reads are being filtered out, redirect them to a separate file:
```bash
fastplong -i in.fq -o out.fq --failed_out failed.fq
```
*Note: The reason for failure (e.g., `failed_quality_filter`) is appended to the read name in the failed file.*

### Parallel Processing and Splitting
For large datasets, you can split the output into multiple files to parallelize downstream analysis:
*   **By File Number**: `--split_by_lines 1000000` (splits every 1M lines).
*   **By File Count**: `--split 10` (splits into 10 roughly equal files).

### Batch Processing
fastplong supports processing all files in a directory. Ensure your input and output paths are directories when using batch mode.

## Expert Tips
*   **Preview Mode**: Use `--reads_to_process 100000` to generate a QC report on a subset of data quickly.
*   **Safety**: Use `--dont_overwrite` in production scripts to prevent accidental data loss if output files already exist.
*   **N-Masking**: If you prefer to keep reads but mask low-quality regions, use `--mask_low_quality` to convert those bases to `N`.

## Reference documentation
- [fastplong GitHub README](./references/github_com_OpenGene_fastplong.md)
- [fastplong Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastplong_overview.md)