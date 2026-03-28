---
name: aviary
description: Aviary is a Snakemake-based wrapper that automates complex metagenomics workflows from raw sequencing data to annotated genomes. Use when user asks to perform hybrid or short-read assembly, recover metagenome-assembled genomes, annotate MAGs, or analyze strain-level diversity.
homepage: https://github.com/rhysnewell/aviary/
---

# aviary

## Overview

Aviary is a Snakemake-based wrapper designed to simplify complex metagenomics workflows. It provides a modular interface for processing raw sequencing data into annotated genomes. It is particularly effective for hybrid assembly (combining Illumina and Oxford Nanopore/PacBio reads) and offers a streamlined path from assembly to strain-level diversity analysis.

## Core Modules and CLI Patterns

Aviary is executed via subcommands corresponding to specific stages of the metagenomic pipeline.

### 1. Environment Configuration
Before running the pipeline, ensure databases (GTDB, EggNog, CheckM2, SingleM) are configured.
- **Automatic Setup**: Use the `--download` flag with any module to trigger database installation.
- **Manual Configuration**: Use the `configure` module to point to existing database paths.
  ```bash
  aviary configure --eggnog-db-path /path/to/eggnog/ --gtdb-path /path/to/gtdb/ --download
  ```

### 2. Assembly (`assemble`)
Performs short-read only or hybrid assembly.
- **Hybrid Assembly**: Provide both short reads (`-1`, `-2`) and long reads (`-L`).
- **Short-read Only**: Omit the `-L` parameter.

### 3. MAG Recovery (`recover`)
Recovers genomes from an existing assembly using multiple binning algorithms.
- Use this if you already have a `contigs.fasta` file and want to identify individual organisms.

### 4. Annotation and Genotyping
- **`annotate`**: Assigns taxonomy via GTDB-tk and functional metadata via EggNOG-mapper.
- **`genotype`**: Analyzes strain-level diversity using Lorikeet.

### 5. End-to-End Workflow (`complete`)
Runs the entire pipeline sequentially: `assemble` -> `recover` -> `annotate` -> `genotype`.
- This is the preferred command for new projects where raw reads are the starting point.

### 6. Multi-run Clustering (`cluster`)
Combines and dereplicates MAGs from multiple independent Aviary runs using the Galah algorithm.
- Essential for comparative metagenomics across different samples or environments.

## Expert Tips and Best Practices

- **Database Storage**: Metagenomic databases are exceptionally large (hundreds of GBs). Always verify available disk space before using the `--download` flag.
- **Resource Management**: Since Aviary wraps Snakemake, it inherits robust task scheduling. Ensure your environment has sufficient threads and memory allocated, as assembly and GTDB-tk are resource-intensive.
- **Module Independence**: Each module can be run independently. If an assembly fails or needs manual curation, you can restart the pipeline from the `recover` or `annotate` stage without re-running the assembly.
- **Conda Integration**: Aviary manages its own dependencies via Conda environments. Ensure your Conda channels are prioritized correctly (`conda-forge` > `bioconda` > `defaults`) to avoid version conflicts.



## Subcommands

| Command | Description |
|---------|-------------|
| aviary annotate | Annotate a given set of MAGs using EggNOG, GTDB-tk, and Checkm2 |
| aviary assemble | Step-down hybrid assembly using long and short reads, or assembly using only short or long reads. |
| aviary batch | Performs all steps in the Aviary pipeline on a batch file. Each line in the batch file is processed separately and then clustered using aviary. (Assembly > Binning > Refinement > Annotation > Diversity) * n_samples --> Cluster |
| aviary cluster | Clusters previous aviary runs together and performsdereplication using Galah |
| aviary complete | Performs all steps in the Aviary pipeline. Assembly > Binning > Refinement > Annotation > Diversity |
| aviary configure | Sets the conda environment variables for future runs and downloads databases. |
| aviary diversity | Perform strain diversity analysis |
| aviary isolate | Step-down hybrid assembly using long and short reads, or assembly using only short or long reads. |
| aviary recover | The aviary binning pipeline |

## Reference documentation
- [Aviary GitHub README](./references/github_com_rhysnewell_aviary_blob_main_README.md)
- [Aviary Overview and Installation](./references/anaconda_org_channels_bioconda_packages_aviary_overview.md)