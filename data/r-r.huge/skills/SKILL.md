---
name: r-r.huge
description: The R.huge package provides methods for managing and accessing large matrices stored in binary format on the local file system to bypass RAM limitations. Use when user asks to work with file-backed matrices, manage datasets too large for memory using the FileMatrix class, or maintain legacy codebases like aroma.affymetrix.
homepage: https://cloud.r-project.org/web/packages/R.huge/index.html
---


# r-r.huge

name: r-r.huge
description: Methods for accessing and managing large datasets in R using file-backed matrices. Use this skill when working with legacy codebases (specifically aroma.affymetrix) that require the R.huge package, or when managing matrices stored in binary format on the local file system to bypass RAM limitations. Note: This package is deprecated; for new projects, consider bigmemory, ff, or BufferedMatrix.

# r-r.huge

## Overview
The `R.huge` package provides a class-based approach (using `R.oo`) to handle matrices that are too large to fit into memory. It stores data in a binary format on the local file system, meaning the data size is limited by disk space rather than RAM. It is primarily maintained for compatibility with the `aroma.affymetrix` framework.

## Installation
To install the stable version from CRAN:
```r
install.packages("R.huge")
```

## Core Workflow: File-Backed Matrices
The primary class is `FileMatrix`, which allows for persistent, disk-based storage of numeric data.

### Creating a File-Backed Matrix
```r
library(R.huge)

# Create a new file-backed matrix (e.g., 1000 rows, 100 columns)
# This creates a physical file on disk
fm <- FileMatrix("my_data.bin", nrow=1000, ncol=100)

# Check dimensions
dim(fm)
```

### Accessing and Modifying Data
`FileMatrix` objects use standard R indexing, but data is read from or written to the disk.
```r
# Write data to a specific cell
fm[1, 1] <- 3.14

# Write a whole row
fm[2, ] <- runif(100)

# Read data
val <- fm[1, 1]
row_data <- fm[2, ]
```

### Memory Management
Since data is on disk, you can work with matrices much larger than your RAM.
```r
# Close the connection to the file
close(fm)

# Re-open an existing FileMatrix
fm <- FileMatrix("my_data.bin")
```

## Important Considerations
- **Deprecation**: This package is deprecated. Do not use it for new development unless required by legacy dependencies.
- **Alternatives**: 
    - `bigmemory`: High-performance shared memory matrices.
    - `ff`: Efficient storage of large data on disk.
    - `BufferedMatrix`: Bioconductor alternative for large matrices.
- **Performance**: Disk I/O is significantly slower than RAM. Minimize frequent small read/writes by processing data in chunks when possible.
- **File Format**: The data is stored in a simple binary format. Ensure you have sufficient disk permissions and space.

## Reference documentation
- [R.huge: Methods for Accessing Huge Amounts of Data [deprecated]](./references/README.md)