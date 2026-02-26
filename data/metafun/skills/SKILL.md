---
name: metafun
description: metaFun is a modular pipeline for the comprehensive analysis of metagenomic and comparative genomic data. Use when user asks to perform quality control on raw reads, conduct strain-level microbial diversity analysis, or download reference databases for functional and taxonomic assignments.
homepage: https://github.com/aababc1/metaFun
---


# metafun

## Overview

metaFun is a modular, scalable pipeline designed for the comprehensive analysis of metagenomic and comparative genomic data. It automates complex bioinformatics workflows—including quality control, assembly, binning, and functional searches—into a unified command-line interface. It is particularly useful for researchers handling large-scale metagenomic datasets who require agile processing from raw reads to strain-level microbial diversity insights.

## Installation and Setup

Before running analysis, ensure the environment is configured and the necessary databases are present.

### Environment Setup
Install metaFun using Conda or Mamba:
```bash
conda create -c bioconda -c conda-forge -n metafun metafun
conda activate metafun
```

### Database Management
The pipeline requires specific reference databases for functional and taxonomic assignments. This must be run before any analysis modules:
```bash
metafun -module DOWNLOAD_DB
```

## Command Line Usage

metaFun operates using a module-based system. The general syntax is:
`metafun -module <MODULE_NAME> -i <input_directory> [options]`

### Common Modules
- **RAWREAD_QC**: Performs quality control on raw sequencing reads.
- **WMS_STRAIN**: Conducts strain-level microbial diversity analysis (available in version 1.0.0+).
- **DOWNLOAD_DB**: Downloads and prepares required reference databases.

### Example: Running Quality Control
To process raw reads located in a directory named `input_reads/`:
```bash
metafun -module RAWREAD_QC -i input_reads/
```

## Best Practices and Troubleshooting

- **Log Monitoring**: metaFun is built on Nextflow. If a run fails, inspect the following files in the execution directory for detailed error reports:
  - `.nextflow.log`: High-level workflow execution logs.
  - `.command.log`: Specific logs for the failed task/command.
- **Input Structure**: Ensure your input directory contains the appropriate fastq/fasta files. The pipeline typically expects standardized naming conventions for paired-end data.
- **Resource Allocation**: For large-scale "big data" metagenomics, ensure your environment has sufficient memory and CPU cores, as assembly and binning modules are resource-intensive.
- **Version Check**: Use strain-level analysis (`WMS_STRAIN`) only if you are running version 1.0.0 or later.

## Reference documentation
- [metaFun Overview](./references/anaconda_org_channels_bioconda_packages_metafun_overview.md)
- [metaFun GitHub Repository](./references/github_com_aababc1_metaFun.md)