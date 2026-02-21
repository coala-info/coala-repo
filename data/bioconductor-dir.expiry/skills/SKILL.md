---
name: bioconductor-dir.expiry
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/dir.expiry.html
---

# bioconductor-dir.expiry

## Overview

The `dir.expiry` package provides a robust mechanism for managing versioned cache directories. It is specifically designed for packages that store resources in external caches (like `~/.cache/package/version/`). It solves the problem of "stale" caches by tracking actual package usage rather than relying on unreliable filesystem access times (atime). It uses file locking to ensure that cleanup operations do not interfere with active R processes.

## Core Workflow

The standard workflow involves three steps: locking the directory, performing operations, and updating the access time upon success.

### 1. Locking a Directory
Always lock a versioned directory before reading from or writing to it. This prevents other processes from deleting the directory while you are using it.

```r
library(dir.expiry)

# Define the versioned path
cache_base <- tools::R_user_dir("my_package", which="cache")
version <- "1.0.0"
target_dir <- file.path(cache_base, version)

# Acquire a lock
# Use exclusive=FALSE for read-only access to allow concurrent readers
lock <- lockDirectory(target_dir, exclusive = TRUE)

# Recommended: ensure unlock happens even if the script errors
# on.exit(unlockDirectory(lock))
```

### 2. Updating Access Time
After successfully accessing or creating the cache, "touch" the directory. This creates an `*_dir.expiry` metadata file that records the current date.

```r
# Create the directory if it doesn't exist
dir.create(target_dir, recursive = TRUE, showWarnings = FALSE)

# Update the access timestamp
touchDirectory(target_dir)
```

### 3. Unlocking and Automatic Cleanup
When you call `unlockDirectory()`, the package automatically checks for other versioned directories in the same parent folder that have expired.

```r
# This releases the lock and triggers clearDirectories() for stale versions
unlockDirectory(lock)
```

## Key Functions

### `lockDirectory(path, exclusive = TRUE)`
- Creates a lock file for the specified versioned directory.
- If `exclusive = TRUE`, other processes cannot lock this directory.
- If `exclusive = FALSE`, other readers can access it, but writers are blocked.

### `touchDirectory(path, date = Sys.Date())`
- Writes an `ExpiryVersion` and `AccessDate` to a metadata file in the parent directory.
- The metadata file is named `basename(path)_dir.expiry`.

### `unlockDirectory(lock, clear = TRUE)`
- Releases the file lock.
- If `clear = TRUE`, it triggers the deletion of expired directories in the same parent folder.
- **Note:** It will only delete versions *older* than the currently locked version to prevent accidental deletion of newer installations.

### `clearDirectories(parent, limit = 30)`
- Manually trigger cleanup of a cache folder.
- `limit`: Number of days since last access before a directory is considered expired.
- Can be controlled via the environment variable `BIOC_DIR_EXPIRY_LIMIT`.

## Implementation Tips

- **Thread Safety:** Always use `lockDirectory()` before `touchDirectory()`.
- **Version Format:** The package expects subdirectories to be named as valid R versions (e.g., "1.0.0").
- **Avoid Collisions:** Do not name your own package files with the suffix `_dir.expiry`, as these are reserved for this package's metadata.
- **Read-Only Optimization:** If your package only needs to read from a cache, use `exclusive = FALSE` in `lockDirectory` to maximize performance across multiple R sessions.

## Reference documentation

- [Managing expiration of versioned subdirectories](./references/userguide.md)