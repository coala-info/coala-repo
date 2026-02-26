---
name: harmonypy
description: harmonypy integrates single-cell data by projecting cells into a shared low-dimensional space and iteratively correcting for batch effects. Use when user asks to integrate single-cell datasets, perform batch correction on PCA embeddings, or merge overlapping cell populations from different batches.
homepage: https://github.com/slowkow/harmonypy
---


# harmonypy

## Overview

harmonypy is the Python implementation of the Harmony algorithm, a robust method for integrating single-cell data. It works by projecting cells into a shared low-dimensional space (usually PCA), then iteratively clustering and adjusting coordinates to merge overlapping populations from different batches. It is designed to be fast, scalable, and compatible with standard bioinformatics workflows like Scanpy.

## Installation

Install via pip or conda:

```bash
pip install harmonypy
# OR
conda install bioconda::harmonypy
```

## Core Usage Patterns

### Standard Integration (Pandas/NumPy)
Use this pattern when working with raw Principal Components and metadata tables.

```python
import harmonypy as hm
import pandas as pd

# pcs: (n_cells, n_components)
# meta: DataFrame with batch information
harmony_out = hm.run_harmony(pcs, meta, 'batch_column_name')

# Access corrected coordinates
corrected_pcs = harmony_out.Z_corr
```

### Integration with Scanpy
This is the most common workflow for single-cell analysis. Harmony should be run after PCA but before computing neighbors or UMAP.

```python
import scanpy as sc
import harmonypy as hm

# 1. Preprocess and run PCA
sc.pp.pca(adata)

# 2. Run Harmony on the PCA embedding
# 'batch' is the column in adata.obs containing batch identifiers
harmony_out = hm.run_harmony(adata.obsm['X_pca'], adata.obs, 'batch')

# 3. Store results and proceed with downstream analysis
adata.obsm['X_pca_harmony'] = harmony_out.Z_corr
sc.pp.neighbors(adata, use_rep='X_pca_harmony')
sc.tl.umap(adata)
```

## Expert Tips and Best Practices

- **Input Scaling**: Always run Harmony on Principal Components (PCs), not raw gene expression counts. Ensure the data was scaled and normalized prior to PCA.
- **Batch Selection**: You can pass a list of columns to `vars_use` (e.g., `['donor', 'technology']`) if you need to correct for multiple nested or crossed batch effects simultaneously.
- **Hardware Acceleration**: As of v0.2.0, harmonypy supports a PyTorch backend. On compatible hardware (like Apple M1/M2 or NVIDIA GPUs), this significantly speeds up integration for large datasets (>100k cells).
- **Memory Efficiency**: For extremely large datasets, ensure your metadata and PCA matrices are in float32 format to reduce memory overhead.
- **Convergence**: If the algorithm does not converge, consider increasing `max_iter_harmony` (default is 10) or adjusting the `sigma` parameter (fuzziness of clusters).

## Reference documentation
- [harmonypy GitHub Repository](./references/github_com_slowkow_harmonypy.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_harmonypy_overview.md)