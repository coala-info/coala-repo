---
name: bioconductor-lrcelltypemarkers
description: This package provides pre-calculated gene enrichment scores and cell-type markers for use with the LRcell R package. Use when user asks to retrieve cell-type specific marker genes from ExperimentHub, identify top marker genes for various tissues, or provide data for LRcell enrichment analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/LRcellTypeMarkers.html
---

# bioconductor-lrcelltypemarkers

## Overview

The `LRcellTypeMarkers` package serves as a data provider for the `LRcell` R package. It contains pre-calculated gene enrichment scores for various tissues, including mouse whole brain and human prefrontal cortex. These scores represent how unique a gene is to a specific cell type or cluster. The package leverages Bioconductor's `ExperimentHub` for efficient data delivery.

## Core Workflow

### 1. Discover and Download Data
Data is retrieved using `ExperimentHub`. You must query the hub for the package name to see available datasets.

```r
library(ExperimentHub)
library(LRcellTypeMarkers)

# Initialize ExperimentHub and query for LRcellTypeMarkers
eh <- ExperimentHub()
query_results <- query(eh, "LRcellTypeMarkers")

# View available records (e.g., EH4548, EH4549, etc.)
print(query_results)

# Download a specific dataset by its ID
# Example: Mouse Frontal Cortex Marker Genes
mouse_FC <- eh[['EH4548']]
```

### 2. Process Marker Genes
The downloaded data is typically a matrix where rows are gene symbols and columns are cell types/clusters. Values are enrichment scores. To use these with `LRcell`, you must extract the top marker genes.

```r
library(LRcell)

# Extract top 100 marker genes per cluster using Logistic Regression (LR) method
FC_marker_genes <- get_markergenes(mouse_FC, method = "LR", topn = 100)

# Inspect the resulting list
str(FC_marker_genes)
```

### 3. Integration with LRcell
The primary use case is passing these marker genes into `LRcellCore` alongside bulk differential expression p-values.

```r
# Assume 'example_gene_pvals' is a named vector of p-values from a DE analysis
# names(example_gene_pvals) should be gene symbols

res <- LRcellCore(
  gene.p = example_gene_pvals,
  marker.g = FC_marker_genes,
  method = "LR", 
  min.size = 5, 
  sig.cutoff = 0.05
)

# View enrichment results
head(res)
```

## Key Considerations

- **Method Consistency**: Ensure the `method` parameter used in `get_markergenes()` matches the `method` used in `LRcellCore()` (typically "LR" for Logistic Regression).
- **MSigDB C8 Datasets**: For datasets derived from MSigDB C8, marker genes are specifically optimized for Logistic Regression (LR) analysis.
- **Data Structure**: The enrichment matrices use gene symbols. Ensure your bulk DE gene names are also symbols to ensure proper mapping.
- **Visualization**: Results from the enrichment analysis can be visualized using `LRcell::plot_manhattan_enrich(res)`.

## Reference documentation

- [LRcellTypeMarkers: Marker gene information for LRcell R Bioconductor package using Bioconductor's ExperimentHub](./references/LRcellTypeMarkers-vignette.md)
- [LRcellTypeMarkers Source Vignette (Rmd)](./references/LRcellTypeMarkers-vignette.Rmd)