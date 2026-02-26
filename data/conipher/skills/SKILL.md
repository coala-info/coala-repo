---
name: conipher
description: CONIPHER automates the grouping of somatic mutations into subclonal clusters and reconstructs the phylogenetic evolutionary history of tumors. Use when user asks to infer subclonal architecture, cluster mutations from multi-region sequencing data, or build tumor phylogenetic trees.
homepage: https://github.com/McGranahanLab/CONIPHER/
---


# conipher

## Overview

CONIPHER (COmputational iNference of PHylogeny in sEquencing Reads) is an R-based tool designed for cancer genomics research. It automates the grouping of mutations into subclonal clusters and the reconstruction of the evolutionary history of a tumor. Use this skill when you have somatic mutation data (including variant allele frequencies and copy number information) from one or more tumor regions and need to infer subclonal architecture and phylogenetic relationships.

## Installation and Environment

The most reliable way to use CONIPHER is via a Conda environment, as it manages complex dependencies like PyClone.

```bash
# Create and activate the environment
conda create -n conipher -c conda-forge -c bioconda conipher
conda activate conipher
```

Alternatively, install the R package directly for tree-building tasks (which do not require PyClone):

```R
library(devtools)
devtools::install_github("McGranahanLab/CONIPHER")
```

## Core Workflow Patterns

### 1. End-to-End Analysis
Use `conipher_run` to perform both mutation clustering and phylogenetic tree reconstruction in a single execution.

```R
library(CONIPHER)
library(tidyverse)

# Define paths
out_dir <- "results/"
input_tsv <- "path/to/input_table.tsv"

# Execute full pipeline
conipher_run(
  case_id = "PATIENT_01", 
  prefix = "PROJECT_NAME", 
  out_dir = out_dir, 
  input_tsv_loc = input_tsv
)
```

### 2. Modular Execution
If you need to run steps separately (e.g., to inspect clusters before building trees):

**Clustering Only:**
```R
conipher_clustering(
  case_id = "PATIENT_01", 
  out_dir = out_dir, 
  input_tsv_loc = input_tsv
)
```

**Tree Building Only:**
```R
conipher_treebuilding(
  prefix = "PROJECT_NAME", 
  out_dir = out_dir, 
  input_tsv_loc = "path/to/clustering_output.tsv"
)
```

## Input Requirements

The input `.tsv` file is the most critical component. It must contain multi-region mutation data. While specific column headers are defined in the CONIPHER protocol, ensure your table includes:
- Case/Patient ID
- Mutation identifiers (Chromosome, Position)
- Reference and Alternative allele counts per region
- Local copy number and purity estimates per region

## Interpreting Outputs

CONIPHER generates results in structured subfolders within your `out_dir`:

- **Clustering/**: Contains PyClone-based clustering results and mutation assignments.
- **Trees/**:
    - `<CASE_ID>.tree.RDS`: The primary R object containing the reconstructed tree(s).
    - `pytree_and_bar.pdf`: Visualization of the default tree and clone proportions.
    - `pytree_multipletrees.pdf`: Shows alternative tree topologies if multiple solutions are parsimonious.

## Expert Tips

- **PyClone Dependency**: The clustering step strictly requires PyClone v0.13.1. If running outside the Conda environment, ensure `PyClone` is in your system PATH.
- **Case IDs and Prefixes**: Use consistent `case_id` strings for patients and `prefix` strings for cohorts to ensure output files are organized correctly for downstream multi-patient analysis.
- **Interactive vs. Scripted**: While the functions can be run interactively in R, for large cohorts, wrap these calls in an Rscript to be executed via the command line.

## Reference documentation
- [CONIPHER GitHub Repository](./references/github_com_McGranahanLab_CONIPHER.md)
- [Bioconda CONIPHER Overview](./references/anaconda_org_channels_bioconda_packages_conipher_overview.md)