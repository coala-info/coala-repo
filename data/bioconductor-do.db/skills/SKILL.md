---
name: bioconductor-do.db
description: This tool provides access to the Disease Ontology (DO) to retrieve disease metadata and navigate hierarchical relationships. Use when user asks to retrieve DO term details, find disease synonyms, or explore the ontology hierarchy including parents, children, ancestors, and offspring.
homepage: https://bioconductor.org/packages/release/data/annotation/html/DO.db.html
---

# bioconductor-do.db

name: bioconductor-do.db
description: Access and navigate the Disease Ontology (DO) using the DO.db annotation package. Use this skill to retrieve DO term details (IDs, terms, synonyms), explore the ontology hierarchy (parents, children, ancestors, offspring), and map relationships between disease concepts in R.

# bioconductor-do.db

## Overview
The `DO.db` package is a Bioconductor annotation resource that provides a structured representation of the Disease Ontology (DO). It organizes disease terms into a Directed Acyclic Graph (DAG), allowing users to programmatically query disease metadata and hierarchical relationships. It uses `Bimap` objects to map DO IDs to their attributes and relative terms.

## Core Workflows

### Loading the Library
```r
library(DO.db)
```

### Retrieving Term Details
The `DOTERM` object contains the full set of DO terms. You can access specific attributes using S4 methods: `DOID()`, `Term()`, `Synonym()`, and `Secondary()`.

```r
# Convert to list to inspect terms
term_list <- as.list(DOTERM[1:5])

# Extract attributes from a specific term object
term_obj <- term_list[[1]]
id <- DOID(term_obj)
label <- Term(term_obj)
syns <- Synonym(term_obj)
```

### Navigating the Ontology Hierarchy
`DO.db` provides four primary mapping objects to navigate the DAG. These are typically converted to lists for easy subsetting.

1.  **Direct Relationships:**
    *   `DOPARENTS`: Maps a DO ID to its immediate parent terms.
    *   `DOCHILDREN`: Maps a DO ID to its immediate child terms.

2.  **Ancestry/Descendancy (Recursive):**
    *   `DOANCESTOR`: Maps a DO ID to all nodes above it in the hierarchy (parents, grandparents, etc.).
    *   `DOOFFSPRING`: Maps a DO ID to all nodes below it in the hierarchy (children, grandchildren, etc.).

```r
# Example: Find all ancestors of a specific disease
ancestors <- as.list(DOANCESTOR)
my_ancestors <- ancestors[["DOID:0014667"]]

# Example: Find immediate children
children <- as.list(DOCHILDREN)
my_children <- children[["DOID:0000000"]]
```

### Database Metadata and Schema
To understand the underlying SQLite structure or check mapping statistics:

```r
# View the SQL schema
DO_dbschema()

# Get counts of mapped keys for each object
DOMAPCOUNTS
```

## Usage Tips
*   **Handling NAs:** When converting Bimaps to lists (e.g., `as.list(DOPARENTS)`), use `xx[!is.na(xx)]` to remove terms that do not have the requested relationship (like the root node having no parents).
*   **Search:** Since `DOTERM` is a Bimap, you can use standard AnnotationDbi-style filtering or convert to a list/dataframe to search for specific disease strings.
*   **DOID Format:** Ensure DO IDs are formatted correctly (e.g., `"DOID:1234"`) when performing lookups.

## Reference documentation
- [How To Use DO.db](./references/DO.db.md)