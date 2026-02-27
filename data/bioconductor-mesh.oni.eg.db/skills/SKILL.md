---
name: bioconductor-mesh.oni.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Oncorhynchus niis. Use when user asks to perform functional annotation, conduct gene enrichment analysis, or map biomedical literature terms to genomic data for this species.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Oni.eg.db.html
---


# bioconductor-mesh.oni.eg.db

name: bioconductor-mesh.oni.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Oncorhynchus niis (Oni). Use this skill when performing functional annotation, gene enrichment analysis, or cross-referencing biomedical literature terms with genomic data for this specific species.

# bioconductor-mesh.oni.eg.db

## Overview
The `MeSH.Oni.eg.db` package is a Bioconductor annotation data package. It serves as a bridge between the MeSH classification system and Entrez Gene identifiers for *Oncorhynchus niis*. It is built upon the `MeSHDbi` framework, allowing users to query biological metadata using standard AnnotationDbi methods.

## Workflow and Usage

### Loading the Database
To begin, load the library. The package object itself shares the name of the package.

```r
library(MeSH.Oni.eg.db)
# View object summary
MeSH.Oni.eg.db
```

### Exploring the Schema
Use the standard four accessor methods to understand what data is available:

- `columns(MeSH.Oni.eg.db)`: Lists the types of data that can be retrieved (e.g., MESHID, GENEID).
- `keytypes(MeSH.Oni.eg.db)`: Lists the types of identifiers that can be used as query keys.
- `keys(MeSH.Oni.eg.db, keytype=...)`: Retrieves all keys of a specific type.
- `select(MeSH.Oni.eg.db, keys, columns, keytype)`: Performs the actual data retrieval.

### Example: Mapping MeSH IDs to Gene IDs
```r
# 1. Identify available keytypes
kts <- keytypes(MeSH.Oni.eg.db)

# 2. Get a sample of keys (e.g., the first few MeSH IDs)
ks <- head(keys(MeSH.Oni.eg.db, keytype="MESHID"))

# 3. Retrieve corresponding Entrez Gene IDs
res <- select(MeSH.Oni.eg.db, 
              keys = ks, 
              columns = c("MESHID", "GENEID"), 
              keytype = "MESHID")
head(res)
```

### Database Metadata
You can extract underlying database information using these utility functions:
- `species(MeSH.Oni.eg.db)`: Confirm the target organism.
- `dbInfo(MeSH.Oni.eg.db)`: Get metadata about the data sources and build version.
- `dbconn(MeSH.Oni.eg.db)`: Access the underlying SQLite connection.
- `dbfile(MeSH.Oni.eg.db)`: Get the file path to the SQLite database.

## Tips
- This package is specifically for *Oncorhynchus niis*. For other species, look for the corresponding `MeSH.XXX.eg.db` package.
- The `select` function may return 1:many mappings; always check the dimensions of your output compared to your input keys.
- Ensure the `MeSHDbi` package is installed, as it provides the interface logic for this data package.

## Reference documentation
- [MeSH.Oni.eg.db Reference Manual](./references/reference_manual.md)