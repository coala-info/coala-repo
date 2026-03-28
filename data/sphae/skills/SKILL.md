---
name: sphae
description: Sphae is a Snakemake-based toolkit for the end-to-end processing, assembly, and annotation of phage genomes from raw sequencing data. Use when user asks to process raw Illumina or Nanopore reads, assemble phage genomes, or perform functional annotation and phylogenetic analysis on existing contigs.
homepage: https://github.com/linsalrob/sphae/
---


# sphae

## Overview

Sphae is a Snakemake-based toolkit designed specifically for the end-to-end processing of phage genomes. It streamlines the transition from raw sequencing data to annotated genomes by integrating quality control, assembly, and specialized viral analysis tools. Use this skill to guide users through the modular workflows of `sphae`, whether they need a full "run" (QC to annotation) or a targeted "annotate" (functional prediction on existing assemblies) operation.

## Installation and Setup

Before running workflows, ensure the environment is prepared and databases are initialized.

- **Environment**: Install via `pip install sphae` or use the provided Conda/Singularity options.
- **Database Initialization**: Run `sphae install` to download required models (Pfam, CheckV, Pharokka, Phynteny, Phold).
- **Environment Variables**: If databases are already present, export the following paths to skip re-downloading:
  - `VVDB`: Pfam35.0 HMM
  - `CHECKVDB`: CheckV database
  - `PHAROKKADB`: Pharokka database
  - `PHYNTENYDB`: Phynteny models
  - `PHOLDDB`: Phold database

## Common CLI Patterns

### 1. Full Workflow (QC + Assembly + Annotation)
Use `sphae run` for raw sequencing reads.

- **Illumina (Paired-end)**:
  Ensure files are named `{sample}_R1.fastq.gz` and `{sample}_R2.fastq.gz`.
  ```bash
  sphae run --input /path/to/reads --output results_dir -k
  ```

- **Nanopore (Long-read)**:
  ```bash
  sphae run --input /path/to/reads --sequencing longread --output results_dir -k
  ```
  *Tip: Use `--no_medaka` for high-accuracy ONT reads (e.g., Q20+) where polishing is unnecessary.*

### 2. Annotation Only
Use `sphae annotate` if you already have assembled FASTA contigs. This runs Pharokka, Phold, and Phynteny, and generates phylogenetic trees for portal proteins and terminase large subunits.
```bash
sphae annotate --genome /path/to/contigs --output annotation_dir -k
```

### 3. Cluster Execution
To run on a Slurm-managed cluster, use the `--profile` or `--executor` flags:
```bash
sphae run --input /path/to/reads --output results_dir --executor slurm --threads 16
```

## Interpreting Results

Outputs are located in the `RESULTS` subdirectory of your specified output folder:

- **Genomes**: `*.fasta` (reoriented to terminase or assembled contigs).
- **Annotations**: GenBank format files containing Phynteny/Pharokka predictions.
- **Visualizations**: `*.png` circular genome maps.
- **Summary**: A genome summary file containing:
  - **Length & Coding Density**: Basic assembly metrics.
  - **CheckV Metrics**: Completeness and contamination percentages.
  - **Taxonomy**: Mash-based identification against the INPHARED database.
- **Phylogeny**: The `trees/` folder contains `.nwk` files for `all_terL` (terminase) and `all_portal` proteins.

## Expert Tips

- **Input Organization**: For `sphae run`, place all samples in a single directory. Sphae automatically detects sample pairs based on R1/R2 suffixes.
- **Workflow Persistence**: Always use the `-k` (keep-going) flag to ensure the Snakemake workflow continues even if one sample fails.
- **Host Contamination**: While optional, providing a host reference during the `run` command can significantly improve assembly quality for samples with high background DNA.



## Subcommands

| Command | Description |
|---------|-------------|
| config | Copy the system default config file |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |

## Reference documentation
- [Sphae GitHub Repository](./references/github_com_linsalrob_sphae.md)
- [Sphae Wiki and Tutorial](./references/github_com_linsalrob_sphae_wiki.md)