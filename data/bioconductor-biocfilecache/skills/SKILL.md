---
name: bioconductor-biocfilecache
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocFileCache.html
---

# bioconductor-biocfilecache

## Overview

BiocFileCache is a Bioconductor package designed to manage local and remote resource files. It provides a centralized, persistent location to organize files, tracking them via a SQLite database. It is particularly useful for:
1. **Caching remote resources**: Storing local copies of web files (e.g., Ensembl GTF, large datasets) to avoid repeated downloads.
2. **Tracking experimental results**: Saving R objects or files with descriptive metadata instead of relying on cryptic file naming.
3. **Version Control**: Checking if remote resources have changed (via etags or last-modified headers) and updating local copies only when necessary.

## Core Workflow

### 1. Initialize the Cache
Create or load a cache object. If no path is specified, it uses a default user-specific directory.

```r
library(BiocFileCache)

# Create/Load default cache
bfc <- BiocFileCache(ask = FALSE)

# Or specify a custom location
bfc <- BiocFileCache("~/my_project_cache", ask = FALSE)

# Check cache location and item count
bfccache(bfc)
length(bfc)
```

### 2. Adding Resources
There are two primary ways to add files:

*   **`bfcadd()`**: Use for existing local files or remote URLs.
*   **`bfcnew()`**: Use to reserve a path for a new file you are about to create (e.g., saving an RDS).

```r
# Add a remote resource (downloads automatically by default)
url <- "https://example.com/data.csv"
path <- bfcadd(bfc, rname = "MyData", fpath = url)

# Add a local file (copy, move, or asis)
local_file <- "results.txt"
path <- bfcadd(bfc, rname = "Experiment1", fpath = local_file, action = "copy")

# Reserve a path for a new R object
new_path <- bfcnew(bfc, "ProcessedMatrix", ext = ".rds")
saveRDS(my_matrix, file = new_path)
```

### 3. Retrieving and Querying
Resources are identified by a unique Resource ID (`rid`, e.g., "BFC1").

```r
# Search for resources by keyword in rname, rpath, or fpath
res <- bfcquery(bfc, "MyData")
rid <- res$rid

# Get the local path for a specific rid
path <- bfcrpath(bfc, rids = rid)

# Shortcut: Get path by URL (adds to cache if not present)
path <- bfcrpath(bfc, "https://example.com/data.csv")
```

### 4. Managing Updates
For web resources, BiocFileCache can check if the remote file has changed.

```r
# Check if updates are needed (returns TRUE, FALSE, or NA)
needs_update <- bfcneedsupdate(bfc, rid)

# Download the latest version if stale
if (!isFALSE(needs_update)) {
    bfcdownload(bfc, rid, ask = FALSE)
}
```

### 5. Metadata and Maintenance
You can attach custom data frames as metadata tables to the cache.

```r
# Add metadata
meta_df <- data.frame(rid = "BFC1", sample_type = "Control", batch = 1)
bfcmeta(bfc, name = "SampleInfo") <- meta_df

# List all tracked files
bfcinfo(bfc)

# Remove a resource (deletes the file if stored inside the cache)
bfcremove(bfc, rid)
```

## Best Practices for Package Developers
When using BiocFileCache within a package to manage data:
1. Define a internal helper function (e.g., `.get_cache()`) using `tools::R_user_dir("PackageName", which="cache")`.
2. Use `bfcrpath()` to provide users with a seamless "download-once, use-many" experience.
3. Use the `FUN` argument in `bfcdownload()` if you need to process a file (e.g., unzip or filter) before it is officially saved into the cache.

## Troubleshooting
*   **Lock Files**: If you encounter "Cannot lock file" errors, ensure you have write permissions or set the `BFC_CACHE` environment variable to a directory on a filesystem that supports file locking.
*   **Proxies**: If behind a firewall, pass proxy configuration to `bfcadd` or `bfcdownload` using the `proxy` or `config` (list of curl options) arguments.

## Reference documentation
- [BiocFileCache: Managing File Resources Across Sessions](./references/BiocFileCache.md)
- [BiocFileCache Troubleshooting](./references/BiocFileCache_Troubleshooting.md)
- [BiocFileCache Use Cases](./references/BiocFileCache_UseCases.md)