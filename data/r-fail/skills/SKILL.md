---
name: r-fail
description: The fail package provides a file abstraction interface layer that treats a directory of RData files as a key-value store. Use when user asks to manage RData files as a key-value store, perform memory-efficient batch processing on saved objects, or cache simulation results and model checkpoints.
homepage: https://cloud.r-project.org/web/packages/fail/index.html
---


# r-fail

## Overview

The `fail` package provides a File Abstraction Interface Layer that treats a directory of RData files as a key-value store. It is particularly useful for handling simulation results, model checkpoints, or large datasets where loading everything into memory is impractical. It supports internal path handling, regex-based key listing, efficient apply functions, and in-memory caching.

## Installation

```r
install.packages("fail")
library(fail)
```

## Core Workflow

### 1. Initialization
Create a FAIL object by pointing it to a directory.
```r
# extension defaults to ".RData"
# use.cache defaults to FALSE
results <- fail(path = "path/to/results", extension = ".RData", use.cache = FALSE)
```

### 2. Managing Keys (Filenames)
Keys are filenames without the extension.
```r
# List all keys
all_keys <- results$ls()

# List keys matching a pattern
subset_keys <- results$ls(pattern = "^model_v1")

# Check file sizes
results$size(unit = "mB")
```

### 3. Storing and Retrieving Objects
```r
# Save objects (put)
results$put(my_obj = c(1, 2, 3))
results$put(li = list(key1 = "val1", key2 = "val2")) # Save from a list

# Load objects (get)
obj <- results$get("my_obj")

# Load multiple into a list
my_list <- results$as.list(c("key1", "key2"))

# Assign directly to environment
results$assign(c("key1", "key2"), envir = .GlobalEnv)

# Remove files
results$remove("key1")
```

### 4. Batch Processing (Memory Efficient)
Use these methods to process files one-by-one to save RAM.
```r
# Apply a function to objects (like lapply)
# Returns a list of results
means <- results$apply(mean, keys = results$ls("result_"), simplify = TRUE)

# Map function (requires 'key' and 'value' arguments)
# Useful for transforming and saving data
processed <- fail("processed_data")
results$mapply(function(key, value) {
  processed$put(scale(value), keys = key)
})
```

### 5. Caching
Enable caching to avoid repeated disk reads for the same keys.
```r
# Enable for specific call
data <- results$get("large_obj", use.cache = TRUE)

# Manage cache
results$cached() # List cached keys
results$clear()  # Clear memory cache
```

## Tips and Best Practices
- **Non-Recursive**: `fail` only looks at the top level of the specified directory.
- **Naming**: Ensure keys are valid filenames. `fail` handles the path joining automatically.
- **Memory Management**: Use `$apply()` instead of `lapply(results$as.list(), ...)` when dealing with many large files to avoid OOM (Out of Memory) errors.
- **One-Liners**: You can quickly load a directory into a list using `as.list(fail("path/to/dir"))`.

## Reference documentation
- [README.md](./references/README.md)