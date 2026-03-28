---
name: methylpy
description: Methylpy is a high-performance pipeline for the end-to-end analysis of DNA methylation data, including alignment and methylation calling. Use when user asks to build bisulfite-converted reference indices, process raw sequencing reads into methylation calls, or identify differentially methylated regions.
homepage: https://github.com/yupenghe/methylpy
---


# methylpy

## Overview
Methylpy is a high-performance Python pipeline designed for the end-to-end analysis of DNA methylation data. It excels at transforming raw sequencing reads into methylation callouts and provides a robust statistical framework for identifying differentially methylated regions (DMRs) at single-cytosine resolution. It supports both bulk and single-cell data, handles various aligners (Bowtie, Bowtie2, Minimap2), and includes specialized support for NOMe-seq (nucleosome occupancy and methylome sequencing) to readout open chromatin states.

## Common CLI Patterns and Workflows

### 1. Reference Genome Preparation
Before alignment, you must build a bisulfite-converted reference index.
```bash
# For Bowtie2 (Standard)
methylpy build-reference \
    --fasta genome.fa \
    --output-prefix genome_prefix \
    --aligner bowtie2

# For Minimap2 (Recommended for v1.3+)
methylpy build-reference \
    --fasta genome.fa \
    --output-prefix genome_prefix \
    --aligner minimap2
```

### 2. Processing Raw Reads (FASTQ to Methylation Calls)
Methylpy can handle the entire pipeline including trimming, alignment, and duplicate removal.
```bash
# Paired-end pipeline example
methylpy paired-end-pipeline \
    --read1 sample_R1.fastq.gz \
    --read2 sample_R2.fastq.gz \
    --sample sample_name \
    --forward-ref genome_prefix_f \
    --reverse-ref genome_prefix_r \
    --aligner bowtie2 \
    --trim-reads \
    --remove-pcr-duplicates \
    --picard-path /path/to/picard.jar
```

### 3. Differential Methylation Region (DMR) Calling
DMR calling identifies significant differences in methylation levels across two or more samples.
```bash
methylpy DMRfind \
    --allc-files sample1_allc.tsv sample2_allc.tsv \
    --samples sample1 sample2 \
    --mc-type CGN \
    --output-prefix study_dmrs \
    --num-procs 8
```

## Expert Tips and Best Practices

*   **Temporary Storage**: Methylpy generates large intermediate files. Always set the `TMPDIR` environment variable to a high-capacity disk (e.g., `export TMPDIR=/large/scratch/dir`) to avoid "disk full" errors in `/tmp`.
*   **Cytosine Masking**: Methylpy only processes cytosines that are **uppercase** in the reference FASTA file. Ensure your genome is not soft-masked (lowercase) if you want to analyze those regions.
*   **Aligner Selection**: Starting with version 1.3, use `--aligner` instead of the deprecated `--bowtie2` flag. Minimap2 is often faster for long reads or specific bisulfite contexts.
*   **DMR Requirements**: DMR calling requires the `run_rms_tests.out` executable. If you encounter errors during `DMRfind`, ensure this C++ component is compiled (using `g++` and `GSL` libraries) and located in the methylpy installation directory.
*   **NOMe-seq**: For NOMe-seq data, use the pipeline to generate readouts for both endogenous methylation (usually CpG) and GpC methyltransferase-induced methylation to map open chromatin.
*   **Low Coverage Handling**: When dealing with low-coverage data, use the feature in `DMRfind` that combines data from adjacent cytosines to increase statistical power.



## Subcommands

| Command | Description |
|---------|-------------|
| DMRfind | Find differentially methylated regions (DMRs) from ALLC files. |
| add-methylation-level | Add methylation level information to genomic intervals in a TSV file using ALLC files. |
| allc-to-bigwig | Convert allc file to bigwig format |
| bam-quality-filter | Filter BAM files based on mapping quality and mCH levels. |
| build-reference | Build reference files for methylpy using specified aligners. |
| call-methylation-state | Call methylation state from BAM files containing mapped bisulfite sequencing reads. |
| filter-allc | Filter allc files based on coverage, mismatch, and sequence context. |
| index-allc | Index ALLC files for faster access. |
| merge-allc | Merge multiple allc files into a single allc file. |
| paired-end-pipeline | Methylpy pipeline for processing paired-end bisulfite sequencing data, including alignment and methylation calling. |
| single-end-pipeline | Methylpy pipeline for single-end bisulfite sequencing data, including read alignment and methylation calling. |
| test-allc | Test allc file for significant methylation sites, estimating non-conversion rates from controls. |

## Reference documentation
- [Methylpy GitHub Repository](./references/github_com_yupenghe_methylpy.md)
- [Methylpy README and Installation](./references/github_com_yupenghe_methylpy_blob_methylpy_README.md)
- [Methylpy Docker Configuration](./references/github_com_yupenghe_methylpy_blob_methylpy_Dockerfile.md)