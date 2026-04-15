---
name: bioconductor-mesh.tgu.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for the Zebra Finch species. Use when user asks to map MeSH terms to Zebra Finch genes, perform functional annotation, or conduct gene set enrichment analysis using MeSH identifiers.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Tgu.eg.db.html
---

# bioconductor-mesh.tgu.eg.db

name: bioconductor-mesh.tgu.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Taeniopygia guttata (Zebra Finch). Use this skill when performing functional annotation, gene set enrichment analysis, or data integration involving MeSH terms and Zebra Finch genomic data in R.

# bioconductor-mesh.tgu.eg.db

## Overview
The `MeSH.Tgu.eg.db` package is a Bioconductor annotation database that facilitates the conversion and mapping between MeSH identifiers and Entrez Gene IDs for the species *Taeniopygia guttata* (Zebra Finch). It is built upon the `MeSHDbi` framework, allowing users to query biological metadata using standard AnnotationDbi methods.

## R Usage and Workflows

### Loading the Database
To begin, load the library. The database object itself shares the name of the package.

```r
library(MeSH.Tgu.eg.db)
# View basic information about the database
MeSH.Tgu.eg.db
```

### Exploring the Database Structure
Use the standard four accessor methods to understand what data is available:

*   `columns(MeSH.Tgu.eg.db)`: Lists the types of data that can be retrieved.
*   `keytypes(MeSH.Tgu.eg.db)`: Lists the types of identifiers that can be used as keys for querying.
*   `keys(MeSH.Tgu.eg.db, keytype=...)`: Retrieves all keys of a specific type.

```r
# List available columns and keytypes
cls <- columns(MeSH.Tgu.eg.db)
kts <- keytypes(MeSH.Tgu.eg.db)

# Get the first few Entrez Gene IDs
gene_keys <- head(keys(MeSH.Tgu.eg.db, keytype="GENEID"))
```

### Retrieving Mappings (select)
The `select` function is the primary tool for mapping between identifiers.

```r
# Map Entrez Gene IDs to MeSH IDs
res <- select(MeSH.Tgu.eg.db, 
              keys = gene_keys, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")
head(res)
```

### Database Metadata
You can extract specific metadata about the underlying SQLite database:

```r
species(MeSH.Tgu.eg.db)   # Confirm species (Taeniopygia guttata)
dbInfo(MeSH.Tgu.eg.db)    # Database source information
dbfile(MeSH.Tgu.eg.db)    # Path to the SQLite file
dbschema(MeSH.Tgu.eg.db)  # Database schema structure
```

## Tips
*   **MeSHDbi Requirement**: This package depends on the `MeSHDbi` interface. Ensure it is installed to use the accessor methods effectively.
*   **Entrez Focus**: The "eg" in the package name signifies that the primary gene identifier used is the Entrez Gene ID.
*   **Integration**: This package is typically used in conjunction with enrichment analysis tools (like `meshr`) to determine if specific MeSH terms are overrepresented in a list of Zebra Finch genes.

## Reference documentation
- [MeSH.Tgu.eg.db Reference Manual](./references/reference_manual.md)