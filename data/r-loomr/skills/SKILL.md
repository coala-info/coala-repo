---
name: r-loomr
description: R package loomr (documentation from project home).
homepage: https://cran.r-project.org/web/packages/loomr/index.html
---

# r-loomr

## Overview
The `loomR` package provides an R-based interface for loom files, which are designed to efficiently store large-scale single-cell genomics datasets. It utilizes the `hdf5r` and `R6` frameworks to allow for memory-efficient data access, enabling users to work with datasets that exceed available RAM by reading only the necessary portions from disk.

## Installation
To install the package from GitHub (as it is primarily maintained there):
```R
# Install dependencies first
install.packages(c("R6", "hdf5r", "iterators", "itertools"))

# Install loomR
devtools::install_github("mojaveazure/loomR")
```

## Core Workflows

### Connecting and Creating
- **Connect to an existing file**: `lfile <- connect(filename = "path/to/file.loom", mode = "r+")`
- **Create a new file**: `create(filename = "new.loom", data = matrix_data, row.attrs = list(gene_names = genes), col.attrs = list(cell_names = cells))`

### Data Access and Manipulation
- **Accessing Data**: Use `lfile[["matrix"]]` for the main expression data.
- **Attributes**: Access row attributes via `lfile[["row_attrs"]]` and column attributes via `lfile[["col_attrs"]]`.
- **Layers**: Add additional data layers (e.g., spliced/unspliced counts) using the `add.layer` method.
- **Subsetting**: Use the `batch.scan` or `subset` methods to extract specific portions of the data without loading the entire file into memory.

### Loompy Compatibility
`loomR` is designed to be compatible with the `loompy` Python implementation. It supports:
- `map/apply` operations across the dataset.
- Combining multiple loom files into one.
- Adding cells or merging additional loom objects.
- Managing graphs (e.g., KNN graphs) within the HDF5 structure.

## Tips for Efficient Usage
- **Memory Management**: Always use `lfile$close_all()` when finished to ensure HDF5 file handles are properly released.
- **Chunked Access**: When performing calculations, use the `apply` method to process data in chunks rather than converting the entire matrix to a standard R matrix.
- **Mode Selection**: Use `mode = "r"` for read-only access to prevent accidental file modification.

## Reference documentation
- [README](./references/README.md)
- [Articles](./references/articles.md)
- [Home Page](./references/home_page.md)