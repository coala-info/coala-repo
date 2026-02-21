---
name: bioconductor-bufferedmatrix
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BufferedMatrix.html
---

# bioconductor-bufferedmatrix

name: bioconductor-bufferedmatrix
description: Create and manage BufferedMatrix objects in R for handling large tabular datasets that exceed main memory. Use this skill when you need to perform row-wise or column-wise operations on large matrices by buffering data on the file system, particularly when the number of rows is much larger than the number of columns.

# bioconductor-bufferedmatrix

## Overview

The `BufferedMatrix` package provides infrastructure for handling large numerical datasets in a tabular format. Unlike standard R matrices, `BufferedMatrix` objects store the bulk of their data on the file system, keeping only frequently accessed portions (buffers) in RAM. This is ideal for "out-of-memory" computations where the dataset size exceeds available physical memory.

**Key Characteristics:**
- **Pass-by-reference:** Unlike most R objects, modifying a `BufferedMatrix` inside a function affects the original object in the calling environment.
- **Fixed Rows, Dynamic Columns:** The number of rows is fixed at creation, but columns can be added dynamically.
- **Buffering Modes:** Supports `ColMode` (default, optimized for column-wise access) and `RowMode` (optimized for contiguous row access).

## Core Workflows

### 1. Initialization and Setup
Create a matrix by specifying the number of rows. You can optionally specify initial columns and buffer sizes.

```r
library(BufferedMatrix)

# Create a matrix with 10,000 rows and 0 columns
X <- createBufferedMatrix(10000)

# Add columns dynamically
AddColumn(X)

# Create with initial dimensions and specific buffer sizes
# bufferrows: rows kept in RAM during RowMode
# buffercols: columns kept in RAM during ColMode
X <- createBufferedMatrix(10000, 5, bufferrows=500, buffercols=2)
```

### 2. Data Access and Manipulation
Use standard R indexing `[` and `[<-`. Note that subsetting `X[i, j]` returns a standard R matrix (copying data into RAM).

```r
# Assign data (coerces to BufferedMatrix storage)
X[1:20, 1:2] <- matrix(runif(40), 20, 2)

# Access data (returns a standard R matrix)
sub_data <- X[1:5, ]

# Set dimension names
rownames(X) <- paste0("R", 1:10000)
colnames(X) <- c("A", "B")
```

### 3. Buffering and Performance Modes
Switch modes based on your access pattern to minimize disk I/O.

```r
# Optimized for column-wise operations (Default)
ColMode(X)

# Optimized for row-wise operations
RowMode(X)

# Toggle ReadOnlyMode for speed (prevents buffer flushing to disk)
ReadOnlyMode(X)
is.ReadOnlyMode(X)
```

### 4. Summarization and Application
Use optimized functions to calculate statistics without loading the entire matrix into RAM.

```r
# Global statistics
Max(X)
Min(X)
mean(X)
Sum(X)

# Column/Row statistics
rowMeans(X)
colSums(X)
rowVars(X)
colSd(X)

# Apply custom functions
colApply(X, function(x) sum(sqrt(x)))
rowApply(X, function(x) max(x) - min(x))

# Element-wise transformation (Modifies the object in-place)
exp(X)
log(X)
sqrt(X)
pow(X, 2.0)
ewApply(X, function(x) x^2 + 1)
```

### 5. Conversion and Duplication
Since `BufferedMatrix` uses pass-by-reference, use `duplicate()` if you need a true copy.

```r
# Create a physical copy on disk
X_copy <- duplicate(X)

# Convert to standard R matrix (Caution: requires enough RAM)
mat <- as(X, "matrix")

# Convert standard matrix to BufferedMatrix
X_new <- as(mat, "BufferedMatrix")
```

## Important Constraints
- **Persistence:** `BufferedMatrix` objects cannot currently be saved via `save()` or `saveRDS()` and reloaded in a new session. Data is stored in temporary files that are deleted when the R session ends or the object is garbage collected.
- **Matrix Algebra:** These objects are not designed for standard linear algebra (e.g., `%*%`). Convert subsets to standard matrices for such operations.
- **Memory Monitoring:** Use `memory.usage(X)` and `disk.usage(X)` to monitor the footprint of the object.

## Reference documentation
- [BufferedMatrix](./references/BufferedMatrix.md)