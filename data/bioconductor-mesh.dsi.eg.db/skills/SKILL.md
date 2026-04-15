---
name: bioconductor-mesh.dsi.eg.db
description: This tool provides mappings between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs using the MeSH.Dsi.eg.db annotation package. Use when user asks to map MeSH terms to NCBI Entrez Gene identifiers, query disease-subject interaction data, or perform functional gene annotation in R.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Dsi.eg.db.html
---

# bioconductor-mesh.dsi.eg.db

name: bioconductor-mesh.dsi.eg.db
description: Access and query the MeSH.Dsi.eg.db annotation package for mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs. Use this skill when performing bioinformatics analysis in R that requires translating between MeSH terms and NCBI Entrez Gene identifiers, specifically for data related to "Dsi" (likely referring to specific disease-subject interactions or datasets).

## Overview

The `MeSH.Dsi.eg.db` package is a Bioconductor annotation resource that provides a mapping between MeSH IDs and Entrez Gene IDs. It is built upon the `AnnotationDbi` framework, meaning it uses a standard set of accessor methods (`columns`, `keytypes`, `keys`, and `select`) to query the underlying database. This package is essential for researchers looking to link functional gene data with standardized medical subject headings for enrichment analysis or literature-based data integration.

## Basic Usage

To use this package, you must first load it into your R session. The package object itself shares the name of the package.

```R
library(MeSH.Dsi.eg.db)

# View the object summary
MeSH.Dsi.eg.db
```

### Exploring the Database Structure

Before querying, identify what types of data (columns) and identifiers (keytypes) are available.

```R
# List available columns
cls <- columns(MeSH.Dsi.eg.db)

# List available keytypes (searchable fields)
kts <- keytypes(MeSH.Dsi.eg.db)
```

### Querying Data

Use the `select` function to retrieve mappings. You typically provide the keys you have, the keytype they represent, and the columns you wish to retrieve.

```R
# Get the first few keys of a specific keytype
ks <- head(keys(MeSH.Dsi.eg.db, keytype = "MESHID"))

# Perform a join/lookup
res <- select(MeSH.Dsi.eg.db, 
              keys = ks, 
              columns = c("MESHID", "GENEID"), 
              keytype = "MESHID")

# View results
head(res)
```

### Database Metadata

You can extract metadata about the underlying SQLite database using standard AnnotationDbi metadata functions:

```R
# Get species information
species(MeSH.Dsi.eg.db)

# Get database connection details
dbconn(MeSH.Dsi.eg.db)

# Get the file path to the SQLite database
dbfile(MeSH.Dsi.eg.db)

# Get the database schema
dbschema(MeSH.Dsi.eg.db)
```

## Workflow Tips

1.  **Standard Accessors**: Since this package follows the `AnnotationDbi` interface, it integrates seamlessly with other Bioconductor workflows.
2.  **MeSH Context**: This specific "Dsi" version of the MeSH database is often used in the context of specific disease-gene associations. Ensure your input IDs match the expected format (e.g., "D000001" for MeSH or integer strings for Entrez Gene).
3.  **Vectorized Queries**: The `select` function is vectorized; you can pass a large vector of IDs to `keys` for efficient batch processing.

## Reference documentation

- [MeSH.Dsi.eg.db Reference Manual](./references/reference_manual.md)