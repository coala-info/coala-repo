---
name: scanpy-cli
description: scanpy-cli provides a command-line interface for executing single-cell RNA sequencing analysis pipelines using the Scanpy library. Use when user asks to filter cells, normalize data, perform batch correction, cluster cell populations, or generate UMAP visualizations.
homepage: https://github.com/nictru/scanpy-cli
metadata:
  docker_image: "quay.io/biocontainers/scanpy-cli:0.2.0--pyhdfd78af_0"
---

# scanpy-cli

## Overview

The `scanpy-cli` tool provides a structured interface to the Scanpy Python library, allowing researchers to execute complex single-cell analysis pipelines directly from the command line. It is particularly useful for building reproducible bioinformatics pipelines, working on remote HPC clusters, or performing rapid exploratory analysis without writing custom Python scripts. The tool organizes functionality into three primary subcommands: `pp` (preprocessing), `tl` (tools/analysis), and `pl` (plotting).

## Core Workflows and Commands

### 1. Preprocessing (pp)
Preprocessing is the foundation of single-cell analysis. Use these commands to clean and prepare your data.

- **Filtering**: Remove low-quality cells or uninformative genes.
  - `scanpy-cli pp filter_cells`
  - `scanpy-cli pp filter_genes`
- **Normalization and Variable Genes**: Identify features for downstream analysis.
  - `scanpy-cli pp highly_variable_genes`
  - `scanpy-cli pp regress_out`: Remove unwanted variation (e.g., mitochondrial content or cell cycle effects).
- **Dimensionality Reduction and Graph Building**:
  - `scanpy-cli pp pca`: Compute Principal Component Analysis.
  - `scanpy-cli pp neighbors`: Compute the neighborhood graph required for clustering and UMAP.

### 2. Batch Correction
If your data contains multiple samples or batches, use these integration tools within the `pp` group:
- `scanpy-cli pp combat`: Standard batch correction.
- `scanpy-cli pp harmony`: Fast and memory-efficient integration.
- `scanpy-cli pp scanorama`: Integration for diverse datasets.
- `scanpy-cli pp bbknn`: Fast batch-balanced neighbors.

### 3. Analysis Tools (tl)
Once preprocessed, use these commands to extract biological insights:
- **Clustering**: `scanpy-cli tl leiden` to identify cell populations.
- **Embeddings**: `scanpy-cli tl umap` for low-dimensional visualization.
- **Marker Genes**: `scanpy-cli tl rank_genes_groups` to find genes that define clusters.
- **Trajectories**: `scanpy-cli tl paga` for trajectory inference and cluster connectivity.

### 4. Visualization (pl)
Generate plots to inspect your results:
- `scanpy-cli pl umap`: Generate UMAP scatter plots colored by clusters or gene expression.

## Expert Tips and Best Practices

- **Help System**: Every subcommand and nested command supports the `--help` flag. Use it to discover specific parameters like `--n-neighbors` for the graph or `--resolution` for clustering.
  - Example: `scanpy-cli pp neighbors --help`
- **Data Persistence**: Most commands operate on `.h5ad` files (AnnData). Ensure your workflow saves intermediate steps if you are not piping outputs, as many commands modify the underlying data structure.
- **Doublet Detection**: Use `scanpy-cli pp scrublet` early in your preprocessing pipeline to identify and remove potential doublets that can create artifactual clusters.
- **Optional Outputs**: Some commands (like `pca`, `harmony`, or `leiden`) allow for specific output flags to export embeddings or cluster assignments to separate files (e.g., `.npy` or `.pkl`) for use in other tools.

## Reference documentation
- [scanpy-cli GitHub Repository](./references/github_com_nictru_scanpy-cli.md)
- [scanpy-cli Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scanpy-cli_overview.md)