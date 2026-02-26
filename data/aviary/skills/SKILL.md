---
name: aviary
description: Aviary is a bioinformatics wrapper for Snakemake-based metagenomics workflows that processes raw sequencing reads into annotated metagenome-assembled genomes. Use when user asks to assemble metagenomes, recover bins, annotate genomes, cluster MAGs, or run an end-to-end hybrid sequencing pipeline.
homepage: https://github.com/rhysnewell/aviary/
---


# aviary

## Overview

Aviary is a comprehensive bioinformatics wrapper for Snakemake-based metagenomics workflows. It streamlines the transition from raw sequencing reads to refined, annotated Metagenome-Assembled Genomes (MAGs). The tool is designed to be modular, allowing users to run specific stages—such as assembly, binning, or annotation—independently or as a continuous end-to-end pipeline. It is particularly optimized for hybrid sequencing projects that leverage both short-read accuracy and long-read contiguity.

## Core Workflows

### 1. Database Configuration
Aviary requires several large databases (GTDB, EggNog, CheckM2, SingleM). Before running analysis, ensure these are configured.

*   **Automatic Setup**: Use the `--download` flag with any module to trigger database installation.
*   **Manual Configuration**: Use the `configure` module to point to existing database paths:
    `aviary configure -o logs/ --eggnog-db-path /path/to/eggnog/ --gtdb-path /path/to/gtdb/ --download`

### 2. End-to-End Pipeline
To run the entire workflow (assemble, recover, annotate, and genotype) in a single command:
`aviary complete -o output_dir/ --short1 reads_R1.fastq.gz --short2 reads_R2.fastq.gz --long long_reads.fastq.gz`

### 3. Modular Execution
If the assembly is already completed or if only specific tasks are needed, use individual modules:

*   **Assembly**: Perform hybrid or short-read only assembly.
    `aviary assemble -o assembly_out/ --short1 R1.fq --short2 R2.fq --long long.fq`
*   **MAG Recovery**: Extract bins from an existing assembly.
    `aviary recover -o recovery_out/ -a assembly.fasta --short1 R1.fq --short2 R2.fq`
*   **Annotation**: Annotate provided MAGs using EggNOG and GTDB-tk.
    `aviary annotate -o annotation_out/ --bins_directory path/to/bins/`
*   **Clustering**: Dereplicate MAGs from multiple independent Aviary runs.
    `aviary cluster -o clustered_out/ --aviary_directories run1/ run2/ run3/`

## Expert Tips and Best Practices

*   **Hybrid vs. Short-read**: While Aviary excels at hybrid assembly, it can function with short reads only. If long reads are unavailable, simply omit the `--long` parameter.
*   **Environment Variables**: Aviary relies on specific environment variables for database paths (e.g., `GTDBTK_DATA_PATH`, `EGGNOG_DATA_DIR`). If moving to a new system, use `aviary configure` to update these paths globally for your environment.
*   **Resource Management**: Metagenomic assembly and annotation are resource-intensive. Always specify output directories with `-o` to keep logs and intermediate Snakemake files organized.
*   **Strain Diversity**: Use the `genotype` module (powered by Lorikeet) specifically when you need to resolve strain-level differences within your MAGs.
*   **Check Installation**: Verify the environment and available modules by running `aviary --help`.

## Reference documentation
- [Aviary GitHub Repository](./references/github_com_rhysnewell_aviary.md)
- [Aviary Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_aviary_overview.md)