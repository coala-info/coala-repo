---
name: zifa
description: ZIFA (Zero-Inflated Factor Analysis) is a dimensionality reduction framework specifically engineered for single-cell gene expression analysis.
homepage: https://github.com/epierson9/ZIFA
---

# zifa

## Overview

ZIFA (Zero-Inflated Factor Analysis) is a dimensionality reduction framework specifically engineered for single-cell gene expression analysis. In single-cell sequencing, many genes appear to have zero expression due to "dropout" events—where a transcript is present but not detected. ZIFA models the probability of these zeros as a function of the mean expression level, allowing for a more accurate latent representation of the data than general-purpose algorithms. It is particularly useful for visualization, clustering, and identifying biological trajectories in sparse datasets.

## Usage Guidelines

### Data Preparation
* **Log Transformation**: ZIFA is designed to work with log-transformed data. If starting with raw count data, apply the transformation $Y = \log_2(1 + \text{count\_data})$ before fitting the model.
* **Data Type**: Ensure the input matrix $Y$ is of type `np.float64` to prevent unexpected behavior or precision errors during the Expectation-Maximization (EM) iterations.

### Algorithm Selection
* **Standard ZIFA**: Use `ZIFA.fitModel(Y, k)` for smaller datasets (e.g., fewer than 2,000 genes).
* **Block ZIFA**: For datasets with more than a few thousand genes, use `block_ZIFA.fitModel(Y, k)`. This version increases efficiency by subsampling genes in blocks.
* **Block Size**: The default block size is approximately 500 genes ($n\_blocks = n\_genes / 500$). While decreasing block size reduces runtime, it may decrease the reliability of the results.

### Implementation Patterns

To fit a model using the standard algorithm:
```python
from ZIFA import ZIFA
# Y: log-transformed expression matrix
# k: number of latent dimensions (e.g., 2 for visualization)
Z, model_params = ZIFA.fitModel(Y, k)
```

To fit a model using the block algorithm for large-scale data:
```python
from ZIFA import block_ZIFA
# n_blocks is optional; defaults to n_genes / 500
Z, model_params = block_ZIFA.fitModel(Y, k, n_blocks=desired_n_blocks)
```

### Performance and Optimization
* **Runtime**: Block ZIFA runtime is roughly linear with respect to the number of samples and genes, but quadratic with respect to the block size.
* **Convergence**: If the model fails to converge or produces errors with different versions of SciPy/NumPy, consider adjusting the `absolute_tolerance` parameter in the source if the unit tests fail.
* **Filtering**: It is recommended to filter out genes that are zero across all samples before running the algorithm to improve stability.

## Reference documentation
- [ZIFA Main Repository and Instructions](./references/github_com_epierson9_ZIFA.md)