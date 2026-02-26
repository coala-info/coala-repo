---
name: seacells
description: SEACells identifies metacells by aggregating highly similar single cells into granular groups to overcome data sparsity while preserving biological heterogeneity. Use when user asks to identify metacells, aggregate single-cell data into dense cellular states, or perform high-resolution trajectory and regulatory analysis.
homepage: https://github.com/dpeerlab/SEACells
---


# seacells

## Overview

SEACells (Single-cell E-cell Aggregation) is an algorithm designed to identify metacells—small groups of highly similar cells that represent distinct, granular cellular states. Unlike traditional clustering which can be too coarse, or single-cell analysis which suffers from extreme sparsity (especially in ATAC-seq), SEACells provides a middle ground that preserves biological heterogeneity while providing the data density needed for complex multi-omic analysis. It is the preferred tool for researchers needing to perform high-resolution trajectory analysis or regulatory element mapping.

## Installation and Environment Setup

SEACells requires a Python 3.8+ environment. It is recommended to install `cmake` first to handle dependencies.

```bash
# Standard installation
pip install cmake
pip install SEACells

# Bioconda installation
conda install bioconda::seacells
```

For GPU acceleration (highly recommended for large datasets), ensure CUDA drivers are configured. If encountering `MulticoreTSNE` issues, use the `conda-forge` and `bioconda` channels to install `cython` and `python=3.8` specifically.

## Core Workflow Patterns

### 1. Initializing the SEACells Model
The algorithm typically operates on an `AnnData` (scRNA) or `MuData` object. You must provide a reduced dimensionality representation (like PCA for RNA or LSI for ATAC).

```python
import SEACells

# Initialize model
# n_metacells: Target number of metacells (rule of thumb: total cells / 75)
model = SEACells.core.SEACells(ad, 
                               build_kernel_on='X_pca', 
                               n_metacells=n_metacells, 
                               n_waypoint_eigs=10,
                               convergence_epsilon=1e-4)
```

### 2. Fitting the Model
The `fit` process identifies the archetypes that define the metacells.

```python
# Construct kernel and fit
model.construct_kernel()
model.initialize_archetypes()
model.fit(min_iter=10, max_iter=100)
```

### 3. Aggregating Data
Once the model is fit, you can aggregate the raw counts into a metacell-by-gene (or peak) matrix.

```python
# Assign cells to metacells
ad.obs['SEACell'] = model.get_soft_assignments()

# Aggregate counts to create a new AnnData object for metacells
metacell_ad = SEACells.core.aggregate_by_metacell(ad, 'SEACell')
```

## Expert Tips and Best Practices

*   **Metacell Sizing**: Aim for approximately 75 cells per metacell. If your dataset has rare cell types (<< 75 cells), you may need to increase the `n_metacells` parameter or process those populations separately to avoid "spurious" metacells that blend distinct types.
*   **ATAC-seq Preprocessing**: For ATAC-seq, use Nucleosome-Free Region (NFR) fragments for peak calling before running SEACells. This significantly improves the quality of the affinity kernel.
*   **Memory Management**: For large-scale datasets, use the sparse assignment matrix option to reduce memory overhead during the `model.fit()` stage.
*   **Convergence**: If the model fails to converge within the default iterations, check the `convergence_epsilon`. For very large datasets, a slightly higher epsilon may be necessary to finish in a reasonable timeframe.
*   **Integration**: When performing scRNA and scATAC integration, compute SEACells on each modality independently and then use the metacell aggregates for cross-modality mapping to reduce noise.

## Reference documentation
- [SEACells GitHub Repository](./references/github_com_dpeerlab_SEACells.md)
- [SEACells Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_seacells_overview.md)