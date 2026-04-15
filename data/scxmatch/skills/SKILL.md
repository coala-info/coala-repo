---
name: scxmatch
description: scxmatch performs Rosenbaum’s cross-match test to determine if two multivariate distributions in single-cell data are significantly different. Use when user asks to compare cellular distributions between conditions, perform a non-parametric test for global shifts in cell states, or execute a distance-based graph matching test on AnnData objects.
homepage: https://github.com/bionetslab/scxmatch
metadata:
  docker_image: "quay.io/biocontainers/scxmatch:0.1.1--pyhdfd78af_0"
---

# scxmatch

## Overview

The `scxmatch` package provides a Python implementation of Rosenbaum’s cross-match test, specifically optimized for single-cell data. It uses distance-based graph matching to assess whether two multivariate distributions are significantly different. This is a non-parametric, distribution-free approach that is more robust than comparing individual gene expression levels when looking for global shifts in cellular states.

## Installation

Due to its dependency on `graph-tool`, `scxmatch` must be installed via Conda rather than PyPI:

```bash
conda install scxmatch -c conda-forge -c bioconda
```

## Core Usage Pattern

The primary entry point is `scxmatch.test()`. It operates directly on `AnnData` objects, making it compatible with standard `scanpy` workflows.

```python
import scxmatch
import scanpy as sc

# Load data
adata = sc.read_h5ad("data.h5ad")

# Execute the cross-match test
p_val, z_score, support = scxmatch.test(
    adata=adata,
    group_by="condition",
    test_group="treated",
    reference="control",
    metric="sqeuclidean",
    rank=True,
    k=100
)

print(f"P-value: {p_val:.4f}")
print(f"Z-score: {z_score:.2f}")
print(f"Support: {support:.2%}")
```

## Parameter Optimization and Best Practices

### Distance Metrics and Data Scaling
- **Rank Transformation**: Set `rank=True` to transform features into ranks before computing distances. This is highly recommended for scRNA-seq data to mitigate the impact of outliers and varying feature scales.
- **Metric Selection**: The default is `"sqeuclidean"`. For most high-dimensional biological data, squared Euclidean distance is standard, but other `scipy.spatial.distance.cdist` metrics are supported.

### Graph Construction (The `k` Parameter)
The `k` parameter determines how many nearest neighbors are used to construct the adjacency graph:
- **Fixed Integer (Default 100)**: Good for most datasets.
- **"full"**: Calculates the full distance matrix. Only use this for small datasets as it is computationally expensive ($O(N^2)$).
- **"auto"**: Automatically determines `k` based on available memory. If using this, you **must** provide `total_RAM_available_gb`.

### Memory Management
When working with very large single-cell atlases, use the `total_RAM_available_gb` parameter to prevent OOM (Out of Memory) errors during the matching phase.

### Interpreting Results
- **P-value**: Probability that the two groups come from the same distribution.
- **Z-score**: The standardized test statistic. Higher values indicate greater divergence between groups.
- **Relative Support**: The proportion of samples successfully included in the matching. Low support may indicate issues with the graph construction or highly imbalanced groups.

## Side Effects and Metadata
Running `scxmatch.test` modifies the input `adata.obs` in-place. It adds a column named `XMatch_partner_<test_group>_vs_<reference>`, which stores the index of each cell's matched partner in the Minimum Weight Covariate Matching (MWMCM). This is useful for downstream "nearest-neighbor" style comparisons between the two conditions.

## Reference documentation
- [scxmatch GitHub Repository](./references/github_com_bionetslab_scxmatch.md)
- [scxmatch Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scxmatch_overview.md)