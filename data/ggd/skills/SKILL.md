---
name: ggd
description: GGD is a package manager for genomic data that automates the discovery, installation, and management of processed genomic files. Use when user asks to search for genomic data recipes, install reference genomes or annotations into environments, manage data environment variables, or uninstall genomic data packages.
homepage: https://github.com/gogetdata/ggd-cli
---


# ggd

## Overview

GGD (GoGetData) acts as a package manager specifically for genomic data, functioning similarly to how Conda manages software. It eliminates the manual burden of finding, downloading, and processing standard genomic files (like reference genomes, annotations, and VCFs). Use this skill to discover curated data recipes, install them into specific environments, and access the resulting files through standardized environment variables. This ensures that data used in bioinformatics pipelines is versioned, reproducible, and easily shared across different compute environments.

## Environment Setup

Before using GGD, ensure the required Conda channels are configured in the following order:

```bash
conda config --add channels defaults
conda config --add channels ggd-genomics
conda config --add channels bioconda
conda config --add channels conda-forge
```

## Core CLI Workflows

### Searching for Data
Search for specific organisms, builds, or data types using keywords.

*   **General search**: `ggd search reference genome`
*   **Specific build search**: `ggd search hg38`
*   **Filter results**: Use `ggd search` with additional keywords to narrow down the repository of available recipes.

### Installing and Accessing Data
GGD installs data into your active Conda environment and creates environment variables for easy access.

*   **Install a package**: `ggd install <package-name>`
*   **Locate installed files**: `ggd get-files <package-name>`
*   **View environment variables**: `ggd show-env`
    *   GGD creates variables following the pattern `$ggd_<package_name>_dir`. Use these in scripts to maintain portability.
*   **Check package metadata**: `ggd pkg-info <package-name>`

### Managing Environments
GGD allows you to manage data in environments other than your current one.

*   **Cross-environment installation**: `ggd install <package-name> --prefix /path/to/other/env`
*   **List data in specific env**: `ggd list --prefix /path/to/other/env`
*   **Access data without activation**: Use the `--prefix` flag with `get-files` to retrieve paths from a central data environment.

### Uninstalling Data
Always use the GGD tool to uninstall packages to ensure that environment variables and metadata are cleaned up correctly.

*   **Proper removal**: `ggd uninstall <package-name>`
*   **Warning**: Do not manually delete files from the installation directory, as this breaks GGD's internal tracking.

## Expert Tips

*   **Avoid Redundancy**: Use a dedicated Conda environment for all GGD data and use the `--prefix` flag to access that data from your various analysis environments. This prevents duplicating large genomic files across your system.
*   **Scripting Integration**: Always use the environment variables (e.g., `cd $ggd_grch38_reference_genome_ensembl_v1_dir`) in your bash scripts or Nextflow/Snakemake workflows instead of hardcoded paths.
*   **Recipe Requests**: If a specific dataset is missing, GGD provides a `make-recipe` command to help generate a new data package from a bash script.

## Reference documentation
- [GGD CLI Overview](./references/github_com_gogetdata_ggd-cli.md)
- [Anaconda GGD Package Details](./references/anaconda_org_channels_bioconda_packages_ggd_overview.md)