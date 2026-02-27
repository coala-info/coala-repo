---
name: bioconductor-ncdfflow
description: This tool provides memory-efficient storage and manipulation of large flow cytometry datasets by storing event-level data on disk in netCDF format. Use when user asks to manage large FCS files that exceed RAM, convert flowSet objects to disk-backed storage, or perform compensation, transformation, and gating on high-throughput flow cytometry data.
homepage: https://bioconductor.org/packages/release/bioc/html/ncdfFlow.html
---


# bioconductor-ncdfflow

name: bioconductor-ncdfflow
description: Memory-efficient storage and manipulation of flow cytometry data using netCDF. Use when handling large FCS datasets that exceed RAM, or when performing standard flowCore operations (transformation, compensation, gating) on disk-backed ncdfFlowSet objects.

# bioconductor-ncdfflow

## Overview

The `ncdfFlow` package provides a memory-efficient alternative to the standard `flowCore` data structures. By using the `ncdfFlowSet` class, event-level data is stored on disk in netCDF format rather than in RAM. This allows for the analysis of high-throughput flow cytometry experiments (hundreds or thousands of files) on standard computers. Most methods for `flowSet` (transformation, compensation, gating) are extended to work transparently with `ncdfFlowSet`.

## Core Workflow

### 1. Creating an ncdfFlowSet
You can create an `ncdfFlowSet` by reading FCS files directly or by converting an existing `flowSet`.

```r
library(ncdfFlow)

# Read FCS files directly to disk
files <- list.files(path, pattern = ".fcs", full.names = TRUE)
ncfs <- read.ncdfFlowSet(files = files)

# Convert an existing flowSet to ncdfFlowSet
data(GvHD)
ncfs_gvhd <- ncdfFlowSet(GvHD)

# Create an empty structure to fill later
ncfs_empty <- read.ncdfFlowSet(files = files, isWriteSlice = FALSE)
```

### 2. Data Access and Metadata
`ncdfFlowSet` supports standard `flowCore` metadata methods.

```r
# Metadata access
sampleNames(ncfs)
colnames(ncfs)
pData(ncfs)
keyword(ncfs, "FILENAME")

# Extracting a single flowFrame (loads into memory)
fr <- ncfs[[1]]
fr <- ncfs[["sample_name"]]

# Subsetting (returns a new ncdfFlowSet pointing to the same disk file)
ncfs_subset <- ncfs[1:3]
```

### 3. Compensation and Transformation
These operations return a new `ncdfFlowSet` pointing to a new netCDF file containing the processed data.

```r
# Compensation
comp_mat <- read.table(comp_file, header = TRUE, check.names = FALSE)
ncfs_comp <- compensate(ncfs, comp_mat)

# Transformation
asinhTrans <- arcsinhTransform(a = 1, b = 1, c = 1)
ncfs_trans <- transform(ncfs, `FL1-H` = asinhTrans(`FL1-H`))
```

### 4. Gating and Subsetting
Standard filters and subsetting operations work as they do in `flowCore`.

```r
# Filtering
rectGate <- rectangleGate(filterId = "NonDebris", "FSC-H" = c(200, Inf))
results <- filter(ncfs, rectGate)

# Subsetting based on a gate
ncfs_gate <- Subset(ncfs, rectGate)

# Splitting (returns an ncdfFlowList)
ncfs_list <- split(ncfs, results)
```

### 5. Iteration with ncfsApply
While `fsApply` works, `ncfsApply` is recommended for functions that return a `flowFrame` (like custom transformations) to ensure the results are stored back to disk rather than bloating memory.

```r
# Apply a function and return a new ncdfFlowSet
ncfs_new <- ncfsApply(ncfs, function(fr) {
    # Perform operation on flowFrame
    return(fr)
})
```

## Important Usage Tips

*   **File Management**: Creating an `ncdfFlowSet` generates a physical `.nc` file on disk. Deleting the R object with `rm()` does **not** delete the disk file. You must explicitly call `unlink(ncfs)` to remove the data from the drive.
*   **Cloning**: Use `clone.ncdfFlowSet(ncfs)` to create a physical copy of the data on disk.
*   **Coercion**: If you need to move data back to RAM for specific legacy functions, use `as.flowSet(ncfs)`. Use the `top` argument (e.g., `as.flowSet(ncfs, top = 5)`) to sample a subset and avoid memory crashes.
*   **Indices**: `ncdfFlow` uses sample names as primary identifiers for indexing the data matrix. Always prefer sample names over numeric indices when assigning data slices.

## Reference documentation

- [ncdfFlow](./references/ncdfFlow.md)