---
name: ggd
description: The ggd tool simplifies the acquisition of genomic data by providing a standardized interface for searching and installing pre-processed data recipes. Use when user asks to search for genomic datasets, install pre-processed data packages, or manage installed genomic files and environment variables.
homepage: https://github.com/gogetdata/ggd-cli
---

# ggd

## Overview
The `ggd` (Go Get Data) ecosystem simplifies the acquisition of genomic data by providing a standardized interface for searching and installing pre-processed data recipes. It eliminates the manual overhead of finding, downloading, and formatting genomic datasets by leveraging Conda's package management system. This skill provides the necessary procedural knowledge to navigate the ggd repository, install datasets into specific environments, and access the resulting files for downstream bioinformatics analysis.

## Setup and Configuration
Before using `ggd`, ensure your Conda environment is configured with the necessary channels in the following priority order:

```bash
conda config --add channels defaults
conda config --add channels ggd-genomics
conda config --add channels bioconda
conda config --add channels conda-forge
```

## Core CLI Workflows

### Finding Data
Use `ggd search` to locate specific genomes, annotations, or data types.
- **Basic search**: `ggd search reference genome`
- **Filtered search**: Use specific keywords like species (e.g., `human`), build (e.g., `hg19`), or source (e.g., `ensembl`).

### Installing Packages
Installation handles the download and any necessary processing (sorting, indexing) automatically.
- **Command**: `ggd install <package-name>`
- **Example**: `ggd install grch38-reference-genome-ensembl-v1`

### Accessing Installed Data
GGD uses environment variables to make data access seamless in scripts.
- **Environment Variables**: After installation, ggd creates a variable named after the package (e.g., `$ggd_grch38_reference_genome_ensembl_v1`).
- **Locating Files**: Use `ggd get-files <package-name>` to get the absolute path to the data files.
- **Check Environment**: Use `ggd show-env` to see all currently available ggd data variables.

### Managing Local Data
- **List installed data**: `ggd list`
- **View package metadata**: `ggd pkg-info <package-name>`
- **Uninstalling**: Always use `ggd uninstall <package-name>` rather than manual deletion to ensure the local database and Conda environment remain synchronized.

## Expert Tips and Best Practices
- **Data Integrity**: Never move the original files installed by ggd. If you need the data elsewhere, create a copy. Moving files breaks ggd's ability to manage or uninstall the package.
- **Environment Isolation**: Install ggd data packages into specific Conda environments dedicated to a project to avoid version conflicts between different genomic builds.
- **Verification**: After installation, run `ggd list` to verify the package is correctly registered in the local ggd database.



## Subcommands

| Command | Description |
|---------|-------------|
| ggd check-recipe | Convert a ggd recipe created from `ggd make-recipe` into a data package. Test both ggd data recipe and data package |
| ggd install | Install a ggd data package into the current or specified conda environment |
| ggd list | Get a list of ggd data packages installed in the current or specified conda prefix/environment. |
| ggd make-meta-recipe | Make a ggd data meta-recipe |
| ggd make-recipe | Make a ggd data recipe from a bash script |
| ggd pkg-info | Get the information for a specific ggd data package installed in the current conda environment |
| ggd predict-path | Get a predicted install file path for a data package before it is installed. (Use for workflows, such as Snakemake) |
| ggd search | Search for available ggd data packages. Results are filtered by match score from high to low. (Only 5 results will be reported unless the -dn flag is changed) |
| ggd show-env | Display the environment variables for data packages installed in the current conda environment |
| ggd uninstall | Use ggd to uninstall a ggd data package installed in the current conda environment |
| ggd_get-files | Get a list of file(s) for a specific installed ggd package |

## Reference documentation
- [ggd-cli README](./references/github_com_gogetdata_ggd-cli_blob_master_README.md)
- [ggd-cli Overview](./references/github_com_gogetdata_ggd-cli.md)