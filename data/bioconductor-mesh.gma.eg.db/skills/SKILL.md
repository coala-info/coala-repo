---
name: bioconductor-mesh.gma.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Glycine max (Soybean). Use when user asks to perform functional annotation, enrichment analysis, or ID conversion between MeSH terms and soybean genes.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Gma.eg.db.html
---


# bioconductor-mesh.gma.eg.db

name: bioconductor-mesh.gma.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Glycine max (Soybean). Use this skill when performing functional annotation, enrichment analysis, or ID conversion for soybean genomic data using Bioconductor's MeSHDbi framework.

# bioconductor-mesh.gma.eg.db

## Overview

The `MeSH.Gma.eg.db` package is a specialized annotation database for *Glycine max* (Soybean). It facilitates the correspondence between Entrez Gene IDs and MeSH terms. This allows researchers to leverage the Medical Subject Headings hierarchy for functional characterization of soybean genes, providing an alternative or complement to Gene Ontology (GO) annotations.

## Basic Usage

### Loading the Database
To begin using the annotation data, load the library:

```r
library(MeSH.Gma.eg.db)
# Display object summary
MeSH.Gma.eg.db
```

### Exploring Metadata
Use these functions to inspect the database properties:

*   `species(MeSH.Gma.eg.db)`: Confirm the target organism (Glycine max).
*   `dbInfo(MeSH.Gma.eg.db)`: View database metadata and source information.
*   `keytypes(MeSH.Gma.eg.db)`: List the types of identifiers that can be used as query keys (e.g., "MESHID", "GENEID").
*   `columns(MeSH.Gma.eg.db)`: List the types of data that can be retrieved.

### Querying the Database
The package follows the standard `AnnotationDbi` interface using `keys`, `columns`, and `select`.

```r
# 1. Identify available keytypes
kts <- keytypes(MeSH.Gma.eg.db)

# 2. Retrieve a sample of keys (e.g., Entrez Gene IDs)
ks <- head(keys(MeSH.Gma.eg.db, keytype="GENEID"))

# 3. Perform a mapping to MeSH IDs and Categories
res <- select(MeSH.Gma.eg.db, 
              keys = ks, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")

# View results
head(res)
```

## Typical Workflow: ID Conversion

When you have a list of soybean Entrez Gene IDs and want to find associated MeSH terms:

1.  Define your gene list as a character vector.
2.  Use `select()` with `keytype="GENEID"`.
3.  Specify `columns=c("MESHID", "MESHCATEGORY")` to see the specific MeSH terms and their broad classifications (e.g., Anatomy, Diseases, Chemicals and Drugs).

## Database Maintenance
To check the underlying database file location or schema:
*   `dbfile(MeSH.Gma.eg.db)`
*   `dbschema(MeSH.Gma.eg.db)`

## Reference documentation

- [MeSH.Gma.eg.db Reference Manual](./references/reference_manual.md)