---
name: metameta
description: MetaMeta is a pipeline that integrates multiple metagenome analysis tools to improve taxonomic profiling accuracy through a consensus approach. Use when user asks to perform taxonomic profiling, run multiple metagenome profilers simultaneously, or merge classification results from different tools.
homepage: https://github.com/pirovc/metameta/
---


# metameta

## Overview

MetaMeta is a pipeline designed to improve the accuracy of taxonomic profiling by integrating the outputs of several established metagenome analysis tools. It automates the complex process of running multiple profilers, managing their respective databases, and merging their results into a unified classification. By leveraging a consensus approach, it mitigates the biases and false positives often associated with individual profiling tools.

## Installation and Setup

MetaMeta is primarily distributed via Bioconda. It is recommended to install it within a dedicated Conda environment to manage dependencies effectively.

```bash
# Create and activate a dedicated environment
conda create -n metametaenv metameta=1.2.0
source activate metametaenv
```

Note: On the first execution, MetaMeta automatically downloads and installs configured tools and default databases (such as `archaea_bacteria_201503`) using the `--use-conda` flag.

## Core CLI Patterns

The `metameta` command is a wrapper around Snakemake. Most standard Snakemake arguments are supported.

### Standard Execution
To run the pipeline, you must provide a configuration file and specify the number of available CPU cores.

```bash
metameta --configfile yourconfig.yaml --use-conda --keep-going --cores 24
```

### Validation and Dry Runs
Before committing to a full run, use the dry-run flag to verify the execution plan and check for missing input files.

```bash
metameta --configfile yourconfig.yaml -np
```

### Cluster Execution
For high-performance computing (HPC) environments using Slurm or similar schedulers, use the cluster configuration flags.

```bash
metameta --configfile yourconfig.yaml --keep-going --use-conda -j 999 --cluster-config yourcluster.json --cluster "sbatch --job-name {cluster.job-name} --partition {cluster.partition} --cpus-per-task {cluster.cpus-per-task} --mem {cluster.mem}"
```

## Expert Tips and Best Practices

### Database Compatibility
Not all tools support every pre-configured database. When selecting a database, ensure your chosen tools are compatible:
- **archaea_bacteria_201503**: Supported by CLARK, DUDEs, GOTTCHA, Kaiju, Kraken, and mOTUs.
- **fungi_viral_201709**: Supported by CLARK, DUDEs, Kaiju, and Kraken (GOTTCHA and mOTUs are not supported).

### Custom Database Requirements
If creating custom databases, you must prepare files with specific extensions and header formats for each tool:
- **CLARK & DUDEs**: Requires `.fna` files with `accession.version` in the header.
- **Kaiju**: Requires `.gbff` (GenBank flat file) format.
- **Kraken**: Requires `.fna` files with the `gi` identifier in the header.

### Resource Management
The `--cores` argument defines the total cores available to the entire pipeline. To control the number of threads used by specific tools within the pipeline, define the `threads` parameter within your configuration file rather than at the command line.

### Path Handling
All paths defined in the configuration file are relative to the `workdir` unless specified as absolute paths. It is best practice to use absolute paths for `dbdir` and `samples` to avoid confusion when running the pipeline from different directories.

## Reference documentation
- [MetaMeta GitHub Repository](./references/github_com_pirovc_metameta.md)
- [Bioconda MetaMeta Overview](./references/anaconda_org_channels_bioconda_packages_metameta_overview.md)