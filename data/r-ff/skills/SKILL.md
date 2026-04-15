---
name: r-ff
description: The r-ff tool provides memory-efficient storage and fast access for large datasets by mapping disk-based objects into R. Use when user asks to handle datasets that exceed available RAM, store large matrices on disk, or perform chunked processing on massive data frames.
homepage: https://cloud.r-project.org/web/packages/ff/index.html
---

# r-ff

name: r-ff
description: Memory-efficient storage and fast access for large datasets in R. Use this skill when working with datasets that exceed available RAM, requiring disk-based storage with transparent memory mapping. It supports specialized atomic types (boolean, quad, nibble, etc.), large matrices, and ffdf (data.frame-like) objects with high-performance I/O and chunked processing.

# r-ff

## Overview
The `ff` package provides data structures that are stored on disk but behave like RAM-resident objects. It achieves this by mapping only a small section (pagesize) into main memory. It is particularly useful for handling massive genomic data, large-scale matrices, and data frames (`ffdf`) that cannot fit in memory. It supports standard R types and non-standard packed types (e.g., 2-bit 'quad' for DNA bases) to further reduce disk footprint.

## Installation
```R
install.packages("ff")
# Often used with the 'bit' package for fast boolean indexing
install.packages("bit")
```

## Core Concepts and Workflows

### Creating ff Objects
`ff` objects can be vectors, matrices, or arrays.
```R
library(ff)

# Create an ff vector of integers
v <- ff(1:1000000, vmode="integer", filename="my_vec.ff")

# Create an ff matrix
m <- ff(0, dim=c(10000, 10000), vmode="double")

# Non-standard types (e.g., quad for 2-bit storage)
g <- ff(vmode="quad", length=1e6) 
```

### Working with ffdf (Data Frames)
`ffdf` objects are collections of `ff` vectors, mimicking R `data.frame` behavior.
```R
# Create ffdf from existing vectors
df <- ffdf(a=ff(1:10), b=ff(11:20))

# Import from CSV (efficiently handles large files)
dat <- read.table.ffdf(file="large_data.csv", sep=",", header=TRUE)
```

### Access and Indexing
Accessing `ff` objects looks like standard R, but triggers disk I/O.
```R
# Standard indexing
subset_v <- v[1:100]

# Virtual transpose (no data moved on disk)
m_transposed <- vt(m)

# Update in-place
v[1:10] <- 0
```

### Chunked Processing
To process data that exceeds RAM, use chunked loops to read/process/write in stages.
```R
# Use chunk() from the bit package
library(bit)
for (i in chunk(v)){
  # Process a piece of the data in RAM
  v[i] <- v[i] * 2
}
```

### Persistence and Finalizers
`ff` objects use finalizers to manage disk files.
- **Temporary**: Files are deleted when the R session ends or the object is garbage collected (default).
- **Permanent**: Use `finalizer="close"` to keep files on disk.
```R
# Save metadata to reopen in a later session
ffsave(v, file="my_data")
# In a new session:
ffload("my_data")
```

## Tips for Performance
1. **vmode**: Choose the smallest `vmode` possible (e.g., `byte` or `short` instead of `integer`) to save disk space and I/O time.
2. **dimorder**: For matrices, match the `dimorder` to your access pattern (row-major vs column-major).
3. **Hybrid Indexing**: `ff` uses "hi" (hybrid index) objects to optimize non-contiguous disk access.
4. **Avoid as.ram**: Calling `as.ram(obj)` loads the entire object into memory. Only use it on small subsets.

## Reference documentation
- [Large objects for R project](./references/home_page.md)