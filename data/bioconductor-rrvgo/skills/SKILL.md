---
name: bioconductor-rrvgo
description: This tool reduces redundancy in Gene Ontology enrichment results by grouping similar terms based on semantic similarity measures. Use when user asks to calculate similarity matrices between GO terms, reduce the complexity of functional enrichment lists, or visualize summarized GO data using scatter plots, treemaps, and heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/rrvgo.html
---


# bioconductor-rrvgo

name: bioconductor-rrvgo
description: Comprehensive tool for reducing redundancy in Gene Ontology (GO) enrichment results. Use when an AI agent needs to group similar GO terms based on semantic similarity, calculate similarity matrices, or visualize summarized functional enrichment data using heatmaps, scatter plots, treemaps, or word clouds.

# bioconductor-rrvgo

## Overview
The `rrvgo` package simplifies the interpretation of Gene Ontology (GO) enrichment analysis by reducing redundancy. It groups similar GO terms based on semantic similarity measures (mimicking REVIGO functionality) and provides a programmatic interface within R using Bioconductor's annotation infrastructure.

## Core Workflow

### 1. Calculate Similarity Matrix
The first step is to compute the semantic similarity between GO terms using `calculateSimMatrix`.

```r
library(rrvgo)

# go_ids: vector of GO terms (e.g., "GO:0006915")
# orgdb: OrgDb object name (e.g., "org.Hs.eg.db")
# ont: "BP" (Biological Process), "MF" (Molecular Function), or "CC" (Cellular Component)
# method: "Rel" (default), "Resnik", "Lin", "Jiang", or "Wang"

simMatrix <- calculateSimMatrix(go_ids, 
                                orgdb="org.Hs.eg.db", 
                                ont="BP", 
                                method="Rel")
```

### 2. Reduce GO Terms
Group terms based on the similarity matrix using `reduceSimMatrix`.

```r
# scores: numeric vector named with GO IDs. 
# IMPORTANT: Higher scores are considered "better" (representative).
# If using p-values, transform them: scores <- -log10(pvalues)

reducedTerms <- reduceSimMatrix(simMatrix,
                                scores,
                                threshold=0.7,
                                orgdb="org.Hs.eg.db")
```
*   **Threshold:** Higher thresholds lead to fewer groups (more reduction). It represents the minimum similarity between group representatives.
*   **Default Scores:** If no scores are provided, `rrvgo` uses GO term size (favoring broader terms) or uniqueness.

## Visualization Functions

`rrvgo` provides several ways to visualize the reduced set of terms:

*   **Heatmap:** `heatmapPlot(simMatrix, reducedTerms)` - Displays the similarity matrix with terms clustered.
*   **Scatter Plot:** `scatterPlot(simMatrix, reducedTerms)` - 2D PCoA plot where distances represent dissimilarity.
*   **Treemap:** `treemapPlot(reducedTerms)` - Hierarchical visualization where box size is proportional to the score.
*   **Word Cloud:** `wordcloudPlot(reducedTerms)` - Summarizes common keywords in the GO term descriptions.

## Interactive Analysis
For interactive exploration, use the built-in Shiny application:
```r
rrvgo::shiny_rrvgo()
```

## Tips and Best Practices
*   **Performance:** If running `calculateSimMatrix` multiple times for the same organism/ontology, pre-calculate the semantic data object using `GOSemSim::godata(orgdb, ont=ont)` and pass it to the `semdata` parameter to save time.
*   **Score Direction:** Always ensure scores are transformed so that the most significant or desirable terms have the highest values.
*   **Organism Support:** Supports any organism with an available `OrgDb` package in Bioconductor (e.g., `org.Mm.eg.db` for mouse, `org.At.tair.db` for Arabidopsis).

## Reference documentation
- [Using the rrvgo package](./references/rrvgo.md)