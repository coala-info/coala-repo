---
name: verticall
description: Verticall reconstructs the vertical evolutionary history of bacteria by identifying and masking horizontally acquired sequences. Use when user asks to 'reconstruct vertical evolutionary history', 'identify and mask horizontally acquired sequences', 'generate a recombination-free distance matrix', or 'create a masked alignment for phylogenetic tree building'.
homepage: https://github.com/rrwick/Verticall
---


# verticall

## Overview

Verticall is a specialized tool designed to reconstruct the vertical evolutionary history of bacteria by identifying and masking horizontally acquired sequences (recombination). Unlike other tools that focus on closely related isolates, Verticall scales to massive datasets and handles significant sequence divergence. It functions by performing pairwise assembly comparisons to distinguish between vertical inheritance and horizontal exchange, providing either a recombination-free distance matrix or a masked alignment for downstream tree-building programs.

## Core Workflows

### 1. Distance Tree Workflow (Diverse Datasets)
Use this workflow for datasets with high variation, such as those spanning multiple species.
- **Step 1: Pairwise Comparison**
  Run `verticall pairwise` on your genome assemblies to generate TSV files containing alignment statistics.
- **Step 2: Generate Matrix**
  Use `verticall matrix` to process the TSV files into a distance matrix.
- **Step 3: Build Tree**
  Input the resulting matrix into a distance-based tree builder (e.g., RapidNJ or FastME).

### 2. Alignment Tree Workflow (Large Datasets)
Use this workflow for thousands of genomes where a Maximum Likelihood (ML) tree is required.
- **Step 1: Reference Comparison**
  Compare each assembly against a single reference genome using `verticall pairwise`.
- **Step 2: Masking**
  Use `verticall mask` to apply the recombination filters to a SNP matrix or alignment.
- **Step 3: Build Tree**
  Input the masked alignment into an ML tree builder (e.g., IQ-TREE or RAxML-NG).

## Command Reference and Best Practices

### Key Commands
- `verticall pairwise`: The primary engine for comparing assemblies. Requires FASTA inputs.
- `verticall matrix`: Aggregates pairwise results into a Phylip-formatted distance matrix.
- `verticall mask`: Filters horizontal regions from an existing alignment based on pairwise results.
- `verticall summary`: Provides a report on the amount of vertical vs. horizontal sequence identified.
- `verticall view`: Visualizes the pairwise comparisons to help verify filtering thresholds.

### Expert Tips
- **Assembly Quality**: While Verticall handles fragmented assemblies, higher N50 values generally improve the sensitivity of recombination detection.
- **Tool Selection**: If your dataset is a small group of very closely related genomes, Gubbins may provide finer resolution. Use Verticall when Gubbins fails to scale or when sequence divergence is high.
- **Parallelization**: `verticall pairwise` is computationally intensive; utilize the `--threads` flag to speed up large-scale comparisons.
- **Memory Management**: For very large matrices, ensure you have sufficient RAM or use the `--existing_tsv` flag to resume interrupted runs without recomputing alignments.

## Reference documentation
- [Verticall Wiki](./references/github_com_rrwick_Verticall_wiki.md)
- [Verticall GitHub Repository](./references/github_com_rrwick_Verticall.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_verticall_overview.md)