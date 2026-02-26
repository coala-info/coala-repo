---
name: bioconductor-arabidopsis.db0
description: This package provides base annotation data for Arabidopsis thaliana to support the creation of custom annotation packages. Use when user asks to build custom Arabidopsis chip-specific annotation databases, use sqlForge for annotation package generation, or access raw SQLite data for Arabidopsis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/arabidopsis.db0.html
---


# bioconductor-arabidopsis.db0

name: bioconductor-arabidopsis.db0
description: Guidance for using the arabidopsis.db0 Bioconductor package. Use this skill when you need to build custom Arabidopsis thaliana annotation packages or use sqlForge to create chip-specific annotation databases using the latest base data.

# bioconductor-arabidopsis.db0

## Overview

The `arabidopsis.db0` package is a Bioconductor "base" annotation package for *Arabidopsis thaliana*. Unlike standard annotation packages (like `org.At.tair.db`), this package is primarily a data distribution mechanism. It contains the raw SQLite databases used by the `AnnotationDbi` "sqlForge" system to generate functional, schema-stable annotation packages.

**Warning:** Direct querying of the databases within this package is discouraged because the internal schema is unstable and subject to change. It is designed to be consumed by `AnnotationDbi` wrapper functions.

## Typical Workflow

### 1. Installation and Loading
To use this package, it must be installed via `BiocManager`.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("arabidopsis.db0")
library(arabidopsis.db0)
```

### 2. Creating Custom Annotation Packages
The primary use case for `arabidopsis.db0` is providing the underlying data for `makeARABIDOPSISCHIP_DB()`. This is used when you have custom array data or need to build a specific chip-level mapping package.

```r
library(AnnotationDbi)
library(arabidopsis.db0)

# Example: Building a custom chip package (requires a mapping file)
# makeARABIDOPSISCHIP_DB(
#    affy=FALSE,
#    prefix="MyCustomChip",
#    fileName="path_to_mapping_file.txt",
#    baseMapType="gb",
#    outputDir=".",
#    version="1.0.0",
#    manufacturer="MyLab"
# )
```

### 3. Accessing the Database Path
If you must locate the raw database file for programmatic use within `AnnotationDbi` tools:

```r
# Find the location of the SQLite database
db_path <- system.file("extdata", "arabidopsis.sqlite", package="arabidopsis.db0")
```

## Usage Tips
- **Do not use for daily lookups:** For standard gene symbol, GO term, or KEGG pathway lookups, use the `org.At.tair.db` package instead.
- **sqlForge Integration:** This package is a dependency for `AnnotationDbi`'s `sqlForge` code. If you are developing new annotation infrastructure for Arabidopsis, this is your data source.
- **Schema Instability:** Because the schema is not guaranteed, always use `AnnotationDbi` methods to interact with the data rather than writing raw SQL queries against the `.sqlite` file.

## Reference documentation

- [arabidopsis.db0 Reference Manual](./references/reference_manual.md)