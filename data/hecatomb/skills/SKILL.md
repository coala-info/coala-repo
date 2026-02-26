---
name: hecatomb
description: Hecatomb is an end-to-end bioinformatic platform designed to extract and classify viral signals from complex metagenomic datasets. Use when user asks to identify viral contigs, perform viral taxonomic classification, or run a viral metagenomics pipeline on short-read or long-read data.
homepage: https://github.com/shandley/hecatomb
---


# hecatomb

## Overview

Hecatomb is an end-to-end bioinformatic platform specifically engineered for viral metagenomics. It streamlines the process of extracting viral signals from complex metagenomic backgrounds by prioritizing the removal of false positives (the "sacrifice") to enrich for high-confidence viral contigs and reads. The tool manages the entire workflow from raw read trimming and host depletion to assembly and taxonomic classification. It is particularly useful for researchers looking for a standardized, reproducible pipeline that handles both short-read and long-read technologies within a Snakemake-powered environment.

## Installation and Setup

Before running analysis, the environment must be initialized and databases must be populated.

- **Install via Conda**: `conda create -n hecatomb -c conda-forge -c bioconda hecatomb`
- **Database Initialization**: Download the required viral and taxonomic databases. Use multiple threads to accelerate the download.
  `hecatomb install --threads 8`
- **Environment Pre-building**: If working on an HPC cluster where compute nodes lack internet access, pre-build the required software environments on a login node first.
  `hecatomb test build_envs`

## Core CLI Patterns

### Running Analysis
The primary execution involves specifying the input reads and the computational resources.

- **Basic Run (Local)**:
  `hecatomb run --reads path/to/reads --threads 32`
- **Long-read Analysis**: Explicitly flag the use of long-read data (e.g., Oxford Nanopore).
  `hecatomb run --reads path/to/reads --longreads --threads 32`

### Input Specifications
Hecatomb is flexible with how it consumes sequence data via the `--reads` argument.

- **Directory Input**: Point to a folder containing FASTQ files. Hecatomb automatically pairs R1 and R2 files based on common naming conventions.
- **TSV Input**: For complex datasets or specific sample naming, provide a Tab-Separated Values file.
  - Column 1: Sample Name
  - Column 2: Forward Reads (R1)
  - Column 3: Reverse Reads (R2) (Optional for single-end)

### Library Preprocessing
Control how reads are cleaned using the `--trim` flag. Supported methods include:
- `fastp` (Default for short reads)
- `prinseq`
- `filtlong` (Optimized for long reads)
- `notrim` (Use if reads are already QC'd and host-filtered)

## HPC and Cluster Execution

Hecatomb leverages Snakemake profiles to manage job submissions on clusters (Slurm, SGE, etc.).

- **Using a Profile**:
  `hecatomb run --reads path/to/reads --profile slurm`
- **Note on Snakemake Versions**: Hecatomb is optimized for Snakemake v7. If using Snakemake v8 or higher, ensure your profiles are compatible with the updated CLI syntax, as breaking changes in Snakemake may affect cluster job submission.

## Expert Tips and Best Practices

- **Validation**: Always run the internal test suite after a new installation to ensure the pipeline and databases are correctly configured.
  `hecatomb test --threads 8`
- **Resource Management**: Viral assembly is memory-intensive. If the pipeline fails during the assembly stage, check the configuration to ensure at least 64GB of RAM is available for standard datasets.
- **Host Removal**: By default, Hecatomb filters against common host genomes. If working with non-standard hosts, you may need to modify the configuration to include specific host genomes for depletion.
- **Config Customization**: To tweak advanced parameters (e.g., assembly k-mers or alignment identity thresholds), generate a local config file:
  `hecatomb config .`
  Then edit the resulting `hecatomb.out/hecatomb.config.yaml` before running the pipeline.

## Reference documentation
- [Hecatomb GitHub Repository](./references/github_com_shandley_hecatomb.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hecatomb_overview.md)