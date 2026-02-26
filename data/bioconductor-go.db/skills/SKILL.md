---
name: bioconductor-go.db
description: This tool provides access to the Gene Ontology (GO) annotation database and its structural relationships. Use when user asks to retrieve GO term metadata, navigate the GO hierarchy, or map relationships between biological process, molecular function, and cellular component domains.
homepage: https://bioconductor.org/packages/release/data/annotation/html/GO.db.html
---


# bioconductor-go.db

name: bioconductor-go.db
description: Provides access to the Gene Ontology (GO) annotation database. Use this skill when you need to retrieve GO term metadata (definitions, synonyms, ontologies), explore the GO hierarchy (parents, children, ancestors, offspring), or map between GO IDs and their structural relationships in Biological Process (BP), Molecular Function (MF), and Cellular Component (CC) domains.

## Overview

The `GO.db` package is a comprehensive annotation data package for the Gene Ontology. It provides a set of SQLite-based maps that describe the relationships between GO terms and their metadata. It is primarily used in bioinformatics workflows to annotate gene sets, perform enrichment analysis, or navigate the Directed Acyclic Graph (DAG) structure of the Gene Ontology.

## Core Workflows

### 1. Accessing GO Term Metadata
The `GOTERM` object is the primary interface for retrieving details about a specific GO ID.

```r
library(GO.db)

# Retrieve information for a specific GO ID
term_info <- GOTERM[["GO:0008150"]]

# Extract specific attributes
GOID(term_info)
Term(term_info)
Definition(term_info)
Ontology(term_info) # BP, CC, or MF
Synonym(term_info)
```

### 2. Using the select() Interface
The modern way to interact with `GO.db` is via the `AnnotationDbi` interface. This is preferred for bulk queries.

```r
# View available columns and keytypes
columns(GO.db)
keytypes(GO.db)

# Query specific terms
select(GO.db, 
       keys = c("GO:0008150", "GO:0003674"), 
       columns = c("TERM", "ONTOLOGY", "DEFINITION"), 
       keytype = "GOID")
```

### 3. Navigating the GO Hierarchy
`GO.db` provides specific objects to traverse the DAG. These are organized by ontology (BP, CC, MF) and relationship type.

*   **Parents/Children**: Direct relationships.
*   **Ancestors/Offspring**: All nodes up or down the path to the root/leaves.

**Example: Finding Children of a BP term**
```r
# Get direct children for a Biological Process term
children_list <- as.list(GOBPCHILDREN)
my_children <- children_list[["GO:0007049"]]

# Look up the terms for those children
select(GO.db, keys = my_children, columns = "TERM", keytype = "GOID")
```

**Relationship Object Mapping:**
*   **Biological Process**: `GOBPPARENTS`, `GOBPCHILDREN`, `GOBPANCESTOR`, `GOBPOFFSPRING`
*   **Molecular Function**: `GOMFPARENTS`, `GOMFCHILDREN`, `GOMFANCESTOR`, `GOMFOFFSPRING`
*   **Cellular Component**: `GOCCPARENTS`, `GOCCCHILDREN`, `GOCCANCESTOR`, `GOCCOFFSPRING`

### 4. Handling Synonyms and Obsolete Terms
*   **Synonyms**: Use `GOSYNONYM` to map alternative names back to primary GO IDs.
*   **Obsolete**: Use `GOOBSOLETE` to check if a GO ID is no longer active.

```r
# Check if a term is a synonym
syn_map <- as.list(GOSYNONYM)
primary_id <- syn_map[["GO:0006736"]]
```

## Tips and Best Practices
*   **Bimap vs Select**: While the "Bimap" interface (e.g., `as.list(GOTERM)`) is common in older scripts, the `select()` function is more robust and consistent with other Bioconductor annotation packages.
*   **Ontology Specificity**: Always ensure you are using the correct relationship object for your ontology (e.g., don't use `GOBPPARENTS` for a `GOMF` ID).
*   **Database Connection**: If you need to perform raw SQL queries, use `GO_dbconn()` to get the connection object, but never call `dbDisconnect()` on it.

## Reference documentation
- [GO.db Reference Manual](./references/reference_manual.md)