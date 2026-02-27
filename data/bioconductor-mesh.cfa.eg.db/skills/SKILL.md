---
name: bioconductor-mesh.cfa.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Canis familiaris. Use when user asks to map dog gene identifiers to MeSH terms, perform functional annotation for dog genomic data, or conduct gene set enrichment analysis using MeSH categories.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Cfa.eg.db.html
---


# bioconductor-mesh.cfa.eg.db

name: bioconductor-mesh.cfa.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Canis familiaris (dog). Use this skill when performing functional annotation, gene set enrichment analysis, or biological data mining involving dog genomic data and MeSH terms.

# bioconductor-mesh.cfa.eg.db

## Overview

The `MeSH.Cfa.eg.db` package is a Bioconductor annotation data package for *Canis familiaris*. It serves as a bridge between the MeSH hierarchical vocabulary and NCBI Entrez Gene identifiers. It is built upon the `AnnotationDbi` and `MeSHDbi` frameworks, allowing users to query biological relationships using a standardized interface.

## Core Workflows

### Loading the Package
```R
library(MeSH.Cfa.eg.db)
# View object summary
MeSH.Cfa.eg.db
```

### Exploring Metadata
Use these functions to understand the database structure and species focus:
```R
species(MeSH.Cfa.eg.db)  # Returns "Canis familiaris"
dbconn(MeSH.Cfa.eg.db)   # Get the underlying SQLite connection
dbschema(MeSH.Cfa.eg.db) # View database schema
dbInfo(MeSH.Cfa.eg.db)   # View package metadata
```

### Querying the Database
The package follows the standard `AnnotationDbi` interface using four main methods: `columns`, `keytypes`, `keys`, and `select`.

1.  **List available data types:**
    ```R
    # See what information you can retrieve
    columns(MeSH.Cfa.eg.db)
    
    # See what identifiers you can use as input keys
    keytypes(MeSH.Cfa.eg.db)
    ```

2.  **Retrieve keys:**
    ```R
    # Get the first 6 Entrez Gene IDs
    ks <- head(keys(MeSH.Cfa.eg.db, keytype="GENEID"))
    ```

3.  **Perform a lookup:**
    ```R
    # Map Entrez Gene IDs to MeSH IDs and Categories
    res <- select(MeSH.Cfa.eg.db, 
                  keys = ks, 
                  columns = c("MESHID", "MESHCATEGORY"), 
                  keytype = "GENEID")
    head(res)
    ```

## Usage Tips
- **MeSH Categories:** When querying, the `MESHCATEGORY` column helps distinguish between different branches of the MeSH hierarchy (e.g., Diseases [D], Chemicals and Drugs [D], etc.).
- **Integration:** This package is typically used in conjunction with `MeSHDbi` for enrichment analysis.
- **Entrez IDs:** Ensure your input gene identifiers are character vectors of Entrez IDs, as this is the primary keytype for this specific database.

## Reference documentation
- [MeSH.Cfa.eg.db Reference Manual](./references/reference_manual.md)