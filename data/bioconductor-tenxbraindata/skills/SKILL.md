---
name: bioconductor-tenxbraindata
description: This package provides access to the 1.3 million mouse brain cell scRNA-seq dataset from 10X Genomics for memory-efficient analysis. Use when user asks to download the 1.3 million mouse brain dataset, perform memory-efficient analysis using HDF5-backed DelayedArrays, or implement parallelized chunk-wise processing for large-scale single-cell data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TENxBrainData.html
---

# bioconductor-tenxbraindata

name: bioconductor-tenxbraindata
description: Access and explore the 1.3 million mouse brain cell scRNA-seq dataset from 10X Genomics. Use this skill to download the data as a SingleCellExperiment object, perform memory-efficient analysis using HDF5-backed DelayedArrays, and implement parallelized chunk-wise processing for large-scale single-cell data.

# bioconductor-tenxbraindata

## Overview

The `TENxBrainData` package provides a Bioconductor resource for the 1.3 million mouse brain cell single-cell RNA-seq dataset. To manage the massive scale of this data (28k genes x 1.3M cells), the package utilizes `HDF5Array` and `DelayedArray` frameworks. This allows the count matrix to remain on disk in HDF5 format, loading only specific subsets into memory as needed, which prevents memory exhaustion on standard machines.

## Loading the Data

The primary entry point is the `TENxBrainData()` function, which retrieves the data via `ExperimentHub`.

```r
library(TENxBrainData)

# Downloads (first time) and loads the dataset
tenx <- TENxBrainData()

# Inspect the SingleCellExperiment object
tenx
```

The resulting object contains:
- **Assays**: A `counts` matrix (DelayedMatrix).
- **rowData**: Ensembl IDs and Gene Symbols.
- **colData**: Barcodes, Sequence, Library, and Mouse identifiers.

## Memory Management and Performance

Because the data is stored on disk, standard operations can be slow if the data is read multiple times.

### Increasing Block Size
To speed up processing, increase the `DelayedArray` block size to utilize more available RAM for disk-to-memory transfers.

```r
options(DelayedArray.block.size = 2e9) # Use 2 GB for loading chunks
```

### Efficient Chunk-wise Processing
Avoid calling `colSums()` or `rowMeans()` directly on the full 1.3M cell matrix for complex operations. Instead, iterate through the data in chunks.

```r
# Example: Calculate library sizes for a subset (e.g., first 20k cells)
tenx20k <- tenx[, 1:20000]
chunksize <- 5000
cidx <- snow::splitIndices(ncol(tenx20k), ncol(tenx20k) / chunksize)

lib.sizes <- numeric(ncol(tenx20k))
for (i in cidx) {
    # Load specific chunk into memory as a dense matrix
    m <- as.matrix(counts(tenx20k)[, i, drop = FALSE])
    lib.sizes[i] <- colSums(m)
}
```

## Parallel Computation

Use `BiocParallel` to process chunks in parallel. This is highly recommended for calculating statistics across the entire 1.3M cell dataset.

```r
library(BiocParallel)

# Setup parallel workers
register(SnowParam(workers = 5))

# Define an iterator for column ranges
iterator <- function(tenx, cols_per_chunk = 5000) {
    start <- seq(1, ncol(tenx), by = cols_per_chunk)
    end <- c(tail(start, -1) - 1L, ncol(tenx))
    i <- 0L
    function() {
        if (i == length(start)) return(NULL)
        i <<- i + 1L
        c(start[i], end[i])
    }
}

# Define the worker function
worker_fun <- function(crng, counts) {
    library(TENxBrainData)
    m <- as.matrix(counts[, seq(crng[1], crng[2])])
    list(n = colSums(m != 0), sum = colSums(m))
}

# Execute parallel iteration
results <- bpiterate(ITER = iterator(tenx), FUN = worker_fun, counts = counts(tenx))
```

## Accessing Raw HDF5 Components

If you need to bypass the `SingleCellExperiment` wrapper to work with the sparse HDF5 data directly (e.g., using `data.table` for speed):

```r
library(ExperimentHub)
hub <- ExperimentHub()
fname <- hub[["EH1039"]] # HDF5 file path

# List HDF5 structure
rhdf5::h5ls(fname)

# Read specific pointers (e.g., indptr for sparse format)
indptr <- rhdf5::h5read(fname, "/mm10/indptr", start = 1, count = 1001)
```

## Reference documentation
- [Exploring the 1.3 million brain cell scRNA-seq data from 10X Genomics](./references/TENxBrainData.md)