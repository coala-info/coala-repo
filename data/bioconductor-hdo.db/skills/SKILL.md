---
name: bioconductor-hdo.db
description: This package provides a Bioconductor annotation suite for the Human Disease Ontology to access disease terms, hierarchical relationships, and gene mappings in R. Use when user asks to retrieve disease metadata, navigate the ontology hierarchy, map diseases to genes, or perform disease enrichment analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/HDO.db.html
---


# bioconductor-hdo.db

name: bioconductor-hdo.db
description: Use this skill when working with the Human Disease Ontology (HDO) in R. It provides access to disease terms, their hierarchical relationships (parents, children, ancestors, offspring), aliases, synonyms, and mappings to genes or Network of Cancer Genes (NCG) IDs. Essential for disease enrichment analysis and functional genomics.

# bioconductor-hdo.db

## Overview

The `HDO.db` package is a Bioconductor annotation suite for the Human Disease Ontology (HDO). It serves as a modern replacement for the older `DO.db` package, providing updated semantic information and relationships between disease terms. It is primarily used to support functional genomics, semantic similarity analysis, and disease enrichment analysis (often in conjunction with the `DOSE` package).

## Core Workflows

### Loading the Package
```r
library(HDO.db)
library(AnnotationDbi)
```

### Exploring Disease Terms
Use `HDOTERM` to access the full list of DO IDs and their primary names.
- **Convert to table**: `toTable(HDOTERM)`
- **Convert to list**: `as.list(HDOTERM)`
- **Find Aliases**: `as.list(HDOALIAS)[['DOID:XXXX']]`
- **Find Synonyms**: `as.list(HDOSYNONYM)[['DOID:XXXX']]`

### Navigating the Ontology Hierarchy
The package provides four main Bimap objects to traverse the Directed Acyclic Graph (DAG) of the ontology:
- **Ancestors**: `HDOANCESTOR` (all nodes above a term)
- **Parents**: `HDOPARENTS` (direct parents only)
- **Offspring**: `HDOOFFSPRING` (all nodes below a term)
- **Children**: `HDOCHILDREN` (direct children only)

Example usage:
```r
# Get direct parents of a specific term
parents <- AnnotationDbi::as.list(HDOPARENTS)[["DOID:0001816"]]

# Get all offspring of a term
offspring <- AnnotationDbi::as.list(HDOOFFSPRING)[["DOID:0001816"]]
```

### Gene and NCG Mappings
- **Disease to Gene**: `HDOGENE` maps DO IDs to Entrez Gene IDs (based on Alliance of Genome Resources).
- **Gene to NCG**: `HDOGENENCG` maps Gene IDs to cancer types based on the Network of Cancer Genes (NCG).

```r
# Get genes associated with a disease
genes <- AnnotationDbi::as.list(HDOGENE)[["DOID:0001816"]]

# Get NCG cancer types for a gene ID
ncg_info <- AnnotationDbi::as.list(HDOGENENCG)[["60"]]
```

### Using the Select Interface
`HDO.db` supports the standard `AnnotationDbi` interface for flexible querying.

- **Check available columns**: `columns(HDO.db)` (e.g., "alias", "ancestor", "gene", "term", "parent")
- **Check keytypes**: `keytypes(HDO.db)` (e.g., "doid", "term", "gene")
- **Query data**:
```r
res <- select(HDO.db, 
              keys = c("angiosarcoma", "pterygium"), 
              keytype = "term", 
              columns = c("doid", "parent", "gene"))
```

## Tips
- Use `toTable()` for a quick overview of a mapping in data frame format.
- When performing enrichment analysis, `HDO.db` is the backend data source; use it to verify specific term relationships or gene associations found in your results.
- The `HDOmetadata` object contains versioning and source information for the underlying ontology data.

## Reference documentation
- [HDO_vignette](./references/HDO_vignette.md)
- [HDO_vignette R Source](./references/HDO_vignette.Rmd)