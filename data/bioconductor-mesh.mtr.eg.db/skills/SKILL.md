---
name: bioconductor-mesh.mtr.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for the organism Medicago truncatula. Use when user asks to perform functional annotation, conduct MeSH enrichment analysis, or map gene identifiers to medical subject headings for Barrel Medic.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Mtr.eg.db.html
---

# bioconductor-mesh.mtr.eg.db

name: bioconductor-mesh.mtr.eg.db
description: Mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Medicago truncatula (Barrel Medic). Use this skill when performing functional annotation, enrichment analysis, or gene-to-term mapping specifically for Medicago truncatula using Bioconductor's AnnotationDbi interface.

## Overview

The `MeSH.Mtr.eg.db` package is a specialized annotation database for *Medicago truncatula*. It provides a bridge between biological identifiers (Entrez Gene IDs) and the Medical Subject Headings (MeSH) hierarchy. This allows researchers to categorize gene sets into functional groups based on the MeSH classification system, which covers diseases, chemicals, drugs, and biological concepts.

The package implements the standard `AnnotationDbi` interface, making it compatible with common R workflows for genomic data analysis.

## Core Workflows

### Loading the Database
To begin using the mapping data, load the library. The database object itself shares the name of the package.

```r
library(MeSH.Mtr.eg.db)
# View object summary
MeSH.Mtr.eg.db
```

### Exploring Available Data
Use the standard four accessor methods to understand the structure of the database:

- `columns()`: Lists the types of data that can be retrieved.
- `keytypes()`: Lists the types of identifiers that can be used as input for queries.
- `keys()`: Returns all possible values for a specific keytype.
- `select()`: Performs the actual data retrieval.

```r
# Check available columns and keytypes
columns(MeSH.Mtr.eg.db)
keytypes(MeSH.Mtr.eg.db)

# Get the first few Entrez Gene IDs available
gene_keys <- head(keys(MeSH.Mtr.eg.db, keytype="GENEID"))
```

### Mapping Identifiers
To map Entrez Gene IDs to MeSH IDs (or vice versa), use the `select` function.

```r
# Map specific Gene IDs to MeSH terms and categories
res <- select(MeSH.Mtr.eg.db, 
              keys = gene_keys, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")

# View results
head(res)
```

### Database Metadata
You can extract metadata about the database version, species, and underlying file structure using these utility functions:

```r
species(MeSH.Mtr.eg.db)
dbInfo(MeSH.Mtr.eg.db)
dbfile(MeSH.Mtr.eg.db)
```

## Usage Tips
- **Entrez IDs**: This package primarily uses Entrez Gene IDs. If you have other identifiers (like Locus Tags or Transcript IDs), use a primary organism annotation package (like `org.Mtr.eg.db`) to convert them to Entrez IDs first.
- **MeSH Hierarchy**: MeSH IDs are organized into categories (e.g., A for Anatomy, G for Phenomena and Processes). Use the `MESHCATEGORY` column to filter results to specific areas of interest.
- **Integration**: This package is often used in conjunction with `MeSHDbi` and `meshr` for formal MeSH enrichment analysis.

## Reference documentation
- [MeSH.Mtr.eg.db Reference Manual](./references/reference_manual.md)