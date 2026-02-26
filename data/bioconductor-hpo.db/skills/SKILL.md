---
name: bioconductor-hpo.db
description: This Bioconductor package provides a comprehensive annotation resource for navigating and querying the Human Phenotype Ontology (HPO) as a directed acyclic graph. Use when user asks to retrieve phenotype term information, find synonyms or aliases for HPO IDs, and traverse the ontology hierarchy to identify parents, children, ancestors, or offspring.
homepage: https://bioconductor.org/packages/release/data/annotation/html/HPO.db.html
---


# bioconductor-hpo.db

## Overview

The `HPO.db` package is a Bioconductor annotation resource that provides a consistent description of human phenotypes. It is designed to replace older, stagnant resources like `DO.db` for disease-related ontology work. It structures HPO data as a directed acyclic graph (DAG), allowing users to navigate the relationships between clinical terms.

## Core Workflows

### Loading the Package
```r
library(HPO.db)
library(AnnotationDbi)
```

### Exploring Available Data
You can list all available maps and metadata within the package:
```r
ls("package:HPO.db")
toTable(HPOmetadata)
HPOMAPCOUNTS # View record counts for each mapping
```

### Retrieving Term Information
Use `HPOTERM` to get the primary names of HPO IDs, and `HPOALIAS` or `HPOSYNONYM` for alternative identifiers.
```r
# Convert to data.frame
doterm <- toTable(HPOTERM)

# Get specific term details
dotermlist <- as.list(HPOTERM)
dotermlist[['HP:0000006']]

# Find aliases and synonyms
as.list(HPOALIAS)[['HP:0000006']]
as.list(HPOSYNONYM)[['HP:0000006']]
```

### Navigating the Ontology Hierarchy
The package provides four main Bimap objects to traverse the DAG:
*   `HPOANCESTOR`: All nodes above the term in the hierarchy.
*   `HPOPARENTS`: Immediate parent nodes.
*   `HPOOFFSPRING`: All nodes below the term in the hierarchy.
*   `HPOCHILDREN`: Immediate child nodes.

```r
# Get direct parents
parents <- as.list(HPOPARENTS)[["HP:0000006"]]

# Get all ancestors (recursive)
ancestors <- as.list(HPOANCESTOR)[["HP:0000006"]]

# Get direct children
children <- as.list(HPOCHILDREN)[["HP:0000002"]]
```

### Using the Select Interface
`HPO.db` supports the standard `AnnotationDbi` interface for complex queries.
```r
# Check available columns and keytypes
columns(HPO.db)
keytypes(HPO.db)

# Query specific terms for multiple attributes
res <- select(x = HPO.db, 
              keys = c("HP:0000001", "HP:0000002"), 
              keytype = "hpoid", 
              columns = c("term", "parent", "offspring"))
```

## Tips for Success
*   **Data Frames vs Lists**: Use `toTable()` for bulk processing and `as.list()` for quick lookups of specific IDs.
*   **Namespace Conflicts**: If `select` or `as.list` behave unexpectedly, use the explicit namespace: `AnnotationDbi::select()`.
*   **Integration**: This package is often used as a backend for `DOSE` or `clusterProfiler` for enrichment analysis.

## Reference documentation
- [HPO_vignette](./references/HPO_vignette.md)
- [HPO_vignette.Rmd](./references/HPO_vignette.Rmd)