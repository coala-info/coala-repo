---
name: titan-gc
description: Titan-gc processes raw viral sequencing data to provide genomic insights through automated multi-step procedures. Use when user asks to process viral sequencing data, clean reads, assemble viral genomes, call variants, assign clades or lineages, characterize viral genomes for specific pathogens, or prepare data for GISAID or GenBank submission.
homepage: https://github.com/theiagen/public_health_viral_genomics
metadata:
  docker_image: "quay.io/biocontainers/titan-gc:1.5.3--hdfd78af_1"
---

# titan-gc

## Overview
The titan-gc skill provides a specialized interface for the Titan genomic characterization workflow. This tool is designed for public health bioinformaticians to process raw viral sequencing data into actionable genomic insights. It automates complex multi-step procedures including read cleaning, assembly, variant calling, and clade/lineage assignment (using integrated tools like Pangolin and Nextclade). This skill focuses on the command-line implementation of these workflows, which are primarily written in Workflow Description Language (WDL) but accessible via the titan-gc CLI wrapper.

## Installation and Environment Setup
To use titan-gc, ensure the environment is properly configured via Bioconda.

- **Standard Installation**:
  `conda install bioconda::titan-gc`
- **Environment Best Practice**: Always create a dedicated environment to avoid dependency conflicts with other bioinformatics tools:
  `conda create -n titan -c bioconda -c conda-forge titan-gc`

## Core Workflows and Pathogens
The tool supports specific genomic characterization tracks for various pathogens of concern:
- **SARS-CoV-2 (TheiaCoV)**: Supports Illumina (PE/SE), Oxford Nanopore (ONT), and ClearLabs platforms.
- **Influenza**: Subtyping and characterization via the IRMA track.
- **Monkeypox (MPXV)**: Targeted assembly and characterization.
- **West Nile Virus (WNV)**: Support for VADR-based annotation.

## Command-Line Usage Patterns
While titan-gc acts as a wrapper for WDL workflows, the CLI execution generally follows these patterns:

- **Local Execution**: Use titan-gc to trigger workflows locally using `miniWDL` or `Cromwell`.
- **Input Requirements**: Most workflows require a JSON input file defining the paths to FASTQ files, reference genomes, and specific tool parameters (e.g., minimum coverage depth).
- **Resource Management**: When running on local hardware or HPC, specify CPU and memory limits to prevent resource exhaustion during high-depth viral assembly.

## Expert Tips and Best Practices
- **Read Filtering**: Ensure `bbduk` or `fastp` tasks are enabled within your configuration to remove low-quality reads and adapters before assembly.
- **Lineage Updates**: Viral lineages (Pangolin/Nextclade) change frequently. Ensure your Docker/Singularity containers or local databases are updated to the latest tags (e.g., `2023-02-25T12:00:00Z` for Nextclade SC2) to ensure accurate reporting.
- **Handling Large Datasets**: If `fastq-scan` or `IRMA` fails due to high read volume, consider subsampling your FASTQ files to a target depth (e.g., 100x-200x) to improve stability and speed.
- **Submission Preparation**: Use the Mercury tracks within titan-gc to generate outputs formatted specifically for GISAID or GenBank submissions.

## Reference documentation
- [Bioconda titan-gc Overview](./references/anaconda_org_channels_bioconda_packages_titan-gc_overview.md)
- [Theiagen Public Health Viral Genomics GitHub](./references/github_com_theiagen_public_health_viral_genomics.md)
- [Known Issues and Troubleshooting](./references/github_com_theiagen_public_health_viral_genomics_issues.md)