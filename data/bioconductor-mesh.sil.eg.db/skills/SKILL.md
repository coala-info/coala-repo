---
name: bioconductor-mesh.sil.eg.db
description: This package provides mappings between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for the species associated with the database. Use when user asks to map gene identifiers to MeSH terms, perform functional annotation, or conduct MeSH-based enrichment analysis in R.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Sil.eg.db.html
---


# bioconductor-mesh.sil.eg.db

name: bioconductor-mesh.sil.eg.db
description: Mapping between MeSH identifiers and Entrez Gene IDs for the species associated with the MeSH.Sil.eg.db package. Use when performing functional annotation, enrichment analysis, or ID conversion involving Medical Subject Headings (MeSH) and gene identifiers in R.

# bioconductor-mesh.sil.eg.db

## Overview
MeSH.Sil.eg.db is a Bioconductor annotation package that provides a mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs. It is built upon the AnnotationDbi framework, allowing for standardized data retrieval using a common set of methods. This package is essential for researchers working with the specific organism (Sil) who need to link genetic data to clinical and biological descriptors defined by MeSH.

## Basic Usage

### Loading the Package
Load the library to make the annotation object available in the R environment.
```r
library(MeSH.Sil.eg.db)
# View the object summary
MeSH.Sil.eg.db
```

### Exploring Available Data
Use the standard AnnotationDbi methods to discover what data types are available for querying.
```r
# List available columns (data types) to retrieve
columns(MeSH.Sil.eg.db)

# List available keytypes (fields that can be used as input)
keytypes(MeSH.Sil.eg.db)

# Retrieve a sample of keys for a specific keytype
head(keys(MeSH.Sil.eg.db, keytype="MESHID"))
```

### Retrieving Mappings
Use the `select` function to map between identifiers.
```r
# Example: Map Entrez Gene IDs to MeSH IDs
gene_ids <- head(keys(MeSH.Sil.eg.db, keytype="GENEID"))
select(MeSH.Sil.eg.db, 
       keys = gene_ids, 
       columns = c("MESHID", "MESHCATEGORY"), 
       keytype = "GENEID")
```

### Database Metadata
Access administrative and versioning information about the underlying database.
```r
# Check the species name
species(MeSH.Sil.eg.db)

# Get database metadata
dbInfo(MeSH.Sil.eg.db)

# Get the underlying SQLite file path or connection
dbfile(MeSH.Sil.eg.db)
dbconn(MeSH.Sil.eg.db)
```

## Workflow Tips
- **Integration**: Combine results from `select()` with differential expression results using `merge()` or `dplyr::left_join()`.
- **MeSH Enrichment**: Use this package as a backend for enrichment analysis tools (like `meshr`) to identify overrepresented MeSH terms in gene lists.
- **Consistency**: Ensure that the `keytype` argument in `select()` matches the format of your input `keys`.

## Reference documentation
- [MeSH.Sil.eg.db Reference Manual](./references/reference_manual.md)