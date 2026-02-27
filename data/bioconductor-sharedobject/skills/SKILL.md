---
name: bioconductor-sharedobject
description: This tool enables the sharing of R objects across multiple processes by storing them in a single shared memory location. Use when user asks to optimize memory usage in parallel computing, share large datasets across R workers without duplication, or manage shared memory properties like copy-on-write.
homepage: https://bioconductor.org/packages/release/bioc/html/SharedObject.html
---


# bioconductor-sharedobject

name: bioconductor-sharedobject
description: Efficiently share R objects across multiple processes using shared memory. Use when Claude needs to optimize memory usage in parallel computing tasks, handle large datasets across R workers without duplication, or manage shared memory properties like copy-on-write.

# bioconductor-sharedobject

## Overview
The `SharedObject` package provides a mechanism for sharing R objects across different R sessions/workers by placing them in a single shared memory location. This is particularly useful in parallel computing with large datasets (e.g., high-throughput sequencing data), as it prevents the memory overhead of copying data to every worker.

## Core Workflow

### 1. Creating Shared Objects
To convert an existing R object into a shared object, use the `share()` function.
```r
library(SharedObject)
# Create a standard matrix
A1 <- matrix(1:9, 3, 3)
# Convert to shared object
A2 <- share(A1)

# Check if shared
is.shared(A2) # Returns TRUE
```

### 2. Creating from Scratch
You can initialize a shared object directly using `SharedObject()`, similar to the `vector()` function.
```r
# Create an empty integer shared vector
x <- SharedObject(mode = "integer", length = 10)

# Create with attributes (e.g., dimensions)
mat <- SharedObject(mode = "numeric", length = 6, attrib = list(dim = c(2L, 3L)))
```

### 3. Parallel Computing Integration
Shared objects work out-of-box with standard parallel packages like `parallel` or `BiocParallel`.
```r
library(parallel)
cl <- makeCluster(2)
clusterExport(cl, "A2")
# Workers access the same memory location as the master process
results <- clusterEvalQ(cl, sum(A2))
stopCluster(cl)
```

## Managing Properties
Shared objects have specific properties that control their behavior during operations.

### Copy-On-Write (COW)
By default, `copyOnWrite = TRUE`. If a worker modifies a shared object, R creates a local copy to prevent affecting other workers.
- **Disable COW**: Set `copyOnWrite = FALSE` to allow multiple workers to write to the same memory location (useful for collecting results).
- **Warning**: Unary functions (like `-x`) can trigger modifications.

```r
# Disable COW to allow in-place modification
setCopyOnWrite(A2, FALSE)
A2[1,1] <- 99 # This change is now visible to all processes sharing A2
```

### Other Properties
- **sharedSubset**: Determines if a subset of the object (e.g., `A2[1:2, ]`) remains a shared object.
- **sharedCopy**: Determines if a duplication of the object remains shared.

```r
# View all properties
sharedObjectProperties(A2)

# Set properties
setSharedSubset(A2, TRUE)
setSharedCopy(A2, TRUE)
```

## Supported Data Types
- **Basic Types**: `raw`, `logical`, `integer`, `numeric`, `complex`, `character`.
- **Containers**: `list`, `pairlist`, `environment`, `data.frame`.
- **Note on Characters**: Sharing character vectors is only memory-efficient if there are many repetitions. Treat them as read-only.
- **Note on Containers**: Sharing a list shares its elements, but the list container itself is not shared (adding/removing elements is local to the process).

## Package Options
Global defaults can be managed via `sharedObjectPkgOptions()`.
- `mustWork`: If `TRUE`, `share()` throws an error if an object cannot be shared.
- `minLength`: Minimum length required for an object to be shared (default is 3).

```r
# Change global default to force error on sharing failure
sharedObjectPkgOptions(mustWork = TRUE)
```

## Memory Management
While the package usually handles memory cleanup automatically, you can manually inspect and free memory if leaks occur.
```r
# List active shared objects
listSharedObjects()

# Manually free by ID (use with caution)
# freeSharedMemory("ID_NUMBER")
```

## Reference documentation
- [Package Quick Start Guide (Rmd)](./references/quick_start_guide.Rmd)
- [Package Quick Start Guide (Markdown)](./references/quick_start_guide.md)
- [新手指引 (Chinese Rmd)](./references/quick_start_guide_Chinese.Rmd)
- [新手指引 (Chinese Markdown)](./references/quick_start_guide_Chinese.md)