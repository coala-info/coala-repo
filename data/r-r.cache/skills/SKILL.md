---
name: r-r.cache
description: This tool provides fast and light-weight memoization for R objects by storing results in a persistent key-value storage on the file system. Use when user asks to cache R function results, speed up repetitive computations, or implement persistent object storage across R sessions.
homepage: https://cloud.r-project.org/web/packages/R.cache/index.html
---

# r-r.cache

name: r-r.cache
description: Fast and light-weight caching (memoization) of R objects and results. Use this skill to speed up repetitive or computationally expensive R function calls by storing results in a persistent key-value storage on the file system.

# r-r.cache

## Overview
The `R.cache` package provides a mechanism for memoization in R. It allows users to cache any R object based on a "key" (which can be any set of R objects). If a function is called with the same parameters, the result is retrieved from the disk cache instead of being recomputed. The cache is persistent across R sessions.

## Installation
```r
install.packages("R.cache")
```

## Core Workflow
The standard pattern involves checking for a cached result before performing a calculation.

```r
library(R.cache)

# 1. Define the key (usually the input arguments)
key <- list(data = my_data, threshold = 0.5)

# 2. Check if the result is already cached
res <- loadCache(key)

if (is.null(res)) {
  # 3. If not cached, perform the expensive computation
  res <- expensive_function(my_data, threshold = 0.5)
  
  # 4. Save the result to the cache for next time
  saveCache(res, key = key, comment = "expensive_function results")
}
```

## Key Functions
- `loadCache(key)`: Retrieves an object from the cache. Returns `NULL` if no cache exists.
- `saveCache(object, key)`: Saves an object to the cache using the specified key.
- `generateCacheRootPath()`: Sets up or retrieves the directory where cache files are stored (usually `~/.Rcache`).
- `getCacheRootPath()` / `setCacheRootPath(path)`: Manage the location of the cache directory.
- `clearCache(path)`: Removes cached files to free up space.

## Memoization of Functions
You can wrap functions to automate the caching process:

```r
memoized_func <- function(...) {
  key <- list(...)
  res <- loadCache(key)
  if (!is.null(res)) return(res)
  
  res <- some_heavy_lifting(...)
  saveCache(res, key = key)
  res
}
```

## Tips for Effective Caching
- **Key Selection**: The key should include all variables that affect the output of the computation. If the function depends on a global option or a random seed, include those in the `key` list.
- **Cache Location**: By default, `R.cache` prompts the user to create a directory. In non-interactive scripts, use `setCacheRootPath("path/to/cache")` to avoid prompts.
- **Object Size**: While `R.cache` is "light-weight," caching extremely large objects frequently can lead to disk I/O overhead that exceeds the computation time.
- **Compression**: `saveCache` supports compression (via `compress = TRUE`) which is useful for large objects to save disk space at the cost of some CPU time during save/load.

## Reference documentation
- [R.cache: Fast and Light-Weight Caching (Memoization) of Objects and Results to Speed Up Computations](./references/README.md)