---
name: bioconductor-updateobject
description: This tool automates the process of updating out-of-sync S4 objects to their current class definitions within R packages and Git repositories. Use when user asks to update serialized data files, migrate old S4 objects to new class definitions, or batch update objects across Bioconductor package source trees.
homepage: https://bioconductor.org/packages/release/bioc/html/updateObject.html
---


# bioconductor-updateobject

## Overview

The `updateObject` package provides a suite of tools designed to automate the process of updating "out-of-sync" S4 objects. These are objects that were serialized (saved to disk) using older versions of a class definition. When class internals change (e.g., slots are added, renamed, or removed), the `updateObject()` generic function is used to migrate these instances to the current definition. This package is specifically tailored for package maintainers to handle bulk updates of data files within R package source trees and Git repositories.

## Core Workflow

### 1. Updating a Single Object
The fundamental operation is calling `updateObject()` on an instance. If the object is already up-to-date, the function acts as a no-op.

```r
library(BiocGenerics)
# Load an old object
x <- readRDS("path/to/old_object.rds")
# Update it
x <- updateObject(x)
# Save it back if changes occurred
saveRDS(x, "path/to/old_object.rds")
```

### 2. Updating an Entire Package Source Tree
To update all serialized objects (`.rds`, `.rda`, `.RData`) within a local package directory without Git integration, use `updatePackageObjects()`.

```r
library(updateObject)
# Updates all data files in the specified directory
# bump.Version = TRUE automatically increments the version in the DESCRIPTION file
updatePackageObjects("path/to/local/package", bump.Version = TRUE)
```

### 3. Updating Bioconductor Git Repositories
For maintainers working with Bioconductor's Git infrastructure, `updateBiocPackageRepoObjects()` automates the clone-update-commit cycle.

```r
# Clone, update objects, bump version, and commit changes
repopath <- file.path(tempdir(), "MyPackage")
updateBiocPackageRepoObjects(
    repopath, 
    branch = "devel", 
    use.https = TRUE,
    push = FALSE # Set to TRUE only if you have push access
)
```

## Key Functions

- `updateSerializedObjects()`: The underlying workhorse that identifies and updates files in a directory.
- `updatePackageObjects()`: Updates a local package; handles version bumping and date updates in the DESCRIPTION file.
- `updateBiocPackageRepoObjects()`: Wraps the update process with Git commands (clone, commit, push).
- `updateAllPackageObjects()`: Batch processes multiple local packages.
- `updateAllBiocPackageRepoObjects()`: Batch processes multiple Bioconductor Git repositories.

## Usage Tips

- **No-op Detection**: `updateObject` functions are intelligent; they only overwrite files if the object actually changed during the update process.
- **Version Bumping**: When using the package-level functions, `bump.Version = TRUE` is recommended to ensure the changes are recognized by the Bioconductor build system.
- **Nested Objects**: `updateObject()` is recursive. It will find and update out-of-sync S4 objects even if they are nested inside lists, DataFrames, or other S4 slots.
- **Dry Runs**: Before pushing changes to a repository, run the update with `push = FALSE` and inspect the Git diff to verify the updates.

## Reference documentation

- [A quick introduction to the updateObject package](./references/updateObject.md)