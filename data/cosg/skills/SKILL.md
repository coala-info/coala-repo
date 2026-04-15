---
name: cosg
description: COSG identifies highly specific marker genes across single-cell data modalities using an ultrafast cosine similarity-based method. Use when user asks to identify marker genes, find cell type-specific markers, or visualize marker gene specificity using dot plots and dendrograms.
homepage: https://github.com/genecell/COSG
metadata:
  docker_image: "quay.io/biocontainers/cosg:1.0.3--pyhdfd78af_0"
---

# cosg

## Overview

COSG (Cosine Similarity-based marker Gene identification) is a specialized method for discovering highly specific marker genes across different single-cell data modalities. Unlike traditional statistical tests that can be computationally expensive, COSG leverages cosine similarity to provide an ultrafast and scalable solution. It is particularly effective at identifying markers that are not only highly expressed in a target group but also exhibit minimal expression in other groups, ensuring greater biological specificity.

## Installation

Install the package via PyPI or Bioconda:

```bash
# Using pip
pip install cosg

# Using conda
conda install -c bioconda cosg
```

## Core Workflow and Best Practices

### 1. Marker Gene Identification
The primary function `cosg.cosg()` operates directly on `AnnData` objects. It is recommended to use log-normalized data.

```python
import cosg
import pandas as pd

# Identify markers
cosg.cosg(
    adata, 
    key_added='cosg', 
    groupby='CellType', 
    use_raw=False, 
    layer='log1p',
    mu=100, 
    remove_lowly_expressed=True,
    expressed_pct=0.1,
    n_genes_user=50
)
```

**Expert Tips:**
- **Penalty Parameter (`mu`)**: The `mu` parameter controls the penalty for genes expressed in non-target cell types. Increasing `mu` leads to higher specificity.
- **Expression Filtering**: Use `remove_lowly_expressed=True` and `expressed_pct` to filter out noise from genes with very low detection rates in the target cluster.
- **Batch Handling**: In version 1.0.2+, use the `batch_key` parameter to compute cosine similarities separately across different batches to mitigate batch effects.

### 2. Extracting Results
Results are stored in `adata.uns['cosg']`. Convert them to a Pandas DataFrame for easy inspection or export.

```python
# Get gene names
marker_names = pd.DataFrame(adata.uns['cosg']['names'])

# Get COSG scores (higher is more specific)
marker_scores = pd.DataFrame(adata.uns['cosg']['scores'])
```

### 3. Visualization
COSG provides built-in functions for visualizing marker specificity.

**Dot Plot:**
```python
cosg.plotMarkerDotplot(
    adata, 
    groupby='CellType', 
    top_n_genes=3, 
    key_cosg='cosg',
    standard_scale='var',
    cmap='Spectral_r'
)
```

**Dendrogram:**
Use `plotMarkerDendrogram` to visualize the relationship between cell types and their markers.
- Supports customized cell type-gene pairs.
- Allows filtering of specific cell types for cleaner plots.
- Supports curved edges for better aesthetic visualization.

## Common CLI and Scripting Patterns

When running COSG in a pipeline, ensure the `AnnData` object has been pre-processed (normalized and log-transformed) as COSG calculates similarity based on these values.

- **Memory Efficiency**: For datasets exceeding 1 million cells, COSG typically finishes in under 2 minutes, making it suitable for interactive analysis in Jupyter notebooks where other methods might hang.
- **Layer Selection**: If your `AnnData` contains multiple layers (e.g., raw counts vs. normalized), explicitly specify the `layer` parameter to ensure you are not running similarity on raw counts.

## Reference documentation
- [COSG GitHub Repository](./references/github_com_genecell_COSG.md)
- [Bioconda COSG Overview](./references/anaconda_org_channels_bioconda_packages_cosg_overview.md)