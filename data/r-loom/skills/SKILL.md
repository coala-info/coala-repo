---
name: r-loom
description: This R package provides an interface for creating, reading, and manipulating HDF5-based loom files for large-scale single-cell genomics data. Use when user asks to connect to loom files, add layers or attributes, perform memory-efficient batch processing, or subset large datasets in R.
homepage: https://cran.r-project.org/web/packages/loom/index.html
---

# r-loom

name: r-loom
description: Specialized R package for interacting with .loom files, a HDF5-based format for large-scale single-cell genomics data. Use this skill when you need to create, read, manipulate, or analyze loom files in R, including adding layers, attributes, and performing map/apply operations on large datasets.

## Overview

The `loomR` package provides an R-based interface for loom files, designed to be compatible with the `loompy` Python implementation. It utilizes the `R6` class system and `hdf5r` to provide efficient access to large-scale single-cell RNA-seq data without loading the entire dataset into memory.

## Installation

```R
install.packages("loomR")
# Note: Requires HDF5 C++ API (libhdf5-dev on Debian/Ubuntu, hdf5-devel on RHEL/CentOS)
```

## Core Workflows

### Connecting and Creating
- **Connect to a file**: `lfile <- connect(filename = "path/to/file.loom", mode = "r+")` (modes: "r" for read-only, "r+" for read/write).
- **Create a new file**: `create(filename, data, row.attrs, col.attrs)` where `data` is a matrix (genes x cells).

### Data Access
- **Access Main Matrix**: `lfile$matrix[rows, cols]`
- **Access Layers**: `lfile$layers$layer_name[rows, cols]`
- **Access Attributes**: 
  - Row attributes: `lfile$row.attrs$attribute_name[]`
  - Column attributes: `lfile$col.attrs$attribute_name[]`

### Modifying Loom Files
- **Add Attributes**: `lfile$add.row.attribute(list(name = data))` or `lfile$add.col.attribute(list(name = data))`.
- **Add Layers**: `lfile$add.layer(list(name = matrix))`.
- **Add Graphs**: `lfile$add.graph(graph, name, is.row = FALSE)`.

### Batch Processing (Map/Apply)
LoomR supports processing data in chunks to maintain a low memory footprint:
- **Apply**: Perform operations across rows or columns.
- **Map**: Calculate values and return them as a new attribute.

### File Management
- **Close connection**: Always close the file handle when finished to prevent HDF5 corruption: `lfile$close()`.
- **Subset**: `lfile$subset(filename, row.indices, col.indices)` creates a new loom file from a subset of the current one.

## Tips for Success
- **Memory Efficiency**: Avoid using `lfile$matrix[,]` on very large files; instead, access specific indices or use the map/apply methods.
- **R6 Syntax**: Remember that `loomR` uses R6 objects; methods are accessed via the `$` operator (e.g., `object$method()`).
- **Compatibility**: Ensure row and column attribute lengths match the dimensions of the main matrix.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)