---
name: bioconductor-ecolik12.db0
description: This package provides the base SQLite annotation database for Escherichia coli K12 used by the sqlForge toolset. Use when user asks to build organism-specific annotation packages, create custom E. coli K12 metadata mappings, or provide source data for AnnotationDbi construction functions.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ecoliK12.db0.html
---


# bioconductor-ecolik12.db0

name: bioconductor-ecolik12.db0
description: Base annotation database for Escherichia coli K12. Use when building organism-specific annotation packages or when sqlForge requires the latest E. coli K12 metadata for genomic data mapping.

# bioconductor-ecolik12.db0

## Overview

The `ecoliK12.db0` package is a Bioconductor "BASE" annotation package for *Escherichia coli* K12. Unlike standard annotation packages (e.g., `org.EcK12.eg.db`), this package is primarily designed as a data distribution mechanism for the `sqlForge` toolset within the `AnnotationDbi` framework.

It contains the raw SQLite databases used to build more stable, user-friendly annotation objects. Users are generally advised to interact with this package through `AnnotationDbi` wrapper functions rather than querying the underlying database directly, as the internal schema is subject to change without notice.

## Installation

To install the package, use the BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ecoliK12.db0")
```

## Usage and Workflow

### Primary Use Case: sqlForge
The main purpose of `ecoliK12.db0` is to provide the source data for creating custom annotation packages. If you are developing a chip-specific or a more stable organism-specific package for E. coli K12, `AnnotationDbi` will look for this package.

### Accessing the Database Location
While direct querying is discouraged, you can find the location of the database file if required by specific `AnnotationDbi` construction functions:

```r
library(ecoliK12.db0)
# The package typically contains a system file path to the SQLite database
db_path <- system.file("extdata", "ecoliK12.sqlite", package="ecoliK12.db0")
```

### Integration with AnnotationDbi
Most users should use the high-level interfaces provided by `AnnotationDbi` to interact with E. coli data. If you need to map identifiers, ensure you have the appropriate "org" package (like `org.EcK12.eg.db`) installed, which may have been built using this `.db0` package.

## Tips and Best Practices
- **Avoid Direct SQL:** Do not write hard-coded SQL queries against the tables in this package for production scripts, as the schema is not guaranteed to be stable across versions.
- **Use as Dependency:** This package is often a hidden dependency. If you encounter errors in `sqlForge` or `makeOrgPackage` regarding missing E. coli K12 data, ensure this package is installed.
- **Check Versioning:** Always ensure `ecoliK12.db0` is up to date via `BiocManager::install()` to ensure `sqlForge` is using the latest available biological metadata.

## Reference documentation
- [ecoliK12.db0 Reference Manual](./references/reference_manual.md)