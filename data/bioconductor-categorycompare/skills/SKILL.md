---
name: bioconductor-categorycompare
description: This package performs meta-analysis of high-throughput biological data by comparing significantly enriched functional categories across multiple datasets. Use when user asks to perform enrichment meta-analysis, compare Gene Ontology terms or KEGG pathways across experiments, and visualize functional annotation networks.
homepage: https://bioconductor.org/packages/release/bioc/html/categoryCompare.html
---

# bioconductor-categorycompare

## Overview

The `categoryCompare` package is designed for the meta-analysis of high-throughput biological data. Instead of simply looking for overlapping genes between experiments, it focuses on comparing significantly enriched categories (such as Gene Ontology terms or KEGG pathways) across different datasets. This allows researchers to identify common functional themes even when the specific genes involved may differ.

## Core Workflow

### 1. Data Preparation
The package requires gene lists and a "universe" (background) of genes, typically represented as Entrez IDs.

```R
library(categoryCompare)

# Define gene lists for different conditions/timepoints
list10 <- list(genes=g10_ids, universe=gUniverse, annotation='org.Hs.eg.db')
list48 <- list(genes=g48_ids, universe=gUniverse, annotation='org.Hs.eg.db')

# Combine into a ccGeneList object
geneLists <- list(T10=list10, T48=list48)
geneLists <- new("ccGeneList", geneLists, ccType=c("BP","KEGG"))
```

### 2. Annotation Enrichment
Perform enrichment calculations across all lists and categories simultaneously.

```R
# Run enrichment
enrichLists <- ccEnrich(geneLists)

# Adjust thresholds if necessary (e.g., making p-value more stringent)
pvalueCutoff(enrichLists$BP) <- 0.001
```

### 3. Comparison Analysis
Compare the enrichment results to find commonalities and differences.

```R
# Define comparison options
ccOpts <- new("ccOptions", listNames=names(geneLists), outType='none')

# Perform comparison
ccResults <- ccCompare(enrichLists, ccOpts)
```

The resulting `ccResults` object contains:
- `mainTable`: Enrichment results in table format with list membership.
- `mainGraph`: A `graphNEL` object showing connections between annotations.
- `allAnnotation`: Mapping of genes to annotations and their source lists.

### 4. Visualization and Network Manipulation
The package integrates with `RCy3` for Cytoscape visualization. A key feature is the ability to "break" edges to simplify complex networks.

```R
# Reduce network complexity by removing edges with low weights (shared genes)
# weight range is 0 to 1
ccBP_filtered <- breakEdges(ccResults$BP, 0.8)

# Export to Cytoscape (requires Cytoscape to be running)
# cw.BP <- ccOutCyt(ccBP_filtered, ccOpts)
```

## Key Functions

- `ccGeneList`: Constructor for the input object containing genes, universe, and annotation type.
- `ccEnrich`: Performs the actual enrichment analysis (supports GO and KEGG).
- `ccCompare`: The core meta-analysis function that merges enrichment results.
- `breakEdges`: Filters the resulting graph based on the overlap weight between nodes.
- `graphType<-`: Switches between "functional" (overlap-based) and "hierarchical" (DAG-based) graph representations.

## Tips for Success

- **ID Consistency**: Ensure all gene identifiers are Entrez IDs and match the annotation package (e.g., `org.Hs.eg.db`).
- **Edge Weights**: When visualizing GO terms, the initial network often has ~20,000+ edges. Always use `breakEdges` with a threshold (e.g., 0.2 to 0.8) before attempting to render in Cytoscape to prevent performance issues.
- **Hierarchical vs. Functional**: Use the default functional layout for discovering "themes" across datasets. Use the hierarchical layout only for small numbers of GO terms to view the DAG structure.

## Reference documentation

- [categoryCompare: High-throughput data meta-analysis using feature annotations](./references/categoryCompare_vignette.md)