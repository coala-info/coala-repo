---
name: bioconductor-rhdf5client
description: This tool accesses and manipulates remote HDF5 datasets using the HDF5 Service within the Bioconductor DelayedArray framework. Use when user asks to interface with remote HDF5 servers, access large-scale genomic data without downloading entire files, or treat remote datasets as local R objects for subsetting and analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/rhdf5client.html
---


# bioconductor-rhdf5client

name: bioconductor-rhdf5client
description: Access and manipulate remote HDF5 datasets using the HDF5 Service (HSDS) within the Bioconductor DelayedArray framework. Use this skill when a user needs to interface with large-scale genomic or matrix data stored on remote HDF5 servers without downloading the entire file.

# bioconductor-rhdf5client

## Overview

The `rhdf5client` package provides a bridge between remote HDF5 Object Stores (HSDS) and the Bioconductor `DelayedArray` infrastructure. It allows users to treat remote datasets as if they were local R objects, performing subsetting, summarization, and analysis while only fetching the necessary data chunks over the network.

## Core Workflow

### 1. Connection and Data Access
To access a remote dataset, you need the server URL, the file domain (path to the .h5 file on the server), and the internal path to the dataset.

```r
library(rhdf5client)

# Check if the HSDS server is reachable
if (check_hsds()) {
  # Create an HSDSArray object
  # Parameters: URL, server type ('hsds'), file path, dataset path
  da <- HSDSArray(
    endpoint = URL_hsds(), 
    svrtype = "hsds",
    domain = "/shared/bioconductor/patelGBMSC.h5", 
    dsetname = "/assay001"
  )
  
  print(da)
}
```

### 2. Working with HSDSArray
Since `HSDSArray` extends `DelayedArray`, you can use standard R matrix operations. The computations are "delayed" until the data is explicitly requested (e.g., via subsetting or calling a summary function).

```r
# Subsetting (only requested rows/cols are downloaded)
sub_matrix <- da[1:100, 1:5]

# Statistical operations
col_sums <- apply(da[, 1:4], 2, sum)

# Check dimensions and type
dim(da)
type(da)
```

## Tips and Best Practices

- **Server Availability**: Always use `check_hsds()` before attempting to initialize an `HSDSArray` to ensure the remote service is active.
- **Efficiency**: Minimize the number of remote calls by subsetting the data to the smallest required range before performing heavy computations.
- **Delayed Operations**: Remember that operations like `log(da)` or `da + 1` do not execute immediately; they create a new `DelayedArray` object that will perform the calculation only when the data is realized (e.g., by `as.matrix()`).
- **Default Endpoint**: `URL_hsds()` typically points to the default Bioconductor HSDS instance, but you can provide a custom URL string if working with a private HSDS deployment.

## Reference documentation

- [HSDSArray – DelayedArray backend for Remote HDF5](./references/delayed-array.md)