---
name: bioconductor-scarray
description: SCArray manages large-scale single-cell omics data by providing a memory-efficient GDS-based backend for the SingleCellExperiment framework. Use when user asks to convert matrices to GDS format, load large datasets as DelayedMatrix objects, or perform optimized normalization and dimensionality reduction on millions of cells.
homepage: https://bioconductor.org/packages/release/bioc/html/SCArray.html
---


# bioconductor-scarray

## Overview
SCArray is a Bioconductor package designed for the management of large-scale single-cell omics data. It utilizes the Genomic Data Structure (GDS) format as an alternative to HDF5 or TileDB. By integrating with the `SingleCellExperiment` and `DelayedArray` frameworks, SCArray allows users to perform standard analysis workflows (like those in `scater` and `scuttle`) on datasets with millions of cells while maintaining a low memory footprint.

## Core Workflow

### 1. Data Conversion to GDS
To use SCArray, you must first convert your data (a standard matrix or a `SingleCellExperiment` object) into a GDS file.

```R
library(SCArray)
library(SingleCellExperiment)

# From an existing SingleCellExperiment
scConvGDS(sce, "output_data.gds")

# From a sparse or dense matrix
library(Matrix)
cnt <- as(my_matrix, "sparseMatrix")
scConvGDS(cnt, "output_data.gds")
```

### 2. Loading GDS Data
Once a GDS file exists, load it as a `SingleCellExperiment` object. The assays will be `SC_GDSMatrix` objects (a type of `DelayedMatrix`).

```R
# Load the experiment
sce <- scExperiment("output_data.gds")

# Check the assay - notice it is a DelayedMatrix
assays(sce)$counts
```

### 3. Normalization and Summarization
Standard Bioconductor tools work with SCArray objects, but SCArray provides optimized versions for GDS backends.

```R
# Normalization using scuttle
library(scuttle)
sce <- logNormCounts(sce)

# Optimized row/column summarization
logcnt <- assays(sce)$logcounts
mvar <- scRowMeanVar(logcnt) # Efficiently calculates mean and variance
```

### 4. Dimensionality Reduction
While standard `runPCA` works, it can be memory-intensive because it may "realize" the matrix into memory. SCArray provides `scRunPCA` which is optimized for large-scale data.

```R
library(scater)

# Optimized PCA for large datasets
sce <- scRunPCA(sce)

# Standard UMAP (works on the PCA results)
sce <- runUMAP(sce)

# Visualization
plotReducedDim(sce, dimred="PCA")
plotReducedDim(sce, dimred="UMAP")
```

## Tips and Debugging
- **Memory Management**: The primary benefit of SCArray is that the full matrix is never loaded into RAM. Operations are performed in chunks.
- **Verbose Output**: To see what is happening under the hood (e.g., when a GDS-specific optimization is triggered), enable verbose mode:
  ```R
  options(SCArray.verbose=TRUE)
  ```
- **File Handling**: Always remember that the `SingleCellExperiment` object is linked to a physical `.gds` file on disk. If you move the file, you must update the path or reload the object.

## Reference documentation
- [Overview](./references/Overview.md)
- [SCArray: Large-scale single-cell RNA-seq data manipulation with GDS files](./references/SCArray.md)