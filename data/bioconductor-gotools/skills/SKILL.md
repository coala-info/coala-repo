---
name: bioconductor-gotools
description: This tool performs functional annotation and comparison of gene sets by mapping probe IDs to Gene Ontology terms. Use when user asks to map probe IDs to GO terms, compare the functional composition of multiple gene lists, or generate graphical representations of GO term distributions.
homepage: https://bioconductor.org/packages/release/bioc/html/goTools.html
---


# bioconductor-gotools

name: bioconductor-gotools
description: Functional annotation and comparison of gene sets using Gene Ontology (GO). Use this skill to map probe IDs to GO terms, compare the functional composition of multiple gene lists, and generate graphical representations (pie charts or bar graphs) of GO term distributions.

# bioconductor-gotools

## Overview

The `goTools` package provides a workflow for comparing the functional profiles of gene sets based on the Gene Ontology (GO) Directed Acyclic Graph (DAG). It maps gene identifiers (typically Affymetrix probe IDs) to GO terms and aggregates them under specific "end nodes" (high-level GO categories) to provide a comparative overview of Molecular Function (MF), Biological Process (BP), or Cellular Component (CC).

## Core Workflow

### 1. Data Preparation
The package expects gene lists as a named list of character vectors containing probe IDs.

```r
library(goTools)
library(GO.db)

# Example: Comparing two sets of Affymetrix hgu133a IDs
gene_lists <- list(
  Set1 = c("215828_at", "201849_at", "219719_at"),
  Set2 = c("213690_s_at", "203172_at", "213693_s_at")
)
```

### 2. Comparing Ontologies
The primary function is `ontoCompare`. It maps IDs to GO terms and calculates the distribution across categories.

```r
# Basic comparison
results <- ontoCompare(gene_lists, probeType = "hgu133a")

# Comparison with plotting enabled
results <- ontoCompare(gene_lists, probeType = "hgu133a", plot = TRUE)
```

**Key Arguments for `ontoCompare`:**
- `probeType`: The metadata package name (e.g., "hgu133a", "hgu95av2").
- `goType`: The ontology branch to use: "MF" (Molecular Function), "BP" (Biological Process), or "CC" (Cellular Component).
- `method`: How percentages are calculated:
  - `"TGenes"` (Default): (Children found) / (Total number of probe IDs).
  - `"TIDS"`: (Children found) / (Total number of GO IDs describing the list).
  - `"none"`: Returns raw counts of children found.
- `endnode`: A character vector of GO IDs to serve as the categories for aggregation.

### 3. Customizing Categories (End Nodes)
By default, `goTools` uses high-level nodes via `EndNodeList()`. You can customize these to get more granular results.

```r
# Create a list of nodes 2 levels below Molecular Function (GO:0003674)
custom_nodes <- CustomEndNodeList("GO:0003674", rank = 2)

# Use custom nodes in comparison
res_custom <- ontoCompare(gene_lists, probeType = "hgu133a", endnode = custom_nodes)
```

### 4. Visualization
If `plot = TRUE` is not set in `ontoCompare`, you can call `ontoPlot` manually on the results.

```r
# Returns a pie chart for a single list, or a bar graph for multiple lists
ontoPlot(results)
```

## Tips and Best Practices
- **Library Dependencies**: Ensure `GO.db` and the specific annotation package for your `probeType` (e.g., `hgu133a.db`) are installed and loaded.
- **ID Formats**: The package is primarily designed for Affymetrix probe IDs. If using other identifiers, they must be supported by the underlying Bioconductor annotation metadata.
- **End Node Selection**: If the default categories are too broad, use `CustomEndNodeList` with a specific `rank` to drill down into more specific biological functions.

## Reference documentation
- [goTools](./references/goTools.md)