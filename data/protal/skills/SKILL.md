---
name: protal
description: Protal performs high-resolution taxonomic profiling and strain-resolved analysis of bacterial communities using universal marker genes. Use when user asks to perform taxonomic profiling, analyze shotgun metagenomic reads, or identify strains within bacterial communities.
homepage: https://github.com/4less/protal
metadata:
  docker_image: "quay.io/biocontainers/protal:0.2.0a--h5ca1c30_0"
---

# protal

## Overview
Protal is a computational tool designed for high-resolution taxonomic profiling of bacterial communities. It utilizes a reference-based approach focusing on the 120 universal marker genes used by GTDB (TIGRFAM, PFAM) to analyze paired-end short reads from shotgun metagenomic sequencing. This specialization allows for precise strain-resolved analyses while maintaining compatibility with other tools in the GTDB ecosystem.

## Installation
The preferred method for installation is via Bioconda:
```bash
conda install bioconda::protal
```
Note: Protal is currently supported only on Linux-64 systems.

## Command Line Usage

### Basic Execution
The primary entry point is the `protal` command. It typically requires paired-end short-read data as input.

### Getting Help
Protal uses a tiered help system to manage its various parameters:
- `protal --help`: Displays basic usage and common options.
- `protal --full_help`: Displays all available options, including advanced categories.
- `protal --map_help`: Displays specific help related to mapping flags and options.

### Key CLI Options
- `-v`: Display the current version.
- `--verbose`: Enable detailed logging of the analysis process.
- `--snp_min_cov <int>`: Set the minimum coverage threshold for internal SNP calling.
- `--snp_min_phred_sum <int>`: Set the minimum Phred score sum for user-adjusted SNP calling.

### Output Files
Protal generates several output files during analysis, including:
- `meta`: Taxonomic profiling results.
- `strain`: Strain-resolved analysis data.
- `snps_filtered`: Filtered SNP calls based on the provided coverage and quality thresholds.

## Expert Tips and Best Practices
- **GTDB Compatibility**: Since Protal uses the same 120 marker genes as GTDB, ensure your downstream analysis tools are also configured for GTDB r207 or later for maximum consistency.
- **SNP Tuning**: If your analysis requires specific sensitivity for strain detection, manually adjust `--snp_min_cov` and `--snp_min_phred_sum`. Default values are optimized for general use, but low-abundance strains may require lower coverage thresholds.
- **Hardware Requirements**: Protal is optimized for Linux environments. Ensure your environment has AVX2 support if using the standard binary; otherwise, the `protal_launcher` will attempt to select the most compatible version for your CPU architecture.
- **Input Format**: Currently, Protal is optimized for paired-end reads. Single-end mode support may be unstable in certain versions; always verify your read orientation before starting a large-scale run.

## Reference documentation
- [Protal Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_protal_overview.md)
- [Protal GitHub Repository](./references/github_com_4less_protal.md)
- [Protal Commit History](./references/github_com_4less_protal_commits_alpha.md)