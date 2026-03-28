---
name: hecatomb
description: Hecatomb is a bioinformatic pipeline designed to identify and extract viral sequences from complex metagenomic datasets. Use when user asks to install viral databases, process short or long reads for viral discovery, or configure metagenomic analysis for high-performance computing environments.
homepage: https://github.com/shandley/hecatomb
---


# hecatomb

## Overview

Hecatomb is a specialized bioinformatic pipeline designed to extract viral signals from complex metagenomic data. It addresses the primary challenges of viral discovery: high host contamination, distant evolutionary relationships, and the need to distinguish true viral sequences from false positives. The tool automates a multi-step process including rigorous quality control, assembly, and taxonomic assignment against curated viral databases. Use this skill to guide the installation of necessary resources, manage sample inputs, and optimize execution for both local and high-performance computing (HPC) environments.

## Installation and Setup

Before running analysis, the software and its associated databases must be initialized.

- **Install Hecatomb**: Use `pip install hecatomb` or `conda install -c bioconda hecatomb`.
- **Database Installation**: Download the required viral and taxonomic databases.
  - Command: `hecatomb install --threads <number>`
  - Tip: Use multiple threads (e.g., 8) to speed up the concurrent download of database components.
- **Environment Pre-building**: If working on an HPC cluster without internet access on compute nodes, pre-build the software environments.
  - Command: `hecatomb test build_envs`

## Execution Patterns

Hecatomb uses a Snakemake-based architecture. The primary way to trigger an analysis is by providing a read source.

### Basic Run
To process a directory of Illumina reads:
`hecatomb --reads path/to/reads/ --threads 32`

### Input Methods
- **Directory**: Hecatomb automatically infers sample names and R1/R2 pairs from filenames.
- **TSV File**: For complex naming or specific groupings, provide a 2 or 3-column TSV (SampleName, R1_Path, [R2_Path]).
  - Command: `hecatomb --reads samples.tsv`

### Long-read Support
For Nanopore or PacBio data, explicitly enable the long-read flag.
- Command: `hecatomb --reads path/to/longreads/ --longreads`

### Trimming Options
Hecatomb uses the Trimnami module. You can specify the method using `--trim`.
- **fastp**: Default for short reads.
- **prinseq**: Alternative for short reads.
- **filtlong**: Recommended for long reads.
- **notrim**: Skip the trimming step if data is already pre-processed.

## Configuration and Optimization

### Customizing Parameters
To modify internal thresholds or tool settings, generate and edit a local config file.
1. Generate config: `hecatomb config`
2. Edit the file: `hecatomb.out/hecatomb.config.yaml` (Note: While the file is YAML, users should interact with it via text editors to change values like bitscore thresholds or assembly parameters).

### HPC and Cluster Usage
Hecatomb supports Snakemake profiles for job scheduling (e.g., Slurm).
- Command: `hecatomb --reads path/to/reads/ --profile slurm`
- Note: Hecatomb currently targets Snakemake version 7. Profiles designed for Snakemake v8+ may require adjustments to remain compatible with the Hecatomb CLI.

## Troubleshooting and Validation

- **Check Installation**: Run `hecatomb --help` to verify the CLI is responsive.
- **Verify Workflow**: Run the built-in test dataset to ensure the pipeline completes successfully in your environment.
  - Command: `hecatomb test --threads 8`
- **Empty Files**: If the test generates empty files, verify that the database installation (`hecatomb install`) completed without errors and that your system has sufficient RAM (64GB recommended for the full pipeline).



## Subcommands

| Command | Description |
|---------|-------------|
| add-host | Add a new host genome to use with Hecatomb |
| combine | Combine multiple Hecatomb runs |
| config | Copy the system default config file |
| list-hosts | List the available host genomes |
| run | Run hecatomb |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |

## Reference documentation
- [Hecatomb Main README](./references/github_com_shandley_hecatomb.md)
- [Hecatomb Wiki Home](./references/github_com_shandley_hecatomb_wiki.md)
- [Running hecatomb on a cluster](./references/github_com_shandley_hecatomb_wiki_Running-hecatomb-on-a-cluster.md)