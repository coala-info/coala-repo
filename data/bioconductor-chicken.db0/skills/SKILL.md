---
name: bioconductor-chicken.db0
description: This package provides the base SQLite databases required to build custom chicken-specific annotation packages using AnnotationDbi's sqlForge. Use when user asks to create custom chip-level or organism-level annotation packages for Gallus gallus or manage raw genomic annotation data sources.
homepage: https://bioconductor.org/packages/release/data/annotation/html/chicken.db0.html
---

# bioconductor-chicken.db0

name: bioconductor-chicken.db0
description: Guidance for using the Bioconductor annotation base package chicken.db0. Use this skill when an AI agent needs to facilitate the creation of chicken-specific annotation packages using AnnotationDbi's sqlForge or when managing the underlying SQLite databases for Gallus gallus genomic data.

# bioconductor-chicken.db0

## Overview

The `chicken.db0` package is a Bioconductor annotation BASE package. Unlike standard annotation packages (like `org.Gg.eg.db`), `chicken.db0` is not intended for direct data querying by end-users. Its primary purpose is to serve as a centralized repository for the latest raw Annotation Databases required by the `AnnotationDbi` `sqlForge` code. 

It is used as a dependency when building custom chip-level or organism-level annotation packages for chicken.

## Usage Guidelines

### Installation

Install the package using `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("chicken.db0")
```

### Intended Workflow: sqlForge

The core use case for `chicken.db0` is providing the data source for `AnnotationDbi` functions that "forge" new annotation packages. You do not typically load this package with `library(chicken.db0)` for data analysis.

Instead, it is used behind the scenes when calling functions such as:
- `makeCHIP_DB()` (for specific microarray chips)
- `makeORG_DB()` (for organism-level packages)

### Accessing the Database Path

If you must locate the database file for custom package building or inspection, you can find the library path:

```r
system.file("extdata", package="chicken.db0")
```

### Warning on Direct Database Access

- **Schema Instability**: The internal SQLite schema of `.db0` packages is subject to change without notice. 
- **Recommendation**: Always prefer using the high-level `AnnotationDbi` interface or the generated `org.Gg.eg.db` package for standard genomic queries (e.g., mapping Entrez IDs to Gene Symbols).

## Reference documentation

- [chicken.db0 Reference Manual](./references/reference_manual.md)