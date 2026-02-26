---
name: palantir
description: Palantir models the stochastic process of cell differentiation by treating it as a continuous journey from stem cells to terminal states using a Markov chain framework. Use when user asks to model cell differentiation trajectories, calculate pseudotime and fate probabilities, identify terminal states, or compute gene expression trends across lineages.
homepage: https://github.com/dpeerlab/palantir
---


# palantir

## Overview

Palantir is a specialized tool for modeling the stochastic process of cell differentiation. Unlike discrete clustering, Palantir treats differentiation as a continuous journey from stem cells to terminal states. It uses a Markov chain framework on a low-dimensional phenotypic manifold (typically diffusion maps) to capture both the continuity of cell states and the uncertainty in fate determination. This skill provides the procedural knowledge to execute the Palantir workflow, from preprocessing to lineage-specific analysis.

## Core Workflow

Palantir is primarily used as a Python library. The standard workflow involves preparing an AnnData object and running a sequence of manifold learning and trajectory inference steps.

### 1. Preprocessing and Manifold Learning
Before running the trajectory algorithm, the data must be projected into a low-dimensional space.

```python
import palantir
import scanpy as ad

# Load data into an AnnData object
adata = ad.read_h5ad("sample_data.h5ad")

# Run PCA (Palantir's wrapper preserves necessary metadata)
palantir.utils.run_pca(adata)

# Compute Diffusion Maps
# n_components=10 is usually sufficient for the manifold
palantir.utils.run_diffusion_maps(adata, n_components=10)

# Compute the multiscale diffusion kernel
palantir.utils.compute_kernel(adata)
```

### 2. Trajectory Inference
To run Palantir, you must specify a "start cell" (the root of the differentiation process).

```python
# Identify a start cell (e.g., based on known marker expression)
start_cell = "Cell_ID_001"

# Run Palantir to calculate pseudotime and fate probabilities
# results is a Palantir results object containing entropy and branch probabilities
pr_res = palantir.core.run_palantir(adata, start_cell, num_waypoints=500)
```

### 3. Identifying Terminal States
Palantir can automatically detect terminal states or allow manual specification.

```python
# Detect terminal states based on the diffusion map
terminal_states = palantir.core.define_terminal_states(pr_res, adata)
```

### 4. Gene Expression Trends
Once trajectories are defined, you can project gene expression across pseudotime for specific lineages.

```python
# Compute gene trends for specific genes
# Use magic_imputation if the data is sparse
imp_df = palantir.utils.run_magic_imputation(adata)
trends = palantir.presults.compute_gene_trends(pr_res, imp_df, genes=['GATA1', 'PAX5'])
```

## Expert Tips and Best Practices

- **AnnData Integration**: Since version 1.3.0, Palantir is AnnData-centric. Always prefer passing `AnnData` objects directly to functions rather than raw DataFrames to ensure metadata (like UMAP coordinates) remains synced.
- **Start Cell Selection**: The accuracy of pseudotime depends entirely on the root cell. Use `palantir.utils.early_cell(adata, fill_val)` to help identify potential progenitor cells based on manifold position.
- **Imputation**: For scRNA-seq, use `palantir.utils.run_magic_imputation(adata, sparse=True)` before calculating gene trends to mitigate the effects of technical dropout.
- **Waypoint Sampling**: If the dataset is extremely large, adjust `num_waypoints` in `run_palantir`. While 500-1000 is standard, larger datasets may benefit from more waypoints at the cost of computation time.
- **Visualization**: Use `palantir.plot.plot_trajectories` to visualize multiple differentiation paths simultaneously on a UMAP or t-SNE embedding.

## Reference documentation
- [Palantir GitHub Repository](./references/github_com_dpeerlab_palantir.md)
- [Bioconda Palantir Overview](./references/anaconda_org_channels_bioconda_packages_palantir_overview.md)