---
name: dajin2
description: DAJIN2 is a "one-step" genotyping solution designed for targeted long-read sequencing (Nanopore).
homepage: https://github.com/akikuno/DAJIN2
---

# dajin2

## Overview

DAJIN2 is a "one-step" genotyping solution designed for targeted long-read sequencing (Nanopore). It excels at identifying complex editing outcomes, such as large deletions or insertions, by comparing a genome-edited sample against a non-edited control. It provides automated allele classification and visualization without requiring deep learning or GPU acceleration, making it suitable for standard laptop environments.

## Installation

Install via Bioconda (recommended) or PyPI:

```bash
# Bioconda
conda install bioconda::dajin2

# PyPI
pip install DAJIN2
```

## Core Workflow

### 1. Prepare Input Files
DAJIN2 requires three primary inputs:
- **Control Directory**: Contains FASTQ, FASTA, or BAM files of the non-edited control.
- **Sample Directory**: Contains FASTQ, FASTA, or BAM files of the genome-edited sample.
- **Allele FASTA**: A reference file containing anticipated sequences.

### 2. Format the Allele FASTA
The FASTA file must follow specific naming and alignment rules:
- Include a `>control` header with the wild-type sequence.
- Include anticipated outcomes (e.g., `>knock-in`, `>knock-out`).
- **Critical**: Ensure both ends of the FASTA sequences match the amplicon sequence exactly to avoid false indel detection.

### 3. Execute Analysis
Run the basic command for a single sample:

```bash
DAJIN2 -c path/to/control_dir -s path/to/sample_dir -a alleles.fasta -n Experiment_Name
```

## Command Line Options

- `-c, --control`: Path to directory containing control files.
- `-s, --sample`: Path to directory containing sample files.
- `-a, --allele`: Path to the FASTA file with anticipated alleles.
- `-n, --name`: Name for the output directory (default: 'Results').
- `-g, --genome`: UCSC genome ID (e.g., `hg38`, `mm39`) for genomic context.
- `-b, --bed`: Path to a BED6 file for genomic coordinates.
- `-t, --threads`: Number of CPU threads to use.
- `--no-filter`: Keep minor alleles below 0.5% frequency (useful for high-sensitivity mosaicism detection).

## Expert Tips and Best Practices

- **Input Directory Structure**: DAJIN2 expects files to be organized in subdirectories, matching the output format of basecallers like Dorado or Guppy. Store each BAM or FASTA file in its own named subdirectory within the main input folder.
- **Basecalling**: While Guppy is supported, using Dorado for basecalling and demultiplexing is recommended for compatibility with the latest DAJIN2 features.
- **Memory Management**: Ensure the system has at least 16 GB of RAM for stable processing of large long-read datasets.
- **Windows Usage**: DAJIN2 is designed for Unix-based environments. Windows users should run the tool via WSL2 (Windows Subsystem for Linux 2).
- **Visualization**: After execution, check the output directory for HTML reports. These provide intuitive visualizations of mutations and allele classifications.

## Reference documentation

- [DAJIN2 Main Documentation](./references/github_com_akikuno_DAJIN2.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dajin2_overview.md)