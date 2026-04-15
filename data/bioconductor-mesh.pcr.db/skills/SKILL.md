---
name: bioconductor-mesh.pcr.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for PCR-related data. Use when user asks to map gene IDs to medical subject headings, perform functional annotation, or conduct enrichment analysis using the MeSH.PCR.db database.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.PCR.db.html
---

# bioconductor-mesh.pcr.db

name: bioconductor-mesh.pcr.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Polymerase Chain Reaction (PCR) related data. Use this skill when performing functional annotation, enrichment analysis, or gene-to-term lookups using the MeSH.PCR.db Bioconductor annotation package.

# bioconductor-mesh.pcr.db

## Overview

`MeSH.PCR.db` is a specialized Bioconductor annotation package that facilitates the correspondence between MeSH IDs and Entrez Gene IDs. It is built upon the `AnnotationDbi` framework, allowing users to query biological metadata using a standardized interface. This package is essential for researchers linking gene sets to medical subject headings specifically curated in the context of PCR.

## Installation

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.PCR.db")
```

## Basic Usage

The package follows the standard `AnnotationDbi` interface using four main methods: `columns`, `keytypes`, `keys`, and `select`.

### Loading the package
```r
library(MeSH.PCR.db)
# View the object summary
MeSH.PCR.db
```

### Exploring the Database Structure
Before querying, identify what data types are available:

```r
# List available columns to retrieve
cls <- columns(MeSH.PCR.db)

# List available keytypes that can be used as query inputs
kts <- keytypes(MeSH.PCR.db)
```

### Querying Data
To retrieve specific mappings, use the `select` function:

```r
# 1. Get a sample of keys (e.g., Entrez Gene IDs)
ks <- head(keys(MeSH.PCR.db, keytype="GENEID"))

# 2. Map these keys to MeSH IDs
res <- select(MeSH.PCR.db, 
              keys = ks, 
              columns = c("MESHID", "MESHTERM"), 
              keytype = "GENEID")

# View results
head(res)
```

## Database Metadata
You can inspect the underlying SQLite database properties using these utility functions:

- `dbconn(MeSH.PCR.db)`: Returns the database connection object.
- `dbfile(MeSH.PCR.db)`: Returns the path to the database file.
- `dbschema(MeSH.PCR.db)`: Displays the database schema.
- `dbInfo(MeSH.PCR.db)`: Provides general information about the database version and creation.

## Workflow Tips
- **Entrez IDs**: Ensure your input gene identifiers are Entrez IDs (numeric strings) when using `keytype="GENEID"`.
- **MeSH IDs**: MeSH identifiers typically start with a unique alphanumeric code (e.g., D000001).
- **Integration**: This package is often used in conjunction with `MeSHDbi` and `meshr` for downstream enrichment analysis.

## Reference documentation
- [MeSH.PCR.db Reference Manual](./references/reference_manual.md)