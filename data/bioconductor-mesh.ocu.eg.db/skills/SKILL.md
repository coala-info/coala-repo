---
name: bioconductor-mesh.ocu.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for *Oryctolagus cuniculus*. Use when user asks to map rabbit Entrez Gene IDs to MeSH terms, perform functional annotation for rabbit genomic data, or query biological metadata using the AnnotationDbi framework.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Ocu.eg.db.html
---

# bioconductor-mesh.ocu.eg.db

name: bioconductor-mesh.ocu.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Oryctolagus cuniculus (rabbit). Use this skill when performing functional annotation, gene enrichment analysis, or data retrieval involving rabbit genomic data and MeSH terms within the Bioconductor ecosystem.

# bioconductor-mesh.ocu.eg.db

## Overview
`MeSH.Ocu.eg.db` is a Bioconductor annotation package that serves as a bridge between Entrez Gene identifiers and MeSH (Medical Subject Headings) terms for *Oryctolagus cuniculus* (rabbit). It is built upon the `AnnotationDbi` framework, allowing users to query biological metadata using a standardized interface.

## Core Workflows

### Loading the Package
```r
library(MeSH.Ocu.eg.db)
# Display package object information
MeSH.Ocu.eg.db
```

### Exploring Metadata
Use the standard `AnnotationDbi` methods to explore the database structure:
- `columns(MeSH.Ocu.eg.db)`: List the types of data that can be retrieved.
- `keytypes(MeSH.Ocu.eg.db)`: List the types of identifiers that can be used as keys for querying.
- `keys(MeSH.Ocu.eg.db, keytype=...)`: Retrieve all available keys for a specific keytype.

### Querying the Database
The `select` function is the primary tool for data retrieval. It requires the database object, the keys to search for, the columns to return, and the keytype of the input keys.

```r
# Example: Retrieve MeSH information for specific Entrez Gene IDs
kts <- keytypes(MeSH.Ocu.eg.db)
kt <- "ENTREZID" # Common keytype
ks <- head(keys(MeSH.Ocu.eg.db, keytype=kt))
cls <- columns(MeSH.Ocu.eg.db)

res <- select(MeSH.Ocu.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)
```

### Database Metadata and Connection
To inspect the underlying database properties:
- `species(MeSH.Ocu.eg.db)`: Confirm the target organism (Oryctolagus cuniculus).
- `dbInfo(MeSH.Ocu.eg.db)`: View metadata about the database version and source.
- `dbfile(MeSH.Ocu.eg.db)`: Get the path to the SQLite database file.
- `dbschema(MeSH.Ocu.eg.db)`: View the SQL schema of the underlying database.

## Usage Tips
- **MeSH Categories**: MeSH IDs are often categorized (e.g., Anatomy, Diseases, Chemicals and Drugs). Use the `MESHID` and `MESHCATEGORY` columns to filter results for specific biological contexts.
- **Integration**: This package is designed to work seamlessly with `MeSHDbi`. For advanced analysis like enrichment, refer to the `meshr` package.
- **Entrez IDs**: Ensure that input keys are character vectors, as Entrez IDs are treated as strings in this interface.

## Reference documentation
- [MeSH.Ocu.eg.db Reference Manual](./references/reference_manual.md)