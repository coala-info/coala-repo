---
name: quantpi
description: Quantpi is a microbiome profiling system that orchestrates metagenomic workflows to transform raw sequencing data into taxonomic and functional abundance tables. Use when user asks to initialize microbiome projects, generate sample sheets, or execute profiling pipelines using tools like Kraken2, MetaPhlAn, and HUMAnN3.
homepage: https://github.com/ohmeta/quantpi
---


# quantpi

## Overview
Quantpi is a robust microbiome profiling system that orchestrates complex metagenomic workflows. It streamlines the transition from raw sequencing data to processed abundance tables by wrapping various bioinformatics tools into a unified command-line interface. Use this skill to initialize microbiome projects, generate sample sheets, and execute standardized profiling pipelines for taxonomic and functional characterization of microbial communities.

## Installation and Environment
The recommended way to use quantpi is via a dedicated Conda environment to manage its extensive dependencies.

```bash
# Create and activate environment
conda create -n quantpi-env -c bioconda -c conda-forge quantpi snakemake
conda activate quantpi-env
```

## Project Initialization
Every analysis begins with the `init` subcommand to set up the project structure and configuration.

### Preparing the Sample Sheet
Quantpi requires a TSV file (`samples.tsv`) to identify input data.
- **For Fastq files**: Header must be `sample_id`, `fq1`, `fq2`.
- **For SRA data**: Header must be `sample_id`, `sra`.
- **For Simulations**: Header must be `id`, `genome`, `abundance`, `reads_num`, `model`.

### Running Init
```bash
# Basic initialization
quantpi init -d ./my_project -s samples.tsv

# Initialization with specific preprocessing options
quantpi init -d ./my_project -s samples.tsv --trimmer fastp --rmhoster bowtie2 --begin trimming
```

## Executing Workflows
Quantpi uses Snakemake internally to manage execution. You can list available targets or run specific profiling modules.

### Listing Available Targets
To see all possible profiling steps and outputs:
```bash
quantpi profiling_wf --list
```

### Common Profiling Commands
Run these commands from within your project directory:

- **Taxonomic Profiling (Kraken2/Bracken)**:
  ```bash
  quantpi profiling_wf --until profiling_kraken2_all
  quantpi profiling_wf --until profiling_bracken_all
  ```

- **Taxonomic Profiling (MetaPhlAn)**:
  ```bash
  quantpi profiling_wf --until profiling_metaphlan3_all
  ```

- **Functional Profiling (HUMAnN3)**:
  ```bash
  quantpi profiling_wf --until profiling_humann3_all
  ```

- **Full Pipeline**:
  ```bash
  quantpi profiling_wf --until profiling_all
  ```

## Best Practices
- **Workdir Management**: Always specify the `-d` (workdir) flag during `init` to keep raw data and results organized.
- **Starting Points**: Use the `-b` or `--begin` flag if your data is already pre-processed (e.g., start at `profiling` if host sequences are already removed).
- **Resource Allocation**: Since quantpi wraps Snakemake, you can often pass execution parameters like `--cores` to manage computational load during the `profiling_wf` step.
- **Sample Validation**: Use the `--check-samples` flag during initialization to ensure your TSV paths are valid before starting long-running jobs.

## Reference documentation
- [Microbiome profiling pipeline overview](./references/github_com_ohmeta_quantpi.md)
- [Bioconda package details](./references/anaconda_org_channels_bioconda_packages_quantpi_overview.md)