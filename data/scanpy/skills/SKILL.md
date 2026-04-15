---
name: scanpy
description: Scanpy is a scalable toolkit for analyzing single-cell gene expression data. Use when user asks to perform quality control, normalize data, reduce dimensionality, cluster cells, or identify marker genes.
homepage: https://scanpy.readthedocs.io/en/latest/
metadata:
  docker_image: "quay.io/biocontainers/scanpy:1.7.2--pyhdfd78af_0"
---

# scanpy

## Overview
Scanpy is a scalable toolkit designed for analyzing single-cell gene expression data. Built on top of `anndata`, it provides a comprehensive suite of tools to handle datasets ranging from a few thousand to over a million cells. Use this skill to implement standard single-cell workflows, including quality control, neighborhood graph construction, and marker gene identification.

## High-Utility Patterns and Best Practices

### 1. Standard Analysis Workflow
The typical Scanpy workflow follows a sequential pipeline. Always ensure data is stored in an `AnnData` object.

```python
import scanpy as sc

# 1. Preprocessing
sc.pp.calculate_qc_metrics(adata, qc_vars=['mt'], inplace=True)
sc.pp.filter_cells(adata, min_genes=200)
sc.pp.filter_genes(adata, min_cells=3)

# 2. Normalization and Log Transformation
sc.pp.normalize_total(adata, target_sum=1e4)
sc.pp.log1p(adata)

# 3. Feature Selection and Scaling
sc.pp.highly_variable_genes(adata, min_mean=0.0125, max_mean=3, min_disp=0.5)
adata = adata[:, adata.var.highly_variable]
sc.pp.scale(adata, max_value=10)

# 4. Dimensionality Reduction and Clustering
sc.pp.pca(adata, svd_solver='arpack')
sc.pp.neighbors(adata, n_neighbors=10, n_pcs=40)
sc.tl.leiden(adata)
sc.tl.umap(adata)

# 5. Marker Gene Identification
sc.tl.rank_genes_groups(adata, 'leiden', method='t-test')
```

### 2. Quality Control (QC) Tips
*   **Mitochondrial Genes:** Always identify mitochondrial genes to filter out dying cells. For human data, use `adata.var['mt'] = adata.var_names.str.startswith('MT-')`.
*   **Doublet Detection:** Use `sc.pp.scrublet` (if installed) to identify and remove potential doublets that can create artificial clusters.

### 3. Efficient Data Handling
*   **Large Datasets:** For datasets exceeding memory capacity, Scanpy supports `dask` integration.
*   **File Formats:** Prefer `.h5ad` for saving and loading `AnnData` objects to preserve all metadata, embeddings, and unstructured data (`sc.write` and `sc.read_h5ad`).
*   **Subsetting:** When subsetting to highly variable genes, it is often best practice to keep the full data in `adata.raw` before filtering so that differential expression can be calculated on all genes later.

### 4. Visualization Best Practices
*   **Embedding Plots:** Use `sc.pl.umap(adata, color=['leiden', 'GeneName'])` to visualize clusters and gene expression simultaneously.
*   **Dot Plots and Heatmaps:** For publication-quality marker gene visualization, use `sc.pl.dotplot` or `sc.pl.stacked_violin`.
*   **Global Settings:** Set `sc.set_figure_params(dpi=80, facecolor='white')` at the start of a session for consistent plot aesthetics.

### 5. Integration and Batch Correction
When working with multiple samples, use the external API for batch correction:
*   **BBKNN:** `sc.external.pp.bbknn(adata, batch_key='sample')`
*   **Harmony:** `sc.external.pp.harmony_integrate(adata, 'sample')`

## Reference documentation
- [Scanpy Documentation Overview](./references/scanpy_readthedocs_io_en_latest.md)
- [Bioconda Scanpy Package](./references/anaconda_org_channels_bioconda_packages_scanpy_overview.md)