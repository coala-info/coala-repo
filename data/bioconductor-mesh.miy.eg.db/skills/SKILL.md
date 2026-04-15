---
name: bioconductor-mesh.miy.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for Mycoplasma. Use when user asks to map Mycoplasma gene IDs to MeSH terms, perform functional annotation, or conduct gene set enrichment analysis using MeSH categories.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Miy.eg.db.html
---

# bioconductor-mesh.miy.eg.db

name: bioconductor-mesh.miy.eg.db
description: Mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Mycoplasma (Miy). Use this skill when performing functional annotation, gene set enrichment analysis, or biological data integration involving Mycoplasma genomic data and MeSH terms within the Bioconductor ecosystem.

## Overview

The `MeSH.Miy.eg.db` package is a specialized annotation database providing correspondences between MeSH IDs and Entrez Gene IDs for *Mycoplasma*. It is built upon the `MeSHDbi` framework, allowing users to query biological metadata using standard Bioconductor AnnotationDbi methods. This package is essential for researchers looking to link specific gene loci in Mycoplasma to the hierarchical controlled vocabulary of MeSH for medical and biological indexing.

## Basic Usage

### Loading the Package
```r
library(MeSH.Miy.eg.db)
# View object summary
MeSH.Miy.eg.db
```

### Exploring the Database
Use the standard four accessor methods to explore the available data types:

*   `columns(MeSH.Miy.eg.db)`: List the types of data that can be retrieved.
*   `keytypes(MeSH.Miy.eg.db)`: List the types of data that can be used as query keys (e.g., "MESHID", "GENEID").
*   `keys(MeSH.Miy.eg.db, keytype="GENEID")`: Retrieve all available keys for a specific type.
*   `select(...)`: The primary function to map between identifiers.

### Example Workflow: Mapping Gene IDs to MeSH Terms
```r
# 1. Identify available keytypes
kts <- keytypes(MeSH.Miy.eg.db)

# 2. Get a sample of Entrez Gene IDs
gene_keys <- head(keys(MeSH.Miy.eg.db, keytype="GENEID"))

# 3. Retrieve corresponding MeSH IDs and categories
results <- select(MeSH.Miy.eg.db, 
                  keys = gene_keys, 
                  columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
                  keytype = "GENEID")

# View results
head(results)
```

## Database Metadata
To inspect the underlying database structure and species information:
*   `species(MeSH.Miy.eg.db)`: Confirm the target organism (Mycoplasma).
*   `dbconn(MeSH.Miy.eg.db)`: Access the underlying SQLite connection.
*   `dbfile(MeSH.Miy.eg.db)`: Locate the database file path.
*   `dbschema(MeSH.Miy.eg.db)`: View the SQL table schema.

## Tips
*   **MeSHDbi Dependency**: This package relies on the `MeSHDbi` interface. If you need more advanced MeSH manipulation, ensure `MeSHDbi` is also loaded.
*   **Data Integration**: Use the `GENEID` column to join this data with other Mycoplasma-specific annotation packages (like `org.Miy.eg.db` if available) for a more comprehensive analysis.

## Reference documentation
- [MeSH.Miy.eg.db Reference Manual](./references/reference_manual.md)