---
name: cellrank
description: CellRank is a modular framework designed to study cellular dynamics by combining the robustness of trajectory inference with the directionality of RNA velocity or other biological priors.
homepage: https://github.com/theislab/cellrank
---

# cellrank

## Overview
CellRank is a modular framework designed to study cellular dynamics by combining the robustness of trajectory inference with the directionality of RNA velocity or other biological priors. It operates through two primary components: **Kernels**, which build cell-cell transition matrices based on data like RNA velocity, pseudotime, or developmental potential; and **Estimators**, which perform Markov chain analysis on these matrices to identify stable states and lineage drivers. It is fully integrated with the `scverse` ecosystem (Scanpy/AnnData).

## Core Workflow
The standard CellRank workflow follows a sequential pattern of kernel initialization, transition matrix computation, and estimator analysis.

### 1. Kernel Initialization and Transition Matrix
Kernels define the "rules" for how cells transition. Choose a kernel based on your available data:
- **VelocityKernel**: Uses RNA velocity vectors (requires `scvelo`).
- **CytoTRACEKernel**: Uses differentiation potential based on gene counts.
- **PseudotimeKernel**: Uses a pre-computed pseudotime (e.g., from DPT or Palantir).

```python
import cellrank as cr

# Initialize a kernel (e.g., using RNA velocity)
vk = cr.kernels.VelocityKernel(adata)

# Compute the transition matrix
vk.compute_transition_matrix()
```

### 2. Estimator Analysis
Estimators take the transition matrix and identify biological states. The `GPCCA` estimator is the standard for most applications.

```python
# Initialize the estimator
g = cr.estimators.GPCCA(vk)

# Identify terminal states
g.compute_terminal_states(n_states=None)

# Compute fate probabilities towards terminal states
g.compute_fate_probabilities()
```

## Key Applications and Patterns

### Identifying Driver Genes
Once fate probabilities are computed, identify genes that correlate with the trajectory towards a specific terminal state.
```python
drivers = g.compute_lineage_drivers(lineages="Alpha_cells")
```

### Visualizing Gene Trends
Visualize how gene expression changes along a specific lineage's fate probability.
```python
cr.pl.gene_trends(
    adata,
    model=cr.models.GAM(adata),
    genes=["Ins1", "Gcg"],
    lineages="Beta_cells",
)
```

### Working with Multi-view Data
CellRank 2 allows combining multiple kernels (e.g., Velocity + CytoTRACE) to create a "weighted" transition matrix.
```python
combined_kernel = 0.6 * vk + 0.4 * ck
combined_kernel.compute_transition_matrix()
```

## Best Practices
- **Data Preprocessing**: Ensure your `AnnData` object has been preprocessed with Scanpy (normalization, PCA, and neighbors) before initializing kernels.
- **State Selection**: When using `compute_terminal_states`, if `n_states` is not provided, CellRank uses the eigengap heuristic. Always verify these states against known biological markers.
- **Directionality**: If your trajectory looks "backward," check the directionality of your pseudotime or velocity vectors. The `PseudotimeKernel` requires a defined starting point.
- **Scalability**: For very large datasets, use the `PETSc` solver if available in your environment to accelerate the Schur decomposition in GPCCA.

## Reference documentation
- [CellRank GitHub Repository](./references/github_com_theislab_cellrank.md)
- [CellRank Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cellrank_overview.md)