---
name: bwa-meme
description: BWA-MEME is a high-performance genomic alignment tool that uses machine learning emulation to accelerate the seeding phase of sequence mapping. Use when user asks to index a reference genome, train a learned-index model, or align DNA reads to a reference with high throughput.
homepage: https://github.com/kaist-ina/BWA-MEME
---


# bwa-meme

## Overview

BWA-MEME (Burrows-Wheeler Aligner with Machine learning Emulation) is a high-performance genomic alignment tool that replaces the traditional FM-index with a Learned-index (P-RMI). It is designed for researchers and bioinformaticians who require BWA-MEM2 compatibility and output identity but seek higher throughput on standard CPU architectures. By utilizing a machine learning approach for the seeding phase, it achieves significantly faster processing without requiring specialized hardware like GPUs or FPGAs.

## Core Workflow

### 1. Indexing the Reference
Build the initial index using the `meme` algorithm. This process generates the suffix array required for the subsequent training step.

```bash
# Recommended: Use at least 8-32 threads for human genome
bwa-meme index -a meme <reference.fasta> -t <threads>
```

### 2. Training the P-RMI Model
After indexing, you must train the Learned-index model. This step is unique to BWA-MEME and is required for the acceleration features.

```bash
# Requires Rust/Cargo if building from source
build_rmis_dna.sh <reference.fasta>
```
*Note: For a human reference, this typically takes ~15 minutes and requires ~64GB of RAM.*

### 3. Performing Alignment
To enable the machine learning emulation and speed improvements, you must include the `-7` flag.

```bash
bwa-meme mem -7 -t <threads> <reference.fasta> <reads_1.fastq> <reads_2.fastq> -o <output.sam>
```

## Expert Tips and Configuration

### Memory Mode Selection
BWA-MEME can be compiled or executed in different modes to fit available system memory. Use the `version` command to check the current mode.

| Mode | Index Size (Human) | Description |
| :--- | :--- | :--- |
| **Mode 1** | ~38GB | Minimal memory footprint; useful for systems with <64GB RAM. |
| **Mode 2** | ~88GB | Intermediate acceleration. |
| **Mode 3** | ~118GB | Full acceleration; fastest seeding throughput. |

To switch modes, you must use the specific binary (e.g., `bwa-meme_mode1`) or recompile with the `MODE` variable:
```bash
make clean
make -j<threads> MODE=1
```

### Performance Optimization
- **Thread Scaling**: For Whole Genome Sequencing (WGS) on human data with >32 threads, ensure the system has 140-192 GB RAM to handle the memory overhead of full acceleration.
- **SAM Compatibility**: BWA-MEME is a drop-in replacement for BWA-MEM2. If your pipeline requires identical results to `bwa mem 0.7.17`, BWA-MEME is the preferred high-speed alternative.
- **Pipes**: Integrate with `samtools` to save disk space and improve I/O:
  ```bash
  bwa-meme mem -7 -t 32 ref.fa reads.fq | samtools view -Sb - > output.bam
  ```



## Subcommands

| Command | Description |
|---------|-------------|
| build_rmis_dna.sh | Learned-index training script for BWA-MEME. For human reference, training requires around 15 minutes and 64GB memory. |
| index | Build an index for a FASTA file using various BWT construction algorithms, including MEME. |
| mem | BWA-MEME (bwa-mem2) alignment tool using learned or ERT indexes for seeding. |

## Reference documentation
- [BWA-MEME README](./references/github_com_kaist-ina_BWA-MEME_blob_master_README.md)
- [P-RMI Training Script](./references/github_com_kaist-ina_BWA-MEME_blob_master_build_rmis_dna.sh.md)
- [Makefile Configuration](./references/github_com_kaist-ina_BWA-MEME_blob_master_Makefile.md)