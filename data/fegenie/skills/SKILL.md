---
name: fegenie
description: FeGenie automates the identification and categorization of iron-related genes and operons within microbial genomes and metagenomes using a curated library of Hidden Markov Models. Use when user asks to discover iron-related genetic potential, analyze genomic bins or protein sequences for iron cycling genes, and cross-validate annotations against reference databases.
homepage: https://github.com/Arkadiy-Garber/FeGenie
---


# fegenie

## Overview
FeGenie is a specialized bioinformatics tool that automates the discovery of iron-related genetic potential within microbial genomes and metagenomes. By leveraging a curated library of Hidden Markov Models (HMMs), it identifies genes involved in the iron cycle and organizes them into functional categories and potential operons. This skill provides guidance on executing the `FeGenie.py` pipeline, optimizing performance via threading, and handling different input types such as raw assemblies or pre-called Open Reading Frames (ORFs).

## Installation and Setup
The most reliable way to use FeGenie is via Conda to ensure all dependencies (HMMER, BLAST, R) are correctly configured.

```bash
conda create -n fegenie -c conda-forge -c bioconda fegenie
conda activate fegenie
```

## Common CLI Patterns

### Analyzing Genome Bins
To run FeGenie on a directory of genomic assemblies (nucleotide FASTA files):
```bash
FeGenie.py -bin_dir /path/to/bins/ -bin_ext fasta -out output_dir -t 8
```
*   `-bin_ext`: Must match the file extension (e.g., `fa`, `fna`, `fasta`).
*   `-t`: Set the number of threads for HMMER and BLAST searches.

### Analyzing Protein Sequences (ORFs)
If you have already performed gene calling (e.g., via Prodigal) and have amino acid sequences:
```bash
FeGenie.py -bin_dir /path/to/orfs/ -bin_ext faa -out output_dir --orfs -t 8
```
*   `--orfs`: This flag is mandatory when the input consists of protein sequences.

### Cross-Validation with Reference Databases
To increase confidence in annotations, use a reference database for cross-validation:
```bash
FeGenie.py -bin_dir genomes/ -bin_ext fna -out output_out -ref /path/to/refseq_nr.faa
```

## Expert Tips and Best Practices
*   **Extension Sensitivity**: The `-bin_ext` argument is literal. If your files are `.fna`, passing `fasta` will result in no files being processed.
*   **Resource Management**: FeGenie can be resource-intensive. Always specify `-t` to match your available CPU cores; the default is 1, which is slow for large metagenomes.
*   **Output Interpretation**: The primary result file is `FeGenie-geneSummary-clusters.csv`. This file provides a high-level overview of identified iron genes and their proximity to one another, which is useful for identifying operons.
*   **Docker Usage**: If running via Docker, ensure you mount your local data directory to `/data` and set the environment variables for HMMs and R scripts as shown in the documentation to avoid path errors.

## Reference documentation
- [FeGenie GitHub Repository](./references/github_com_Arkadiy-Garber_FeGenie.md)
- [FeGenie Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fegenie_overview.md)