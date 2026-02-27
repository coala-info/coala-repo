---
name: bioconductor-mesh.syn.eg.db
description: This package provides mappings between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for functional annotation and enrichment analysis. Use when user asks to map MeSH terms to gene identifiers, perform MeSH-based enrichment analysis, or query biological relationships between literature terms and genes.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Syn.eg.db.html
---


# bioconductor-mesh.syn.eg.db

name: bioconductor-mesh.syn.eg.db
description: Mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs. Use when performing functional annotation, enrichment analysis, or cross-referencing biological literature terms with gene identifiers in R.

# bioconductor-mesh.syn.eg.db

## Overview
The `MeSH.Syn.eg.db` package is a Bioconductor annotation resource that provides a mapping between MeSH (Medical Subject Headings) IDs and Entrez Gene IDs. It implements the standard `AnnotationDbi` interface, allowing users to query biological relationships using a consistent set of accessor methods.

## Usage

### Loading the Database
Load the package to make the `MeSH.Syn.eg.db` object available in the global environment.

```r
library(MeSH.Syn.eg.db)
# Display object summary
MeSH.Syn.eg.db
```

### Exploring the Schema
Use standard accessor functions to discover what data types are available for querying.

- `columns(MeSH.Syn.eg.db)`: List the types of data that can be retrieved.
- `keytypes(MeSH.Syn.eg.db)`: List the types of identifiers that can be used as query keys.
- `keys(MeSH.Syn.eg.db, keytype="...")`: Retrieve all valid keys for a specific keytype.

### Querying Mappings
Use the `select` function to perform lookups between MeSH IDs and Entrez IDs.

```r
# Example: Mapping Entrez IDs to MeSH IDs
my_keys <- head(keys(MeSH.Syn.eg.db, keytype="GENEID"))
res <- select(MeSH.Syn.eg.db, 
              keys = my_keys, 
              columns = c("MESHID", "GENEID"), 
              keytype = "GENEID")
head(res)
```

### Database Metadata
Access underlying database information and species context.

- `species(MeSH.Syn.eg.db)`: Identify the organism associated with the mappings.
- `dbInfo(MeSH.Syn.eg.db)`: View metadata about the data sources and versions.
- `dbconn(MeSH.Syn.eg.db)`: Access the underlying SQLite connection.
- `dbfile(MeSH.Syn.eg.db)`: Get the path to the SQLite database file.

## Workflow Tips
- **Integration**: This package is often used in conjunction with `MeSHDbi` for more complex MeSH-based enrichment workflows.
- **Key Selection**: Always verify the available `keytypes` before running a `select` query, as the available identifiers may vary between Bioconductor releases.
- **Data Frames**: The output of `select` is a standard R data frame, which can be easily integrated into tidyverse or base R downstream analyses.

## Reference documentation
- [MeSH.Syn.eg.db Reference Manual](./references/reference_manual.md)