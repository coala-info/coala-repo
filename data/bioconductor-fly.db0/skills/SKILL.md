---
name: bioconductor-fly.db0
description: This package provides the base SQLite databases for Drosophila melanogaster used by AnnotationDbi to construct functional annotation packages. Use when user asks to create custom fly annotation packages, use sqlForge to build chip-specific databases, or provide the raw data source for organism-specific annotation objects.
homepage: https://bioconductor.org/packages/release/data/annotation/html/fly.db0.html
---


# bioconductor-fly.db0

name: bioconductor-fly.db0
description: Use when working with Drosophila melanogaster (fly) genomic annotations in R. This skill is specifically for scenarios involving the creation of custom annotation packages using sqlForge or when AnnotationDbi requires the base fly database to build organism-specific or chip-specific annotation objects.

# bioconductor-fly.db0

## Overview
`fly.db0` is a Bioconductor annotation BASE package for *Drosophila melanogaster*. Unlike standard annotation packages (e.g., `org.Dm.eg.db`), `fly.db0` is not intended for direct data querying by most users. Its primary purpose is to provide the raw SQLite databases required by the `sqlForge` engine within the `AnnotationDbi` package to construct functional annotation packages.

## Installation
To install the package and its dependencies, use `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("fly.db0")
```

## Usage and Workflow
The package serves as a data source for building other annotation packages. You should generally use the wrapper functions provided by `AnnotationDbi` rather than accessing the `fly.db0` database directly.

### Building Annotation Packages
The most common use case is using `sqlForge` to create a "chip" or "organism" package.

```r
library(AnnotationDbi)
library(fly.db0)

# Example: Using sqlForge logic (conceptually)
# These functions look for the .db0 packages to find the latest source data
# makeFLYCHIP_DB(schema, prefix, ...) 
```

### Direct Access Warning
Directly calling the database inside this package is discouraged because:
1. The schema is unstable and can change between Bioconductor releases.
2. No official schema documentation is provided for the `.db0` level.
3. Standard `select()`, `keys()`, and `columns()` methods should be used on the resulting packages generated from this base (like `org.Dm.eg.db`) rather than `fly.db0` itself.

## Typical Integration
If you are developing a new Bioconductor package that requires the latest fly mappings, you would list `fly.db0` in your requirements so that `AnnotationDbi` can utilize it during the build process or during specific `makeXXXX_DB` calls.

## Reference documentation
- [fly.db0 Reference Manual](./references/reference_manual.md)