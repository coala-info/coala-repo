---
name: cellxgene
description: cellxgene is an interactive explorer for visualizing and analyzing single-cell genomic data through a web-based interface. Use when user asks to launch a data viewer, perform dimensionality reduction visualization, identify marker genes through differential expression, or prepare AnnData files for exploration.
homepage: https://chanzuckerberg.github.io/cellxgene/
metadata:
  docker_image: "quay.io/biocontainers/cellxgene:1.3.0--pyhdfd78af_0"
---

# cellxgene

## Overview
This skill provides guidance for using `cellxgene`, an open-source explorer for single-cell genomic data. It allows users to perform dimensionality reduction visualization (UMAP/t-SNE), differential expression analysis, and metadata exploration directly in a browser. It is particularly useful for validating clusters, identifying marker genes, and sharing processed datasets with collaborators without requiring them to write code.

## Installation and Setup
Install via conda or pip:
```bash
conda install -c bioconda cellxgene
# OR
pip install cellxgene
```

## Core CLI Usage
The primary command is `launch`, which starts a local web server to host the dataset.

### Launching a Dataset
```bash
cellxgene launch dataset.h5ad --open
```
- `--open`: Automatically opens the browser window.
- `--port`: Specify a custom port (default is 5005).
- `--host`: Set the interface to bind to (e.g., `0.0.0.0` for remote access).

### Preparing Data
Data must be in `.h5ad` (AnnData) or `.loom` format. For optimal performance:
- Ensure the file contains a dimensionality reduction (e.g., `X_umap` or `X_tsne`).
- Ensure `X` contains normalized/log-transformed counts for visualization.
- Use the `prepare` command to optimize a raw file (requires `scipy` and `pandas`):
```bash
cellxgene prepare raw_data.h5ad --output=processed_data.h5ad
```

## Expert Tips
- **Memory Management**: For very large datasets, ensure the server has sufficient RAM as `cellxgene` loads the data into memory.
- **Metadata**: Categorical metadata in the AnnData `obs` slot will automatically appear as colorable groups in the sidebar.
- **Differential Expression**: You can select two sets of cells in the UI and trigger a "Differential Expression" calculation to find top markers between them in real-time.
- **Embedding Selection**: If multiple embeddings exist (e.g., UMAP and PCA), use the dropdown in the UI to toggle between them.



## Subcommands

| Command | Description |
|---------|-------------|
| cellxgene | Command-line interface for cellxgene |
| cellxgene annotate | Add predicted annotations to an H5AD file. Run `cellxgene annotate --help` for more information. |
| cellxgene launch | Launch the cellxgene data viewer. This web app lets you explore single-cell expression data. Data must be in a format that cellxgene expects. Read the "getting started" guide to learn more: https://github.com/chanzuckerberg/cellxgene- documentation/blob/main/README.md |
| cellxgene prepare | Preprocess data for use with cellxgene. This tool runs a series of scanpy routines for preparing a dataset for use with cellxgene. It loads data from different formats (h5ad, loom, or a 10x directory), runs dimensionality reduction, computes nearest neighbors, computes an embedding, performs clustering, and saves the results. Includes additional options for naming annotations, ensuring sparsity, and plotting results. |

## Reference documentation
- [cellxgene Overview](./references/chanzuckerberg_github_io_cellxgene.md)
- [Bioconda cellxgene Package](./references/anaconda_org_channels_bioconda_packages_cellxgene_overview.md)