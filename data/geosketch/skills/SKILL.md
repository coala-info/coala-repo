---
name: geosketch
description: Geosketch selects a representative subset of points from large datasets while preserving the underlying geometric structure and rare populations. Use when user asks to summarize massive datasets, perform geometric sketching, preserve rare cell types, or reduce data volume for visualization and analysis.
homepage: https://github.com/brianhie/geosketch/
---


# geosketch

## Overview
Geosketch is a specialized tool for summarizing massive datasets by selecting a representative subset of points. Unlike standard uniform sampling, which over-represents dense regions and often misses rare populations, geometric sketching ensures that the sampled "sketch" accurately reflects the entire geometric landscape of the data. This is particularly valuable in bioinformatics for preserving rare cell types while reducing data volume for visualization and downstream analysis.

## Installation
Geosketch can be installed via PyPI or Bioconda:
- `pip install geosketch`
- `conda install bioconda::geosketch`

## Core Workflow
Geometric sketching is most effective when performed on dimensionality-reduced data, such as Principal Components (PCs).

### Python Implementation
The primary function is `gs()`, which returns the indices of the selected samples.

```python
from geosketch import gs
import numpy as np

# 1. Prepare your data (samples in rows, features in columns)
# It is highly recommended to use PCA-reduced data (e.g., top 50-100 PCs)
# X_dimred = ... 

# 2. Compute the sketch
# N is the number of samples to obtain
sketch_index = gs(X_dimred, N, replace=False)

# 3. Apply indices to the original or reduced dataset
X_sketch = X_dimred[sketch_index]
```

### R Implementation
Geosketch can be used in R via the `reticulate` library. Note the specific requirement for index handling.

```R
library(reticulate)
gs_module <- import("geosketch")

# IMPORTANT: Set one_indexed=TRUE because R uses 1-based indexing
sketch_index <- gs_module$gs(X_dimred, N, one_indexed=TRUE)
X_sketch <- X[sketch_index, ]
```

## Best Practices and Expert Tips
- **Dimensionality Reduction**: Do not run geosketch on raw gene expression matrices. Always perform PCA first (typically 50-100 PCs) to capture the variance before sketching.
- **Sketch Size**: For typical single-cell datasets (100k+ cells), a sketch size of 20,000 is a standard starting point that balances computational efficiency with biological representation.
- **Matrix Formats**: The tool supports both sparse and dense matrices. Ensure your input matrix has samples as rows and features (PCs) as columns.
- **Rare Population Detection**: If your goal is to find extremely rare cell types, you may need to increase the sketch size (N) relative to the total population.
- **Reproducibility**: While the algorithm is randomized, the geometric constraints provide more stable representations across runs than uniform sampling.

## Reference documentation
- [Geometric sketching Overview](./references/github_com_brianhie_geosketch.md)
- [Bioconda geosketch package](./references/anaconda_org_channels_bioconda_packages_geosketch_overview.md)