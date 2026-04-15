---
name: bioconductor-mesh.eco.ed1a.eg.db
description: This tool provides mapping between MeSH identifiers and Entrez Gene IDs for Escherichia coli strain ED1a. Use when user asks to map gene IDs to MeSH terms, perform functional annotation, or conduct enrichment analysis for this specific bacterial strain.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Eco.ED1a.eg.db.html
---

# bioconductor-mesh.eco.ed1a.eg.db

start_thoughtname: bioconductor-mesh.eco.ed1a.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Escherichia coli ED1a. Use this skill when performing functional annotation, enrichment analysis, or cross-referencing gene data with MeSH terms for this specific bacterial strain.

# bioconductor-mesh.eco.ed1a.eg.db

## Overview

The `MeSH.Eco.ED1a.eg.db` package is a specialized annotation database within the Bioconductor ecosystem. It facilitates the mapping between Entrez Gene identifiers and MeSH (Medical Subject Headings) terms for *Escherichia coli* strain ED1a. This package is built upon the `MeSHDbi` framework and follows the standard `AnnotationDbi` interface, allowing users to query biological metadata using a consistent set of accessor functions.

## Core Workflows

### Loading the Database
To begin using the annotation data, load the library in R:

```r
library(MeSH.Eco.ED1a.eg.db)
# Display basic information about the database
MeSH.Eco.ED1a.eg.db
```

### Exploring the Database Structure
Use the standard `AnnotationDbi` methods to understand what data is available:

- `columns(MeSH.Eco.ED1a.eg.db)`: Lists the types of data that can be retrieved (e.g., MESHID, GENEID).
- `keytypes(MeSH.Eco.ED1a.eg.db)`: Lists the types of identifiers that can be used as query keys.
- `keys(MeSH.Eco.ED1a.eg.db, keytype=...)`: Returns all keys of a specific type.

### Querying Data
The `select` function is the primary tool for retrieving mappings.

```r
# Example: Retrieve mappings for specific Entrez Gene IDs
kts <- keytypes(MeSH.Eco.ED1a.eg.db)
kt <- "GENEID" # Or kts[2]
ks <- head(keys(MeSH.Eco.ED1a.eg.db, keytype=kt))

# Perform the selection
res <- select(MeSH.Eco.ED1a.eg.db, 
              keys = ks, 
              columns = columns(MeSH.Eco.ED1a.eg.db), 
              keytype = kt)
head(res)
```

### Database Metadata
To inspect the underlying database connection and schema:

```r
species(MeSH.Eco.ED1a.eg.db)  # Confirm species (Escherichia coli ED1a)
dbconn(MeSH.Eco.ED1a.eg.db)   # Get the DBI connection object
dbfile(MeSH.Eco.ED1a.eg.db)   # Get the path to the SQLite file
dbschema(MeSH.Eco.ED1a.eg.db) # View the database schema
dbInfo(MeSH.Eco.ED1a.eg.db)   # View metadata about the database build
```

## Usage Tips
- **MeSHDbi Requirement**: This package depends on the `MeSHDbi` package for its functional interface. Ensure it is installed.
- **Strain Specificity**: This package is specifically for *E. coli* ED1a. For other strains or organisms, different `MeSH.*.eg.db` packages must be used.
- **Integration**: The output of `select` is a `data.frame`, which can be easily integrated into downstream bioinformatics pipelines for enrichment analysis.

## Reference documentation

- [MeSH.Eco.ED1a.eg.db Reference Manual](./references/reference_manual.md)