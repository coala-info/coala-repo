---
name: r-anndata
description: The r-anndata package provides an R interface to the Python anndata library for managing large-scale annotated data matrices. Use when user asks to create, read, write, or manipulate AnnData objects in R, handle H5AD files, or integrate R workflows with Python-based single-cell tools like Scanpy.
homepage: https://cloud.r-project.org/web/packages/anndata/index.html
---

# r-anndata

name: r-anndata
description: Expert guidance for using the 'anndata' R package, a reticulate wrapper for the Python 'anndata' library. Use this skill when needing to create, read, write, or manipulate AnnData objects in R, particularly for single-cell genomics workflows, H5AD file interoperability, or integrating R code with Python-based tools like Scanpy.

# r-anndata

## Overview
The `anndata` package provides an R interface to the Python `anndata` library. It allows for the storage of a large data matrix `X` alongside observations (`obs`), variables (`var`), and unstructured metadata (`uns`). It is the standard format for single-cell analysis interoperability between R and Python.

## Installation
Install the package from CRAN:
```r
install.packages("anndata")
```
Note: Since this is a `reticulate` wrapper, it requires a Python environment with the `anndata` Python package installed.

## Core Workflows

### Creating an AnnData Object
Initialize an object by providing a matrix and associated data frames for annotations.
```r
library(anndata)

ad <- AnnData(
  X = matrix(1:6, nrow = 2),
  obs = data.frame(group = c("a", "b"), row.names = c("s1", "s2")),
  var = data.frame(type = c(1L, 2L, 3L), row.names = c("var1", "var2", "var3")),
  uns = list(description = "Example dataset")
)
```

### Accessing Data
Use the `$` operator to access slots. Note that many elements return as Python-linked objects or standard R types depending on the context.
- `ad$X`: The main data matrix.
- `ad$obs`: Observation annotations (data.frame).
- `ad$var`: Variable annotations (data.frame).
- `ad$obsm`: Multi-dimensional observation annotations (list-like).
- `ad$layers`: Additional data matrices of the same shape as `X`.

### File I/O
Read and write the standard `.h5ad` format:
```r
# Reading
ad <- read_h5ad("matrix.h5ad")

# Writing
ad$write_h5ad("output.h5ad")
```

### Subsetting and Views
Subsetting an AnnData object in R creates a "View", which is memory-efficient as it does not copy the underlying data until modified.
```r
# Subset first 100 observations
view <- ad[1:100, ]

# Subset by variable name
gene_subset <- ad[, c("GeneA", "GeneB")]
```

### Integration with Scanpy
You can use `reticulate` to call Scanpy functions directly on the R AnnData object.
```r
library(reticulate)
sc <- import("scanpy")

# Perform Scanpy preprocessing on the R object 'ad'
sc$pp$normalize_total(ad, target_sum = 1e4)
sc$pp$log1p(ad)
sc$pp$highly_variable_genes(ad)
```

## Important Tips
- **In-place Modification**: Unlike standard R objects, modifying an AnnData object often changes the original object in place because it is a pointer to a Python object.
- **Explicit Copying**: To create a true independent copy of an object, use `ad_copy <- ad$copy()`.
- **Matrix Behavior**: `ad$X` can be treated like an R matrix for many operations (e.g., `rowMeans(ad$X)`), but for complex R-native matrix functions, you may need to cast it using `as.matrix()` or `as(ad$X, "SparseMatrix")`.

## Reference documentation
- [Getting started](./references/getting_started.Rmd)
- [Demo with scanpy](./references/scanpy_demo.Rmd)