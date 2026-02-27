---
name: bioconductor-yeast.db0
description: This package provides base annotation data and raw SQLite databases for Saccharomyces cerevisiae to support the creation of custom yeast annotation packages. Use when user asks to build custom yeast annotation libraries using sqlForge, access raw yeast genomic metadata, or create chip-specific mapping databases.
homepage: https://bioconductor.org/packages/release/data/annotation/html/yeast.db0.html
---


# bioconductor-yeast.db0

name: bioconductor-yeast.db0
description: Provides guidance on using the yeast.db0 Bioconductor package. This package is a base annotation package for Saccharomyces cerevisiae (Yeast). Use this skill when you need to build custom yeast annotation packages using AnnotationDbi's sqlForge or when you need to access the raw SQLite databases for yeast genomic metadata.

# bioconductor-yeast.db0

## Overview

The `yeast.db0` package is a "base" annotation package for *Saccharomyces cerevisiae*. Unlike standard Bioconductor annotation packages (like `org.Sc.sgd.db`), `.db0` packages are primarily designed as data sources for the `AnnotationDbi` "sqlForge" framework. They contain the raw SQLite databases used to construct more user-friendly chip-specific or organism-level annotation packages.

While direct use is generally discouraged because the internal schema is subject to change, it is essential for bioinformaticians who need to create custom annotation objects or map identifiers using the most recent underlying data provided by Bioconductor.

## Typical Workflows

### 1. Building a Custom Yeast Annotation Package
The primary use case for `yeast.db0` is as an input to `makeYEASTCHIP_DB` or similar functions to create a structured annotation library.

```r
library(AnnotationDbi)
library(yeast.db0)

# Example: Creating a custom chip-level mapping database
# This requires a data frame or file mapping manufacturer IDs to systematic names
# makeYEASTCHIP_DB(affy_data_file, output_directory, manufacturer_name)
```

### 2. Accessing the Raw Database Path
If you must access the database directly (e.g., for complex SQL queries not supported by standard select methods), you can locate the database file:

```r
# Find the location of the SQLite file
db_path <- system.file("extdata", "yeast.sqlite", package = "yeast.db0")
```

### 3. Integration with AnnotationDbi
Most users should interact with this data through the `AnnotationDbi` interface rather than calling `yeast.db0` functions directly.

```r
# Ensure the package is installed to make the data available to sqlForge
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("yeast.db0")
```

## Usage Tips
- **Schema Stability**: Be aware that `yeast.db0` does not guarantee a stable SQL schema. If you write raw SQL queries against it, they may break in future Bioconductor releases.
- **Preferred Alternatives**: For standard gene-centric lookups (GO terms, Chromosomes, Entrez IDs), use `org.Sc.sgd.db` instead.
- **Purpose**: Only use this package if you are developing new annotation tools or if the standard `org` packages are insufficient for your specific mapping needs.

## Reference documentation

- [yeast.db0 Reference Manual](./references/reference_manual.md)