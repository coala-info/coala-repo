---
name: nanopack
description: NanoPack is a toolkit for processing, filtering, and visualizing long-read sequencing data from fastq, BAM, or summary files. Use when user asks to generate quality control plots, filter or trim reads, compare multiple sequencing runs, or calculate summary statistics for long-read datasets.
homepage: https://github.com/wdecoster/nanopack
---


# nanopack

---

## Overview
NanoPack is a specialized toolkit designed to handle the specific requirements of long-read sequencing datasets. It transforms raw data (fastq), alignments (BAM/CRAM), and summary files into actionable insights through high-quality visualizations and high-performance filtering. Use this skill to determine the appropriate tool for specific bioinformatic tasks, such as assessing run quality, removing low-quality reads, or comparing performance across different flow cells.

## Tool Selection Guide

The NanoPack suite consists of several specialized tools. Choose the tool based on your specific objective:

*   **NanoPlot**: The primary tool for generating comprehensive plots (histograms, scatter plots, heatmaps) and statistical summaries from reads or alignments.
*   **NanoComp**: Used for comparative analysis. It generates overlapping plots to compare read length and quality across multiple samples or runs.
*   **chopper**: The modern, high-performance Rust implementation for filtering and trimming. Use this instead of the deprecated `NanoFilt` or `NanoLyse`.
*   **Cramino**: A fast Rust-based tool for quick summary statistics of BAM or CRAM files. Use this as a faster alternative to `NanoStat`.
*   **NanoQC**: Focuses on the beginning and end of reads to investigate nucleotide composition and quality distribution.
*   **kyber**: Provides a minimalist, standardized impression of a BAM/CRAM file.

## Common CLI Patterns

### Quality Control and Visualization
Generate a standard QC report from a fastq file:
`NanoPlot --fastq reads.fastq.gz --output dir_name`

Generate plots from a BAM file using a specific plot type (e.g., hex bin):
`NanoPlot --bam alignment.bam --plots hex --title "Sample A Analysis"`

### Filtering and Trimming
Filter reads for a minimum quality of Q10 and a minimum length of 500bp using `chopper`:
`gunzip -c reads.fastq.gz | chopper -q 10 -l 500 | gzip > filtered_reads.fastq.gz`

Trim 10 nucleotides from the start of every read:
`chopper --headcrop 10 < input.fastq > trimmed.fastq`

### Comparative Analysis
Compare multiple fastq files to evaluate different library preps:
`NanoComp --fastq sample1.fastq sample2.fastq --names control treatment`

### Fast Statistics
Get a quick summary of an alignment file:
`cramino alignment.bam`

## Expert Tips

*   **Prefer Rust Tools**: Always use `chopper` and `cramino` over the older Python-based `NanoFilt`, `NanoLyse`, and `NanoStat`. The Rust implementations are significantly faster and more memory-efficient, especially for large datasets.
*   **Parallelization**: `NanoPlot` and `NanoComp` support the `--threads` argument. Use it to speed up processing on multi-core systems.
*   **Memory Management**: When working with extremely large BAM files in `NanoPlot`, consider using the `--downsample` flag to reduce memory usage while maintaining a representative visualization.
*   **Streaming Workflows**: `chopper` is designed to work in a pipe. You can chain it with other tools (like `minimap2`) to filter reads on-the-fly without writing intermediate large files to disk.
*   **Input Flexibility**: Most NanoPack tools can accept multiple input formats simultaneously (e.g., a mix of fastq and BAM) to aggregate data for a single report.

## Reference documentation
- [nanopack - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_nanopack_overview.md)
- [GitHub - wdecoster/nanopack: An overview of all nanopack tools](./references/github_com_wdecoster_nanopack.md)