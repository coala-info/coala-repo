---
name: metapi
description: metapi is a modular metagenomics data mining system designed to automate the transition from raw sequencing data to refined genomic bins and gene catalogs.
homepage: https://github.com/ohmeta/metapi
---

# metapi

## Overview

metapi is a modular metagenomics data mining system designed to automate the transition from raw sequencing data to refined genomic bins and gene catalogs. It leverages a subcommand-based architecture to handle project initialization, read simulation, and the execution of Metagenome-Assembled Genome (MAG) or gene-centric pipelines. This skill assists in configuring the necessary sample sheets and navigating the CLI to run specific stages of the metagenomic workflow, from quality control to taxonomic classification.

## Installation

The recommended method for installing metapi is via Mamba to ensure all dependencies are correctly resolved:

```bash
mamba install -c conda-forge -c bioconda metapi=3.0.0
```

## Project Initialization

Every metapi project must begin with the `init` command. This creates the required directory structure, including logs, results, and environment configurations.

### Sample Sheet Requirements
A `samples.tsv` file is mandatory. The header format depends on your starting point:
- **Standard (FastQ):** `sample_id, assembly_group, binning_group, fq1, fq2`
- **SRA-based:** `sample_id, assembly_group, binning_group, sra`
- **Simulation:** `id, genome, abundance, reads_num, model`

### Common Initialization Patterns
Initialize a project starting from quality control (trimming):
```bash
metapi init -s samples.tsv -d ./project_dir -b trimming --trimmer fastp --rmhoster bowtie2
```

Initialize a project starting directly from binning (requires existing assemblies):
```bash
metapi init -s samples.tsv -d ./project_dir -b binning --assembler metaspades --binner metabat2 concoct
```

## Workflow Execution

metapi uses `mag_wf` for genome-centric workflows and `gene_wf` for gene-centric workflows.

### Executing the MAG Pipeline
The `mag_wf` command requires a `TASK` positional argument to define the endpoint. If no task is specified, it defaults to `all`.

- **Run the full pipeline:**
  ```bash
  metapi mag_wf -d ./project_dir --use-conda
  ```

- **Run up to a specific stage (e.g., Assembly only):**
  ```bash
  metapi mag_wf assembly_all -d ./project_dir --use-conda
  ```

- **Run Binning and CheckM only:**
  ```bash
  metapi mag_wf binning_all checkm_all -d ./project_dir --use-conda
  ```

### Cluster Integration
metapi supports various cluster engines. Use the `--cluster-engine` flag to specify your environment:
```bash
metapi mag_wf --cluster-engine slurm --use-conda
```
Supported engines: `slurm`, `sge`, `lsf`, `pbs-torque`.

## Expert Tips and Best Practices

- **Begin Points:** Use the `-b` flag during `init` to skip unnecessary steps. For example, if your reads are already filtered for host DNA, start at `assembly`.
- **Tool Selection:** metapi supports multiple tools for the same task (e.g., `sickle`, `fastp`, or `trimmomatic` for trimming). Specify your preference during `init` to avoid using defaults that may not suit your data.
- **Dry Runs:** Since metapi is powered by Snakemake, you can often verify the execution plan by checking the generated `config.yaml` in the project directory after initialization.
- **Environment Management:** Always use the `--use-conda` flag when running workflows to ensure that metapi can automatically manage the specific software versions required for each step of the pipeline.

## Reference documentation
- [metapi GitHub Repository](./references/github_com_ohmeta_metapi.md)
- [metapi Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_metapi_overview.md)