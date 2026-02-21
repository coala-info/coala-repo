---
name: scvi-tools
description: The `scvi-tools` library provides a suite of deep generative models built on PyTorch and AnnData for analyzing single-cell datasets.
homepage: https://github.com/YosefLab/scvi-tools
---

# scvi-tools

## Overview
The `scvi-tools` library provides a suite of deep generative models built on PyTorch and AnnData for analyzing single-cell datasets. It is designed to handle the inherent noise and sparsity of omics data by modeling them as probabilistic distributions. This skill guides the implementation of standard workflows—from data preparation and model training to downstream analysis—ensuring efficient use of GPU resources and proper integration with the Scanpy ecosystem.

## Core Workflow and Best Practices

### 1. Data Preparation
Before modeling, data must be organized into an `AnnData` object. `scvi-tools` requires a specific setup step to register the necessary fields (batches, labels, etc.) for the model.

*   **Registration**: Always use `scvi.model.MODEL_TYPE.setup_anndata(adata, ...)` before initializing a model.
*   **Batch Handling**: If your data contains multiple samples or technologies, specify the `batch_key` during setup to enable integrated latent space learning.
*   **Layer Selection**: By default, models look for raw counts in `adata.X`. If your counts are in a specific layer, use the `layer` argument in `setup_anndata`.

### 2. Model Selection
Choose the model based on the specific analysis task:
*   **SCVI**: Standard variational autoencoder for dimensionality reduction and batch correction of scRNA-seq data.
*   **SCANVI**: Semi-supervised model for automated cell type annotation using a subset of labeled cells.
*   **SOLO**: Specialized for doublet detection (requires a pre-trained SCVI model).
*   **DestVI / Stereoscope**: Used for spatial deconvolution of multi-cellular spots.
*   **TotalVI**: Designed for CITE-seq data (simultaneous RNA and surface protein analysis).

### 3. Training and GPU Acceleration
`scvi-tools` leverages PyTorch Lightning for training.
*   **GPU Usage**: Ensure `accelerator="gpu"` is passed to the `train()` method to significantly reduce computation time for large datasets.
*   **Early Stopping**: Training automatically employs early stopping based on the validation loss to prevent overfitting.
*   **Reproducibility**: Set a global seed using `scvi.settings.seed` for deterministic results across runs.

### 4. Downstream Analysis
Once trained, use the model object to extract biological insights:
*   **Latent Space**: Use `model.get_latent_representation()` to get batch-corrected coordinates for UMAP/clustering.
*   **Differential Expression**: Use `model.differential_expression()` for probabilistic DE testing, which accounts for technical noise better than traditional frequentist tests.
*   **Imputation**: Use `model.get_normalized_expression()` to obtain denoised expression values.

## Expert Tips
*   **Memory Management**: For extremely large datasets, use the `PeakCounting` or `HDF5` backends to avoid loading the entire matrix into RAM.
*   **Model Saving**: Use `model.save("path/to/dir")` to store the trained weights and the associated AnnData metadata. This allows for future "query-to-reference" mapping using `scvi.model.SCVI.load_query_data`.
*   **Scanpy Integration**: Most outputs from `scvi-tools` can be directly assigned back to `adata.obsm` or `adata.layers`, making it compatible with Scanpy's visualization functions.

## Reference documentation
- [scvi-tools GitHub Repository](./references/github_com_scverse_scvi-tools.md)
- [scvi-tools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scvi-tools_overview.md)