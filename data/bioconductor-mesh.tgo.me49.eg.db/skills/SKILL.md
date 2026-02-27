---
name: bioconductor-mesh.tgo.me49.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for Toxoplasma gondii ME49. Use when user asks to perform functional annotation, conduct enrichment analysis, or map gene identifiers to medical subject headings for this organism.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Tgo.ME49.eg.db.html
---


# bioconductor-mesh.tgo.me49.eg.db

name: bioconductor-mesh.tgo.me49.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Toxoplasma gondii ME49. Use this skill when performing functional annotation, enrichment analysis, or cross-referencing gene data with medical terminology for this specific organism.

# bioconductor-mesh.tgo.me49.eg.db

## Overview

The `MeSH.Tgo.ME49.eg.db` package is a specialized Bioconductor annotation database for *Toxoplasma gondii* ME49. It facilitates the translation between Entrez Gene identifiers and MeSH terms, allowing researchers to link genomic data with a hierarchical vocabulary of medical and biological concepts. It implements the standard `AnnotationDbi` interface.

## Usage Guidance

### Loading the Database
To begin using the annotation data, load the library in R:

```r
library(MeSH.Tgo.ME49.eg.db)
# Display object summary
MeSH.Tgo.ME49.eg.db
```

### Exploring the Database Structure
Use the standard four accessor methods to understand what data is available:

- `columns(MeSH.Tgo.ME49.eg.db)`: Lists the types of data that can be retrieved (e.g., MESHID, ENTREZID, MESHCATEGORY).
- `keytypes(MeSH.Tgo.ME49.eg.db)`: Lists the types of identifiers that can be used as query keys.
- `keys(MeSH.Tgo.ME49.eg.db, keytype=...)`: Returns all keys of a specific type.

### Querying Data
The `select` function is the primary tool for retrieving mappings:

```r
# Example: Retrieve MeSH information for specific Entrez IDs
kts <- keytypes(MeSH.Tgo.ME49.eg.db)
kt <- "ENTREZID" # Or kts[2] depending on index
ks <- head(keys(MeSH.Tgo.ME49.eg.db, keytype=kt))

res <- select(MeSH.Tgo.ME49.eg.db, 
              keys = ks, 
              columns = columns(MeSH.Tgo.ME49.eg.db), 
              keytype = kt)
head(res)
```

### Database Metadata
To inspect the underlying database properties:

- `species(MeSH.Tgo.ME49.eg.db)`: Confirm the target organism (Toxoplasma gondii ME49).
- `dbInfo(MeSH.Tgo.ME49.eg.db)`: View metadata about the data sources and build version.
- `dbfile(MeSH.Tgo.ME49.eg.db)`: Get the path to the SQLite database file.

## Workflow Tips
- **Integration**: This package is often used in conjunction with `MeSHDbi` for more complex MeSH-based enrichment analyses.
- **Filtering**: When using `select`, you can filter results by specific MeSH categories (like 'D' for Drugs or 'G' for Biological Sciences) if the `MESHCATEGORY` column is included in your query.

## Reference documentation

- [MeSH.Tgo.ME49.eg.db Reference Manual](./references/reference_manual.md)