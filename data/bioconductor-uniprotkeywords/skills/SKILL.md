---
name: bioconductor-uniprotkeywords
description: This package provides a standardized interface to the UniProt controlled vocabulary and its hierarchical structure. Use when user asks to access protein function metadata, map UniProt keywords to gene IDs, or navigate the hierarchical relationships of biological terms.
homepage: https://bioconductor.org/packages/release/data/annotation/html/UniProtKeywords.html
---


# bioconductor-uniprotkeywords

## Overview

The `UniProtKeywords` package provides a standardized interface to the UniProt controlled vocabulary. It allows users to programmatically access the hierarchical structure of protein functions, biological processes, and cellular components as defined by UniProt, and map these keywords to specific genes for various organisms.

## Core Data Objects

The package provides five primary data objects representing the keyword database. Load them using `data()` after calling `library(UniProtKeywords)`.

*   `kw_terms`: A list containing metadata for each keyword (Identifier, Accession, Description, Gene_ontology mapping, Hierarchy, and Category).
*   `kw_parents` / `kw_children`: Lists defining direct hierarchical relationships.
*   `kw_ancestors` / `kw_offspring`: Lists defining the full recursive hierarchical tree.

```r
library(UniProtKeywords)

# View package release info
UniProtKeywords

# Access specific keyword metadata
data(kw_terms)
kw_terms[["Cell cycle"]]

# Explore hierarchy
data(kw_children)
kw_children[["ATP-binding"]]
```

## Loading Keyword Genesets

The `load_keyword_genesets()` function is the primary tool for functional genomics, mapping UniProt keywords to Entrez Gene IDs.

### Usage Patterns

1.  **By Taxon ID**: Use the NCBI taxonomy ID (e.g., 9606 for Human).
2.  **By Name**: Use common names (e.g., "mouse") or Latin names.
3.  **Format Selection**:
    *   Default: Returns a named list where names are keywords and elements are vectors of gene IDs.
    *   `as_table = TRUE`: Returns a long-format data frame with "keyword" and "gene" columns, ideal for tidyverse workflows.

```r
# Load human genesets as a list
human_gs <- load_keyword_genesets(9606)

# Load mouse genesets as a data frame
mouse_df <- load_keyword_genesets("mouse", as_table = TRUE)
```

## Common Workflows

### Functional Summarization
To summarize the functions of a gene list, filter the table returned by `load_keyword_genesets` for your genes of interest and count the frequency of associated keywords.

### Hierarchy Navigation
To expand a functional analysis, use `kw_offspring` to include genes associated with more specific child terms of a broad keyword.

```r
data(kw_offspring)
# Get all specific terms under "Metal-binding"
sub_terms <- kw_offspring[["Metal-binding"]]
```

## Tips
*   **GO Mapping**: Use `kw_terms[[id]]$Gene_ontology` to find equivalent Gene Ontology terms for cross-database validation.
*   **Keyword Categories**: Keywords are grouped into categories like "Biological process", "Molecular function", "Cellular component", "Ligand", etc. Check the `$Category` field in `kw_terms`.

## Reference documentation

- [Keywords from the UniProt database (Rmd)](./references/UniProtKeywords.Rmd)
- [Keywords from the UniProt database (md)](./references/UniProtKeywords.md)