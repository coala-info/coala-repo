---
name: bbknn
description: BBKNN is a fast, graph-based integration tool that mitigates batch effects in single-cell transcriptomics by identifying neighbors within each batch independently. Use when user asks to integrate single-cell datasets, remove batch effects from neighbor graphs, or perform computationally efficient data integration after PCA.
homepage: https://github.com/Teichlab/bbknn
---


# bbknn

## Overview
BBKNN (Batch Balanced K-Nearest Neighbors) is a fast, graph-based integration tool designed to mitigate batch effects in single-cell transcriptomics. Unlike standard methods that find the nearest neighbors across an entire merged dataset—which often results in cells clustering by batch rather than biology—BBKNN identifies a set number of neighbors for each cell within each individual batch independently. These local neighbor lists are then merged to create a balanced connectivity graph. This approach is computationally efficient and integrates data without modifying the original gene expression values or PCA coordinates, making it a "lightweight" alternative to more intensive correction methods like MNN or Harmony.

## Installation
Install via conda or pip:
```bash
conda install -c bioconda bbknn
# OR
pip install bbknn
```
*Note: For significantly faster performance on large datasets, ensure `faiss` is installed.*

## Core Usage Patterns

### Standard Scanpy Integration
BBKNN is designed to replace `scanpy.pp.neighbors()`. It should be run after PCA but before clustering (Leiden/Louvain) or manifold visualization (UMAP/PAGA).

```python
import scanpy as sc
import bbknn

# 1. Standard preprocessing
sc.pp.filter_cells(adata, min_genes=200)
sc.pp.normalize_total(adata)
sc.pp.log1p(adata)
sc.pp.highly_variable_genes(adata)
sc.pp.pca(adata)

# 2. Run BBKNN instead of sc.pp.neighbors
# batch_key identifies the column in adata.obs containing batch info
bbknn.bbknn(adata, batch_key='batch')

# 3. Proceed with downstream analysis
sc.tl.umap(adata)
sc.tl.leiden(adata)
```

### Advanced Integration with Ridge Regression
For complex datasets, integration can be improved by regressing out technical effects while preserving biological variation using a "round-trip" workflow.

```python
# Initial integration to get coarse clusters
bbknn.bbknn(adata, batch_key='batch')
sc.tl.leiden(adata)

# Perform ridge regression using clusters as biological confounders
bbknn.ridge_regression(adata, batch_key=['batch'], confounder_key=['leiden'])

# Re-run PCA and BBKNN on the regressed data
sc.tl.pca(adata)
bbknn.bbknn(adata, batch_key='batch')
```

### Working with Raw Matrices
If you are not using `AnnData` objects, use the matrix-based interface:

```python
import bbknn.matrix
# pca_matrix: cells as rows, PCs as columns
# batch_list: a vector/list of batch assignments for each cell
distances, connectivities, parameters = bbknn.matrix.bbknn(pca_matrix, batch_list)
```

## Expert Tips and Best Practices

- **Batch Key Selection**: The `batch_key` defaults to `'batch'`. If your samples were concatenated using `adata.concatenate()`, this column is created automatically.
- **Neighbors per Batch**: Use `neighbors_within_batch` (default: 3) to control how many neighbors are identified in each batch. Total neighbors for a cell will be `neighbors_within_batch * number_of_batches`.
- **Graph Trimming**: If you suspect unrelated cell populations are being forced together, use the `trim` parameter. It limits the total number of neighbors per cell to the $N$ strongest edges, helping to remove spurious connections.
- **FAISS Acceleration**: If working with >100k cells, use `use_faiss=True`. This requires the `faiss` library and provides a massive speedup for the neighbor search.
- **Metric Choice**: While Euclidean distance is standard for PCA space, you can specify other metrics (e.g., `metric='angular'`) if your data requires it.
- **R Integration**: While there is no native R package, BBKNN can be called via `reticulate` within a Seurat/SingleCellExperiment workflow by passing the PCA embeddings and batch vector to the Python module.

## Reference documentation
- [Batch balanced KNN GitHub Repository](./references/github_com_Teichlab_bbknn.md)
- [bbknn - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bbknn_overview.md)