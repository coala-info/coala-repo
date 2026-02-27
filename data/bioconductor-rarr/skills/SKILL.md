---
name: bioconductor-rarr
description: The bioconductor-rarr package provides a native R interface for reading, writing, and interacting with Zarr arrays. Use when user asks to read or write Zarr files, access data subsets without loading entire datasets, inspect Zarr metadata, or integrate Zarr arrays with the DelayedArray framework.
homepage: https://bioconductor.org/packages/release/bioc/html/Rarr.html
---


# bioconductor-rarr

## Overview

The `Rarr` package provides a native R implementation for interacting with Zarr arrays. It allows for efficient access to subsets of data without loading entire datasets into memory. While it does not currently support Zarr hierarchical groups (it reads individual arrays), it supports various compression formats (like blosc and bzip2) and integrates with the `DelayedArray` framework for handling large-scale data.

## Quick Start

### Installation and Loading
```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("Rarr")
library(Rarr)
```

### Exploring a Zarr Array
Use `zarr_overview()` to inspect metadata such as shape, chunk size, and data type.
```r
path <- "path/to/array.zarr"
zarr_overview(path)

# Return as a data frame for programmatic use
meta <- zarr_overview(path, as_data_frame = TRUE)
```

## Reading Data

### Local and Remote Reading
`read_zarr_array()` is the primary function for data extraction.
```r
# Read entire array
data <- read_zarr_array("path/to/array.zarr")

# Read specific subset (e.g., first 10 rows, all columns, first slice)
# Use NULL to select all indices in a dimension
index <- list(1:10, NULL, 1)
subset_data <- read_zarr_array("path/to/array.zarr", index = index)

# Reading from S3
s3_url <- "https://bucket-name.s3.amazonaws.com/array.zarr"
data_s3 <- read_zarr_array(s3_url, index = list(1, NULL, NULL))
```

### S3 Authentication
If accessing private buckets, set environment variables or provide a `paws` S3 client.
```r
# Method 1: Environment Variables
Sys.setenv("AWS_ACCESS_KEY_ID" = "your_id", "AWS_SECRET_ACCESS_KEY" = "your_key")

# Method 2: S3 Client (useful for anonymous access to public buckets when local credentials exist)
library(paws.storage)
s3_client <- paws.storage::s3(config = list(
    credentials = list(anonymous = TRUE),
    endpoint = "https://endpoint-url.com",
    region = "auto"
))
zarr_overview(s3_url, s3_client = s3_client)
```

## Writing Data

### Writing Full Arrays
```r
x <- array(1:1000, dim = c(10, 10, 10))
write_zarr_array(x, zarr_array_path = "new_array.zarr", chunk_dim = c(5, 5, 5))
```

### Partial Updates and Empty Arrays
For large datasets, it is more efficient to create an empty structure and update specific chunks.
```r
# 1. Create empty array with a fill value
create_empty_zarr_array(
    zarr_array_path = "empty.zarr",
    dim = c(100, 100),
    chunk_dim = c(10, 10),
    data_type = "double",
    fill_value = 0
)

# 2. Update a specific subset
update_zarr_array(
    zarr_array_path = "empty.zarr",
    x = matrix(runif(100), 10, 10),
    index = list(1:10, 1:10)
)
```

## DelayedArray Integration
`Rarr` supports the `DelayedArray` framework, allowing Zarr files to be treated like standard R arrays while keeping data on disk.
```r
library(DelayedArray)

# Wrap Zarr as a DelayedArray
za <- ZarrArray("path/to/array.zarr")

# Perform delayed operations (no data loaded yet)
log_za <- log2(za + 1)

# Realize an in-memory object to a Zarr-backed DelayedArray
zarr_backed <- writeZarrArray(some_matrix, zarr_array_path = "backed.zarr")
```

## Limitations
- **Hierarchical Groups**: `Rarr` cannot browse Zarr groups; you must provide the direct path to the specific array folder.
- **Data Types**: Writing is limited to R-native types (integer, double, string).
- **64-bit Integers**: Reading 64-bit integers may result in precision loss if values exceed R's integer capacity.

## Reference documentation
- [Reading Zarr arrays with Rarr](./references/Rarr.md)