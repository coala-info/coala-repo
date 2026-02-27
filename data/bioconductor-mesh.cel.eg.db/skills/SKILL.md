---
name: bioconductor-mesh.cel.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for Caenorhabditis elegans. Use when user asks to map C. elegans genes to medical subject headings, perform MeSH enrichment analysis, or cross-reference gene data with biological categories.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Cel.eg.db.html
---


# bioconductor-mesh.cel.eg.db

name: bioconductor-mesh.cel.eg.db
description: Mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Caenorhabditis elegans (C. elegans). Use this skill when performing functional annotation, enrichment analysis, or cross-referencing gene data with MeSH terms in R for C. elegans research.

# bioconductor-mesh.cel.eg.db

## Overview

The `MeSH.Cel.eg.db` package is a Bioconductor annotation db-style package. It provides a standardized interface to map *Caenorhabditis elegans* Entrez Gene IDs to MeSH (Medical Subject Headings) terms. This is essential for researchers looking to associate specific genes with medical and biological concepts defined by the National Library of Medicine (NLM).

## Usage and Workflows

The package follows the standard `AnnotationDbi` interface. You interact with the `MeSH.Cel.eg.db` object using four main methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

### Loading the Package
```r
library(MeSH.Cel.eg.db)
# View object summary
MeSH.Cel.eg.db
```

### Exploring the Database Structure
Before querying, identify what data types are available:
- `keytypes(MeSH.Cel.eg.db)`: Lists the types of identifiers that can be used as query keys (e.g., "MESHID", "GENEID").
- `columns(MeSH.Cel.eg.db)`: Lists the types of data that can be retrieved.

### Querying Data
Use the `select` function to perform mappings.

```r
# 1. Define keys (e.g., first 6 Entrez Gene IDs)
kts <- keytypes(MeSH.Cel.eg.db)
ks <- head(keys(MeSH.Cel.eg.db, keytype="GENEID"))

# 2. Retrieve MeSH mappings
res <- select(MeSH.Cel.eg.db, 
              keys = ks, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")

# View results
head(res)
```

### Database Metadata
To inspect the underlying database connection and metadata:
- `species(MeSH.Cel.eg.db)`: Confirms the target organism (Caenorhabditis elegans).
- `dbInfo(MeSH.Cel.eg.db)`: Displays metadata about the data sources and versions.
- `dbfile(MeSH.Cel.eg.db)`: Shows the path to the SQLite database file.

## Tips
- **MeSH Categories**: MeSH terms are organized into categories (e.g., Anatomy [A], Diseases [C]). Use the `MESHCATEGORY` column to filter results by specific biological domains.
- **Integration**: This package is often used in conjunction with `MeSHDbi` and enrichment analysis tools like `meshr` to perform MeSH term enrichment analysis.
- **Entrez IDs**: Ensure your input keys are character vectors of Entrez Gene IDs when using `keytype="GENEID"`.

## Reference documentation
- [MeSH.Cel.eg.db Reference Manual](./references/reference_manual.md)