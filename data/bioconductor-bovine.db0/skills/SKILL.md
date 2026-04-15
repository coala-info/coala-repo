---
name: bioconductor-bovine.db0
description: This package provides the base SQLite databases for Bos taurus annotation data. Use when user asks to build custom bovine annotation packages, create chip-specific annotation objects, or provide raw genomic mappings for sqlForge.
homepage: https://bioconductor.org/packages/release/data/annotation/html/bovine.db0.html
---

# bioconductor-bovine.db0

name: bioconductor-bovine.db0
description: Use this skill when working with the Bioconductor annotation base package 'bovine.db0'. This package provides the underlying SQLite databases for Bos taurus (cow) annotation. It is primarily used as a data source for AnnotationDbi's sqlForge to build higher-level annotation packages (like bovine.db or chip-specific packages).

# bioconductor-bovine.db0

## Overview
The `bovine.db0` package is a "base" annotation package for *Bos taurus*. Unlike standard annotation packages (e.g., `org.Bt.eg.db`), it does not provide a stable, user-friendly schema for direct querying. Instead, it serves as a centralized repository for the latest bovine genomic data mappings, intended to be consumed by `AnnotationDbi` functions to generate custom annotation objects or chips.

## Usage Guidelines

### Installation
To use this package, it must be installed via `BiocManager`:
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("bovine.db0")
```

### Primary Workflow: Building Annotation Packages
The core purpose of `bovine.db0` is to provide the raw data for `sqlForge`. You should use it when you need to create a custom chip-level annotation package for bovine arrays.

Example of using the data via `AnnotationDbi` (conceptual):
```r
library(AnnotationDbi)
library(bovine.db0)

# While users rarely call bovine.db0 directly, it enables functions like:
# makeBOVINECHIP_DB(schema, prefix, ...) 
```

### Direct Database Access (Discouraged)
Directly querying the SQLite database inside `bovine.db0` is possible but discouraged because the internal schema is unstable and subject to change without notice. 

If you must explore the contents:
1. Load the library: `library(bovine.db0)`
2. Locate the database file using `system.file("extdata", package="bovine.db0")`.
3. Use `RSQLite` to connect, though using `org.Bt.eg.db` is almost always the better alternative for data retrieval.

## Best Practices
- **Do not use for routine lookups:** For mapping Entrez IDs to Gene Symbols or GO terms, use the `org.Bt.eg.db` package instead.
- **Use for Package Creation:** Only invoke this package when your goal is to manufacture a new annotation package or when `AnnotationDbi` specifically requests the base database.
- **Keep Updated:** Always ensure `bovine.db0` is updated to the latest version via `BiocManager::install()` to ensure `sqlForge` is building packages with the most recent genomic mappings.

## Reference documentation
- [bovine.db0 Reference Manual](./references/reference_manual.md)