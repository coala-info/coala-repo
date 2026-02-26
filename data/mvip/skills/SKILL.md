---
name: mvip
description: The mvip tool is a Python-based framework that automates the processing, identification, and annotation of large-scale viral sequencing data. Use when user asks to identify viral sequences, assess genome quality, cluster sequences into vOTUs, or perform functional annotation of viromics data.
homepage: https://gitlab.com/ccoclet/mvp
---


# mvip

## Overview
The Multi-tool Viromics Pipeline (MVP), executed via the `mvip` command, is a Python-based framework designed to standardize the processing of large-scale viral sequencing data. It automates a complex multi-step workflow that includes viral identification, quality assessment, clustering into viral Operational Taxonomic Units (vOTUs), and functional annotation. This skill provides the necessary CLI patterns and operational guidance to navigate the pipeline's modular structure.

## Installation and Setup
The pipeline is primarily distributed via Bioconda. Ensure the environment is properly configured to avoid "command not found" errors.

```bash
# Installation via Conda/Mamba
conda install bioconda::mvip

# Verify installation
mvip -h
```

## Core CLI Usage
The `mvip` tool operates through a series of numbered modules. While specific subcommands for every step are handled by the internal logic, the primary entry point is the `mvip` binary.

### General Syntax
```bash
mvip [module_options] [arguments]
```

### Common Workflow Steps
The pipeline typically follows these functional stages:
1.  **Identification**: Detecting viral sequences within contigs (e.g., using geNomad).
2.  **Quality Control**: Assessing genome completeness and contamination.
3.  **Clustering**: Grouping sequences into vOTUs to reduce redundancy.
4.  **Annotation**: Assigning taxonomic labels and functional roles to viral genes.
5.  **Binning**: Organizing viral fragments into bins.
6.  **Summary**: Generating comprehensive reports for downstream ecological analysis.

## Expert Tips and Best Practices
*   **Database Management**: MVP relies on external databases (e.g., geNomad, HMM profiles). Ensure the `00_DATABASES` directory is correctly populated and accessible. If the pipeline fails to find databases, check environment variables or specific flags for database paths.
*   **Execution Time**: Module 06 (often involving Prodigal or intensive HMM searches) is computationally expensive and can take several days on large datasets. Do not interrupt the process if files are still being generated in the module directory.
*   **Resource Allocation**: When running on clusters, ensure sufficient I/O throughput. Slow disk access significantly impacts the performance of the clustering and annotation modules.
*   **Troubleshooting "Command Not Found"**: If `mvip` is not recognized after activation, try reinstalling within a fresh Conda environment to ensure all entry points are correctly linked.
*   **Input Data**: The pipeline is robust for metagenomes, metatranscriptomes, and isolate genomes. Ensure contig headers are clean and do not contain special characters that might break downstream parsing tools.

## Reference documentation
- [mvip - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mvip_overview.md)
- [Clement Coclet / mvp · GitLab](./references/gitlab_com_ccoclet_mvp.md)