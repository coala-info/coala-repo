---
name: bioconductor-restfulse
description: This tool provides a bridge between remote HDF5 Object Stores and the Bioconductor SummarizedExperiment ecosystem to enable out-of-memory analysis of large-scale genomic datasets. Use when user asks to access remote HDF5 data, perform out-of-memory analysis on large biological datasets, or manipulate multi-terabyte datasets like 10x Genomics or GTEx without downloading them.
homepage: https://bioconductor.org/packages/3.8/bioc/html/restfulSE.html
---


# bioconductor-restfulse

name: bioconductor-restfulse
description: Access and analyze large-scale genomic data stored on remote HDF5 servers (HSDS) using the SummarizedExperiment interface. Use this skill when you need to perform out-of-memory data analysis on large biological datasets (like 10x Genomics neurons or GTEx tissue expression) without downloading the entire dataset.

# bioconductor-restfulse

## Overview

The `restfulSE` package provides a bridge between remote HDF5 Object Stores (HSDS) and the standard Bioconductor `SummarizedExperiment` ecosystem. It allows users to manipulate multi-terabyte datasets as if they were local R objects, only fetching specific data slices into memory when the `assay()` method is explicitly called. This is particularly useful for single-cell RNA-seq and large-scale methylation studies.

## Core Workflows

### 1. Accessing Built-in Remote Datasets
The package provides convenience functions to access pre-configured remote datasets.

```r
library(restfulSE)

# 1.3 Million Neurons from 10x Genomics
my10x <- se1.3M()

# GTEx Tissue Expression (recount2)
tiss <- gtexTiss()

# 100k Neurons subset
tenx100k <- se100k()
```

### 2. Connecting to Custom HSDS Resources
To connect to a specific HDF5 file on an HSDS server, follow the source-path-dataset hierarchy.

```r
# Establish connection to server
hsds <- H5S_source(URL_hsds())

# Set path to the .h5 file on the server
hsdsCon <- setPath(hsds, "/home/user/my_data.h5")

# List available datasets within that file
datasets <- fetchDatasets(hsdsCon)

# Create a pointer to a specific dataset ID
remote_ds <- H5S_dataset2(hsdsCon, "d-unique-uuid-here")

# Wrap as a DelayedArray for use in SummarizedExperiment
ds_array <- H5S_Array(URL_hsds(), "/home/user/my_data.h5", "assay_name")
```

### 3. Data Manipulation and Slicing
Because `restfulSE` objects inherit from `SummarizedExperiment`, standard R slicing works. Data is only transferred from the server when `assay()` is called.

```r
# Subset metadata (fast, no data transfer)
sub_se <- my10x[1:100, 1:50]

# Extract numerical data (triggers REST API call)
numeric_matrix <- assay(sub_se)

# Example: Filter GTEx by tissue type
brain_indices <- grep("Brain", tiss$smtsd)
brain_se <- tiss[, brain_indices]
```

### 4. Functional Annotations
The package includes helpers to find genes by GO terms to facilitate targeted slicing.

```r
# Find genes related to a pattern
ntgenes <- goPatt(termPattern="neurotroph")

# Use results to slice a SummarizedExperiment
target_genes <- intersect(ntgenes$ENSEMBL, rownames(my10x))
small_slice <- my10x[target_genes, 1:1000]
```

## Tips for Performance
- **Minimize `assay()` calls**: Every call to `assay()` or `as.matrix()` on a `restfulSE` object initiates network I/O. Perform all row/column filtering first.
- **DelayedArray Integration**: The objects returned by `assay()` are often `DelayedMatrix` objects. You can use `DelayedArray` functions to perform block-processing if the slice is still too large for memory.
- **Metadata First**: Use `colData(se)` and `rowData(se)` to identify your targets before requesting the heavy numerical data.

## Reference documentation
- [restfulSE – experiments with HDF5 server content wrapped in SummarizedExperiment](./references/restfulSE.md)