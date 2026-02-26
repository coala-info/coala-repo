---
name: squire
description: SQuIRE is a comprehensive pipeline for the locus-specific quantification and differential expression analysis of transposable element expression from RNA-seq data. Use when user asks to download genome-specific repeat data, clean repeat annotations, align reads to transposable elements, quantify specific repeat loci, or perform differential expression analysis of repeats.
homepage: https://github.com/wyang17/SQuIRE
---


# squire

## Overview
SQuIRE (Software for Quantifying Interspersed Repeat Expression) is a comprehensive pipeline designed to provide a locus-specific view of transposable element expression. Unlike tools that aggregate TE counts at the subfamily level, SQuIRE allows researchers to identify which specific genomic instances of a repeat are transcriptionally active. The workflow is divided into preparation (Fetch, Clean), quantification (Map, Count), and analysis (Call, Draw, Seek) stages.

## Installation and Environment
SQuIRE relies on specific versions of bioinformatics tools (STAR 2.5.3a, bedtools 2.25.0, samtools 1.1, stringtie 1.3.3, and DESeq2 1.16.1) and runs on Python 2.7.

```bash
# Recommended installation via mamba
mamba create -n squire -c bioconda squire
conda activate squire
```

## Core Workflow Commands

### 1. Preparation Stage
Before processing samples, you must download genome-specific data and clean the repeat annotations.

*   **Fetch**: Downloads UCSC genome files and generates a STAR index.
    ```bash
    squire Fetch -b hg38 -f -c -r -g -x -p 8
    ```
    *   `-b`: UCSC build (e.g., hg38, mm10).
    *   `-x`: Create STAR index (resource intensive).
    *   `-p`: Number of threads.

*   **Clean**: Filters and collapses overlapping repeats from RepeatMasker.
    ```bash
    squire Clean -b hg38 -c DNA,LTR -o squire_clean_hg38
    ```
    *   `-c`: Comma-separated repeat classes to include (e.g., 'DNA,LTR,SINE').

### 2. Quantification Stage
Align your RNA-seq data and quantify the reads.

*   **Map**: Aligns reads using STAR with parameters optimized for multi-mapping repeats.
    ```bash
    squire Map -1 sample_R1.fastq.gz -2 sample_R2.fastq.gz -o map_output -p 8
    ```

*   **Count**: Assigns reads to specific TE loci using an Expectation-Maximization (EM) algorithm.
    ```bash
    squire Count -m map_output -c squire_clean_hg38 -o count_output -p 8
    ```

### 3. Analysis Stage
*   **Call**: Performs differential expression analysis using DESeq2. Requires a experimental design file.
    ```bash
    squire Call -d design_matrix.txt -o de_results
    ```

## Best Practices and Tips
*   **One-Time Setup**: `Fetch` and `Clean` only need to be run once per genome build. Reuse these outputs for all subsequent samples.
*   **Resource Management**: The `Fetch -x` (indexing) and `Map` steps are memory-intensive. Ensure your environment has at least 32GB of RAM for human/mouse genomes.
*   **Software Compatibility**: If you encounter issues with conda-installed dependencies, use `squire Build -s all` to manually compile compatible versions of STAR, bedtools, and samtools.
*   **Wildcards**: When using `Clean`, you can use UNIX wildcard patterns for repeat classes or families (e.g., `ERV*`).

## Reference documentation
- [SQuIRE GitHub Repository](./references/github_com_wyang17_SQuIRE.md)
- [Bioconda SQuIRE Package](./references/anaconda_org_channels_bioconda_packages_squire_overview.md)