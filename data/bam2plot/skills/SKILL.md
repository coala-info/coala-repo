---
name: bam2plot
description: "bam2plot generates publication-quality depth visualizations and HTML reports from sequence alignment data or raw reads. Use when user asks to visualize BAM coverage, generate coverage plots from FASTQ files, or analyze reference GC content."
homepage: https://github.com/willros/bam2plot
---

# bam2plot

## Overview

bam2plot is a high-performance bioinformatics tool designed to transform sequence alignment data into intuitive, publication-quality visualizations. Unlike general-purpose tools, it specializes in "three-color" depth visualization—highlighting regions with zero coverage, low coverage (below a user-defined threshold), and sufficient coverage. It provides a standalone HTML report that aggregates global and per-reference statistics, making it an ideal choice for rapid QC of whole-genome or targeted sequencing runs.

## Core Workflows

### 1. Generating Plots from BAM Files
The `from_bam` command is the primary entry point for existing alignments. It automatically handles depth computation using a parallel sweep-line algorithm.

*   **Basic Usage**:
    `bam2plot from_bam -b input.bam -o output_dir -s`
    *   Use `-s` to automatically sort and index the BAM file if not already done.
*   **Customizing Thresholds**:
    `bam2plot from_bam -b input.bam -o output_dir -t 20 -c`
    *   `-t 20`: Sets the "sufficient coverage" threshold to 20X (visualized in blue).
    *   `-c`: Generates cumulative coverage plots.
*   **Regional Zooming**:
    `bam2plot from_bam -b input.bam -o output_dir -z '1000 5000'`
    *   Focuses the visualization on a specific coordinate range.

### 2. Direct Alignment and Plotting
If you have raw FASTQ files and a reference, `from_reads` bypasses the need for manual alignment steps by using an internal minimap2-based aligner.

*   **Long Reads or Single-End**:
    `bam2plot from_reads -r1 reads.fastq -ref reference.fasta -o output_dir`
*   **Paired-End Short Reads**:
    `bam2plot from_reads -r1 R1.fastq -r2 R2.fastq -ref reference.fasta -o output_dir`
*   **GC Content Overlay**:
    `bam2plot from_reads -r1 reads.fastq -ref reference.fasta -o output_dir -gc`

### 3. Reference GC Analysis
Use the `guci` command to analyze the GC composition of a reference genome independently of any sequencing data.

*   `bam2plot guci -ref reference.fasta -w 1000 -o output_dir`
    *   `-w 1000`: Sets the rolling window size to 1kb for smoothing the GC curve.

## Expert Tips and Best Practices

*   **Performance Optimization**: For large BAM files, ensure the file is indexed (`.bai`). bam2plot will automatically use multiple threads (up to 4) to process references in parallel when an index is present.
*   **Reference Filtering**: If your BAM contains many small contigs (e.g., unplaced scaffolds), use `-n` to limit the plot to the top $N$ references or `-w` to whitelist specific chromosomes (e.g., `-w chr1,chr2,chrX`).
*   **Smoothing Data**: Adjust the `-r` (rolling window) parameter based on your library type. Use a larger window (e.g., 500-1000) for low-depth WGS to reduce noise, or a smaller window (e.g., 50) for high-depth amplicon sequencing.
*   **Interpreting Uniformity**: Pay close attention to the Lorenz curves in the HTML report. A Gini coefficient closer to 0 indicates perfectly uniform coverage, while values approaching 1 suggest significant capture bias or mapping issues.
*   **Output Formats**: By default, plots are PNG. Use `-p both` to generate both PNG and SVG files if you need vector graphics for publication.



## Subcommands

| Command | Description |
|---------|-------------|
| bam2plot | Plot your bam files! |
| bam2plot | Align your reads and plot the coverage! |
| bam2plot | Plot GC content of your reference fasta! |

## Reference documentation
- [github_com_willros_bam2plot_blob_main_README.md](./references/github_com_willros_bam2plot_blob_main_README.md)
- [github_com_willros_bam2plot_blob_main_BENCHMARKS.md](./references/github_com_willros_bam2plot_blob_main_BENCHMARKS.md)