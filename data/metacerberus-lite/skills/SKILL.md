---
name: metacerberus-lite
description: MetaCerberus-lite is a streamlined pipeline that transforms raw sequencing data into functional knowledge through quality control, gene prediction, and HMM-based metabolic profiling. Use when user asks to perform functional annotation of meta'omics data, identify genes in diverse ecosystems, or generate metabolic profiles from raw reads and contigs.
homepage: https://github.com/raw-lab/metacerberus
---


# metacerberus-lite

## Overview

MetaCerberus-lite is a streamlined pipeline designed to transform raw sequencing data into functional knowledge. It automates the processing of shotgun meta'omics data—including bacteria, archaea, viruses, and eukaryotes—by integrating quality control, gene prediction, and Hidden Markov Model (HMM) searches against specialized databases. Use this tool when you need a "start-to-finish" workflow for metabolic analysis and functional profiling across diverse ecosystems.

## Installation and Initial Setup

Before running analysis, the environment must be initialized and databases downloaded.

```bash
# Create environment
mamba create -n metacerberus -c conda-forge -c bioconda metacerberus-lite
conda activate metacerberus

# Initialize and download databases (Required once)
metacerberus.py --setup
metacerberus.py --download
```

## Core CLI Usage

MetaCerberus-lite supports three primary input types:
1. **Raw Reads**: `.fastq` (Illumina, PacBio, or Nanopore)
2. **Nucleotide Contigs**: `.fasta`, `.fa`, `.fna`
3. **Protein Sequences**: `.faa` (pORFs)

### Common Command Patterns

**Basic Annotation from Contigs:**
```bash
metacerberus.py --prodigal <input_file.fasta> --dir_out <output_directory>
```

**Processing Eukaryote-Rich Metagenomes:**
```bash
metacerberus.py --super <input_file.fasta> --dir_out <output_directory>
```
*Note: The `--super` flag utilizes FragGeneScanRs, which is more effective at identifying ORFs in eukaryotic data.*

**Handling Raw Illumina Reads (with QC):**
```bash
metacerberus.py --illumina --fastq1 <reads_R1.fastq> --fastq2 <reads_R2.fastq> --dir_out <output_directory>
```

## Expert Tips and Best Practices

### Viral Analysis Precautions
By default, MetaCerberus removes the phiX174 genome (a common Illumina spike-in). If you are conducting viral or phage analysis, use the `--skip_decon` flag. This prevents the accidental removal of k-mers shared with ssDNA microviruses, which could lead to false negatives.

### Customizing HMM Sensitivity
You can adjust the stringency of functional assignments by modifying the bitscore and e-value thresholds.
*   **Default Bitscore**: 25
*   **Default E-value**: 1e-9
*   **Custom Command**: `metacerberus.py --bitscore 30 --evalue 1e-10 [other_args]`

### Database Selection
MetaCerberus-lite can search against FOAM, KEGG, CAZy/dbCAN, VOG, pVOG, PHROG, and COG. You can specify individual databases to save time if the full metabolic profile is not required.

### Resource Management
For large metagenomic datasets, MetaCerberus can utilize RAY for distributed computing. Ensure your environment is configured for multiprocessing if handling high-volume shotgun data.

## Reference documentation
- [MetaCerberus Main Repository](./references/github_com_raw-lab_metacerberus.md)
- [MetaCerberus Wiki](./references/github_com_raw-lab_metacerberus_wiki.md)