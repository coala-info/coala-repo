---
name: kgwasflow
description: kgwasflow is a bioinformatics pipeline for performing k-mer based genome-wide association studies to identify genetic variants without requiring a reference genome. Use when user asks to perform k-mer GWAS, identify genetic variants associated with phenotypic variation, count k-mers, or assemble significant k-mers into contigs.
homepage: https://github.com/akcorut/kGWASflow
metadata:
  docker_image: "quay.io/biocontainers/kgwasflow:1.3.0--pyhdfd78af_1"
---

# kgwasflow

## Overview

kgwasflow is a specialized bioinformatics pipeline designed to identify genetic variants associated with phenotypic variation without requiring a complete reference genome. It automates the method developed by Voichek et al. (2020), providing a reproducible path from raw sequencing reads to associated k-mer sequences. The workflow is particularly useful for species with complex genomes or those lacking high-quality reference assemblies. It handles the entire lifecycle of a k-mer GWAS: trimming reads, counting k-mers, running the association model, and performing downstream analysis such as mapping significant k-mers to available references or assembling them into longer contigs for functional annotation.

## Core Workflow Commands

### 1. Environment Setup
Always ensure the environment is active before executing commands.
```bash
conda activate kgwasflow
```

### 2. Project Initialization
Initialize a new working directory to generate the required configuration templates.
```bash
kgwasflow init --work-dir <path/to/project>
```
This creates a `config/` directory containing:
- `config.yaml`: Main workflow parameters.
- `samples.tsv`: Metadata and paths for sequencing reads.
- `phenos.tsv`: Phenotypic data for association testing.

### 3. Execution Patterns
Run the workflow using the `run` command. Use `-n` for a dry run to validate the configuration before processing.

**Standard Execution:**
```bash
# Run with 16 threads using default settings
kgwasflow run -t 16 --snake-default
```

**Custom Configuration:**
```bash
# Point to a specific configuration file
kgwasflow run -t 16 -c config/custom_config.yaml
```

**Advanced Options:**
- `--generate-report`: Creates an HTML Snakemake report summarizing the run.
- `--conda-frontend mamba`: Uses mamba for faster dependency resolution during the run.
- `--work-dir <path>`: Specifies the directory where the analysis should be performed.

### 4. Testing
Validate the installation and environment using the built-in E. coli test dataset.
```bash
kgwasflow test -t 8
```

## Best Practices

- **Resource Management**: Always specify threads with `-t`. k-mer counting and assembly are memory-intensive; ensure your environment has sufficient RAM (typically 4GB+ per thread depending on genome size).
- **Input Validation**: Ensure `samples.tsv` contains absolute paths to FASTQ files to avoid path resolution errors during the Snakemake execution.
- **Dry Runs**: Always perform a dry run (`kgwasflow run -n`) after modifying `config.yaml` to ensure the DAG (Directed Acyclic Graph) is valid.
- **Post-GWAS Analysis**: If a reference genome is available, enable the mapping steps in `config.yaml` to automatically place significant k-mers into a genomic context.



## Subcommands

| Command | Description |
|---------|-------------|
| snakemake | kGWASflow: A Snakemake Workflow for k-mers Based GWAS |
| snakemake | kGWASflow: A Snakemake Workflow for k-mers Based GWAS |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_akcorut_kGWASflow.md)
- [Installation Guide](./references/github_com_akcorut_kGWASflow_wiki_Installing-kGWASflow.md)
- [Running kGWASflow](./references/github_com_akcorut_kGWASflow_wiki_Running-kGWASflow.md)
- [Configuration Details](./references/github_com_akcorut_kGWASflow_wiki_kGWASflow-Configuration.md)