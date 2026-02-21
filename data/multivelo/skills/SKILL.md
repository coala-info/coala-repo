---
name: multivelo
description: MultiVelo is a mechanistic model that extends the standard RNA velocity framework by incorporating chromatin accessibility data.
homepage: https://github.com/welch-lab/MultiVelo
---

# multivelo

## Overview
MultiVelo is a mechanistic model that extends the standard RNA velocity framework by incorporating chromatin accessibility data. While traditional RNA velocity uses the ratio of unspliced to spliced mRNA to predict future cell states, MultiVelo adds a layer of epigenomic regulation, allowing users to identify time lags between chromatin opening and gene transcription. Use this skill to guide the processing of 10X Multiome data, aggregate peaks into gene-linked accessibility scores, and run the probabilistic latent variable model to recover gene expression dynamics.

## Installation
Install the package using one of the following commands:
- **PyPI**: `pip install multivelo`
- **Conda/Mamba**: `conda install -c bioconda multivelo`

## Core Workflow and CLI Patterns
MultiVelo is typically used within a Python environment (Jupyter or scripts) alongside `scanpy` and `scvelo`.

### 1. Data Preparation
MultiVelo requires three primary inputs:
- Spliced and unspliced RNA count matrices (usually from `velocyto` or `kb-python`).
- ATAC-seq peak count matrix.
- Feature linkage information (e.g., 10X Genomics `feature_linkage.bedpe`).

### 2. Peak Aggregation
To link chromatin accessibility to specific genes, use the aggregation function. This requires the 10X peak annotation and linkage files.
```python
import multivelo as mv
# Aggregate peaks based on 10X feature linkage
mv.aggregate_peaks_10x(adata_atac, 
                       "peak_annotation.tsv", 
                       "feature_linkage.bedpe", 
                       output_file="aggregated_peaks.h5ad")
```

### 3. Chromatin Smoothing
Accessibility data is often sparse. Smoothing across the nearest neighbor graph is essential before running the velocity model.
```python
# Smooth chromatin accessibility using the shared neighbor graph
mv.knn_smooth_chrom(adata_atac, nn_idx=None, nn_dist=None)
```

### 4. Recovering Dynamics
The core of MultiVelo is the `recover_dynamics_chrom` function, which fits the multi-omic model.
```python
# Fit the model to estimate switch times and rate parameters
mv.recover_dynamics_chrom(adata_rna, adata_atac, max_iter=10, init_vals=None)
```
For large datasets, consider using the `adam` optimizer variant if available in the latest version to speed up parameter recovery.

### 5. Velocity Calculation and Visualization
After recovering dynamics, calculate the velocity vectors and project them onto embeddings (UMAP/TSNE).
```python
mv.velocity_graph(adata_rna)
mv.velocity_embedding(adata_rna, basis='umap')
```

## Expert Tips and Best Practices
- **Cell Matching**: Ensure that the RNA and ATAC AnnData objects contain the same cells in the same order. Use `mv.utils.match_cells(adata_rna, adata_atac)` if necessary.
- **Feature Selection**: Focus analysis on highly variable genes (HVGs) that also show significant correlation with chromatin accessibility to reduce noise and computation time.
- **Handling Sparsity**: If you encounter `'SparseCSCView' object has no attribute 'A'` errors, explicitly convert your layers to dense arrays or standard sparse formats using `adata.layers['matrix'].tocsr()`.
- **Time Lags**: Use the inferred `state` values to quantify the discordance between epigenomic and transcriptomic states. A "state" value typically represents whether the chromatin is open/closed relative to the gene being active/inactive.
- **Neural Network Mode**: For complex trajectories, MultiVelo supports a neural network-based time prediction mode. This is useful when the standard mechanistic model struggles to fit the data.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_welch-lab_MultiVelo.md)
- [Anaconda Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_multivelo_overview.md)
- [MultiVelo Issues and Bug Reports](./references/github_com_welch-lab_MultiVelo_issues.md)