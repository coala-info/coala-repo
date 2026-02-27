---
name: bioconductor-mesh.spu.eg.db
description: This Bioconductor package provides mappings between MeSH identifiers and Entrez Gene IDs for the species Strongylocentrotus purpuratus. Use when user asks to map MeSH terms to gene identifiers, perform functional annotation, or conduct gene set enrichment analysis for the purple sea urchin.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Spu.eg.db.html
---


# bioconductor-mesh.spu.eg.db

name: bioconductor-mesh.spu.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Strongylocentrotus purpuratus (Purple Sea Urchin). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological concepts with gene data for this specific species using Bioconductor.

# bioconductor-mesh.spu.eg.db

## Overview

`MeSH.Spu.eg.db` is a specialized Bioconductor annotation package. It serves as a bridge between the MeSH hierarchical vocabulary and Entrez Gene identifiers for the species *Strongylocentrotus purpuratus*. It is built upon the `MeSHDbi` framework, allowing users to query biological context associated with specific genes or find genes associated with specific medical/biological headings.

## Core Workflows

### Loading the Package
```r
library(MeSH.Spu.eg.db)
# View basic object information
MeSH.Spu.eg.db
```

### Exploring the Database Structure
Use the standard `AnnotationDbi` interface to understand what data is available:

```r
# List available data types (e.g., MESHID, GENEID, MESHCATEGORY)
cls <- columns(MeSH.Spu.eg.db)

# List types of keys that can be used for filtering
kts <- keytypes(MeSH.Spu.eg.db)

# Retrieve a sample of keys for a specific keytype
ks <- head(keys(MeSH.Spu.eg.db, keytype = "MESHID"))
```

### Querying Annotations
The `select` function is the primary tool for retrieving mappings:

```r
# Map MeSH IDs to Entrez Gene IDs
res <- select(MeSH.Spu.eg.db, 
              keys = ks, 
              columns = c("MESHID", "GENEID"), 
              keytype = "MESHID")

# View results
head(res)
```

### Database Metadata
To inspect the underlying database properties:

```r
species(MeSH.Spu.eg.db)  # Confirm species (Strongylocentrotus purpuratus)
dbInfo(MeSH.Spu.eg.db)   # Get package metadata and data sources
dbfile(MeSH.Spu.eg.db)   # Locate the SQLite database file
dbschema(MeSH.Spu.eg.db) # View the database schema
```

## Usage Tips
- **Keytypes**: Common keytypes include `GENEID` (Entrez) and `MESHID`.
- **MeSH Categories**: You can filter or select by `MESHCATEGORY` to narrow down results to specific branches of the MeSH hierarchy (e.g., Diseases, Chemicals and Drugs).
- **Integration**: This package is often used in conjunction with `MeSHSim` for semantic similarity analysis or `meshr` for enrichment analysis.

## Reference documentation

- [MeSH.Spu.eg.db Reference Manual](./references/reference_manual.md)