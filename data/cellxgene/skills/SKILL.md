---
name: cellxgene
description: cellxgene is an interactive, web-based data explorer designed for large-scale single-cell transcriptomics.
homepage: https://chanzuckerberg.github.io/cellxgene/
---

# cellxgene

## Overview
cellxgene is an interactive, web-based data explorer designed for large-scale single-cell transcriptomics. It allows researchers to visualize cell clusters, gene expression patterns, and metadata annotations in real-time. This skill provides the necessary CLI commands to launch the viewer and manage data files, enabling seamless transition from raw data processing to interactive discovery.

## Installation
Install cellxgene via conda or pip:
```bash
conda install -c bioconda cellxgene
# OR
pip install cellxgene
```

## Core Usage Patterns

### Launching the Explorer
The primary command to start the web application is `launch`. Point it to a processed `.h5ad` (AnnData) file.
```bash
cellxgene launch dataset.h5ad --open
```
- `--open`: Automatically opens the browser window.
- `--port <number>`: Specify a custom port (default is 5005).
- `--host <address>`: Set the host address (e.g., `0.0.0.0` for remote access).

### Data Preparation
Before launching, ensure the dataset is in the correct format. cellxgene requires `.h5ad` files.
- **Embedding**: Ensure the file contains at least one embedding (e.g., `X_umap` or `X_tsne`) in `adata.obsm`.
- **Expression Data**: Raw or normalized counts should be in `adata.X` or `adata.raw.X`.
- **Metadata**: Categorical and numerical metadata should be stored in `adata.obs`.

### Performance Optimization
For very large datasets, use the following flags to improve responsiveness:
- `--disable-diffexp`: Disables on-the-fly differential expression calculations to save memory.
- `--max-category-items <number>`: Limits the number of categories displayed in the sidebar to prevent UI lag.

## Expert Tips
- **Private Hosting**: When running on a remote server, use SSH tunneling to access the UI: `ssh -L 5005:localhost:5005 user@remote_host`.
- **Data Validation**: Use the `cellxgene-schema` tool (if installed separately) to ensure your h5ad file meets the CZ CELLxGENE Discover requirements for public sharing.
- **Sparse Matrices**: Ensure `adata.X` is stored as a CSR sparse matrix for faster loading and lower memory footprint.

## Reference documentation
- [cellxgene Overview](./references/chanzuckerberg_github_io_cellxgene.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_cellxgene_overview.md)