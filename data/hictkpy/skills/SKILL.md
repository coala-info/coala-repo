---
name: hictkpy
description: hictkpy provides high-performance Python bindings for the hictk toolkit to efficiently manipulate and extract data from .hic and .cool files. Use when user asks to read Hi-C data, convert genomic interactions to pandas DataFrames or numpy matrices, and perform fast format conversions between specialized genomic interaction files.
homepage: https://github.com/paulsengroup/hictkpy
---


# hictkpy

## Overview

hictkpy provides high-performance Python bindings for the hictk toolkit, designed for efficient manipulation of .hic and .cool files. It bridges the gap between specialized genomic interaction formats and the Python data science ecosystem, allowing researchers to load massive Hi-C datasets directly into memory-efficient structures. Use this skill to perform fast data extraction, format conversion, and integration of Hi-C data into downstream analysis pipelines.

## Installation

The recommended way to install hictkpy with all optional dependencies (like pandas and numpy support) is via pip:

```bash
pip install 'hictkpy[all]'
```

Alternatively, use conda:

```bash
conda install -c bioconda hictkpy
```

## Core Usage Patterns

### Reading Hi-C Data
To read data, initialize a `File` object with the path and the desired resolution.

```python
import hictkpy

# Open a .hic or .cool file at 100kb resolution
file_path = "data.mcool" # or "data.hic"
clr = hictkpy.File(file_path, 100_000)

# Fetch interactions for a specific chromosome or region
selector = clr.fetch("chr1")
# For specific ranges: clr.fetch("chr1:0-10,000,000")
```

### Data Conversion
Once a region is selected, you can export it to various formats:

```python
# 1. To Pandas DataFrame (Tabular format: bin1_id, bin2_id, count)
df = selector.to_df()

# 2. To NumPy Matrix (Dense representation)
matrix = selector.to_numpy()

# 3. To SciPy CSR Matrix (Sparse representation - recommended for large regions)
sparse_matrix = selector.to_csr()
```

## Expert Tips and Best Practices

- **Resolution Handling**: When working with `.mcool` or `.hic` files (which contain multiple resolutions), you must specify the resolution during the `File` initialization.
- **Memory Efficiency**: For large genomic regions, prefer `to_csr()` over `to_numpy()`. Hi-C matrices are typically very sparse, and dense NumPy arrays can quickly exhaust system memory.
- **Balanced Matrices**: If the file contains normalization vectors (e.g., KR, VC, ICE), ensure you are fetching the balanced matrix if required for your analysis. Check the documentation or file metadata to confirm available normalizations.
- **Dependency-Free Creation**: Recent versions of hictkpy support creating `.cool` and `.hic` files without strictly requiring `pandas` or `pyarrow`, which is useful for lightweight production environments.
- **Type Validation**: hictkpy performs strict type and domain validation when ingesting pixels. Ensure your input data types (e.g., bin IDs as integers) match the expected schema to avoid ingestion errors.

## Reference documentation
- [hictkpy GitHub Repository](./references/github_com_paulsengroup_hictkpy.md)
- [hictkpy Overview](./references/anaconda_org_channels_bioconda_packages_hictkpy_overview.md)