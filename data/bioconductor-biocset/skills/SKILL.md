---
name: bioconductor-biocset
description: BiocSet provides a tidyverse-compatible framework for managing and manipulating biological element sets through three related data tables. Use when user asks to represent gene sets in a tidy format, perform set operations like union or intersection, map between different biological ID types, or import and export .gmt and .obo files.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocSet.html
---


# bioconductor-biocset

name: bioconductor-biocset
description: Specialized workflow for managing and manipulating element sets (gene sets) using the BiocSet package. Use this skill when you need to represent biological sets in a tidy format, perform set operations (union, intersection), map between different ID types (e.g., ENSEMBL to SYMBOL), or import/export .gmt and .obo files.

# bioconductor-biocset

## Overview

`BiocSet` provides a tidyverse-compatible framework for representing and manipulating element sets (like gene sets or pathways). It organizes data into three related tibbles: `es_element` (the individual items), `es_set` (the groups), and `es_elementset` (the mapping between them). This structure allows for seamless integration with `dplyr` verbs and specialized set operations while maintaining biological context.

## Core Workflows

### 1. Creating and Importing Sets

Create a `BiocSet` from R objects or external files:

```R
library(BiocSet)

# From named character vectors
bs <- BiocSet(set1 = c("geneA", "geneB"), set2 = c("geneB", "geneC"))

# Import from GMT (Gene Matrix Transposed)
gmt_file <- system.file(package = "BiocSet", "extdata", "hallmark.gene.symbol.gmt")
bs_gmt <- import(gmt_file)

# Import from OBO (Ontology files)
obo_bs <- import("path/to/file.obo", extract_tag = "everything")
```

### 2. Tidy Manipulation (The "Verb-Tibble" Pattern)

`BiocSet` uses a specific naming convention to apply `dplyr` verbs to specific internal tibbles: `verb_tibble`.

*   **Filter**: `filter_element()`, `filter_set()`, `filter_elementset()`
*   **Mutate**: `mutate_element()`, `mutate_set()`, `mutate_elementset()`
*   **Arrange**: `arrange_element()`, `arrange_set()`, `arrange_elementset()`

```R
# Example: Filter for specific elements and add a p-value to sets
bs %>% 
  filter_element(element %in% c("geneA", "geneB")) %>%
  mutate_set(p_val = 0.05)
```

### 3. Set Operations

Perform operations across different `BiocSet` objects or within a single object:

```R
# Between two objects
union(es1, es2)
intersection(es1, es2)

# Within a single object (collapsing multiple sets into one)
union_single(bs)
intersect_single(bs)
```

### 4. ID Mapping and Annotation

`BiocSet` simplifies mapping between biological identifiers using `AnnotationDbi` objects:

```R
library(org.Hs.eg.db)

# Map IDs (1:1)
bs_mapped <- map_unique(bs, org.Hs.eg.db, from = "ENSEMBL", to = "SYMBOL")

# Add metadata columns without changing the primary ID
map_vals <- map_add_set(bs, GO.db, "GOID", "DEFINITION")
bs_annotated <- bs %>% mutate_set(definition = map_vals)
```

### 5. Specialized Set Construction

Generate sets directly from Bioconductor annotation resources:

```R
# Create GO sets for a specific organism and ID type
go <- go_sets(org.Hs.eg.db, "ENSEMBL")

# Create KEGG sets (requires KEGGREST)
kegg <- kegg_sets("hsa")
```

### 6. Integration with Other Classes

Convert `BiocSet` objects back to standard data frames or tibbles for use in other pipelines:

```R
# Flatten to a single tibble
df <- tibble_from_elementset(bs)

# Create a BiocSet from existing metadata tibbles
# Requires columns named 'element' and 'set'
new_bs <- BiocSet_from_elementset(mapping_tbl, element_metadata, set_metadata)
```

## Tips for Success

*   **Active Tibble**: By default, `es_elementset` is the active tibble. Use the specific `verb_tibble` functions to ensure you are modifying the correct data layer.
*   **URL References**: Use `url_ref(bs)` to automatically add columns with clickable links to Ensembl, Entrez, or AmiGO for the IDs in your set.
*   **Empty Sets**: After filtering elements, you may have empty sets. Use `bs %>% group_by(set) %>% filter(n() > 0)` to clean them up.

## Reference documentation

- [BiocSet: Representing Element Sets in the Tidyverse](./references/BiocSet.md)