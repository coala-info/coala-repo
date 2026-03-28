---
name: poppunk
description: PopPUNK performs rapid analysis of bacterial populations by using k-mer comparisons to distinguish between core and accessory genomic variation. Use when user asks to create genomic databases, fit models to define strain boundaries, assign new query sequences to clusters, or generate visualization files for population structure.
homepage: https://github.com/johnlees/PopPUNK
---


# poppunk

## Overview

PopPUNK (Population Partitioning Using Nucleotide K-mers) is a tool designed for the rapid analysis of bacterial populations. It bypasses the need for a reference genome or sequence alignment by using variable-length k-mer comparisons to distinguish between divergence in shared sequences (core) and gene content (accessory). 

Use this skill to:
- Create genomic databases from assemblies or reads.
- Fit models to define strain boundaries (BGMM, DBSCAN, or Refine).
- Assign new query sequences to established clusters/lineages.
- Generate visualization files for Microreact, Phandango, and Cytoscape.

## Core Workflows

### 1. Database Creation and Sketching
The first step is to create a database of k-mer sketches from your input sequences.

```bash
# Create a database from a list of files
poppunk --create-db --output my_db --r-files file_list.txt --threads 8
```
*Note: `file_list.txt` should be a tab-separated file with sample names and paths to fasta/fastq files.*

### 2. Model Fitting
After sketching, you must fit a model to define the boundary between "within-strain" and "between-strain" distances.

```bash
# Fit a Bayesian Gaussian Mixture Model (BGMM)
poppunk --fit-model bgmm --distances my_db/my_db.dists --output my_db --K 2

# Refine a model to optimize the boundary
poppunk --refine-model --distances my_db/my_db.dists --output my_db --db my_db
```

### 3. Query Assignment
To add new samples to an existing database without re-running the entire analysis:

```bash
poppunk_assign --db my_db --query query_list.txt --output query_results --threads 8
```

### 4. Visualization
Generate files for interactive exploration of the population structure.

```bash
# Generate Microreact and Cytoscape files
poppunk_visualise --db my_db --output viz_output --microreact --cytoscape
```

## Expert Tips and Best Practices

- **Quality Control**: Always use `--qc-filter` during database creation to exclude poor-quality assemblies that can skew distance calculations.
- **K-mer Range**: The default k-mer range (15-29 with step 3) is generally robust for most bacteria. For very small genomes or specific viruses, you may need to adjust `--min-k` and `--max-k`.
- **Model Verification**: Always check the `--plot-fit` output. If the core and accessory distributions overlap significantly, the model may need refinement using `--refine-model`.
- **GPU Acceleration**: If available, use `--gpu-dist` and `--gpu-sketch` to significantly speed up the calculation of distance matrices for large datasets.
- **Lineage Assignment**: For long-term surveillance, use the `--lineage` flag to maintain stable nomenclature across different versions of your database.



## Subcommands

| Command | Description |
|---------|-------------|
| poppunk | PopPUNK (POPulation Partitioning Using Nucleotide Kmers) |
| poppunk | PopPUNK (POPulation Partitioning Using Nucleotide Kmers) |
| poppunk | PopPUNK (POPulation Partitioning Using Nucleotide Kmers) |
| poppunk | PopPUNK (POPulation Partitioning Using Nucleotide Kmers) |

## Reference documentation
- [PopPUNK GitHub Repository](./references/github_com_bacpop_PopPUNK.md)
- [PopPUNK Documentation Index](./references/poppunk-docs_bacpop_org_index.md)
- [Sketching and Database Creation](./references/poppunk-docs_bacpop_org_sketching.html.md)
- [Model Fitting Guide](./references/poppunk-docs_bacpop_org_model_fitting.html.md)
- [Query Assignment](./references/poppunk-docs_bacpop_org_query_assignment.html.md)
- [Visualization Options](./references/poppunk-docs_bacpop_org_visualisation.html.md)