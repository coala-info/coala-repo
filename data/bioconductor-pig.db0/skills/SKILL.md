---
name: bioconductor-pig.db0
description: This package provides the base SQLite database infrastructure for Sus scrofa genomic annotations within the Bioconductor framework. Use when user asks to build custom pig annotation packages using sqlForge, manage raw pig genomic data sources, or construct organism-level annotation objects.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pig.db0.html
---


# bioconductor-pig.db0

name: bioconductor-pig.db0
description: Use when working with the Bioconductor annotation base package for Sus scrofa (pig). This skill is specifically for using pig.db0 as a source for sqlForge to build custom pig annotation packages or when managing the underlying SQLite database for pig genomic annotations.

# bioconductor-pig.db0

## Overview

The `pig.db0` package is a Bioconductor "base" annotation package for *Sus scrofa*. Unlike standard `.db` annotation packages (e.g., `org.Ss.eg.db`), `pig.db0` is not intended for direct data querying by end-users. Its primary purpose is to provide the raw SQLite database infrastructure required by the `AnnotationDbi` package's `sqlForge` functionality to construct more user-friendly, schema-stable annotation objects.

## Usage and Workflow

### Installation
Install the package using `BiocManager`:
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pig.db0")
```

### Primary Use Case: sqlForge
The main reason to load `pig.db0` is to provide the necessary data source for building a custom chip-level or organism-level annotation package.

```r
library(pig.db0)
library(AnnotationDbi)

# Example: Using the data within sqlForge workflows
# While users rarely call pig.db0 directly, it must be installed 
# for functions like makeOrgPackage() or specific chip-building 
# functions to find the source pig data.
```

### Accessing the Database Location
If you must find the path to the underlying SQLite database:
```r
# Load the package
library(pig.db0)

# The database object is typically named after the package
# You can find the location of the database file
dbfile <- system.file("extdata", "pig.sqlite", package="pig.db0")
```

## Important Constraints
- **Schema Instability**: The internal database schema of `pig.db0` is subject to change without notice. Avoid writing hard-coded SQL queries against this database.
- **Prefer Org Packages**: For standard gene-centric lookups (e.g., mapping Entrez IDs to Gene Symbols), use `org.Ss.eg.db` instead of `pig.db0`.
- **Wrapper Functions**: Always prefer using `AnnotationDbi` wrapper functions rather than direct database connections.

## Reference documentation
- [pig.db0 Reference Manual](./references/reference_manual.md)