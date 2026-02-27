---
name: bioconductor-mesh.db
description: This tool provides access to Medical Subject Headings (MeSH) annotations and their mappings to Entrez Gene IDs within the Bioconductor framework. Use when user asks to map MeSH terms to genes, explore MeSH hierarchies, or retrieve metadata from the MeSH.db annotation package.
homepage: https://bioconductor.org/packages/3.6/data/annotation/html/MeSH.db.html
---


# bioconductor-mesh.db

name: bioconductor-mesh.db
description: Access and query Medical Subject Headings (MeSH) annotations and their mappings to Entrez Gene IDs. Use this skill when you need to map MeSH terms to genes, explore MeSH hierarchies, or retrieve metadata from the MeSH.db Bioconductor annotation package.

## Overview
The `MeSH.db` package is a Bioconductor annotation resource that provides a unified interface to Medical Subject Headings (MeSH) data. It primarily facilitates the correspondence between MeSH IDs and Entrez Gene IDs. It implements the standard `AnnotationDbi` interface, allowing users to query the database using a consistent set of methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

## Installation
To use this package, it must be installed via `BiocManager`:
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MeSH.db")
```

## Core Workflow
The package follows the standard AnnotationDbi workflow.

### 1. Loading the Library
```r
library(MeSH.db)
```

### 2. Exploring the Database
Before querying, identify what data is available:
- `columns(MeSH.db)`: Lists the types of data that can be retrieved (e.g., MESHID, ENTREZID).
- `keytypes(MeSH.db)`: Lists the types of identifiers that can be used as query keys.
- `keys(MeSH.db, keytype="MESHID")`: Retrieves all available keys for a specific keytype.

### 3. Querying Data
Use the `select()` function to perform mappings.
```r
# Example: Map specific MeSH IDs to Entrez Gene IDs
ks <- c("D000001", "D000002")
res <- select(MeSH.db, keys=ks, columns=c("MESHID", "ENTREZID"), keytype="MESHID")
head(res)
```

### 4. Database Metadata
To inspect the underlying database structure or connection:
- `dbconn(MeSH.db)`: Returns the connection object to the underlying SQLite database.
- `dbfile(MeSH.db)`: Returns the path to the SQLite database file.
- `dbschema(MeSH.db)`: Displays the database schema.
- `dbInfo(MeSH.db)`: Provides metadata about the database version and source.

## Usage Tips
- **MeSHDbi Dependency**: While `MeSH.db` provides the data, the underlying logic is often handled by the `MeSHDbi` package. If advanced manipulation is required, refer to `MeSHDbi` documentation.
- **Memory Management**: For large-scale queries, it is more efficient to request only the specific `columns` you need rather than all available columns.
- **Key Selection**: Always verify the `keytype` matches the format of your input `keys` to avoid empty results.

## Reference documentation
- [MeSH.db Reference Manual](./references/reference_manual.md)