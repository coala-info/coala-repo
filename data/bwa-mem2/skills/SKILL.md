---
name: bwa-mem2
description: bwa-mem2 is a high-performance tool for aligning DNA sequences against a large reference genome using SIMD parallelization. Use when user asks to index a reference genome, map short-read sequencing data, or perform fast sequence alignment.
homepage: https://github.com/bwa-mem2/bwa-mem2
---


# bwa-mem2

## Overview

bwa-mem2 is the high-performance successor to the widely used bwa-mem algorithm. It is designed to produce alignment results identical to bwa-mem 0.7.17 but at significantly higher speeds (typically 1.3x to 3.1x faster) by leveraging SIMD (Single Instruction, Multiple Data) parallelization. It is the tool of choice for genomic pipelines requiring efficient mapping of short-read sequencing data to large reference genomes like the human genome.

## Installation

The most efficient way to use bwa-mem2 is via precompiled binaries or Conda:

```bash
# Via Bioconda
conda install bioconda::bwa-mem2

# Via precompiled binaries (recommended for Intel/AMD performance)
curl -L https://github.com/bwa-mem2/bwa-mem2/releases/download/v2.2.1/bwa-mem2-2.2.1_x64-linux.tar.bz2 | tar jxf -
```

## Core Workflow

### 1. Indexing the Reference
Before mapping, you must build an index for your reference genome. 
**Warning:** This process is memory-intensive, requiring approximately 28 GB of RAM per 1 GB of reference sequence.

```bash
bwa-mem2 index -p <prefix_name> <reference.fasta>
```
*   If `-p` is omitted, the fasta filename is used as the prefix.
*   For the human genome (~3GB), ensure at least 84GB of RAM is available during indexing.

### 2. Mapping Reads
Map single-end or paired-end reads to the indexed reference.

```bash
# Paired-end mapping with 16 threads
bwa-mem2 mem -t 16 <prefix_name> <reads_1.fastq> <reads_2.fastq> > out.sam
```

## Expert Tips and Best Practices

### Performance Optimization
*   **SIMD Support:** bwa-mem2 automatically detects the highest SIMD instruction set (SSE4.1, AVX2, or AVX-512) supported by your CPU. Use the multi-target binary for automatic dispatch.
*   **Threading:** Use the `-t` flag to match the number of available physical CPU cores.
*   **NUMA Awareness:** On multi-socket systems, use `numactl` to bind the process to a specific memory node to avoid cross-socket latency:
    ```bash
    numactl -m 0 -C 0-27 ./bwa-mem2 mem -t 28 <prefix> <reads.fq> > out.sam
    ```

### Memory Management
*   **Index Size:** The modern index (v2.1+) is significantly smaller than earlier versions (~10GB for human genome on disk and in memory). If you have an index created before October 2020, you must rebuild it.
*   **Piping to Samtools:** To save disk space and I/O time, pipe the SAM output directly to `samtools` for BAM conversion:
    ```bash
    bwa-mem2 mem -t 16 <prefix> <r1.fq> <r2.fq> | samtools view -bS - > out.bam
    ```

### Advanced Variants
*   **LISA Seeding:** For even faster seeding (up to 4.5x faster seeding phase), consider the `bwa-mem2-lisa` branch, though it requires a larger index (~120GB for human).
*   **ERT:** The `ert` branch uses Enumerated Radix Trees for a 10-30% speedup over vanilla bwa-mem2. Use the `-K 1000000` flag with ERT for best results.

## Reference documentation
- [bwa-mem2 Overview](./references/anaconda_org_channels_bioconda_packages_bwa-mem2_overview.md)
- [bwa-mem2 GitHub Repository](./references/github_com_bwa-mem2_bwa-mem2.md)