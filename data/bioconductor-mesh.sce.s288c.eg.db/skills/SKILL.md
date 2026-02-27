---
name: bioconductor-mesh.sce.s288c.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for Saccharomyces cerevisiae strain S288c. Use when user asks to perform MeSH enrichment analysis, map yeast genes to medical subject headings, or convert between Entrez Gene IDs and MeSH terms.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Sce.S288c.eg.db.html
---


# bioconductor-mesh.sce.s288c.eg.db

name: bioconductor-mesh.sce.s288c.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Saccharomyces cerevisiae (S288c). Use this skill when performing functional annotation, enrichment analysis, or identifier conversion for yeast genomic data using Bioconductor.

# bioconductor-mesh.sce.s288c.eg.db

## Overview

The `MeSH.Sce.S288c.eg.db` package is a specialized annotation database for *Saccharomyces cerevisiae* (strain S288c). It facilitates the integration of MeSH terms—a hierarchical controlled vocabulary used for indexing biomedical literature—with NCBI Entrez Gene identifiers. This allows researchers to associate yeast genes with specific biological concepts, diseases, or chemical categories defined in the MeSH system.

The package follows the standard `AnnotationDbi` interface, making it compatible with common Bioconductor workflows.

## Basic Usage

### Loading the Database
```r
library(MeSH.Sce.S288c.eg.db)
# View object summary
MeSH.Sce.S288c.eg.db
```

### Exploring the Schema
Use the standard four accessor methods to understand available data:
- `columns(MeSH.Sce.S288c.eg.db)`: Lists the types of data that can be retrieved (e.g., MESHID, GENEID).
- `keytypes(MeSH.Sce.S288c.eg.db)`: Lists the types of identifiers that can be used as query keys.
- `keys(MeSH.Sce.S288c.eg.db, keytype=...)`: Returns all identifiers of a specific type.

### Querying the Database
The `select` function is the primary tool for retrieving data:
```r
# Example: Retrieve MeSH IDs for specific Entrez Gene IDs
ks <- head(keys(MeSH.Sce.S288c.eg.db, keytype="GENEID"))
res <- select(MeSH.Sce.S288c.eg.db, 
              keys = ks, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")
head(res)
```

## Database Metadata
You can extract administrative and versioning information using these utility functions:
- `species(MeSH.Sce.S288c.eg.db)`: Confirms the target organism (Saccharomyces cerevisiae).
- `dbInfo(MeSH.Sce.S288c.eg.db)`: Displays metadata about the source data and package version.
- `dbfile(MeSH.Sce.S288c.eg.db)`: Shows the path to the underlying SQLite database file.

## Workflow Integration
This package is typically used in conjunction with the `MeSHDbi` and `meshr` packages. While `MeSH.Sce.S288c.eg.db` provides the raw mappings, `meshr` is used to perform MeSH enrichment analysis (similar to GO enrichment) to identify overrepresented biological themes in a list of yeast genes.

## Reference documentation
- [MeSH.Sce.S288c.eg.db Reference Manual](./references/reference_manual.md)