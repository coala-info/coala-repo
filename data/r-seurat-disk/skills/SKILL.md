---
name: r-seurat-disk
description: This tool provides a high-performance HDF5-based file format for storing Seurat objects and converting data between R and Python single-cell ecosystems. Use when user asks to save or load h5Seurat files, convert between Seurat and AnnData formats, or perform memory-efficient partial loading of single-cell datasets.
homepage: https://cran.r-project.org/web/packages/seurat-disk/index.html
---


# r-seurat-disk

## Overview
`seurat-disk` provides a dedicated HDF5-based file format (h5Seurat) for Seurat objects. It is designed for high-performance storage of multi-modal single-cell data and enables seamless interoperability with the Python Scanpy ecosystem by providing robust conversion tools between `.h5Seurat` and `.h5ad` files.

## Installation
`seurat-disk` is currently available primarily via GitHub.
```R
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
remotes::install_github("mojaveazure/seurat-disk")
library(SeuratDisk)
```

## Core Workflows

### 1. Saving and Loading h5Seurat Files
The h5Seurat format preserves all Seurat object slots (assays, reductions, graphs, images).

*   **Save:** `SaveH5Seurat(object, filename = "data.h5Seurat", overwrite = TRUE)`
*   **Load:** `object <- LoadH5Seurat("data.h5Seurat")`

### 2. Interoperability with Scanpy (AnnData)
Conversion between Seurat and AnnData is a two-step process using h5Seurat as the intermediate.

**Seurat to AnnData (.h5ad):**
```R
SaveH5Seurat(seurat_obj, filename = "transfer.h5Seurat")
Convert("transfer.h5Seurat", dest = "h5ad")
```

**AnnData (.h5ad) to Seurat:**
```R
Convert("data.h5ad", dest = "h5seurat", overwrite = TRUE)
seurat_obj <- LoadH5Seurat("data.h5seurat")
```

### 3. Memory-Efficient Partial Loading
You can load specific parts of a dataset without reading the entire file into RAM.

*   **Connect without loading:** `hfile <- Connect("data.h5Seurat")`
*   **View contents:** `hfile$index()`
*   **Load specific assays/slots:**
    ```R
    # Load only the SCT assay data slot
    obj <- LoadH5Seurat("data.h5Seurat", assays = list(SCT = "data"))
    ```
*   **Append data to an existing object:**
    ```R
    # Add PCA reductions to a partially loaded object
    obj <- AppendData(file = "data.h5Seurat", object = obj, reductions = "pca")
    ```
*   **Close connection:** `hfile$close_all()`

## Tips for Success
*   **Global Objects:** Dimensional reductions (like UMAP) and Images are often marked "global." You can load them even if their associated assay is not loaded by setting `reductions = NA` or `images = NULL` in `LoadH5Seurat`.
*   **Overwrite:** The `Convert()` and `SaveH5Seurat()` functions require `overwrite = TRUE` if the destination file already exists.
*   **Validation:** Use `hfile$index()` after `Connect()` to verify which slots (counts, data, scale.data) are actually present in the file before attempting to load them.

## Reference documentation
- [Conversions: h5Seurat and AnnData](./references/convert-anndata.html.md)
- [Saving and Loading Data from an h5Seurat File](./references/h5Seurat-load.html.md)
- [h5Seurat File Format Specification](./references/h5Seurat-spec.html.md)
- [SeuratDisk Home](./references/home_page.md)