---
name: clark
description: CLARK is a high-performance sequence classification system that assigns taxonomic labels to DNA reads using discriminative k-mers. Use when user asks to classify metagenomic reads, define taxonomic targets, build reference databases, or estimate the abundance of microbial communities.
homepage: https://github.com/rouni001/CLARK
metadata:
  docker_image: "quay.io/biocontainers/clark:1.3.0.0--h9948957_0"
---

# clark

## Overview
CLARK (CLAssifier based on Reduced K-mers) is a high-performance sequence classification system designed for genomics and metagenomics. It utilizes discriminative k-mers to assign taxonomic labels to DNA reads with high precision and speed. The tool is particularly effective for researchers needing to characterize the composition of complex microbial communities or verify the identity of genomic sequences against known reference databases.

## Core Workflow

### 1. Define Targets and Build Database
Before classification, you must define the reference sequences (targets) and the taxonomic level (e.g., species, genus).

```bash
# Define targets for bacteria at the species level
./set_targets.sh <DIR_DB/> bacteria --species
```

### 2. Classify Metagenomic Reads
Run the classifier on your input sequences (Fasta or Fastq).

```bash
# Basic classification using default settings
./classify_metagenome.sh -O <input_file.fa> -R <output_prefix> -D <DIR_DB/>
```

### 3. Estimate Abundance
After classification, generate a summary of the taxonomic distribution.

```bash
# Compute abundance estimation based on classification results
./estimate_abundance.sh -F <results_file.csv> -D <DIR_DB/>
```

## Execution Modes
CLARK provides different modes to balance sensitivity, speed, and memory:

- **CLARK (Default):** High speed and accuracy using exact k-mer matching. Requires significant RAM (e.g., ~156GB for building the bacterial database).
- **CLARK-l:** Memory-efficient mode designed for workstations with limited RAM (as low as 4GB). Best for small metagenomes.
- **CLARK-S:** Uses spaced k-mers for significantly higher sensitivity, though it requires more RAM and processing time.

## Expert Tips and Best Practices

### K-mer Length Selection
- **High Sensitivity:** Use `-k 20` or `-k 21`. This is better for detecting distant homologs or working with shorter reads.
- **Balanced Performance:** Use `-k 31` (default). This provides an optimal trade-off between speed, precision, and memory usage.

### Performance Optimization
- **Multithreading:** Always utilize the `-n` flag to specify the number of CPU threads to speed up the classification process.
- **Paired-End Data:** For paired-end Fastq files, use the `-P` flag followed by both file paths to improve classification confidence.
- **Mode Selection:** Use `-m` to change execution behavior:
  - `1`: Default (fast).
  - `2`: Express (faster, slightly less sensitive).
  - `0`: Full (most exhaustive).

### Memory Management
If you encounter "Out of Memory" errors on standard workstations:
1. Switch to **CLARK-l**.
2. Increase the gap for non-overlapping k-mers using the `-g` flag (default is 4).
3. Use the sampling factor `-s` to reduce the number of discriminative k-mers loaded into memory.

## Reference documentation
- [CLARK Overview and Installation](./references/anaconda_org_channels_bioconda_packages_clark_overview.md)
- [CLARK GitHub Repository and Usage Manual](./references/github_com_rouni001_CLARK.md)