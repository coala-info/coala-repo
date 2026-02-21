---
name: mnnpy
description: mnnpy is a high-performance Python implementation of the Mutual Nearest Neighbors (MNN) batch correction method.
homepage: http://github.com/chriscainx/mnnpy
---

# mnnpy

## Overview

mnnpy is a high-performance Python implementation of the Mutual Nearest Neighbors (MNN) batch correction method. It identifies pairs of cells that are mutual nearest neighbors across different batches to calculate correction vectors, effectively removing technical noise while maintaining the underlying biological signal. Unlike the original R implementation, mnnpy is optimized for large-scale datasets with multicore support via OpenMP and lower memory overhead. It is designed to integrate seamlessly with `scanpy` and `anndata` objects.

## Installation and Setup

Install via pip or conda:

```bash
pip install mnnpy
# OR
conda install -c bioconda mnnpy
```

**Expert Tip (Installation):** If installation fails due to C compiler issues on macOS/Linux, explicitly set the compiler:
```bash
brew install gcc@8
export CC=/usr/local/Cellar/gcc@8/8.4.0/bin/gcc-8
pip install mnnpy
unset CC
```

## Core Usage Pattern

The primary function is `mnn_correct()`. It accepts multiple AnnData objects or matrices.

```python
import mnnpy
import scanpy as sc

# Load batches
adata1 = sc.read("batch1.h5ad")
adata2 = sc.read("batch2.h5ad")

# Identify Highly Variable Genes (HVGs) - Recommended for performance
hvgs = ["gene1", "gene2", "gene3"] # or derived from sc.pp.highly_variable_genes

# Run correction
# Returns a tuple: (corrected_adata, correction_vectors, list_of_indices)
corrected_list = mnnpy.mnn_correct(adata1, adata2, var_subset=hvgs, batch_categories=["B1", "B2"])
adata_integrated = corrected_list[0]
```

## Best Practices and Parameters

*   **Data Preprocessing:** Always use **log-transformed** data. MNN correction is designed for log-normalized expression values.
*   **Feature Selection:** Use Highly Variable Genes (`var_subset`) instead of the full gene set. This significantly speeds up the computation and reduces noise in the neighbor search.
*   **Sigma (Bandwidth):** The default `sigma` is 1.0. While the R version (scran) moved to 0.1, mnnpy retains 1.0 as it often performs better on Python-based workflows. If the correction is too "aggressive," try reducing sigma.
*   **Cosine Normalization:** Keep `cos_norm=True` (default). This helps mitigate differences in total RNA content between batches before calculating distances.
*   **Parallelization:** mnnpy uses OpenMP-based multithreading. Ensure your environment supports OpenMP for maximum performance on large datasets.

## Troubleshooting and Expert Tips

*   **Memory Management:** If you encounter memory issues, ensure you are using version 0.1.9 or higher, which replaced standard multiprocessing with OpenMP multithreading to reduce memory overhead.
*   **Multiprocessing Bugs:** If you see strange errors during the normalization phase, force sequential normalization:
    ```python
    mnnpy.settings.normalization = 'seq'
    ```
*   **Scipy Compatibility:** In newer versions of Scipy, the `n_jobs` parameter in `cKDTree` was renamed to `workers`. If you encounter a "keyword argument" error regarding `n_jobs`, you may need to use a compatible Scipy version or patch the call if using an older mnnpy version.
*   **Output Structure:** `mnn_correct` returns a tuple. The first element `[0]` is the integrated AnnData object. The `batch` information is automatically added to the `obs` metadata.

## Reference documentation
- [mnnpy GitHub Repository](./references/github_com_chriscainx_mnnpy.md)
- [mnnpy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mnnpy_overview.md)