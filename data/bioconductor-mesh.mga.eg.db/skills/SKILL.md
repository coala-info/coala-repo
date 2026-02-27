---
name: bioconductor-mesh.mga.eg.db
description: This package provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Mus gallogallo (Chicken). Use when user asks to map MeSH terms to chicken gene identifiers, perform functional annotation, or conduct gene set enrichment analysis using Bioconductor.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Mga.eg.db.html
---


# bioconductor-mesh.mga.eg.db

name: bioconductor-mesh.mga.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Mus gallogallo (Chicken). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for chicken models using Bioconductor.

## Overview

The `MeSH.Mga.eg.db` package is an AnnotationDbi-based resource that facilitates the correspondence between MeSH terms and Entrez Gene identifiers. It is part of the MeSH-related annotation infrastructure in Bioconductor, allowing researchers to link specific genes to standardized medical and biological headings.

## Core Workflow

### Loading the Package
To begin using the annotation database, load the library in R:

```R
library(MeSH.Mga.eg.db)
# View object summary
MeSH.Mga.eg.db
```

### Exploring the Database
Use the standard AnnotationDbi interface to explore available data types:

```R
# List available columns (data types to retrieve)
cls <- columns(MeSH.Mga.eg.db)

# List available keytypes (fields used as input keys)
kts <- keytypes(MeSH.Mga.eg.db)

# Retrieve a sample of keys for a specific keytype
ks <- head(keys(MeSH.Mga.eg.db, keytype = "MESHID"))
```

### Retrieving Mappings
Use the `select` function to map between identifiers:

```R
# Example: Map MeSH IDs to Entrez Gene IDs
res <- select(MeSH.Mga.eg.db, 
              keys = ks, 
              columns = c("MESHID", "GENEID"), 
              keytype = "MESHID")
head(res)
```

### Database Metadata
To inspect the underlying database structure and species information:

```R
species(MeSH.Mga.eg.db)
dbconn(MeSH.Mga.eg.db)
dbfile(MeSH.Mga.eg.db)
dbschema(MeSH.Mga.eg.db)
```

## Usage Tips
- **Keytypes**: Common keytypes include `MESHID` and `GENEID`.
- **Integration**: This package is designed to work seamlessly with `MeSHDbi`. For advanced queries or enrichment analysis, ensure `MeSHDbi` is also installed.
- **Species Specificity**: This specific package is curated for *Mus gallogallo* (Chicken). Ensure your gene identifiers are Entrez IDs for this species.

## Reference documentation

- [MeSH.Mga.eg.db Manual](./references/reference_manual.md)