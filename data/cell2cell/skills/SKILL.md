---
name: cell2cell
description: cell2cell is a bioinformatics tool for inferring and analyzing cell-cell communication by mapping gene expression data onto ligand-receptor pairs. Use when user asks to estimate communication strength between cell types, perform tensor factorization across multiple samples, integrate spatial transcriptomics data, or troubleshoot memory issues in large-scale datasets.
homepage: https://github.com/earmingol/cell2cell
metadata:
  docker_image: "quay.io/biocontainers/cell2cell:0.8.4--pyhdfd78af_0"
---

# cell2cell

## Overview
cell2cell is a specialized bioinformatics tool for decoding the "social network" of cells. It maps gene expression data onto known ligand-receptor pairs to estimate the strength of communication between cell types. Beyond simple pair-wise interactions, it features "Tensor-cell2cell," which allows you to analyze communication dynamics across many samples simultaneously, identifying coordinated patterns that change between conditions. Use this skill to set up communication pipelines, perform tensor factorizations, and troubleshoot common memory or performance issues in large-scale single-cell datasets.

## Installation and Environment
To ensure compatibility with the tool's dependencies, use a dedicated Conda environment:

```bash
# Create and activate environment
conda create -n cell2cell -y python=3.7 jupyter
conda activate cell2cell

# Install via pip
pip install cell2cell
```

## Core Workflows

### 1. Interaction Pipelines
cell2cell supports three primary analysis modes:
- **Bulk Data**: For comparing communication between tissues or samples in bulk RNA-seq.
- **Single-Cell Data**: For inferring interactions between distinct cell clusters within a single sample.
- **Tensor-cell2cell**: For context-aware analysis across multiple samples (e.g., a cohort of patients or a time-series).

### 2. Tensor-cell2cell Factorization
When analyzing multiple samples, the tool organizes data into a 4D tensor (Contexts x Ligand-Receptor Pairs x Sender Cells x Receiver Cells).
- **Deconvolution**: Use tensor factorization to identify "communication programs" (factors) that explain the variance across your samples.
- **GPU Acceleration**: For large tensors, move the object to a GPU device using the `.to_device()` method to speed up factorization.

### 3. Spatial and Multi-modal Analysis
- **Spatial Transcriptomics**: Integrate spatial coordinates to restrict communication inferences to cells that are physically proximal.
- **Coupled Tensor Analysis**: Use for multi-modal data to find coordinated dynamics between different types of communication (e.g., protein-mediated and metabolite-mediated).

## Expert Tips and Best Practices

### Memory Management
Tensor factorization of large single-cell datasets is memory-intensive.
- **Optimization**: If you encounter memory errors during factorization, change the initialization method. Replace `init='svd'` with `init='random'` in your factorization function.
- **Sparsity**: Be mindful of the number of ligand-receptor pairs; use curated lists relevant to your organism to reduce the tensor size.

### Parameter Tuning
- **Manual Weights**: When performing coupled tensor analysis, use the `manual_weights` parameter (default is often `(0.5, 0.5)`) to balance the contribution of different data modalities.
- **Elbow Plots**: Use the elbow method to determine the optimal number of factors for tensor deconvolution. If using coupled tensors, you can choose to separate them in the elbow plot for better clarity.

### Downstream Analysis
- **GSEA**: After identifying communication factors, perform Gene Set Enrichment Analysis (GSEA) to link specific communication patterns to biological functions.
- **Visualization**: Use the built-in dot plots for interaction scores, ensuring you adjust marker sizes and legend locations for publication-quality figures.

## Reference documentation
- [cell2cell GitHub Repository](./references/github_com_earmingol_cell2cell.md)
- [cell2cell Commit History](./references/github_com_earmingol_cell2cell_commits_master.md)
- [cell2cell Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cell2cell_overview.md)