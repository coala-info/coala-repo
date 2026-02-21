---
name: r-bigmemory
description: "Create, store, access, and manipulate massive matrices.     Matrices are allocated to shared memory and may use memory-mapped     files.  Packages 'biganalytics', 'bigtabulate', 'synchronicity', and     'bigalgebra' provide advanced functionality.</p>"
homepage: https://cloud.r-project.org/web/packages/bigmemory/index.html
---

# r-bigmemory

name: r-bigmemory
description: Manage massive matrices in R using shared memory and memory-mapped files. Use this skill when working with datasets that exceed available RAM, requiring 'big.matrix' objects for efficient storage, access, and manipulation.

# r-bigmemory

## Overview

The `bigmemory` package allows R users to manage massive matrices by allocating them to shared memory or memory-mapped files. This enables handling datasets larger than physical RAM and facilitates shared-memory parallel computing. It provides an S4 class `big.matrix` that behaves similarly to a standard R `matrix`.

## Installation

```R
install.packages("bigmemory")
# Recommended companion packages
install.packages(c("biganalytics", "bigtabulate", "bigalgebra", "synchronicity"))
```

## Core Workflows

### 1. Creating a big.matrix
Create a matrix in RAM (shared memory) or linked to a file on disk.

```R
library(bigmemory)

# Create an in-memory big.matrix
x <- big.matrix(nrow = 1000, ncol = 100, type = "double", init = 0)

# Create a file-backed big.matrix (persists on disk)
# This is essential for datasets larger than RAM
y <- filebacked.big.matrix(nrow = 10000, ncol = 1000, type = "integer",
                           backingfile = "data.bin",
                           descriptorfile = "data.desc")
```

### 2. Accessing and Modifying
Use standard R indexing. Note that `big.matrix` objects are modified in-place (pass-by-reference).

```R
# Basic indexing
x[1, 1] <- 5
val <- x[1:10, 5]

# Column names (requires option enabled for performance reasons)
options(bigmemory.allow.dimnames = TRUE)
colnames(x) <- c("alpha", "beta", ...)
```

### 3. Attaching to Existing Matrices
To use a file-backed matrix in a new R session or a different process:

```R
# Load the descriptor to point to the binary data
desc <- dget("data.desc")
z <- attach.big.matrix(desc)
```

### 4. Data Types
Choose the smallest type necessary to save memory:
- `double` (8 bytes)
- `float` (4 bytes)
- `integer` (4 bytes)
- `short` (2 bytes)
- `char` (1 byte)

## Key Functions

- `big.matrix()`: Create a new shared-memory matrix.
- `filebacked.big.matrix()`: Create a matrix backed by a file on disk.
- `as.big.matrix()`: Coerce a standard R matrix to a `big.matrix`.
- `attach.big.matrix()`: Connect to an existing file-backed or shared-memory matrix.
- `describe()`: Get the descriptor object required for attaching.
- `mmap()`: Low-level memory mapping (used internally).
- `flush()`: Ensure file-backed changes are written to disk.

## Tips for Performance
- **Avoid Copies**: `big.matrix` uses reference semantics. Assigning `y <- x` does not copy the data; both variables point to the same memory.
- **Column-Major**: Like R matrices, `big.matrix` is column-major. Accessing data by column is significantly faster than by row.
- **Shared Memory**: Use `bigmemory` with the `foreach` package and `doParallel` to allow multiple workers to access the same data without copying.

## Reference documentation
- [bigmemory README](./references/README.md)