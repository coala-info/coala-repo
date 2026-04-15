---
name: bioconductor-scarray.sat
description: SCArray.sat extends the Seurat framework to support large-scale single-cell analysis by using Genomic Data Structure files as an on-disk backend. Use when user asks to analyze millions of cells on standard hardware, convert datasets to GDS format, or perform Seurat workflows using on-disk data storage.
homepage: https://bioconductor.org/packages/release/bioc/html/SCArray.sat.html
---

# bioconductor-scarray.sat

## Overview

SCArray.sat (Single-Cell Array Seurat Analysis Tool) extends the Seurat framework to support Genomic Data Structure (GDS) files. By using GDS as a DelayedArray backend, it allows users to analyze millions of cells on standard hardware by keeping data on-disk rather than in-memory. It introduces the `SCArrayAssay` class, which is compatible with standard Seurat workflows but utilizes optimized algorithms for on-disk data access.

## Key Workflows

### 1. Data Preparation and Conversion
To use SCArray.sat, data must first be in a GDS format. You can convert from `SingleCellExperiment`, `Seurat`, or a standard matrix.

```R
library(SCArray)
library(SCArray.sat)
library(Seurat)

# Convert a matrix or SingleCellExperiment to GDS
# scConvGDS(input_object, "output.gds")

# Create a Seurat object directly from a GDS file
seurat_obj <- scNewSeuratGDS("path_to_data.gds")
```

### 2. Standard Seurat Workflow
SCArray.sat implements S3 methods for common Seurat generics. These versions are optimized to handle `SC_GDSMatrix` objects without pulling the full matrix into RAM.

```R
# Normalization (Log-normalization)
seurat_obj <- NormalizeData(seurat_obj)

# Feature Selection
seurat_obj <- FindVariableFeatures(seurat_obj, nfeatures = 2000)

# Scaling (Calculates on-the-fly or stores as DelayedMatrix)
seurat_obj <- ScaleData(seurat_obj)

# Dimensionality Reduction
# RunPCA.SC_GDSMatrix is optimized for large-scale covariance matrices
seurat_obj <- RunPCA(seurat_obj)
seurat_obj <- RunUMAP(seurat_obj, dims = 1:50)
```

### 3. Memory Management and Persistence
*   **Saving:** You can save the Seurat object as an `.rds` file. The `SCArrayAssay` stores the file path to the GDS; it does not embed the raw counts in the RDS, keeping file sizes small.
*   **Reloading:** When `readRDS()` is called, the GDS file is automatically reopened when the data is accessed.
*   **Downgrading:** If a specific package requires a standard in-memory matrix, use `scMemory()` to convert the assay back to a standard Seurat `Assay`.

```R
# Convert back to in-memory sparse matrix if needed
standard_seurat <- scMemory(seurat_obj)
```

### 4. Parallel Processing
SCArray.sat leverages `BiocParallel` for multi-core operations.

```R
library(BiocParallel)
DelayedArray::setAutoBPPARAM(MulticoreParam(workers = 4))
```

## Tips for Large Datasets
*   **Check Backend:** Use `scGetFiles(seurat_obj)` to verify which GDS file is backing the current assay.
*   **Verbose Mode:** If operations seem slow or you need to track on-disk access, enable debugging with `options(SCArray.verbose = TRUE)`.
*   **Sparse Matrix Limits:** Standard R sparse matrices (Matrix package) are limited to ~2.1 billion non-zero elements. SCArray bypasses this limit, making it the preferred choice for "Dfull" (1.3M+ cell) datasets.

## Reference documentation
- [SCArray -- Large-scale single-cell RNA-seq data manipulation with GDS files](./references/Overview.Rmd)
- [Large-scale single-cell RNA-seq data manipulation with GDS files](./references/SCArray.Rmd)
- [Large-scale single-cell RNA-seq data analysis using GDS files and Seurat](./references/SCArray.sat.md)