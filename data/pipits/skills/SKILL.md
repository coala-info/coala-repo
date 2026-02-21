---
name: pipits
description: PIPITS is a specialized bioinformatics pipeline designed specifically for fungal community analysis.
homepage: https://github.com/hsgweon/pipits
---

# pipits

## Overview

PIPITS is a specialized bioinformatics pipeline designed specifically for fungal community analysis. It automates the complex transition from raw Illumina sequencing reads to structured Operational Taxonomic Unit (OTU) tables. By integrating established tools like VSEARCH, ITSx, and the UNITE database, it provides a reproducible path for fungal diversity studies. This skill should be used when you need to perform fungal metabarcoding, from initial sequence preparation to final taxonomic assignment.

## Installation and Environment

PIPITS requires a POSIX-compatible system (Linux or macOS) and at least 16GB of RAM (32GB+ recommended for large databases).

Install via Conda to manage dependencies:
```bash
conda create -n pipits_env -c bioconda -c conda-forge python=3.10 pipits
conda activate pipits_env
```

## Core Workflow

The pipeline consists of four primary commands executed in sequence.

### 1. Generate Read Pairs List
Prepare a tab-delimited file mapping forward and reverse reads to sample IDs. Sample IDs are automatically parsed from the filename prefix (characters before the first underscore).
```bash
pipits_createreadpairslist -i rawdata_dir -o readpairslist.txt
```
*   **Input**: Directory containing `.fastq`, `.fastq.gz`, or `.fastq.bz2` files.
*   **Tip**: Verify `readpairslist.txt` for duplicate sample IDs before proceeding.

### 2. Sequence Preparation
Join paired-end reads, perform quality filtering, and aggregate samples into a single FASTA file.
```bash
pipits_prep -i rawdata_dir -o out_prep -l readpairslist.txt
```
*   **Output**: Generates `prepped.fasta` in the output directory.

### 3. Fungal ITS Extraction (Optional)
Extract specific ITS subregions (ITS1 or ITS2) and remove conserved regions to improve taxonomic resolution.
```bash
pipits_funits -i out_prep/prepped.fasta -o out_funits -x ITS2
```
*   **Parameters**: Use `-x` to specify the subregion (`ITS1` or `ITS2`).
*   **Note**: This step uses ITSx and can be computationally intensive.

### 4. Downstream Processing
Perform OTU clustering, chimera removal, and taxonomic assignment using the UNITE database.
```bash
pipits_process -i out_funits/ITS.fasta -o out_process
```
*   **Default**: PIPITS 4.0 uses SINTAX as the default classifier and UNITE 10.0 as the default database.
*   **Troubleshooting**: If BIOM format conversion fails on older systems, run `conda update pipits` within the environment.

## Expert Tips and Best Practices

*   **Memory Management**: Recent versions of the UNITE database are large. Ensure your environment has at least 32GB of RAM if the process hangs during taxonomic assignment.
*   **Subregion Selection**: Illumina 300bp x 2 sequencing is generally insufficient to cover the full ITS region with overlap. Choose either ITS1 or ITS2 for extraction; do not attempt to process both simultaneously.
*   **Classifier Choice**: While SINTAX is the default in version 4.0 due to its speed, the RDP Classifier is still supported if specific legacy comparisons are required.
*   **Data Integrity**: Ensure raw filenames follow a consistent naming convention (e.g., `SampleID_R1.fastq`) to allow `pipits_createreadpairslist` to correctly identify pairs and IDs.

## Reference documentation
- [PIPITS Main Documentation](./references/github_com_hsgweon_pipits.md)
- [Conda Installation Overview](./references/anaconda_org_channels_bioconda_packages_pipits_overview.md)