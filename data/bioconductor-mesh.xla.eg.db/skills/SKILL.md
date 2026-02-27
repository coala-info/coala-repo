---
name: bioconductor-mesh.xla.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for the species Xenopus laevis. Use when user asks to perform functional annotation, conduct gene enrichment analysis, or map biological concepts to gene data for the African clawed frog.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Xla.eg.db.html
---


# bioconductor-mesh.xla.eg.db

name: bioconductor-mesh.xla.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Xenopus laevis (African clawed frog). Use this skill when performing functional annotation, gene enrichment analysis, or cross-referencing biological concepts with gene data for Xenopus laevis using Bioconductor.

## Overview

The `MeSH.Xla.eg.db` package is a specialized annotation database for *Xenopus laevis*. It belongs to the MeSHDb suite of packages and follows the standard `AnnotationDbi` interface. It allows researchers to map between Entrez Gene IDs and MeSH terms, which are hierarchical controlled vocabularies used for indexing biological and medical information.

## Core Functions and Usage

The package uses the standard four accessor methods common to Bioconductor annotation objects: `columns`, `keytypes`, `keys`, and `select`.

### Loading the Database
```r
library(MeSH.Xla.eg.db)
# View object summary
MeSH.Xla.eg.db
```

### Exploring the Schema
Before querying, identify what data types are available:
```r
# List available columns to retrieve
columns(MeSH.Xla.eg.db)

# List available keytypes to search by (e.g., "MESHID", "GENEID")
keytypes(MeSH.Xla.eg.db)
```

### Querying Data
Use `select` to perform mappings. This is the primary workflow for converting IDs.

```r
# Example: Mapping Entrez Gene IDs to MeSH IDs
# 1. Get some sample keys
pk_keys <- head(keys(MeSH.Xla.eg.db, keytype="GENEID"))

# 2. Retrieve corresponding MeSH information
results <- select(MeSH.Xla.eg.db, 
                  keys = pk_keys, 
                  columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
                  keytype = "GENEID")

head(results)
```

### Database Metadata
To inspect the underlying database structure or species information:
```r
species(MeSH.Xla.eg.db)
dbInfo(MeSH.Xla.eg.db)
dbfile(MeSH.Xla.eg.db)
```

## Typical Workflow: Gene to MeSH Mapping

1. **Identify Input**: Start with a list of *Xenopus laevis* Entrez Gene IDs.
2. **Verify Keytype**: Ensure "GENEID" is a valid keytype using `keytypes()`.
3. **Select Columns**: Choose "MESHID" to get the identifiers or other metadata columns.
4. **Execute**: Run `select()` to generate the mapping table.
5. **Integrate**: Use the resulting data frame for downstream enrichment analysis (often using the `meshr` package).

## Tips
- This package is specifically for *Xenopus laevis*. For other species, use the corresponding `MeSH.XXX.eg.db` package.
- If you need more detailed information on the MeSH terms themselves (like the term names), you may need to use the `MeSH.db` general purpose package in conjunction with this species-specific mapping.
- The `SOURCEID` column typically refers to the Entrez Gene ID, while `MESHID` refers to the Medical Subject Heading identifier.

## Reference documentation
- [MeSH.Xla.eg.db Reference Manual](./references/reference_manual.md)