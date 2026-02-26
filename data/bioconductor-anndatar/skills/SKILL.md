---
name: bioconductor-anndatar
description: The anndataR package provides a native R implementation of the AnnData data structure for reading, writing, and manipulating single-cell genomics data in HDF5 format. Use when user asks to read or write .h5ad files, convert between AnnData and SingleCellExperiment or Seurat objects, or access and subset single-cell metadata and expression matrices in R.
homepage: https://bioconductor.org/packages/release/bioc/html/anndataR.html
---


# bioconductor-anndatar

## Overview

The `anndataR` package provides a native R implementation of the `AnnData` data structure, primarily used for single-cell genomics. Unlike other packages that rely on Python via `reticulate`, `anndataR` offers a pure R HDF5 interface for `.h5ad` files. It is designed for high interoperability, allowing seamless conversion between `AnnData` objects and standard Bioconductor (`SingleCellExperiment`) or CRAN (`Seurat`) classes.

## Core Workflows

### Reading and Writing Data
The primary entry point is `read_h5ad()`, which can return different object types based on the `as` argument.

```r
library(anndataR)

# Read as an in-memory AnnData object (default)
adata <- read_h5ad("data.h5ad")

# Read directly into R-native formats
sce <- read_h5ad("data.h5ad", as = "SingleCellExperiment")
seurat <- read_h5ad("data.h5ad", as = "Seurat")

# Read as HDF5-backed (lazy loading for large files)
adata_backed <- read_h5ad("data.h5ad", as = "HDF5AnnData")

# Write objects to .h5ad
write_h5ad(adata, "output.h5ad")
write_h5ad(sce, "from_sce.h5ad")
```

### Working with AnnData Objects
`AnnData` objects in R use an S7-based interface. Access slots using the `$` operator.

*   **Slots**: `X` (primary matrix), `obs` (cell metadata), `var` (feature metadata), `obsm`/`varm` (multi-dimensional metadata), `layers` (alternative matrices), `uns` (unstructured data).
*   **Subsetting**: Use standard R bracket notation `[rows, cols]`. This returns an `AnnDataView` (lazy subset) which can be realized using `$as_InMemoryAnnData()`.

```r
# Access data
expression <- adata$X
cell_metadata <- adata$obs

# Subsetting
subset_adata <- adata[adata$obs$cell_type == "B-cell", 1:100]
```

### Interoperability and Conversion
You can convert existing objects using `as_AnnData()` or class-specific methods on the `AnnData` object.

```r
# To AnnData
adata_from_sce <- as_AnnData(sce)
adata_from_seurat <- as_AnnData(seurat)

# From AnnData to R formats
sce_obj <- adata$as_SingleCellExperiment()
seurat_obj <- adata$as_Seurat()
```

### Customizing Conversions
When converting between formats, use mapping arguments to control which slots are transferred. Mappings can be `TRUE` (all), `FALSE` (none), or a named character vector for specific renaming.

```r
# Example: Custom Seurat conversion
seurat_obj <- adata$as_Seurat(
  layers_mapping = c(counts = "raw_counts"), # Map 'raw_counts' layer to Seurat 'counts'
  reduction_mapping = list(pca = c(embeddings = "X_pca"))
)
```

## Python Integration
While `anndataR` is native R, it can interact with Python `AnnData` objects via `reticulate` if needed (e.g., for using `scanpy`).

```r
library(reticulate)
sc <- import("scanpy")
adata_py <- sc$read_h5ad("data.h5ad")

# Convert Python AnnData to SingleCellExperiment
sce <- adata_py$as_SingleCellExperiment()
```

## Reference documentation

- [Using anndataR](./references/anndataR.md)
- [Python Integration with anndataR](./references/usage_python.md)
- [Read/write Seurat objects using anndataR](./references/usage_seurat.md)
- [Read/write SingleCellExperiment objects using anndataR](./references/usage_singlecellexperiment.md)