---
name: bioconductor-lrcell
description: LRcell identifies specific cell types responsible for differential expression patterns in bulk RNA-seq data by leveraging single-cell marker genes. Use when user asks to identify cell-type enrichment in bulk tissue, calculate cell-type significance p-values using logistic or linear regression, or visualize cell-type enrichment with Manhattan plots.
homepage: https://bioconductor.org/packages/release/bioc/html/LRcell.html
---


# bioconductor-lrcell

## Overview

LRcell is a Bioconductor package designed to bridge the gap between bulk RNA-seq and single-cell RNA-seq (scRNA-seq). It identifies which specific sub-cell types are likely responsible for the differential gene expression patterns observed in bulk tissue. By using marker genes from scRNA-seq as indicators, the package applies Logistic Regression (LR) or Linear Regression (LiR) to calculate cell-type significance p-values. It is particularly well-suited for neurological studies, providing pre-loaded marker sets for various human and mouse brain regions.

## Standard Workflow

### 1. Data Preparation
LRcell requires a named vector of p-values from a bulk differential expression (DE) analysis (e.g., from DESeq2 or limma).

```r
library(LRcell)
# example_gene_pvals is a named numeric vector: genes as names, p-values as values
data("example_gene_pvals")
```

### 2. Running LRcell Analysis
There are two primary ways to run the analysis: using pre-defined regions or providing custom marker genes.

**Option A: Using Pre-defined Species and Regions**
This is the simplest method for supported tissues (Human PBMC, Human pFC, or 9 Mouse brain regions).
*   `method = "LiR"`: Linear Regression (uses enrichment scores).
*   `method = "LR"`: Logistic Regression (uses binary marker gene presence).

```r
res <- LRcell(gene.p = example_gene_pvals,
              species = "mouse",
              region = "FC", # Frontal Cortex
              method = "LiR")
```

**Option B: Using Custom Marker Genes**
If you have your own marker gene list (a list of character vectors), use `LRcellCore`.

```r
res <- LRcellCore(gene.p = example_gene_pvals,
                  marker.g = my_custom_markers,
                  method = "LR")
```

### 3. Visualizing Results
Use the built-in plotting function to generate a Manhattan-style plot of cell-type enrichment.

```r
# res$FC contains the result dataframe if using LRcell() with region="FC"
plot_manhattan_enrich(res$FC, sig.cutoff = 0.05, label.topn = 5)
```

## Advanced Usage

### Calculating Custom Gene Enrichment Scores
If you have a scRNA-seq count matrix and cell annotations, you can generate your own enrichment scores to identify marker genes.

```r
# expr: gene-by-cell matrix; annot: named vector of cell types
enriched.g <- LRcell_gene_enriched_scores(expr = my_counts, 
                                          annot = my_annotations, 
                                          parallel = TRUE, 
                                          n.cores = 4)

# Extract top marker genes for LRcellCore
my_markers <- get_markergenes(enriched.g, method = "LR", topn = 100)
```

### Accessing Pre-loaded Markers via ExperimentHub
The package utilizes `LRcellTypeMarkers` for data storage. You can manually query these if needed.

```r
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "LRcellTypeMarkers")
# Example: Load Mouse Frontal Cortex (EH4548)
enriched_genes <- eh[["EH4548"]]
```

## Tips for Success
*   **Method Selection**: Logistic Regression (`LR`) is often more robust for binary "marker vs non-marker" logic, while Linear Regression (`LiR`) utilizes the magnitude of enrichment scores.
*   **Region Codes**: Common codes include `FC` (Frontal Cortex), `HI` (Hippocampus), `STR` (Striatum), and `pFC` (Prefrontal Cortex).
*   **Input Names**: Ensure the gene symbols in your bulk p-value vector match the nomenclature used in the marker gene sets (typically official Gene Symbols).

## Reference documentation
- [LRcell Vignette](./references/LRcell-vignette.md)
- [LRcell Vignette (Source)](./references/LRcell-vignette.Rmd)