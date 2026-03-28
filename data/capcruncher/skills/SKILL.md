---
name: capcruncher
description: CapCruncher is a bioinformatics toolset for processing and analyzing Capture-C, Tri-C, and Tiled-C chromosome conformation capture data. Use when user asks to process capture-based sequencing data, run the CapCruncher pipeline, generate contact matrices, or perform specific tasks like fragment annotation and read deduplication.
homepage: https://github.com/sims-lab/CapCruncher.git
---


# capcruncher

## Overview

CapCruncher is a high-performance bioinformatics toolset specifically optimized for Capture-C, Tri-C, and Tiled-C data. Unlike general-purpose Hi-C pipelines, CapCruncher employs filtering and processing steps tailored to the unique requirements of capture-based chromosome conformation capture. It automates the journey from raw sequencing reads to contact matrices and visualization, scaling efficiently from local workstations to large HPC clusters using workflow management profiles.

## Installation and Setup

CapCruncher is primarily supported on Linux. It is best managed within a conda/mamba environment to handle dependencies like Singularity or specific Python libraries.

```bash
# Installation via Bioconda (Recommended)
mamba install -c bioconda capcruncher

# Installation via PyPI
pip install capcruncher
```

## Core CLI Usage

The tool uses a subcommand-based interface. Always use the `--help` flag to explore specific parameters for each module.

### 1. Pipeline Configuration
Before running the pipeline, you must generate a configuration file. CapCruncher provides an interactive prompt to ensure all parameters are correctly set.

```bash
capcruncher pipeline-config
```
Follow the interactive prompts to define your genome, restriction enzymes, and viewpoint locations.

### 2. Running the Pipeline
The pipeline expects raw FASTQ files to be present in the current working directory.

```bash
# Local execution with 8 cores
capcruncher pipeline --cores 8

# HPC execution using SLURM and Singularity containers
capcruncher pipeline --cores 16 --profile slurm --use-singularity
```

### 3. Modular Subcommands
For fine-grained control or custom workflows, you can call individual processing modules:

- `capcruncher annotate`: Annotate fragments with genomic features.
- `capcruncher deduplicate`: Remove PCR duplicates from mapped reads.
- `capcruncher filter`: Apply Capture-C specific filters to interactions.
- `capcruncher pileup`: Generate contact matrices from filtered interactions.
- `capcruncher statistics`: Generate quality control metrics for the run.

## Expert Tips and Best Practices

- **Session Management**: Since genomic pipelines can run for hours, always execute the pipeline within a `tmux` or `screen` session, or use `nohup` to prevent job termination upon disconnection.
- **HPC Optimization**: When running on a cluster, use the `--profile` flag (e.g., `slurm`) to allow the underlying Snakemake engine to manage job submissions and resource allocation automatically.
- **Dependency Isolation**: Use the `--use-singularity` flag in production environments. This ensures that the exact versions of alignment tools (like Bowtie2) and processing libraries are used, improving reproducibility.
- **Input Organization**: Ensure your FASTQ files follow standard naming conventions and are placed in the root of your analysis directory before initializing the pipeline.



## Subcommands

| Command | Description |
|---------|-------------|
| capcruncher | Command-line interface for capcruncher utilities. |
| capcruncher alignments | Alignment annotation, identification and deduplication. |
| fastq | Fastq splitting, deduplication and digestion. |
| genome | Genome wide methods digestion. |
| interactions | Reporter counting, storing, comparison and pileups |
| plot | Generates plots for the outputs produced by CapCruncher |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |

## Reference documentation

- [CapCruncher README](./references/github_com_sims-lab_CapCruncher_blob_master_README.md)
- [Pipeline Guide](./references/sims-lab_github_io_CapCruncher_pipeline.md)
- [CLI Reference](./references/sims-lab_github_io_CapCruncher_cli.md)