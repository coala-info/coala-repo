---
name: sonicparanoid
description: SonicParanoid is a high-performance tool for identifying orthologous relationships between proteins across large-scale genomic datasets. Use when user asks to perform orthology inference, run comparative genomics workflows, or add new genomes to an existing orthology analysis.
homepage: http://iwasakilab.bs.s.u-tokyo.ac.jp/sonicparanoid/
metadata:
  docker_image: "quay.io/biocontainers/sonicparanoid:2.0.9--py312hc9302aa_0"
---

# sonicparanoid

## Overview

SonicParanoid is a high-performance tool designed for orthology inference, capable of processing thousands of genomes with high speed and accuracy. It leverages machine learning and language models to identify orthologous relationships between proteins, making it particularly effective for comparative genomics and evolutionary biology studies. This skill provides the necessary command-line patterns to initialize, run, and manage orthology detection workflows.

## Core Workflows

### 1. Project Initialization
Before running an analysis, you must set up a project directory containing your input proteomes (FASTA format).

```bash
# Create a new project directory
mkdir my_orthology_project
# Place all .fasta or .faa files into an 'input' subdirectory
mkdir my_orthology_project/input
```

### 2. Running Orthology Inference
The primary command executes the full pipeline, including sequence alignment and orthology assignment.

```bash
# Basic run with default parameters
sonicparanoid -i ./my_orthology_project/input -o ./my_orthology_project/output -t 8
```

**Key Arguments:**
- `-i / --input`: Path to the directory containing input proteome files.
- `-o / --output`: Path where results and intermediate files will be stored.
- `-t / --threads`: Number of CPU cores to utilize (highly recommended for speed).
- `-m / --mode`: Sensitivity mode (e.g., `fast`, `sensitive`, or `ultra-sensitive`).

### 3. Adding New Genomes
SonicParanoid allows for the incremental addition of new species without recomputing the entire dataset.

```bash
# Add new proteomes to an existing run
sonicparanoid -i ./new_proteomes/ -o ./my_orthology_project/output --add
```

### 4. Output Interpretation
The results are typically found in the `output/orthology` directory:
- `ortholog_groups.tsv`: A table where each row is an orthologous group and columns represent species.
- `ortholog_groups_long.tsv`: A long-format version of the groups for easier parsing by scripts.

## Best Practices

- **Input Cleaning**: Ensure protein headers in FASTA files do not contain special characters or spaces, as these can cause parsing issues.
- **Resource Allocation**: For datasets exceeding 500 genomes, ensure at least 64GB of RAM is available, as the machine learning components can be memory-intensive during the clustering phase.
- **Database Maintenance**: Use the `--clear-cache` flag if a previous run was interrupted to prevent corrupted intermediate files from affecting the new run.

## Reference documentation

- [SonicParanoid Overview](./references/anaconda_org_channels_bioconda_packages_sonicparanoid_overview.md)