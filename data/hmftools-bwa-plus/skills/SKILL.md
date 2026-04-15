---
name: hmftools-bwa-plus
description: hmftools-bwa-plus is a high-performance sequence alignment tool based on bwa-mem2 that supports coordinate-sorted FASTQ files. Use when user asks to index a reference genome, align sequence reads to a reference, or process coordinate-sorted FASTQ data.
homepage: https://github.com/hartwigmedical/bwa-plus
metadata:
  docker_image: "quay.io/biocontainers/hmftools-bwa-plus:1.0.0--h077b44d_0"
---

# hmftools-bwa-plus

## Overview

`hmftools-bwa-plus` is a high-performance sequence alignment tool based on `bwa-mem2`. It is specifically designed to extend the capabilities of the original Burrows-Wheeler Aligner to support coordinate-sorted FASTQ files, a feature not natively handled by standard `bwa-mem2`. This makes it an essential tool for bioinformatics pipelines where input data may already be ordered, such as the WiGiTS (Whole Genome Sequencing Integrated Tool Set) framework. It functions as a drop-in replacement for BWA MEM while maintaining the performance optimizations (like SIMD utilization) inherited from the `bwa-mem2` codebase.

## Installation

The tool is primarily distributed via Bioconda. To install it in a Linux or macOS environment:

```bash
conda install bioconda::hmftools-bwa-plus
```

## Command Line Usage

The syntax for `bwa-plus` is identical to the original BWA MEM tool.

### 1. Indexing the Reference Genome
Before alignment, you must index the reference FASTA file. Note that `bwa-plus` (like `bwa-mem2`) creates large index files to support faster alignment.

```bash
bwa-plus index reference.fasta
```

### 2. Sequence Alignment (MEM algorithm)
To align paired-end reads to a reference:

```bash
bwa-plus mem -t [threads] reference.fasta read1.fastq.gz read2.fastq.gz > alignment.sam
```

### Common Options
- `-t INT`: Number of threads to use for parallel processing.
- `-R STR`: Complete read group header line (e.g., `'@RG\tID:foo\tSM:bar'`).
- `-p`: Smart pairing (if the input is a single interleaved FASTQ file).
- `-K INT`: Fixed-size chunk for processing (useful for ensuring deterministic output across different thread counts).

## Expert Tips and Best Practices

- **Coordinate-Sorted FASTQs**: Use this tool specifically if your upstream process generates FASTQ files that are already sorted by genomic coordinates. Standard BWA versions may fail or produce unexpected results if they encounter reads in an order they don't expect; `bwa-plus` is patched to handle this logic.
- **Memory Requirements**: Because this tool is based on `bwa-mem2`, the index files are significantly larger than those of the original `bwa`. Ensure your system has sufficient RAM (typically ~30-40GB for a human genome index) to load the index into memory.
- **Piping to SAMtools**: To save disk space and improve efficiency, pipe the output directly to `samtools` for conversion to BAM format:
  ```bash
  bwa-plus mem -t 16 reference.fasta r1.fq r2.fq | samtools view -Sb - > alignment.bam
  ```
- **WiGiTS Integration**: If you are running the Hartwig Medical Foundation's WiGiTS pipeline, ensure `bwa-plus` is in your PATH, as the pipeline expects this specific implementation to handle its data ordering requirements.

## Reference documentation
- [hmftools-bwa-plus Overview](./references/anaconda_org_channels_bioconda_packages_hmftools-bwa-plus_overview.md)
- [bwa-plus GitHub Repository](./references/github_com_hartwigmedical_bwa-plus.md)