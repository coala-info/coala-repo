---
name: bioconductor-mesh.pae.pao1.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for Pseudomonas aeruginosa PAO1. Use when user asks to map identifiers, perform functional annotation, or conduct MeSH enrichment analysis for Pseudomonas aeruginosa PAO1.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Pae.PAO1.eg.db.html
---


# bioconductor-mesh.pae.pao1.eg.db

name: bioconductor-mesh.pae.pao1.eg.db
description: Mapping between MeSH identifiers and Entrez Gene IDs for Pseudomonas aeruginosa PAO1. Use this skill when performing functional annotation, enrichment analysis, or identifier conversion for P. aeruginosa PAO1 using Medical Subject Headings (MeSH).

# bioconductor-mesh.pae.pao1.eg.db

## Overview

The `MeSH.Pae.PAO1.eg.db` package is a Bioconductor annotation object that provides correspondence between Medical Subject Headings (MeSH) IDs and Entrez Gene IDs for the bacterium *Pseudomonas aeruginosa PAO1*. It is built upon the `MeSHDbi` framework and follows the standard `AnnotationDbi` interface.

## Basic Usage

### Loading the Package
Load the library to make the annotation object available:
```r
library(MeSH.Pae.PAO1.eg.db)
# Access the object directly
MeSH.Pae.PAO1.eg.db
```

### Exploring the Database
Use standard accessor methods to discover available data types:
- `columns(MeSH.Pae.PAO1.eg.db)`: List data types that can be retrieved.
- `keytypes(MeSH.Pae.PAO1.eg.db)`: List the types of identifiers that can be used as query keys.
- `keys(MeSH.Pae.PAO1.eg.db, keytype="ENTREZID")`: Retrieve all keys of a specific type.

### Mapping Identifiers
Use the `select` function to perform lookups. This is the primary method for converting between Entrez Gene IDs and MeSH terms.

```r
# Example: Map Entrez IDs to MeSH IDs and Categories
my_keys <- c("877315", "877316") # Example Entrez IDs
res <- select(MeSH.Pae.PAO1.eg.db, 
              keys = my_keys, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "ENTREZID")
head(res)
```

## Database Metadata

Retrieve information about the database source and target species:
- `species(MeSH.Pae.PAO1.eg.db)`: Confirm the target organism (Pseudomonas aeruginosa PAO1).
- `dbInfo(MeSH.Pae.PAO1.eg.db)`: View metadata about the data sources and versions.
- `dbconn(MeSH.Pae.PAO1.eg.db)`: Get the underlying SQLite connection.
- `dbschema(MeSH.Pae.PAO1.eg.db)`: View the database schema.

## Typical Workflow

1.  **Identify Input**: Determine if you have Entrez Gene IDs or MeSH IDs.
2.  **Verify Keytypes**: Run `keytypes(MeSH.Pae.PAO1.eg.db)` to ensure your input type is supported.
3.  **Select Columns**: Run `columns(MeSH.Pae.PAO1.eg.db)` to choose the desired output (e.g., MESHID, MESHSOURCE).
4.  **Execute Query**: Use `select()` to generate the mapping table.
5.  **Downstream Analysis**: Use the resulting mappings for MeSH enrichment analysis or functional profiling.

## Reference documentation

- [MeSH.Pae.PAO1.eg.db Manual](./references/reference_manual.md)