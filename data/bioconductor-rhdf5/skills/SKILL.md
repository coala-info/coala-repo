---
name: bioconductor-rhdf5
description: "This tool provides an R interface for creating, reading, and writing data in the HDF5 format. Use when user asks to store large datasets in a hierarchical structure, read specific subsets of data from disk, manage HDF5 groups and datasets, or access HDF5 files stored in S3 buckets."
homepage: https://bioconductor.org/packages/release/bioc/html/rhdf5.html
---


# bioconductor-rhdf5

name: bioconductor-rhdf5
description: Interface for the HDF5 data format in R. Use this skill to create, read, write, and manage HDF5 files, including handling large datasets, subsetting data without loading entire files into memory, and accessing HDF5 data stored in S3 buckets.

# bioconductor-rhdf5

## Overview
The `rhdf5` package provides an R interface to the Hierarchical Data Format version 5 (HDF5). It allows for the storage of large, complex datasets in a structured, hierarchical manner (similar to a file system with groups and datasets). Key features include high-level functions for easy R object storage, low-level access to the HDF5 C library, and efficient subsetting of on-disk data.

## Core Workflows

### File and Group Management
Create files and organize them using a folder-like hierarchy.
```r
library(rhdf5)
h5createFile("my_data.h5")
h5createGroup("my_data.h5", "experiment_1")
h5createGroup("my_data.h5", "experiment_1/metadata")

# List contents
h5ls("my_data.h5")
```

### Writing and Reading Data
Use `h5write` and `h5read` for standard R objects (matrices, arrays, data frames).
```r
# Write a matrix
A <- matrix(1:10, nrow = 5)
h5write(A, "my_data.h5", "experiment_1/matrix_A")

# Read data
A_back <- h5read("my_data.h5", "experiment_1/matrix_A")

# Read/Write using handles (more efficient for multiple operations)
h5f <- H5Fopen("my_data.h5")
data <- h5f$experiment_1$matrix_A
H5Fclose(h5f)
```

### Efficient Subsetting
Read only specific parts of a large dataset using the `index` argument.
```r
# Read rows 1-2 and all columns
sub_data <- h5read("my_data.h5", "experiment_1/matrix_A", index = list(1:2, NULL))
```

### Handling 64-bit Integers
R natively supports 32-bit integers. For 64-bit HDF5 data, use `bit64conversion`.
```r
# Recommended: use 'bit64' to return integer64 objects
data64 <- h5read("file.h5", "dataset", bit64conversion = "bit64")
```

## Performance Tips
- **Chunking**: For large datasets, use `h5createDataset` to define `chunk` sizes. This significantly impacts random access speed.
- **Compression**: Set `level` (0-9) in `h5write` or `h5createDataset` to reduce file size.
- **Avoid Repeated Opens**: When performing many operations, open a file handle once with `H5Fopen()` and close it with `H5Fclose()` or `h5closeAll()` when finished.
- **Hyperslabs**: For complex regular patterns, use `start`, `stride`, `block`, and `count` arguments instead of `index`.

## Cloud Access (S3)
Read HDF5 files directly from Amazon S3 buckets.
```r
# Public Bucket
url <- "https://bucket-name.s3.amazonaws.com/file.h5"
h5ls(url, s3 = TRUE)
data <- h5read(url, "dataset_name", s3 = TRUE)

# Private Bucket
creds <- list(aws_region = "us-east-1", 
              access_key_id = "ID", 
              secret_access_key = "KEY")
h5ls(url, s3 = TRUE, s3credentials = creds)
```

## Reference documentation
- [rhdf5 Practical Tips](./references/practical_tips.md)
- [rhdf5 - HDF5 interface for R](./references/rhdf5.md)
- [Reading HDF5 Files In The Cloud](./references/rhdf5_cloud_reading.md)