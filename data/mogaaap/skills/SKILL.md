---
name: mogaaap
description: MoGAAAP is a modular Snakemake pipeline for eukaryotic genome assembly, annotation, and quality assessment. Use when user asks to assemble genomes from HiFi or ONT reads, perform quality assessment on existing scaffolds, or annotate genomes using a modular workflow.
homepage: https://github.com/dirkjanvw/MoGAAAP
metadata:
  docker_image: "quay.io/biocontainers/mogaaap:1.1.0--pyhdfd78af_0"
---

# mogaaap

## Overview

MoGAAAP (Modular Genome Assembly, Annotation and Assessment Pipeline) is a Snakemake-powered tool designed for eukaryotic genomics. While originally developed for plant genomes, it is species-agnostic. Its primary strength lies in its modularity; you can use it for a complete "reads-to-annotation" workflow or isolate specific tasks, such as performing quality assessment on a previously assembled scaffold or annotating a genome without re-running the assembly phase. It relies heavily on Apptainer (Singularity) for dependency management and requires specific database setups for functional annotation and contamination screening.

## Installation and Environment Setup

MoGAAAP is primarily distributed via Bioconda.

```bash
# Recommended installation via Conda
conda create -c conda-forge -c bioconda -n mogaaap mogaaap
conda activate mogaaap
```

### Critical Environment Variables
Because MoGAAAP uses Apptainer containers, you must configure your `.bashrc` to allow the containers to access your file system. Failure to set `APPTAINER_BIND` will result in "File not found" errors inside the pipeline.

- **APPTAINER_BIND**: Must include the paths for all input data, output directories, and the GXDB database.
- **APPTAINER_CACHEDIR**: Recommended to set this to a high-capacity drive to avoid filling up home directory quotas.

## Core CLI Operations

### 1. Database Preparation
The pipeline requires approximately 900GB of database storage (GXDB, Kraken2 nt, and OMA). Use the built-in helper to automate this:

```bash
# Download all required databases to a specific directory
MoGAAAP download_databases -d /path/to/databases/ all
```

### 2. Project Initialization
Before running a workflow, you must initialize a working directory. This creates the necessary folder structure and template configuration files.

```bash
MoGAAAP init -d working_directory
```

### 3. Sample Sheet Configuration
MoGAAAP uses a TSV (Tab-Separated Values) file to define samples. This file should be placed in `working_directory/config/`.

**Required Columns for the TSV:**
- `accessionId`: Unique name for the sample.
- `haplotypes`: 1 for homozygous, 2 for heterozygous.
- `speciesName`: Used for gene naming.
- `taxId`: NCBI taxonomy ID.
- `referenceId`: Identifier for the reference genome defined in the main config.

**Data Input Logic:**
- To **Assemble**: Provide `hifi` or `ont` paths.
- To **QA Only**: Provide `assemblyLocation` (FASTA). This skips the assembly stage.
- To **Annotate Only**: Provide `assemblyLocation` and leave `annotationLocation` empty.

## Expert Tips and Best Practices

- **Modular QA**: If you already have a scaffolded assembly from another tool (like HiCanu or Hifiasm), use the `assemblyLocation` column in your sample sheet. MoGAAAP will automatically pivot to Quality Assessment mode.
- **GPU Acceleration**: If your system has a GPU, set `export APPTAINER_NV=1` to allow Helixer (used in annotation) to utilize hardware acceleration, significantly speeding up gene prediction.
- **Memory Management**: Ensure the GXDB database path is explicitly bound in your Apptainer settings, as the FCS (Foreign Contamination Screen) module will fail if it cannot see the database mount point.
- **Hi-C Integration**: When using Hi-C data for scaffolding, ensure you provide both `hic_1` and `hic_2` in the sample sheet. MoGAAAP can use YAHS for scaffolding prior to other joining steps.

## Reference documentation
- [MoGAAAP Overview](./references/anaconda_org_channels_bioconda_packages_mogaaap_overview.md)
- [MoGAAAP GitHub Repository](./references/github_com_dirkjanvw_MoGAAAP.md)