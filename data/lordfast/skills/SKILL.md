---
name: lordfast
description: lordfast is a specialized alignment tool designed for long-read sequencing technologies.
homepage: https://github.com/vpc-ccg/lordfast
---

# lordfast

## Overview

lordfast is a specialized alignment tool designed for long-read sequencing technologies. It is specifically optimized to handle the high error rates associated with single-molecule sequencing platforms like PacBio and Oxford Nanopore. The tool operates by first creating a BWT-based index of a reference genome and then performing sensitive mapping using anchoring and chaining algorithms. It is ideal for workflows requiring high sensitivity in noisy data environments.

## Installation

The most efficient way to install lordfast is via Bioconda:

```bash
conda install -c bioconda lordfast
```

Alternatively, it can be built from source using `make` if GCC and zlib are available.

## Core Workflows

### 1. Indexing the Reference
Before mapping, you must generate an index for your reference genome (FASTA format).

```bash
lordfast --index reference.fasta
```

### 2. Mapping Reads
Perform alignment by providing both the reference genome used for indexing and the read file (FASTA or FASTQ).

```bash
# Basic mapping to stdout
lordfast --search reference.fasta --seq reads.fastq > alignment.sam

# Mapping using all available CPU cores
lordfast --search reference.fasta --seq reads.fastq --threads 0 -o alignment.sam
```

## Command Line Options

### Essential Parameters
- `-S, --search <FILE>`: Path to the reference genome FASTA file.
- `-s, --seq <FILE>`: Path to the long-read sequences (FASTA/FASTQ).
- `-t, --threads <INT>`: Number of CPU cores. Use `0` for all available cores.
- `-o, --out <STR>`: Output file path (defaults to stdout).

### Tuning for Sensitivity and Performance
- **Read Length Filter**: By default, lordfast ignores reads shorter than 1000bp. Adjust this with `-l, --minReadLen <INT>` if working with shorter fragments.
- **Anchor Length**: Use `-k, --minAnchorLen <INT>` (default 14) to change the minimum anchor size. Increasing this can speed up the tool but may reduce sensitivity in very noisy regions.
- **Candidate Alignment**: Control the maximum number of candidate positions to explore per read using `-n, --numMap <INT>` (default 10).
- **Read Groups**: For downstream pipeline compatibility (like GATK), add SAM read group headers:
  ```bash
  lordfast --search ref.fa --seq reads.fq -R '@RG\tID:sample1\tSM:sample1'
  ```

## Best Practices
- **Memory Management**: Ensure the system has enough RAM to hold the reference index, especially for large mammalian genomes.
- **Output Handling**: lordfast outputs in SAM format. It is often best to pipe the output directly to `samtools` for conversion to BAM to save disk space:
  ```bash
  lordfast --search ref.fa --seq reads.fq --threads 8 | samtools view -bS - > alignment.bam
  ```
- **Algorithm Selection**: While `dp-n2` is the default chaining algorithm, you can experiment with `--chainAlg clasp` if specific chaining behavior is required for your dataset.

## Reference documentation
- [lordfast GitHub Repository](./references/github_com_vpc-ccg_lordfast.md)
- [lordfast Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_lordfast_overview.md)