---
name: scvi
description: scvi applies probabilistic deep generative models to single-cell omics data for normalization and analysis. Use when user asks to integrate disparate datasets, reduce dimensionality for visualization, or perform differential expression analysis.
homepage: https://github.com/YosefLab/scVI
metadata:
  docker_image: "quay.io/biocontainers/scvi:0.6.8--py_0"
---

# scvi

## Overview
The `scvi` (single-cell Variational Inference) skill enables the application of probabilistic models to high-dimensional single-cell data. It is designed to handle the inherent noise, sparsity, and batch effects found in omics datasets by leveraging deep generative models built on PyTorch and AnnData. Use this skill to implement standardized workflows for integrating disparate datasets, reducing dimensionality for visualization, and performing differential expression analysis within a Bayesian framework.

## Core Workflow and Best Practices

### 1. Data Preparation
All `scvi-tools` models interact with `AnnData` objects. Before training, you must register the data to specify which fields (layers, batch, covariates) the model should use.

```python
import scvi
import scanpy as sc

# Load data
adata = sc.read_h5ad("dataset.h5ad")

# Setup the AnnData object for the specific model
# Identify the batch column to perform integration
scvi.model.SCVI.setup_anndata(
    adata, 
    layer="counts", 
    batch_key="batch",
    continuous_covariate_keys=["percent_mito"]
)
```

### 2. Model Training
Standard `SCVI` is the workhorse for scRNA-seq integration and normalization.

*   **GPU Acceleration**: Always use a GPU if available (`accelerator="gpu"`).
*   **Early Stopping**: Enabled by default to prevent overfitting.

```python
# Initialize the model
model = scvi.model.SCVI(adata, n_layers=2, n_latent=30, gene_likelihood="nb")

# Train the model
model.train(max_epochs=400, accelerator="gpu")
```

### 3. Latent Representation and Integration
After training, extract the latent space to use for clustering and visualization (UMAP/t-SNE). This representation is "batch-corrected" by design.

```python
# Get the latent representation
adata.obsm["X_scVI"] = model.get_latent_representation()

# Use Scanpy for downstream clustering on the scVI latent space
sc.pp.neighbors(adata, use_rep="X_scVI")
sc.tl.leiden(adata)
sc.tl.umap(adata)
```

### 4. Differential Expression
`scvi-tools` provides a "Change-point" analysis for differential expression, which is more robust than frequentist tests for sparse single-cell data.

```python
# Compare two specific clusters
de_df = model.differential_expression(
    groupby="leiden", 
    group1="0", 
    group2="1"
)
```

## Expert Tips
*   **Gene Selection**: For best results, filter the `AnnData` to Highly Variable Genes (HVGs) before setting up the model. This significantly speeds up training and reduces noise.
*   **Library Size**: `scvi` models the library size as a latent variable; do not provide log-normalized data to the `counts` layer. Use raw integer counts.
*   **Model Selection**:
    *   Use `SCVI` for standard scRNA-seq.
    *   Use `SCANVI` for semi-supervised annotation (when you have some cell type labels).
    *   Use `TOTALVI` for CITE-seq (paired RNA and protein).
    *   Use `DestVI` or `Stereoscope` for spatial deconvolution.

## Reference documentation
- [scvi-tools GitHub Repository](./references/github_com_scverse_scvi-tools.md)
- [Bioconda scvi Overview](./references/anaconda_org_channels_bioconda_packages_scvi_overview.md)