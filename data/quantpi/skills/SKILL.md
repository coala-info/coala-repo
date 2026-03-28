---
name: quantpi
description: The quantpi tool is a comprehensive profiling system that transforms raw sequencing data into taxonomic and functional microbiome profiles through unified bioinformatics workflows. Use when user asks to initialize a microbiome project, perform taxonomic classification with Kraken2 or MetaPhlAn3, conduct functional profiling with HUMAnN3, or simulate metagenomic datasets.
homepage: https://github.com/ohmeta/quantpi
---

# quantpi

## Overview

The `quantpi` tool is a comprehensive profiling system designed for microbiome research. It streamlines the transition from raw sequencing data to taxonomic and functional profiles by wrapping complex bioinformatics workflows into a unified command-line interface. It is particularly useful for researchers who need to perform standardized preprocessing (trimming and host removal) followed by multi-method taxonomic classification or functional analysis.

## Core Workflows

### Project Initialization
Before running a pipeline, you must initialize the workspace. This creates the necessary directory structure and configuration.

```bash
# Basic initialization
quantpi init -d ./my_project -s samples.tsv -b trimming

# Initialization with specific tools
quantpi init --trimmer fastp --rmhoster bowtie2 -b rmhost
```

### Sample Sheet Requirements (`samples.tsv`)
The input TSV file must follow specific header formats based on the starting point (`-b`):

*   **Trimming/RMHost/Profiling (Fastq):** `sample_id`, `fq1`, `fq2`
*   **Trimming/RMHost/Profiling (SRA):** `sample_id`, `sra`
*   **Simulation:** `id`, `genome`, `abundance`, `reads_num`, `model`

### Executing Profiling Pipelines
`quantpi` supports several specialized sub-workflows for metagenomic analysis:

*   **Taxonomic Classification:**
    *   `profiling_kraken2_all`: Standard k-mer based classification.
    *   `profiling_bracken_all`: Bayesian re-estimation of abundance.
    *   `profiling_kmcp_all`: Classification using the KMCP tool.
*   **Genome Coverage:**
    *   `profiling_genomecov_all`: General coverage analysis.
    *   `profiling_genome_coverm_all`: Coverage calculation via CoverM.
*   **Functional & Marker-based Profiling:**
    *   `profiling_metaphlan3_all`: Marker-gene based taxonomic profiling.
    *   `profiling_humann3_all`: Functional metabolic profiling.

## Expert Tips and Best Practices

*   **Environment Management:** Always ensure the `quantpi-env` is active. The tool relies on a specific stack of dependencies including Snakemake, Mamba, and various Biopython libraries.
*   **PYTHONPATH Configuration:** If installing from source (GitHub), ensure the path to the repository is added to your `PYTHONPATH` to allow the `run_quantpi.py` script to locate internal modules.
*   **Host Removal:** When using `--rmhoster`, ensure your reference database (e.g., for Bowtie2 or Kraken2) is correctly indexed and accessible in your environment configuration.
*   **Simulation:** Use the `simulate_wf` subcommand to generate mock datasets for validating your profiling parameters before running on real-world samples.



## Subcommands

| Command | Description |
|---------|-------------|
| quantpi simulate_wf | Pipeline for simulating data with quantpi |
| quantpi_init | Initialize a quantpi project. |
| quantpi_profiling_wf | Pipeline end point. |
| quantpi_sync | Sync project data to a directory. |

## Reference documentation
- [Microbiome profiling pipeline overview](./references/github_com_ohmeta_quantpi_blob_main_README.md)
- [Quantpi initialization and CLI usage](./references/github_com_ohmeta_quantpi.md)