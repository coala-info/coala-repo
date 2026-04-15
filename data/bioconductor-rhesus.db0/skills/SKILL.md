---
name: bioconductor-rhesus.db0
description: This package provides base annotation data and SQLite databases for the Rhesus macaque (Macaca mulatta) to support Bioconductor's annotation infrastructure. Use when user asks to build custom annotation packages using sqlForge, perform low-level SQL queries on Rhesus genomic mappings, or access raw data sources for Rhesus macaque annotations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rhesus.db0.html
---

# bioconductor-rhesus.db0

name: bioconductor-rhesus.db0
description: Base annotation package for Rhesus macaque (Macaca mulatta). Use this skill when you need to build custom annotation packages for Rhesus using AnnotationDbi's sqlForge or when working with low-level Rhesus genomic data mapping in Bioconductor.

# bioconductor-rhesus.db0

## Overview
The `rhesus.db0` package is a Bioconductor "base" annotation package. Unlike standard organism-level packages (like `org.Mm.eg.db`), `.db0` packages are primarily designed as data sources for the `AnnotationDbi` `sqlForge` infrastructure. They contain the raw SQLite databases used to construct more user-friendly chip-specific or organism-specific annotation packages.

## Usage and Workflow

### Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rhesus.db0")
```

### Primary Purpose: sqlForge
The main use case for `rhesus.db0` is providing the underlying data for creating custom annotation packages. You typically do not call functions within `rhesus.db0` directly; instead, you use `AnnotationDbi` functions that look for this package.

```r
library(AnnotationDbi)
library(rhesus.db0)

# Example: Using sqlForge to create a custom Rhesus annotation package
# Note: This is typically used by developers creating chip-specific packages
# or updated organism packages.
```

### Accessing the Database Directly
While the package documentation warns that the schema is subject to change, you can access the underlying database path if you need to perform low-level SQL queries for Rhesus genomic mappings.

```r
# Locate the database file
db_path <- system.file("extdata", "rhesus.sqlite", package = "rhesus.db0")

# Connect using RSQLite
library(RSQLite)
con <- dbConnect(SQLite(), db_path)

# List tables to explore available mappings
dbListTables(con)

# Disconnect when finished
dbDisconnect(con)
```

## Tips and Best Practices
- **Avoid Direct Calls**: For standard analysis (Gene ID to Symbol, GO terms, etc.), check if a compiled organism package like `org.Mmu.eg.db` exists first. Use `rhesus.db0` only if you are building a new annotation package or require data not present in the standard assemblies.
- **Schema Volatility**: Be aware that the internal table names and relationships in `rhesus.db0` are not guaranteed to be stable across different Bioconductor releases.
- **Dependency**: Ensure `AnnotationDbi` is loaded alongside this package to make use of the infrastructure it supports.

## Reference documentation
- [rhesus.db0 Reference Manual](./references/reference_manual.md)