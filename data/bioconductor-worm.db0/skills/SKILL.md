---
name: bioconductor-worm.db0
description: This package provides raw SQLite databases for Caenorhabditis elegans used by AnnotationDbi to build higher-level annotation packages. Use when user asks to generate custom worm annotation packages, build chip-specific packages, or use sqlForge to construct formatted annotation objects.
homepage: https://bioconductor.org/packages/release/data/annotation/html/worm.db0.html
---

# bioconductor-worm.db0

name: bioconductor-worm.db0
description: Use this skill when working with the Bioconductor annotation base package 'worm.db0'. This package provides the raw SQLite databases for Caenorhabditis elegans (worm) used by AnnotationDbi's sqlForge to build higher-level annotation packages. Use this skill when you need to generate custom worm annotation packages or when AnnotationDbi requires these base databases as a dependency for building chip-specific or organism-specific packages.

## Overview

The `worm.db0` package is a specialized Bioconductor "base" annotation package. Unlike standard annotation packages (like `org.Ce.eg.db`), `worm.db0` is not intended for direct data querying by end-users. Its primary purpose is to serve as a data source for the `AnnotationDbi` package, specifically for the `sqlForge` functionality which constructs formatted annotation objects.

## Usage and Workflow

### Installation

To use `worm.db0`, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("worm.db0")
```

### Primary Role: Package Construction

The core use case for `worm.db0` is providing the underlying database for functions that create custom annotation packages. You do not typically load `worm.db0` using `library()`; instead, `AnnotationDbi` functions look for it in your R library.

Common wrapper functions in `AnnotationDbi` that utilize these base databases include:
- `makeWORMCHIP_DB()`: To create a chip-specific annotation package for C. elegans.
- `makeOrgPackage()`: When building a custom organism package from scratch using the base data.

### Accessing the Database Path

If you must find the location of the raw SQLite database provided by this package (e.g., for custom SQL queries, though this is discouraged due to unstable schemas), you can find the library path:

```r
system.file("extdata", package = "worm.db0")
```

## Important Constraints

- **Schema Instability**: The internal database schema of `worm.db0` is not guaranteed to be stable. It can change between Bioconductor releases.
- **Direct Querying**: Avoid direct SQL calls to the databases within this package for production scripts. It is always safer to use the high-level `select()`, `keys()`, and `columns()` interface provided by the resulting `org.Ce.eg.db` or custom-built packages.
- **Target Audience**: This package is primarily a dependency for developers or bioinformaticians building custom annotation infrastructure.

## Reference documentation

- [worm.db0 Reference Manual](./references/reference_manual.md)