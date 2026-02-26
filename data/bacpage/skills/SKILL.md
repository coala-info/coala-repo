---
name: bacpage
description: bacpage is a Snakemake-based bioinformatics pipeline for the assembly and analysis of bacterial genomes. Use when user asks to assemble bacterial genomes, perform variant calling, conduct phylogenetic inference, or identify antimicrobial resistance genes and virulence factors.
homepage: https://github.com/CholGen/bacpage
---


# bacpage

## Overview
bacpage is a Snakemake-based bioinformatics pipeline designed to streamline the assembly and analysis of bacterial genomes. It bridges the gap between raw sequencing data (Illumina paired-end or ONT long-reads) and actionable genomic insights. By encapsulating tools for quality control, variant calling, and phylogenetic inference, it provides a standardized workflow that is accessible to researchers while remaining modular enough for advanced configuration.

## Installation and Environment
To ensure all dependencies are correctly managed, bacpage should be installed and run within a dedicated Conda environment.

- **Conda Installation**: `conda install bioconda::bacpage`
- **Environment Activation**: Always activate the environment before running commands: `mamba activate bacpage` or `conda activate bacpage`.

## Core Workflow Patterns

### 1. Project Initialization
Every analysis begins with the creation of a project directory structure. This ensures the pipeline knows where to look for inputs and where to store results.
```bash
bacpage setup [your-project-directory-name]
```
This command creates a standardized directory structure, including an `input/` folder.

### 2. Data Preparation
Place your raw sequencing reads (paired-end Illumina or ONT long-reads) directly into the `input/` directory created during the setup phase.

### 3. Executing the Assembly
The primary command for generating consensus sequences and performing initial analysis is the `assemble` command.
```bash
bacpage assemble [your-project-directory-name]
```
**Key Outputs:**
- **Consensus Sequences**: Located at `<project>/results/consensus_sequences/<sample>.masked.fasta`.
- **QC Report**: An HTML summary of alignment and quality metrics found at `<project>/results/reports/qc_report.html`.

## Functional Capabilities
While `assemble` is the primary entry point, the pipeline is designed to support the following specialized tasks:
- **Reference-based Assembly**: Best for Illumina paired-end reads when a high-quality reference genome is available.
- **De novo Assembly**: Supports both Illumina paired-end and ONT long-read data.
- **Phylogenetic Inference**: Uses `iqtree` for maximum-likelihood tree construction from processed samples.
- **Genomic Profiling**: Detects MLST profiles, antimicrobial resistance (AMR) genes, virulence factors, and plasmids.
- **Variant Calling**: Utilizes `bcftools` for robust SNP and indel detection.

## Expert Tips and Best Practices
- **Pathogen Specificity**: Currently, the pipeline is optimized for *Vibrio Cholerae*. When working with other pathogens, verify that the default reference parameters align with your target organism's characteristics.
- **Resource Management**: Since bacpage is built on Snakemake, it inherits robust task management. If a run is interrupted, re-running the same command will typically resume from the last successful step.
- **Testing Installations**: After installation or updates, verify the CLI is responsive by running `bacpage -h` and `bacpage version`.
- **Updates**: To update a local git installation, run `git pull` followed by `mamba env update -f environment.yaml` and `pip install .` to ensure the CLI entry point is refreshed.

## Reference documentation
- [bacpage GitHub Repository](./references/github_com_CholGen_bacpage.md)
- [bacpage Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bacpage_overview.md)