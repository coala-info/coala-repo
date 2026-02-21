---
name: metacerberus
description: MetaCerberus is a comprehensive pipeline designed to transform raw sequencing reads or assembled contigs into functional knowledge.
homepage: https://github.com/raw-lab/metacerberus
---

# metacerberus

## Overview
MetaCerberus is a comprehensive pipeline designed to transform raw sequencing reads or assembled contigs into functional knowledge. It automates the transition from quality control (QC) and gene prediction to functional annotation using Hidden Markov Models (HMMs). This skill helps navigate its multi-stage workflow, including read trimming, ORF (Open Reading Frame) prediction, and searching against specialized environmental and functional databases.

## Installation and Setup
Before running analysis, the environment and databases must be initialized.

```bash
# Setup the environment (Mamba is recommended)
mamba create -n metacerberus -c conda-forge -c bioconda metacerberus
conda activate metacerberus

# Initialize and download required HMM databases
metacerberus.py --setup
metacerberus.py --download
```

## Common CLI Patterns

### 1. End-to-End Analysis from Raw Reads
Use this for Illumina or PacBio fastq files to perform QC, trimming, gene prediction, and annotation in one go.
```bash
metacerberus.py --prodigal <path/to/reads.fastq> --dir_out <output_directory>
```

### 2. Analyzing Assembled Contigs
If you already have assembled nucleotide fasta files, skip the QC/trimming steps.
```bash
metacerberus.py --fna <assembly.fasta> --dir_out <output_directory>
```

### 3. Analyzing Protein Sequences (pORFs)
For the fastest execution when gene prediction is already complete.
```bash
metacerberus.py --faa <proteins.faa> --dir_out <output_directory>
```

## Expert Tips and Best Practices

### Gene Prediction Selection
*   **Standard Bacteria/Archaea:** Use `--prodigal` (default).
*   **Eukaryote-rich samples:** Use `--super` to run both Prodigal and FragGeneScanRs. FragGeneScanRs is significantly better at identifying ORFs in eukaryotic data.
*   **Viral/Phage focus:** Use `prodigal-gv` for improved gene prediction in viral genomes.

### Quality Control and Contamination
*   **PhiX Removal:** MetaCerberus removes the phiX174 genome by default. If performing viral analysis where ssDNA microviruses are expected, use `--skip_decon` to prevent false negatives caused by shared k-mers.
*   **N-Repeat Handling:** The pipeline automatically removes N-repeats from contigs/genomes to improve annotation reliability.

### Database Customization
You can limit searches to specific databases to save time or focus on specific functions:
*   Use `--db <database_name>` to specify (e.g., FOAM, KEGG, CAZy, VOG, PHROG, COG).
*   Custom HMMs can be integrated for specialized research needs.

### Performance Optimization
*   **Multiprocessing:** MetaCerberus supports Ray for distributed computing. Ensure your environment has sufficient resources allocated for HMMER searches, which are the most computationally intensive part of the pipeline.

## Reference documentation
- [MetaCerberus GitHub Repository](./references/github_com_raw-lab_metacerberus.md)
- [MetaCerberus Wiki](./references/github_com_raw-lab_metacerberus_wiki.md)