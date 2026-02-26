---
name: bioconductor-fgsea
description: The fgsea package provides a fast implementation of the Gene Set Enrichment Analysis algorithm for calculating accurate p-values using a Monte Carlo scheme. Use when user asks to perform fast preranked GSEA, conduct over-representation analysis with fora, identify co-regulated gene sets with geseca, or visualize enrichment results.
homepage: https://bioconductor.org/packages/release/bioc/html/fgsea.html
---


# bioconductor-fgsea

## Overview
The `fgsea` package provides an exceptionally fast implementation of the GSEA algorithm. It is designed to calculate accurate p-values for gene set enrichment using an adaptive multi-level Monte Carlo scheme. Beyond standard GSEA, it includes `fora` for over-representation analysis and `geseca` for identifying gene sets with high internal correlation in datasets where traditional "case vs. control" contrasts are unavailable (e.g., time-series, single-cell, or spatial data).

## Core Workflows

### 1. Fast Preranked GSEA (fgsea)
Use this when you have a ranked list of genes (e.g., sorted by log2 fold change or t-statistic).

```r
library(fgsea)

# 1. Prepare inputs
# stats: named numeric vector (names = gene IDs)
# pathways: list of gene ID vectors
data(exampleRanks)
data(examplePathways)

# 2. Run fgsea
# eps=0.0 allows for more accurate p-values beyond the default 1e-10
fgseaRes <- fgsea(pathways = examplePathways, 
                  stats    = exampleRanks,
                  minSize  = 15,
                  maxSize  = 500,
                  eps      = 0.0)

# 3. View results (ordered by p-value)
head(fgseaRes[order(pval), ])
```

### 2. Gene Set Co-regulation Analysis (geseca)
Use this for multi-conditional data (time-series, spatial) where no single contrast exists. It identifies pathways where genes vary together across samples.

```r
# E: log-transformed, normalized expression matrix
# pathways: list of gene sets
gesecaRes <- geseca(pathways = examplePathways, 
                    E = exampleExpressionMatrix, 
                    minSize = 15, 
                    maxSize = 500)

# For large datasets (scRNA-seq), use a PCA-reduced matrix for speed
# Ensure center=FALSE if the matrix is already centered
```

### 3. Over-representation Analysis (fora)
A fast hypergeometric test for enrichment in a "hit list" vs. a background universe.

```r
# fg: vector of gene IDs of interest
# bg: vector of all detected gene IDs (universe)
foraRes <- fora(pathways = examplePathways, 
                genes = fg, 
                universe = bg)
```

## Visualization and Utilities

### Enrichment Plots
```r
# Standard GSEA plot for a single pathway
plotEnrichment(examplePathways[["Pathway_Name"]], exampleRanks)

# Table plot for multiple pathways
topPathways <- fgseaRes[head(order(pval), n=10), pathway]
plotGseaTable(examplePathways[topPathways], exampleRanks, fgseaRes, gseaParam=0.5)
```

### Collapsing Redundant Pathways
GSEA often returns many similar pathways. Use `collapsePathways` to find independent "main" pathways.
```r
collapsedPathways <- collapsePathways(fgseaRes[padj < 0.01], examplePathways, exampleRanks)
mainPathways <- fgseaRes[pathway %in% collapsedPathways$mainPathways][order(-NES), pathway]
```

### Loading GMT Files
```r
pathways <- gmtPathways("path/to/genesets.gmt")
```

## Performance Tips
- **Parallelization**: `fgsea` uses `BiocParallel`. You can set the number of threads using the `nproc` argument (e.g., `nproc=4`).
- **Gene IDs**: Ensure the ID type in your `stats` or `E` matrix matches the ID type in your `pathways` list (e.g., Entrez, Symbol, or Ensembl).
- **Leading Edge**: The `leadingEdge` column in `fgsea` results contains the genes contributing most to the enrichment score. Use `mapIdsList` to convert these IDs to human-readable symbols if necessary.

## Reference documentation
- [Using fgsea package](./references/fgsea-tutorial.md)
- [Gene set co-regulation analysis tutorial](./references/geseca-tutorial.md)