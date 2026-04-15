---
name: bioconductor-xenopus.db0
description: This package provides base annotation data for Xenopus genomic data to be used as a source for building higher-level annotation packages. Use when user asks to create custom chip-level annotation packages, build organism-specific annotation packages using sqlForge, or access raw SQLite databases for Xenopus genomic mappings.
homepage: https://bioconductor.org/packages/release/data/annotation/html/xenopus.db0.html
---

# bioconductor-xenopus.db0

name: bioconductor-xenopus.db0
description: Use this skill when working with the Bioconductor package xenopus.db0. This is a base annotation package for Xenopus (frog) genomic data, primarily used as a data source for AnnotationDbi's sqlForge to create higher-level annotation packages.

# bioconductor-xenopus.db0

## Overview

The `xenopus.db0` package is a Bioconductor "base" annotation package. Unlike standard organism-level packages (like `org.Xl.eg.db`), `.db0` packages are designed as raw data repositories. They contain the SQLite databases required by the `AnnotationDbi` package's `sqlForge` functionality to build custom chip-based or organism-based annotation packages.

Directly querying the databases within this package is generally discouraged because the internal schema is unstable and subject to change between Bioconductor releases.

## Usage Guidelines

### Installation

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("xenopus.db0")
```

### Primary Workflow: Using with sqlForge

The intended use of `xenopus.db0` is to provide the underlying data for creating specific annotation objects. You do not typically call functions from `xenopus.db0` directly; instead, you use `AnnotationDbi` functions that look for this package in the R library.

Common wrappers that utilize these base databases include:
- `makeXENOPUSCHIP_DB()`: To create a chip-level annotation package.
- `makeOrgPackage()`: To create a custom organism package.

### Accessing the Database Location

If you must find the raw database file (e.g., for custom SQL processing despite the stability warnings), you can locate it using `system.file`:

```r
# Locate the SQLite database file
db_path <- system.file("extdata", "xenopus.sqlite", package = "xenopus.db0")
```

### Typical Integration

When building a new annotation package for Xenopus, ensure `xenopus.db0` is installed. The `AnnotationDbi` engine will automatically detect and use the data stored here to map identifiers (like Entrez IDs to GO terms or RefSeq accessions).

## Tips and Warnings

- **Schema Instability**: Do not hard-code SQL queries against the tables in this package for production scripts, as the table names and columns may change without notice in future versions.
- **End-User Alternative**: For standard gene-centric lookups (e.g., mapping Gene Symbols to Entrez IDs), use the higher-level `org.Xl.eg.db` package if available, rather than this base package.
- **Purpose**: This package exists to provide a consistent location for the latest Xenopus annotation data so that `sqlForge` can build functional annotation packages.

## Reference documentation

- [xenopus.db0 Reference Manual](./references/reference_manual.md)