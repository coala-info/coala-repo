---
name: bioconductor-mesh.eco.iai39.eg.db
description: This Bioconductor package provides mapping between MeSH identifiers and Entrez Gene IDs for the Escherichia coli IAI39 strain. Use when user asks to perform functional annotation, conduct gene set enrichment analysis, or cross-reference biological literature with genomic data for this specific bacterial strain.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Eco.IAI39.eg.db.html
---


# bioconductor-mesh.eco.iai39.eg.db

name: bioconductor-mesh.eco.iai39.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Escherichia coli IAI39. Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for this specific bacterial strain.

## Overview

The `MeSH.Eco.IAI39.eg.db` package is a Bioconductor annotation database. It serves as a bridge between the hierarchical MeSH vocabulary and Entrez Gene identifiers for *Escherichia coli IAI39*. It implements the standard `AnnotationDbi` interface, allowing users to query biological metadata using a consistent set of methods.

## Core Workflows

### Loading the Database
To begin using the annotation data, load the library in R:

```R
library(MeSH.Eco.IAI39.eg.db)
# View object summary
MeSH.Eco.IAI39.eg.db
```

### Exploring Available Data
Use the standard four accessor methods to understand the structure and content of the database:

*   `columns(MeSH.Eco.IAI39.eg.db)`: Lists the types of data that can be retrieved.
*   `keytypes(MeSH.Eco.IAI39.eg.db)`: Lists the types of identifiers that can be used as query keys (e.g., MESHID, GENEID).
*   `keys(MeSH.Eco.IAI39.eg.db, keytype=...)`: Returns all viable keys for a specific keytype.

### Querying the Database
The `select` function is the primary tool for retrieving data. It requires the database object, the keys you are searching for, the columns you want to return, and the keytype of your input keys.

```R
# Example: Retrieve MeSH terms for specific Entrez Gene IDs
kts <- keytypes(MeSH.Eco.IAI39.eg.db)
kt <- "GENEID" # Or kts[2] depending on index
ks <- head(keys(MeSH.Eco.IAI39.eg.db, keytype=kt))
cls <- columns(MeSH.Eco.IAI39.eg.db)

res <- select(MeSH.Eco.IAI39.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)
```

### Database Metadata
To inspect the underlying database connection or species information:

```R
species(MeSH.Eco.IAI39.eg.db)
dbInfo(MeSH.Eco.IAI39.eg.db)
dbfile(MeSH.Eco.IAI39.eg.db)
```

## Usage Tips
*   **MeSHDbi Integration**: This package is designed to work seamlessly with the `MeSHDbi` framework. For complex enrichment analyses, refer to `MeSHHyperGParams` in related MeSH packages.
*   **Strain Specificity**: Ensure your data specifically relates to *E. coli IAI39*, as MeSH mappings are strain-specific in these annotation packages.
*   **Keytype Matching**: Always verify your input ID type using `keytypes()` before running `select()` to avoid empty results.

## Reference documentation
- [MeSH.Eco.IAI39.eg.db Reference Manual](./references/reference_manual.md)