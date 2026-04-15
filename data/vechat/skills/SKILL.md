---
name: vechat
description: VeChat is a specialized error-correction tool for noisy long-read sequencing data. Use when user asks to 'correct errors in long-read sequencing data', 'correct PacBio CLR reads', 'correct Oxford Nanopore reads', or 'remove chimeric sequences'.
homepage: https://github.com/HaploKit/vechat
metadata:
  docker_image: "quay.io/biocontainers/vechat:1.1.1--hdcf5f25_1"
---

# vechat

## Overview
VeChat is a specialized error-correction tool designed for noisy long-read sequencing data. Unlike traditional methods that rely on a single consensus sequence—which can inadvertently mask true biological variants as errors—VeChat utilizes variation graphs. This graph-based approach allows the tool to distinguish between actual sequencing errors and low-frequency haplotype-specific variants, making it particularly effective for polyploid organisms or complex metagenomic samples.

## Installation
The recommended way to install VeChat is via Bioconda:
```bash
conda install -c bioconda vechat
```

## Core CLI Usage
The basic command structure requires an input sequence file (FASTA/FASTQ, can be gzipped) and a specified sequencing platform.

### Basic Correction
```bash
# For PacBio CLR reads (default)
vechat input_reads.fq.gz -t 8 --platform pb -o corrected_reads.fa

# For Oxford Nanopore (ONT) reads
vechat input_reads.fq.gz -t 8 --platform ont -o corrected_reads.fa
```

### Handling Large Datasets
For datasets exceeding 10GB (FASTA) or 20GB (FASTQ), use the `--split` flag to manage memory consumption by processing the data in chunks.
```bash
vechat large_reads.fq.gz -t 48 --platform ont --split -o corrected_reads.fa
```

## Parameter Tuning and Best Practices
*   **Platform Selection**: Always specify `--platform ont` for Nanopore data; the default is `pb` (PacBio).
*   **Graph Pruning**: If the correction is too aggressive or too lenient, adjust the edge filtering parameters:
    *   `-d, --min-confidence`: Minimum confidence for keeping edges (default: 0.2).
    *   `-s, --min-support`: Minimum support for keeping edges (default: 0.2).
*   **Chimeric Reads**: Use the `--scrub` flag if your library is known to have a high rate of chimeric sequences.
*   **Identity Threshold**: The `--min-identity-cns` (default: 0.99) controls the stringency of overlaps during the consensus round. Lower this slightly if working with extremely noisy older data.

## Troubleshooting Common Issues
*   **Empty Overlap Set**: If you encounter an "Empty overlap set" error, ensure your input reads have sufficient coverage and that the sequencing platform matches your data type.
*   **Memory Crashes**: If the process crashes on a local machine without the `--split` flag, re-run with `--split` and consider reducing the `--threads` count to lower the concurrent memory overhead.
*   **Dependencies**: VeChat relies on `minimap2`, `racon`, `fpa`, and `yacrd`. If running from source, ensure these are in your PATH.

## Reference documentation
- [vechat GitHub Repository](./references/github_com_HaploKit_vechat.md)
- [vechat Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vechat_overview.md)