---
name: bioconductor-mesh.dvi.eg.db
description: This package provides mappings between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for biological data analysis. Use when user asks to map MeSH terms to gene identifiers, perform functional annotation, or conduct gene enrichment analysis using MeSH categories.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Dvi.eg.db.html
---


# bioconductor-mesh.dvi.eg.db

name: bioconductor-mesh.dvi.eg.db
description: Mapping between MeSH identifiers and Entrez Gene IDs using the MeSH.Dvi.eg.db annotation package. Use when performing functional annotation, gene enrichment analysis, or cross-referencing Medical Subject Headings (MeSH) with Entrez Gene identifiers for biological data analysis.

# bioconductor-mesh.dvi.eg.db

## Overview

MeSH.Dvi.eg.db is a Bioconductor annotation package that provides a mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs. This package is built upon the MeSHDbi framework and follows the standard AnnotationDbi interface, allowing users to query biological annotations using a consistent set of methods.

## Usage

### Loading the Package

Load the library to make the annotation object available:

```r
library(MeSH.Dvi.eg.db)
```

### Exploring the Database

Use the standard AnnotationDbi methods to explore the structure of the mapping:

- `columns(MeSH.Dvi.eg.db)`: List the types of data that can be retrieved.
- `keytypes(MeSH.Dvi.eg.db)`: List the types of identifiers that can be used as keys for querying.
- `keys(x, keytype)`: Retrieve all keys of a specific type from the database.
- `species(MeSH.Dvi.eg.db)`: Identify the species associated with this annotation package.

### Querying Data

Use the `select` function to perform mappings between MeSH IDs and Gene IDs:

```r
# Example: Mapping Entrez Gene IDs to MeSH IDs
kts <- keytypes(MeSH.Dvi.eg.db)
kt <- kts[2] # Select a specific keytype, e.g., "GENEID"
ks <- head(keys(MeSH.Dvi.eg.db, keytype=kt))

res <- select(MeSH.Dvi.eg.db, 
              keys = ks, 
              columns = columns(MeSH.Dvi.eg.db), 
              keytype = kt)
```

### Database Metadata

Access underlying database information using these utility functions:

- `dbconn(MeSH.Dvi.eg.db)`: Get the SQLite connection object.
- `dbfile(MeSH.Dvi.eg.db)`: Get the path to the database file.
- `dbschema(MeSH.Dvi.eg.db)`: View the database schema.
- `dbInfo(MeSH.Dvi.eg.db)`: Get metadata about the database version and source.

## Workflow Example

A typical workflow involves identifying specific genes of interest and finding their associated MeSH terms for functional characterization:

1. Load the package.
2. Define a vector of Entrez Gene IDs.
3. Use `select()` with `keytype = "GENEID"` and `columns = "MESHID"`.
4. Analyze the resulting data frame to identify prevalent MeSH categories.

## Reference documentation

- [MeSH.Dvi.eg.db Manual](./references/reference_manual.md)