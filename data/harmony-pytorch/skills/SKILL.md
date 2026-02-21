---
name: harmony-pytorch
description: Harmony-pytorch provides a fast and memory-efficient implementation of the Harmony integration algorithm.
homepage: https://github.com/lilab-bcb/harmony-pytorch
---

# harmony-pytorch

## Overview

Harmony-pytorch provides a fast and memory-efficient implementation of the Harmony integration algorithm. It is designed to correct batch effects in single-cell transcriptomics data while preserving biological variation. This skill helps you integrate embeddings (typically PCA) from multiple datasets into a unified space, supporting standard Python data structures like NumPy arrays, Pandas DataFrames, AnnData (Scanpy), and MultimodalData (Pegasus).

## Installation

Install the package via pip or conda:

```bash
# Via pip
pip install harmony-pytorch

# Via conda (bioconda channel)
conda install bioconda::harmony-pytorch
```

## Core Usage Patterns

### 1. Standard NumPy and Pandas Integration
Use this pattern when working with raw embeddings and metadata.

```python
from harmony import harmonize
import pandas as pd

# X: N-by-d matrix (N cells, d components)
# df_metadata: DataFrame containing batch information
Z = harmonize(X, df_metadata, batch_key='batch_column_name')
```

### 2. Integrating AnnData (Scanpy Workflow)
This is the most common workflow for Scanpy users. Ensure you have already run PCA.

```python
from harmony import harmonize

# Assuming adata.obsm['X_pca'] exists
Z = harmonize(adata.obsm['X_pca'], adata.obs, batch_key='batch')
adata.obsm['X_harmony'] = Z
```

### 3. Handling Multiple Batch Variables
If your data has nested batch effects (e.g., different labs and different dates), pass a list to `batch_key`.

```python
Z = harmonize(X, df_metadata, batch_key=['Lab', 'Date'])
```

## Expert Tips and Best Practices

*   **Input Requirements**: Harmony operates on reduced-dimensional embeddings, not raw count matrices. Always perform normalization, highly variable gene selection, and PCA before running Harmony.
*   **Hardware Acceleration**: Since this is a PyTorch implementation, it can leverage GPU acceleration if available, which is significantly faster for very large cell counts (e.g., >1 million cells).
*   **Verbosity**: Use the `verbose=True` argument in `harmonize()` to monitor the convergence of the objective function during the iterative clustering and correction phases.
*   **Memory Management**: For extremely large datasets, ensure your metadata DataFrame indices match the embedding matrix rows exactly to avoid alignment errors that consume extra memory.
*   **Downstream Analysis**: After integration, use the resulting `X_harmony` embedding for neighbor graph construction, UMAP/t-SNE visualization, and clustering instead of the original PCA.

## Reference documentation
- [Harmony-Pytorch GitHub Repository](./references/github_com_lilab-bcb_harmony-pytorch.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_harmony-pytorch_overview.md)