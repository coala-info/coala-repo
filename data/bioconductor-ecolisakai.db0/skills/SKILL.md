---
name: bioconductor-ecolisakai.db0
description: This package provides base annotation data for Escherichia coli Sakai to be used as a data source for building custom annotation packages. Use when user asks to access raw SQLite databases for E. coli Sakai or use sqlForge to generate schema-stable annotation packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ecoliSakai.db0.html
---


# bioconductor-ecolisakai.db0

name: bioconductor-ecolisakai.db0
description: Guidance for using the ecoliSakai.db0 Bioconductor package. Use when needing to access the base annotation data for Escherichia coli Sakai or when using AnnotationDbi/sqlForge to build custom annotation packages for this organism.

# bioconductor-ecolisakai.db0

## Overview

The `ecoliSakai.db0` package is a Bioconductor annotation BASE package for *Escherichia coli* Sakai. Unlike standard annotation packages (e.g., `.db` packages), `.db0` packages are primarily designed as data sources for the `sqlForge` functionality within the `AnnotationDbi` framework. They contain the raw SQLite databases used to generate more user-friendly, schema-stable annotation packages.

## Installation

Install the package using `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ecoliSakai.db0")
```

## Usage Guidelines

### Primary Purpose
This package is not intended for direct querying by most users. Its main role is to provide the underlying data for building "normal" annotation packages (like chip-specific or organism-specific packages).

### Working with sqlForge
Use this package when you need to create a custom annotation package for *E. coli* Sakai. The `AnnotationDbi` package uses the data in `ecoliSakai.db0` to populate the schemas of new packages.

```r
library(ecoliSakai.db0)
library(AnnotationDbi)
# Typically used internally by sqlForge functions
```

### Direct Database Access (Discouraged)
While you can load the package, direct interaction with the internal database is discouraged because:
1. The database schema is not guaranteed to be stable and may change between versions.
2. No official schema documentation is provided for the `.db0` format.
3. Standard `select()`, `keys()`, and `columns()` methods are better supported in the derived `.db` packages.

## Best Practices
- **Use Derived Packages:** If a standard annotation package for *E. coli* Sakai exists (e.g., `org.EcSakai.eg.db`), use that instead for routine tasks like mapping gene IDs to GO terms or KEGG pathways.
- **Stay Updated:** Always use the latest version of this package when building new annotation packages to ensure the underlying genomic data is current.
- **Avoid Hardcoding:** Do not write scripts that depend on the specific table structures within this package.

## Reference documentation

- [ecoliSakai.db0 Reference Manual](./references/reference_manual.md)