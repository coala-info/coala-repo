---
name: bioconductor-famat
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/famat.html
---

# bioconductor-famat

## Overview

The `famat` package facilitates the discovery of functional links between metabolites and genes. It integrates multi-omics data by performing pathway enrichment across multiple databases, extracting direct molecular interactions, and calculating the centrality of elements within biological pathways. It also supports Gene Ontology (GO) enrichment and provides a Shiny interface for interactive visualization of the results.

## Core Workflow

The package follows a sequential four-step workflow. Each function's output serves as the input for the next.

### 1. Pathway Enrichment (`path_enrich`)
Perform enrichment analysis for genes (using gene symbols) and metabolites (using KEGG Compound IDs). You should run this for all three supported databases to maximize interaction discovery.

```r
library(famat)

# Load your data (genes as symbols, meta as KEGG IDs)
data(genes)
data(meta)

# Run enrichment for each database
listk <- path_enrich("KEGG", meta, genes)
listr <- path_enrich("REAC", meta, genes)
listw <- path_enrich("WP", meta, genes)
```

### 2. Interaction Extraction (`interactions`)
Identify direct interactions between your specific genes and metabolites within the enriched pathways. This step also calculates the centrality of each element.

```r
# Requires results from all three databases
interactions_result <- interactions(listk, listr, listw)
```

### 3. Data Completion (`compl_data`)
This function performs GO term enrichment on the genes, filters pathways (requiring at least 20% coverage or a direct interaction), and builds a parent-child hierarchy for the results.

```r
compl_data_result <- compl_data(interactions_result)
```

### 4. Visualization (`rshiny`)
Launch an interactive Shiny application to explore the hierarchies, heatmaps, and element-specific data.

```r
rshiny(compl_data_result)
```

## Input Requirements
*   **Genes**: Must be provided as Gene Symbols (e.g., "TP53").
*   **Metabolites**: Must be provided as KEGG Compound IDs (e.g., "C00022").
*   **Order**: Functions must be called in the order: `path_enrich` -> `interactions` -> `compl_data` -> `rshiny`.

## Key Features
*   **Centrality**: Measures the number of direct interactions an element has within a specific pathway, helping identify "hub" molecules.
*   **Filtering**: `compl_data` automatically removes pathways that lack sufficient evidence (less than 1/5 of user elements present) unless a direct interaction between a user's gene and metabolite is found.
*   **Shiny Interface**: Includes tabs for Elements (data tables), Pathways (hierarchical heatmaps), and GO terms (Molecular Function and Biological Process).

## Reference documentation

- [famat Vignette (Rmd)](./references/famat.Rmd)
- [famat Vignette (Markdown)](./references/famat.md)