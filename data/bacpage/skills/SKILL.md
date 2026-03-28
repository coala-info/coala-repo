---
name: bacpage
description: bacpage is a modular bioinformatics pipeline that automates the assembly and analysis of bacterial genomes from raw sequencing reads. Use when user asks to initialize genomic projects, execute reference-based or de novo assemblies, generate quality control reports, or reconstruct phylogenetic trees.
homepage: https://github.com/CholGen/bacpage
---


# bacpage

## Overview

bacpage is a modular bioinformatics pipeline designed to automate the assembly and analysis of bacterial genomes. It simplifies the transition from raw sequencing reads to high-quality genomic data by wrapping tools like Snakemake, bcftools, and iqtree into a streamlined command-line interface. Use this skill to guide the setup of genomic projects, execute reference-based or de novo assemblies, and generate comprehensive quality control reports and phylogenetic trees.

## Command Line Usage

The bacpage tool follows a project-based workflow. You must initialize a project directory before running analysis.

### Project Initialization
To start a new analysis batch, create a dedicated project directory:
```bash
bacpage setup [project-name]
```
This creates a standardized folder structure. You must place your paired-end sequencing reads (FASTQ files) into the `input/` directory within this new project folder.

### Executing Assembly
Once reads are in the `input/` folder, run the assembly pipeline:
```bash
bacpage assemble [project-name]
```
This command triggers the reference-based assembly workflow, which includes:
1. Read alignment to a reference genome.
2. Variant calling and filtering.
3. Generation of masked consensus sequences.

### Quality Control and Results
After running the assembly, results are organized in the project directory:
- **Consensus Sequences**: Found in `[project-name]/results/consensus_sequences/` as `<sample>.masked.fasta`.
- **QC Reports**: An interactive HTML report is generated at `[project-name]/results/reports/qc_report.html`.

## Expert Tips and Best Practices

- **Environment Management**: Always ensure the conda environment is active before running commands: `mamba activate bacpage`.
- **Input Naming**: Ensure Illumina reads are properly paired (e.g., `_R1.fastq.gz` and `_R2.fastq.gz`) to allow the pipeline to correctly identify sample pairs in the `input/` directory.
- **Pathogen Specificity**: While the tool is moving toward being pathogen-agnostic, its current defaults and internal logic are optimized for *Vibrio cholerae*. When working with other species, verify that the reference genome configuration matches your target organism.
- **Phylogenetic Inference**: The pipeline can construct maximum-likelihood trees using `iqtree`. This is typically part of the broader analysis workflow beyond the initial assembly.
- **Updating the Tool**: If the pipeline behavior seems outdated, navigate to the source directory and run `git pull` followed by `pip install .` to ensure the CLI is linked to the latest logic.



## Subcommands

| Command | Description |
|---------|-------------|
| bacpage phylogeny | Reconstructs maximum likelihood phylogeny from consensus sequences. |
| bacpage utilities | Available utilities:   One of the following utilities must be specified: |
| bacpage_assemble | Assembles consensus sequence from raw sequencing reads. |
| bacpage_profile | Reconstructs maximum likelihood phylogeny from consensus sequences. |
| identify_files | Generate a valid sample_data.csv from a directory of FASTQs. |
| setup | Set up project directory for analysis. |

## Reference documentation
- [bacpage README](./references/github_com_CholGen_bacpage_blob_master_README.md)
- [bacpage Overview](./references/anaconda_org_channels_bioconda_packages_bacpage_overview.md)