---
name: bioconductor-mesh.osa.eg.db
description: This package provides mappings between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for *Oryza sativa* (Rice). Use when user asks to map rice gene identifiers to MeSH terms, perform functional annotation, or conduct MeSH-based enrichment analysis for rice genomic data.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Osa.eg.db.html
---


# bioconductor-mesh.osa.eg.db

name: bioconductor-mesh.osa.eg.db
description: Mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Oryza sativa (Rice). Use this skill when performing functional annotation, enrichment analysis, or identifier conversion for rice genomic data using MeSH terms within the Bioconductor ecosystem.

# bioconductor-mesh.osa.eg.db

## Overview
The `MeSH.Osa.eg.db` package is a Bioconductor annotation db-package that provides correspondence between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs specifically for *Oryza sativa* (Rice). It is built upon the `MeSHDbi` interface, allowing users to query biological metadata using standard AnnotationDbi methods.

## Basic Usage

To use this package, load the library and interact with the `MeSH.Osa.eg.db` object.

### Exploration
Use the standard four accessor methods to explore the database structure:
- `columns(MeSH.Osa.eg.db)`: List the types of data that can be retrieved.
- `keytypes(MeSH.Osa.eg.db)`: List the types of keys that can be used for lookup (e.g., MESHID, GENEID).
- `keys(MeSH.Osa.eg.db, keytype=...)`: Retrieve all keys of a specific type.
- `select(MeSH.Osa.eg.db, keys=..., columns=..., keytype=...)`: Perform the actual data retrieval.

### Metadata and Connection Info
- `species(MeSH.Osa.eg.db)`: Confirm the target organism (Oryza sativa).
- `dbInfo(MeSH.Osa.eg.db)`: View package metadata and data sources.
- `dbconn(MeSH.Osa.eg.db)`: Access the underlying SQLite connection.
- `dbschema(MeSH.Osa.eg.db)`: View the database schema.

## Workflow Example

The following R code demonstrates a typical workflow for mapping Entrez Gene IDs to MeSH terms:

```R
library(MeSH.Osa.eg.db)

# 1. Check available columns and keytypes
cls <- columns(MeSH.Osa.eg.db)
kts <- keytypes(MeSH.Osa.eg.db)

# 2. Retrieve a sample of keys (Entrez Gene IDs)
# Assuming 'GENEID' is the keytype for Entrez IDs
sample_keys <- head(keys(MeSH.Osa.eg.db, keytype="GENEID"))

# 3. Map Gene IDs to MeSH IDs and Categories
results <- select(MeSH.Osa.eg.db, 
                  keys = sample_keys, 
                  columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
                  keytype = "GENEID")

# 4. View results
head(results)
```

## Tips
- **MeSH Categories**: MeSH terms are organized into categories (e.g., D for Drugs and Chemicals, G for Phenomena and Processes). Use the `MESHCATEGORY` column to filter results.
- **Integration**: This package is often used in conjunction with `MeSHHyperGParams` (from the `meshr` package) to perform MeSH enrichment analysis.
- **Key Selection**: Always verify the `keytype` before running `keys()` or `select()` to ensure you are using the correct identifier format.

## Reference documentation
- [MeSH.Osa.eg.db Reference Manual](./references/reference_manual.md)