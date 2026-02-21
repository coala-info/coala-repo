---
name: floria
description: Floria is a high-performance tool designed to resolve genomic variations within metagenomic samples, allowing for the differentiation of closely related microbial strains.
homepage: https://github.com/bluenote-1577/floria
---

# floria

## Overview

Floria is a high-performance tool designed to resolve genomic variations within metagenomic samples, allowing for the differentiation of closely related microbial strains. By utilizing haplotype phasing, it transforms mapped reads and variant calls into strain-level clusters and phased haplotypes. It is particularly effective for complex metagenomic contigs where multiple strains of the same species may be present.

## Installation and Setup

Floria can be installed via Conda or compiled from source using Rust.

- **Conda (Recommended):**
  ```bash
  conda install -c bioconda floria
  ```
- **Source (Requires Rust > 1.80.0):**
  ```bash
  git clone https://github.com/bluenote-1577/floria
  cd floria
  cargo install --path .
  ```

## Core CLI Usage

The primary workflow requires a BAM file (reads mapped to a reference) and a VCF file (variant calls).

### Basic Command
```bash
floria -b <input.bam> -v <input.vcf> -r <reference.fasta> -o <output_dir>
```

### Parameters
- `-b, --bam`: Path to the BAM file containing mapped short or long reads.
- `-v, --vcf`: Path to the VCF file containing variant calls.
- `-r, --ref`: Path to the reference FASTA file used for mapping.
- `-o, --out`: Directory where results and strain-level clusters will be stored.

## Best Practices and Expert Tips

### 1. Input Consistency
Ensure that the BAM and VCF files were generated using the exact same reference FASTA. Mismatched coordinates or contig names will cause the phasing process to fail or produce incorrect clusters.

### 2. Interpreting HAPQ Scores
Floria outputs a "HAPQ" (Haplotype Quality) score. 
- **High HAPQ**: Indicates a high-confidence strain phasing.
- **Low HAPQ**: Often indicates spurious "haplosets" or noise. When analyzing results, prioritize clusters with high HAPQ scores to avoid over-estimating strain diversity.

### 3. Visualization
If you have `matplotlib` installed, you can visualize the resulting "vartigs" (variant contigs) to inspect the phasing quality:
```bash
python scripts/visualize_vartigs.py <output_dir>/<contig_name>/<contig_name>.vartigs
```

### 4. Handling Large Contigs
Floria is optimized for speed and can phase 1Mbp+ contigs in minutes. If working with extremely large metagenomic assemblies, ensure your system has sufficient RAM for the Rust-based phasing engine, though it is generally memory-efficient.

### 5. Long-Read vs. Short-Read
While Floria supports both, long-read data (PacBio/Oxford Nanopore) typically provides significantly better phasing connectivity across larger genomic distances compared to short-read data.

## Reference documentation
- [Floria GitHub Repository](./references/github_com_bluenote-1577_floria.md)
- [Bioconda Floria Overview](./references/anaconda_org_channels_bioconda_packages_floria_overview.md)