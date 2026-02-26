---
name: bwa-meme
description: BWA-MEME is a performance-optimized DNA sequence aligner that uses learned-indexes to accelerate the mapping of reads to a reference genome. Use when user asks to index a reference genome with a machine learning model, train a P-RMI index, or perform high-speed sequence alignment.
homepage: https://github.com/kaist-ina/BWA-MEME
---


# bwa-meme

## Overview

BWA-MEME is a performance-optimized version of BWA-MEM2 that utilizes a machine learning approach (learned-indexes) to accelerate DNA sequence alignment. It is designed to be a drop-in replacement for BWA-MEM2, producing identical SAM output while achieving up to 3.32x faster seeding and 1.4x higher overall alignment throughput. 

Use this skill to guide the multi-step process of indexing reference genomes, training the P-RMI (Recursive Model Index), and executing high-speed alignments. It is particularly useful for large-scale genomic studies where CPU efficiency and cost-effectiveness are priorities.

## Installation and Setup

The most efficient way to deploy bwa-meme is via Bioconda:

```bash
conda install -c conda-forge -c bioconda bwa-meme
```

## Core Workflow

### 1. Indexing the Reference
Unlike standard BWA, BWA-MEME requires a specific index type (`-a meme`).

```bash
# Recommended: Use at least 8-32 threads for human genome
bwa-meme index -a meme <reference.fasta> -t <threads>
```

### 2. Training the Learned-Index (P-RMI)
After indexing, you must train the P-RMI model. This step requires the suffix array generated in the previous step.

```bash
# Takes ~15 minutes for a human genome
build_rmis_dna.sh <reference.fasta>
```

### 3. Running Alignment
To enable the learned-index acceleration, you **must** include the `-7` flag.

```bash
bwa-meme mem -7 -t <threads> -Y -K 100000000 <reference.fasta> <reads_1.fastq> <reads_2.fastq> -o <output.sam>
```

## Expert Tips and Best Practices

### Memory Mode Selection
BWA-MEME can be compiled or executed in different modes to match available system memory. If the binary supports it, you can choose specific modes:
- **Mode 1**: ~38GB RAM (Minimal acceleration).
- **Mode 2**: ~88GB RAM.
- **Mode 3**: ~118GB RAM (Maximum acceleration/Fastest).

### Handling Samtools Bottlenecks
Because BWA-MEME aligns sequences faster than standard tools, the bottleneck often shifts to `samtools sort`. To mitigate this:
- Use `mbuffer` in your pipe to prevent CPU waste.
- Set the `mbuffer` size to match the total memory allocated to samtools (e.g., if using `samtools sort -@ 20 -m 1G`, use a 20G mbuffer).

### Performance Tuning
- **SIMD Support**: The `bwa-meme` binary automatically detects and utilizes the highest available SIMD instructions (SSE, AVX2, AVX512). Ensure your execution environment matches the build environment for optimal performance.
- **Memory Allocation**: For Whole Genome Sequencing (WGS) on human genomes with full acceleration (>32 threads), 140GB–192GB of RAM is recommended to prevent swapping.
- **Library Optimization**: Use the `mimalloc` library (usually enabled by default in the Makefile) to improve memory allocation performance in multi-threaded runs.

## Reference documentation
- [BWA-MEME GitHub Repository](./references/github_com_kaist-ina_BWA-MEME.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bwa-meme_overview.md)