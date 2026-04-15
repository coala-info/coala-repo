---
name: bioconductor-mesh.hsa.eg.db
description: This package provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Homo sapiens. Use when user asks to map human gene identifiers to medical concepts, perform MeSH-based enrichment analysis, or query relationships between genes and diseases or chemicals.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Hsa.eg.db.html
---

# bioconductor-mesh.hsa.eg.db

name: bioconductor-mesh.hsa.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Homo sapiens. Use this skill when performing biological data annotation, enrichment analysis, or converting between MeSH terms and human gene identifiers using the MeSH.Hsa.eg.db Bioconductor package.

# bioconductor-mesh.hsa.eg.db

## Overview
The `MeSH.Hsa.eg.db` package is a specialized annotation database within the Bioconductor ecosystem. It serves as a bridge between the MeSH (Medical Subject Headings) classification system and NCBI Entrez Gene identifiers for human data. It implements the standard `AnnotationDbi` interface, allowing users to query relationships between genes and medical concepts (diseases, chemicals, phenomena, etc.) using a consistent set of accessor functions.

## Usage and Workflows

### Loading the Database
To begin, load the library. The object `MeSH.Hsa.eg.db` is automatically instantiated.

```r
library(MeSH.Hsa.eg.db)
# Display object summary
MeSH.Hsa.eg.db
```

### Exploring the Database Structure
Use the standard AnnotationDbi methods to see what data is available:

*   `columns(MeSH.Hsa.eg.db)`: Lists the types of data that can be retrieved (e.g., MESHID, GENEID, MESHCATEGORY).
*   `keytypes(MeSH.Hsa.eg.db)`: Lists the types of identifiers that can be used as query keys.
*   `keys(MeSH.Hsa.eg.db, keytype=...)`: Retrieves all keys of a specific type.

```r
# Check available columns and keytypes
cols <- columns(MeSH.Hsa.eg.db)
kts <- keytypes(MeSH.Hsa.eg.db)

# Get the first few Entrez Gene IDs present in the DB
gene_keys <- head(keys(MeSH.Hsa.eg.db, keytype="GENEID"))
```

### Mapping Identifiers (The `select` Method)
The primary workflow involves mapping a list of known IDs (keys) to desired information (columns).

```r
# Map Entrez Gene IDs to MeSH IDs
results <- select(MeSH.Hsa.eg.db, 
                  keys = gene_keys, 
                  columns = c("MESHID", "MESHCATEGORY"), 
                  keytype = "GENEID")
head(results)
```

### Database Metadata
You can inspect the underlying database properties using these utility functions:

```r
species(MeSH.Hsa.eg.db)   # Should return "Homo sapiens"
dbconn(MeSH.Hsa.eg.db)    # Get the underlying SQLite connection
dbfile(MeSH.Hsa.eg.db)    # Get the path to the DB file
dbschema(MeSH.Hsa.eg.db)  # View the SQL schema
```

## Tips for Success
*   **MeSH Categories**: MeSH IDs are often categorized (e.g., D for Drugs/Chemicals, C for Diseases). Use the `MESHCATEGORY` column to filter results if you are only interested in specific types of associations.
*   **MeSHDbi Dependency**: This package relies on the `MeSHDbi` framework. For advanced queries or understanding the underlying data structure, refer to `MeSHDbi` documentation.
*   **Entrez IDs**: Ensure your input gene identifiers are Entrez IDs (integers/strings like "1", "10") rather than Gene Symbols (like "TP53"), as this specific database is keyed to Entrez.

## Reference documentation
- [MeSH.Hsa.eg.db Reference Manual](./references/reference_manual.md)