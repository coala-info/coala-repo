---
name: scib
description: `scib` (Single-cell Integration Benchmarking) is a specialized toolkit for assessing the performance of data integration methods in single-cell genomics.
homepage: https://github.com/theislab/scib
---

# scib

## Overview
`scib` (Single-cell Integration Benchmarking) is a specialized toolkit for assessing the performance of data integration methods in single-cell genomics. It provides a unified interface to run various integration algorithms and, more importantly, a comprehensive suite of metrics to evaluate the results. It is the standard tool for researchers needing to quantify the balance between batch effect removal and the preservation of biological identity.

## Core Usage Patterns

### 1. Preprocessing (`scib.pp`)
Before integration, datasets must be standardized to ensure fair comparison.
- **HVG Selection**: Use `scib.pp.hvg_batch` to select highly variable genes while accounting for batch structure, preventing batch-specific noise from dominating the gene selection.
- **Standardization**: Ensure the `AnnData` object is properly normalized and scaled as required by the specific integration method being tested.

### 2. Running Integration (`scib.ig`)
`scib` provides convenient wrappers for common integration tools, allowing them to be called directly on `AnnData` objects:
- `scib.ig.scanorama(adata, batch)`
- `scib.ig.harmony(adata, batch)`
- `scib.ig.bbknn(adata, batch)`
- `scib.ig.scvi(adata, batch)`

### 3. Evaluating Metrics (`scib.me`)
Metrics are the primary output of `scib`. They are categorized into Batch Correction and Biological Conservation.

**Batch Correction Metrics:**
- `scib.me.kBET(adata, batch, label)`: Measures how well batches are mixed within cell type clusters.
- `scib.me.graph_connectivity(adata, label, batch)`: Checks if all cells of the same type are connected in the integrated neighbor graph.
- `scib.me.ilisi_graph(adata, batch)`: Integration Local Inverse Simpson’s Index for graph-based batch mixing.

**Biological Conservation Metrics:**
- `scib.me.nmi(adata, label, cluster_key)`: Normalized Mutual Information between clusters and ground-truth labels.
- `scib.me.ari(adata, label, cluster_key)`: Adjusted Rand Index for clustering consistency.
- `scib.me.silhouette(adata, label, embed)`: Average Silhouette Width (ASW) for cell labels to measure cluster separation.
- `scib.me.isolated_labels_asw(adata, label, batch, embed)`: Evaluates performance on cell types present in only a few batches.

## Best Practices and Tips
- **Label Consistency**: Always ensure your `AnnData` object has consistent keys in `.obs` for 'batch' and 'celltype' (or 'label') before running the metrics suite.
- **Embedding Specification**: Many metrics require a latent space or embedding. By default, `scib` looks for `X_pca` or `X_emb`. If your integration output is stored in a custom slot, pass it via the `embed` parameter.
- **R Dependencies**: Several core metrics (like `kBET` and `LISI`) require R-based backends. Ensure `rpy2`, `anndata2ri`, and the corresponding R packages are installed in your environment.
- **Clustering for Metrics**: For metrics like NMI and ARI, you must first cluster your integrated data (e.g., using Leiden or Louvain) and provide the resulting cluster key.

## Reference documentation
- [scib GitHub Repository](./references/github_com_theislab_scib.md)
- [scib Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scib_overview.md)