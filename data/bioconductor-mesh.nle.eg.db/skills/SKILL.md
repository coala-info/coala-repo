---
name: bioconductor-mesh.nle.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for the Northern white-cheeked gibbon. Use when user asks to perform functional annotation, conduct MeSH enrichment analysis, or map gene identifiers to medical subject headings for Nomascus leucogenys.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Nle.eg.db.html
---

# bioconductor-mesh.nle.eg.db

name: bioconductor-mesh.nle.eg.db
description: Mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Nomascus leucogenys (Northern white-cheeked gibbon). Use this skill when performing functional annotation, enrichment analysis, or cross-referencing gene identifiers with MeSH terms for this specific species.

# bioconductor-mesh.nle.eg.db

## Overview

The `MeSH.Nle.eg.db` package is a Bioconductor annotation database that provides correspondence between MeSH identifiers and Entrez Gene IDs for the species *Nomascus leucogenys* (Northern white-cheeked gibbon). It utilizes the standard `AnnotationDbi` interface, allowing users to query biological metadata using a consistent set of methods.

## Basic Usage

### Loading the Database

```r
library(MeSH.Nle.eg.db)
# Display object information
MeSH.Nle.eg.db
```

### Exploring Metadata

To understand what data types are available for querying:

```r
# List available columns to retrieve
columns(MeSH.Nle.eg.db)

# List key types that can be used as query inputs
keytypes(MeSH.Nle.eg.db)

# Check the target species
species(MeSH.Nle.eg.db)
```

### Querying the Database

Use the `select` function to map identifiers. Common keytypes include `MESHID` and `GENEID`.

```r
# 1. Get a sample of keys (e.g., Entrez Gene IDs)
pk <- head(keys(MeSH.Nle.eg.db, keytype="GENEID"))

# 2. Map Gene IDs to MeSH IDs
res <- select(MeSH.Nle.eg.db, 
              keys = pk, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")

# View results
head(res)
```

### Database Inspection

For low-level database information or connection details:

```r
dbconn(MeSH.Nle.eg.db)   # Get SQLite connection
dbfile(MeSH.Nle.eg.db)   # Get path to DB file
dbschema(MeSH.Nle.eg.db) # View table schemas
dbInfo(MeSH.Nle.eg.db)   # View metadata/source information
```

## Typical Workflow: MeSH Enrichment Analysis

1.  **Identify Genes:** Start with a list of Entrez Gene IDs from your differential expression analysis.
2.  **Map to MeSH:** Use `select()` to find associated MeSH IDs.
3.  **Analyze:** Use the mapped MeSH terms with packages like `meshr` or `MeSHSim` to perform functional enrichment or semantic similarity analysis.

## Reference documentation

- [MeSH.Nle.eg.db Manual](./references/reference_manual.md)