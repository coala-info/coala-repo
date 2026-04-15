---
name: kompot
description: Kompot is a Python library and CLI tool for comparing phenotypic manifolds in single-cell data to identify differential abundance and gene expression. Use when user asks to compare single-cell conditions, compute Mahalanobis distances between manifolds, or perform differential expression analysis using Gaussian Process models.
homepage: https://github.com/settylab/kompot
metadata:
  docker_image: "quay.io/biocontainers/kompot:0.6.3--pyhdfd78af_0"
---

# kompot

## Overview

Kompot is a high-performance Python library and CLI tool designed to compare phenotypic manifolds in single-cell data. It identifies differential abundance (DA) and differential gene expression (DGE) by leveraging Gaussian Process models to compute Mahalanobis distances, providing a robust statistical measure of shift between conditions. It is optimized for speed via a JAX backend (with optional GPU support) and maintains full compatibility with AnnData objects. Use this skill to execute analysis pipelines, configure hardware acceleration, and interpret manifold-scale differences.

## CLI Usage Patterns

The primary entry point for command-line analysis is the `de` (differential expression) subcommand.

### Basic Differential Expression
Run a comparison between two groups defined in the AnnData observations (`obs`):
```bash
kompot de input.h5ad -o output.h5ad \
    --groupby condition_column \
    --condition1 control \
    --condition2 treatment
```

### Performance and Hardware Control
Kompot allows for fine-grained control over computational resources, which is critical for large-scale single-cell datasets:
- **GPU Acceleration**: Ensure JAX is configured for CUDA to automatically utilize GPU resources.
- **Thread Management**: Use `--threads [N]` to limit CPU usage in shared environments.
- **Memory Optimization**: For datasets with high sample variance, utilize disk-backed covariance storage to prevent OOM (Out of Memory) errors.

## Python API Integration

Kompot follows a scikit-learn-like API pattern (`fit`/`predict`) but also provides high-level functional wrappers for rapid analysis.

### Standard Workflow
```python
import kompot
import anndata as ad

# Load your single-cell data
adata = ad.read_h5ad("sample.h5ad")

# Compute differential expression using PCA embeddings
kompot.compute_differential_expression(
    adata, 
    groupby="cell_type", 
    condition1="Group_A", 
    condition2="Group_B", 
    obsm_key="X_pca"
)
```

## Expert Tips and Best Practices

- **Embedding Selection**: Always specify an appropriate `obsm_key` (usually `X_pca`). The Mahalanobis distance calculation is most effective in a reduced dimensional space that captures the biological variance of the manifold.
- **RunInfo Utility**: After execution, check the `RunInfo` metadata stored within the object to verify package versions and parameters used during the computation, ensuring reproducibility.
- **Visualization**: Use the built-in plotting suite for downstream analysis. Kompot supports generating volcano plots and heatmaps specifically tuned for Mahalanobis distance results.
- **Large Datasets**: When working with tens of thousands of cells, prefer the CLI for pipeline integration or ensure you are using the JAX GPU backend to handle the Gaussian Process covariance matrix calculations efficiently.

## Reference documentation
- [Kompot GitHub Repository](./references/github_com_settylab_kompot.md)
- [Bioconda Kompot Overview](./references/anaconda_org_channels_bioconda_packages_kompot_overview.md)