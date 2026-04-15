---
name: bioconductor-mesh.aga.pest.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for the Anopheles gambiae PEST strain. Use when user asks to perform functional annotation, conduct gene set enrichment analysis, or cross-reference biological literature terms with genomic data for this mosquito species.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Aga.PEST.eg.db.html
---

# bioconductor-mesh.aga.pest.eg.db

name: bioconductor-mesh.aga.pest.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Anopheles gambiae (Pimpernel/PEST strain). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature terms with genomic data for this specific mosquito species.

# bioconductor-mesh.aga.pest.eg.db

## Overview

The `MeSH.Aga.PEST.eg.db` package is a Bioconductor annotation resource that facilitates the correspondence between MeSH IDs and Entrez Gene IDs for *Anopheles gambiae* (PEST strain). It is built upon the `MeSHDbi` framework, allowing users to query biological descriptors and their associated genes using standard AnnotationDbi methods.

## Core Workflow

To use this package, you must have `MeSH.Aga.PEST.eg.db` and `AnnotationDbi` installed and loaded in your R environment.

### 1. Loading the Database
```r
library(MeSH.Aga.PEST.eg.db)
# View object summary
MeSH.Aga.PEST.eg.db
```

### 2. Exploring the Database Structure
Use the standard four accessor methods to understand what data is available:

*   **`columns(MeSH.Aga.PEST.eg.db)`**: Lists the types of data that can be retrieved (e.g., MESHID, GENEID).
*   **`keytypes(MeSH.Aga.PEST.eg.db)`**: Lists the types of identifiers that can be used as keys for querying.
*   **`keys(MeSH.Aga.PEST.eg.db, keytype=...)`**: Returns all keys of a specific type.

### 3. Querying Data
The `select` function is the primary tool for retrieving mappings.

```r
# Example: Retrieve mappings for specific Entrez Gene IDs
kts <- keytypes(MeSH.Aga.PEST.eg.db)
kt <- "GENEID" # Or kts[2] depending on index
ks <- head(keys(MeSH.Aga.PEST.eg.db, keytype=kt))

res <- select(MeSH.Aga.PEST.eg.db, 
              keys = ks, 
              columns = columns(MeSH.Aga.PEST.eg.db), 
              keytype = kt)
head(res)
```

### 4. Database Metadata
You can extract administrative and versioning information using these utility functions:
*   `species(MeSH.Aga.PEST.eg.db)`: Confirms the target organism.
*   `dbInfo(MeSH.Aga.PEST.eg.db)`: Displays metadata about the database source and version.
*   `dbfile(MeSH.Aga.PEST.eg.db)`: Shows the path to the underlying SQLite file.

## Tips for Success
*   **Consistency**: Ensure your input keys match the `keytype` specified. If querying by Entrez IDs, they should be character strings.
*   **MeSHDbi**: For more complex queries involving MeSH hierarchies (Categories, Headings), refer to the `MeSHDbi` package documentation, as this package serves as the data container for those methods.

## Reference documentation

- [MeSH.Aga.PEST.eg.db Reference Manual](./references/reference_manual.md)