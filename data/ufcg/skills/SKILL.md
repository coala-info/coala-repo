---
name: ufcg
description: ufcg is a bioinformatics pipeline for taxonomic classification and phylogenetic analysis of fungal species using universal core genes. Use when user asks to profile fungal marker genes, reconstruct phylogenetic trees, align core gene sequences, or train custom fungal marker models.
homepage: https://ufcg.steineggerlab.com
metadata:
  docker_image: "quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0"
---

# ufcg

## Overview

UFCG is a specialized bioinformatics pipeline designed for the fungal kingdom. It leverages a curated database of universal fungal core genes to enable high-resolution taxonomic classification and genome-wide phylogenetic analysis. You should use this skill when you need to identify fungal species from raw sequence data, annotate core marker genes, or build robust phylogenetic trees using validated fungal-specific models.

## Core Workflows

### 1. Database Initialization
Before running analysis, you must download the necessary marker gene models and configuration files.
- **Minimum setup**: `ufcg download -t minimum`
- **Full setup**: `ufcg download -t full`

### 2. Taxonomic Profiling
Extract marker gene sequences from your biological data. UFCG supports genome, transcriptome, and proteome sequences.
- **Standard I/O mode**: `ufcg profile -i <INPUT_FASTA> -o <OUTPUT_DIR>`
- **Interactive mode**: `ufcg profile -u`
- **Input types**: Ensure your input is in FASTA format. The tool automatically detects whether the input is nucleotide or protein based on the sequence content.

### 3. Phylogenetic Tree Reconstruction
Reconstruct relationships using the profiles generated in the previous step.
- **Command**: `ufcg tree -i <PROFILE_DIR> -o <TREE_OUTPUT_DIR>`
- **Note**: This module typically requires external dependencies like MAFFT for alignment and IQ-TREE for tree inference to be in your PATH.

### 4. Multiple Sequence Alignment
If you only require the alignments of the marker genes without building a full tree:
- **Command**: `ufcg align -i <PROFILE_DIR> -o <ALIGN_DIR>`

### 5. Custom Model Training
Generate sequence models for your own specific fungal marker genes if the default core genes are insufficient for your specialized study.
- **Command**: `ufcg train -i <SEED_SEQUENCES> -g <REFERENCE_GENOMES> -o <MODEL_OUTPUT_DIR>`

## Expert Tips and Best Practices

- **Dependency Management**: UFCG relies on several external tools for specific modules. Ensure the following are installed for full functionality:
    - `profile`: AUGUSTUS (v3.5.0+) and MMseqs2 (v13+).
    - `tree`: MAFFT (v7.310+) and IQ-TREE (v2.0.3+).
- **Memory Considerations**: When running `ufcg profile` on large sets of fungal genomes, ensure sufficient disk space for the intermediate MMseqs2 databases created during the search process.
- **Conda Installation**: The most reliable way to set up the environment is via Bioconda: `conda install -c bioconda ufcg`.
- **Docker Usage**: For reproducible environments, use the official image: `docker pull endix1029/ufcg:latest`.



## Subcommands

| Command | Description |
|---------|-------------|
| ufcg profile | Extract UFCG profile from Fungal whole genome sequences |
| ufcg profile-rna | Extract UFCG profile from Fungal RNA-seq reads |
| ufcg train | Train and generate sequence model of fungal markers |
| ufcg tree | Reconstruct the phylogenetic relationship with UFCG profiles |
| ufcg_align | Align genes and provide multiple sequence alignments from UFCG profiles |
| ufcg_convert | Convert core gene profile into a FASTA file |
| ufcg_download | List or download resources |
| ufcg_profile-pro | Extract UFCG profile from Fungal proteome |
| ufcg_prune | Fix UFCG tree labels or get a single gene tree |

## Reference documentation

- [UFCG Pipeline README](./references/github_com_steineggerlab_ufcg_blob_main_README.md)
- [UFCG Docker Configuration](./references/github_com_steineggerlab_ufcg_blob_main_Dockerfile.md)