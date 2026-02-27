---
name: bioconductor-panther.db
description: This tool provides a Bioconductor interface to access and query the PANTHER Classification System for gene functional annotation and ontology mapping. Use when user asks to map gene identifiers to PANTHER families, retrieve pathway or GO-slim terms, or traverse the protein class ontology tree.
homepage: https://bioconductor.org/packages/release/data/annotation/html/PANTHER.db.html
---


# bioconductor-panther.db

name: bioconductor-panther.db
description: Access and query the PANTHER Classification System via the PANTHER.db Bioconductor package. Use this skill to map gene identifiers (Entrez, Uniprot) to PANTHER families, subfamilies, pathways, and GO-slim terms, or to explore the PANTHER Protein Class ontology tree.

# bioconductor-panther.db

## Overview
The `PANTHER.db` package is an annotation resource that provides a `select` interface to the PANTHER (Protein ANalysis THrough Evolutionary Relationships) Classification System. It allows users to map gene identifiers to functional classifications, including pathways and protein classes, across over 100 organisms.

## Installation and Setup
The package requires a large SQLite database (approx. 500MB) which must be downloaded via `AnnotationHub`.

```r
library(AnnotationHub)
library(PANTHER.db)

# Initial download (only needed once)
ah <- AnnotationHub()
query(ah, "PANTHER.db")[[1]]
```

## Core Workflows

### 1. Organism Management
By default, `PANTHER.db` queries across all supported organisms. It is highly recommended to restrict the scope to your organism of interest.

```r
# List supported organisms and their taxonomy IDs
availablePthOrganisms(PANTHER.db)

# Set organism to Human
pthOrganisms(PANTHER.db) <- "HUMAN"

# Reset to all organisms
resetPthOrganisms(PANTHER.db)
```

### 2. Querying Data
Use the standard `AnnotationDbi` interface (`columns`, `keytypes`, `keys`, and `select`) to retrieve data.

```r
# View available data types
columns(PANTHER.db)
# [1] "CLASS_ID" "CLASS_TERM" "ENTREZ" "FAMILY_ID" "PATHWAY_TERM" "GOSLIM_ID" ...

# View searchable keys
keytypes(PANTHER.db)

# Perform a query
res <- select(PANTHER.db, 
              keys = c("P00533", "P04637"), 
              columns = c("FAMILY_ID", "PATHWAY_TERM", "GOSLIM_TERM"), 
              keytype = "UNIPROT")
```

### 3. Join Types
The `select` function supports a `jointype` argument:
- `inner` (default): Returns only rows with an associated PANTHER family ID.
- `left`: Returns all results for the provided keys, even if they lack a PANTHER family mapping.

```r
res <- select(PANTHER.db, keys = my_keys, columns = "CLASS_ID", jointype = "left")
```

### 4. Traversing the Protein Class Ontology
The package provides a specific method to navigate the hierarchical structure of PANTHER Protein Classes.

```r
term <- "PC00209" # Example Class ID

# Get related terms
parents <- traverseClassTree(PANTHER.db, term, scope = "PARENT")
children <- traverseClassTree(PANTHER.db, term, scope = "CHILD")
ancestors <- traverseClassTree(PANTHER.db, term, scope = "ANCESTOR")
offspring <- traverseClassTree(PANTHER.db, term, scope = "OFFSPRING")

# Look up terms for the IDs found
select(PANTHER.db, keys = ancestors, columns = "CLASS_TERM", keytype = "CLASS_ID")
```

## Tips
- **Memory**: The database is large; ensure you have sufficient RAM when performing broad queries across multiple organisms.
- **Mapping**: Use `mapIds` for a 1:1 mapping (e.g., getting the primary Pathway for a list of genes) and `select` for 1:many mappings.
- **Identifiers**: The package is particularly useful for bridging Uniprot and Entrez IDs within the context of PANTHER classifications.

## Reference documentation
- [PANTHER.db vignette](./references/PANTHER.db.md)