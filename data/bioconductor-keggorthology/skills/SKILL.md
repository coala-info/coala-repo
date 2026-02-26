---
name: bioconductor-keggorthology
description: This tool provides a representation of the KEGG Orthology hierarchy as a graph object in R for biological pathway exploration. Use when user asks to navigate pathway relationships, retrieve KEGG tags by keyword, or map pathways to gene and probe identifiers for filtering expression data.
homepage: https://bioconductor.org/packages/release/bioc/html/keggorthology.html
---


# bioconductor-keggorthology

name: bioconductor-keggorthology
description: Access and explore the KEGG Orthology (KO) hierarchy as a graph object in R. Use this skill to navigate pathway relationships, retrieve KO tags by keyword, and map pathways to gene/probe identifiers for filtering expression data.

## Overview

The `keggorthology` package provides a representation of the KEGG Orthology hierarchy as a `graphNEL` object. It allows users to explore the conceptual organization of biological pathways (e.g., Metabolism, Genetic Information Processing) and map these categories to specific gene identifiers or microarray probe sets.

## Core Data and Exploration

The primary data structure is `KOgraph`, a directed graph representing the KEGG hierarchy.

```r
library(keggorthology)
library(graph)
data(KOgraph)

# View top-level categories
adj(KOgraph, nodes(KOgraph)[1])

# Access node attributes (tag and depth)
nodeData(KOgraph, , "tag")[1:5]   # Numerical KEGG tags
nodeData(KOgraph, , "depth")[1:5] # Hierarchical level
```

## Pathway Navigation

To find the relationship or path between the root and a specific pathway, use the `RBGL` package:

```r
library(RBGL)
# Find path to a specific term
sp.between(KOgraph, nodes(KOgraph)[1], "PPAR signaling pathway")
```

## Searching and Gene Filtering

The package provides utility functions to search the orthology and map terms to genomic identifiers.

### Finding Tags by Keyword
Use `getKOtags` to find numerical identifiers for pathways matching a substring.

```r
# Search for tags related to a term
getKOtags("insulin")
```

### Mapping to Probes/Genes
Use `getKOprobes` to retrieve probe identifiers associated with a specific KO term. By default, this uses the `hgu95av2.db` annotation package, but other Bioconductor annotation packages can be used.

```r
# Get probes for a specific term
mp = getKOprobes("Methionine", annotPkg = "hgu95av2.db")

# Use these probes to subset an ExpressionSet
# library(ALL); data(ALL)
# subset_all = ALL[mp, ]
```

## Workflow Tips

- **Graph Structure**: The root node is typically `KO.Feb10root`.
- **Node Names**: Nodes are named by their descriptive pathway titles (e.g., "Metabolism").
- **Annotation Packages**: When using `getKOprobes`, ensure the corresponding `.db` annotation package for your platform is installed and loaded.
- **Data Currency**: The internal `KOgraph` is based on a specific snapshot of KEGG (March 2010). For the most current KEGG data, consider using `KEGGREST`, though `keggorthology` remains useful for its specific hierarchical graph structure.

## Reference documentation

- [keggorthology: the KEGG orthology as graph](./references/keggorth.md)