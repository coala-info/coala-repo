---
name: bioconductor-zellkonverter
description: The zellkonverter package facilitates the conversion of single-cell data between R SingleCellExperiment objects and Python AnnData objects. Use when user asks to read or write H5AD files, convert data between SingleCellExperiment and AnnData formats, or transfer single-cell datasets between R and Python ecosystems.
homepage: https://bioconductor.org/packages/release/bioc/html/zellkonverter.html
---

# bioconductor-zellkonverter

## Overview

The `zellkonverter` package provides a critical bridge between the R/Bioconductor ecosystem (centered around `SingleCellExperiment`) and the Python/Scanpy ecosystem (centered around `AnnData`). It allows for seamless data transfer by either reading/writing H5AD files or performing in-memory conversion using `reticulate`.

## Core Workflows

### Reading and Writing H5AD Files

The most common use case is importing or exporting H5AD files.

```r
library(zellkonverter)

# Read an H5AD file into a SingleCellExperiment object
sce <- readH5AD("path/to/data.h5ad")

# Write a SingleCellExperiment object to an H5AD file
writeH5AD(sce, file = "output_data.h5ad")
```

### In-Memory Conversion

For users working with `reticulate` or `basilisk`, data can be converted directly without writing to disk.

```r
# Convert SCE to AnnData (requires reticulate and anndata python package)
adata <- SCE2AnnData(sce)

# Convert AnnData back to SCE
sce_new <- AnnData2SCE(adata)
```

### Managing Python Environments

Because `zellkonverter` relies on specific Python dependencies, it is recommended to use `basilisk` to ensure environment stability.

```r
library(basilisk)

# Run conversion within a managed environment
sce_roundtrip <- basiliskRun(fun = function(sce_obj) {
    adata <- SCE2AnnData(sce_obj)
    # Perform Python operations here if needed
    AnnData2SCE(adata)
}, env = zellkonverterAnnDataEnv(), sce_obj = sce)
```

## Tips and Best Practices

- **Verbosity**: If conversion is taking a long time or you need to debug the mapping of slots, use `verbose = TRUE` in `readH5AD()` or set it globally with `setZellkonverterVerbose(TRUE)`.
- **Dependency Check**: Use `AnnDataDependencies()` to see which versions of Python packages (like `anndata`, `numpy`, and `pandas`) are being used by the current version of the package.
- **Slot Mapping**: `zellkonverter` handles the mapping of `assays` to `X`/`layers`, `colData` to `obs`, `rowData` to `var`, and `reducedDims` to `obsm` automatically.

## Reference documentation

- [Converting single-cell data structures between Bioconductor and Python](./references/zellkonverter.md)