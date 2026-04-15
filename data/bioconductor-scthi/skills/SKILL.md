---
name: bioconductor-scthi
description: This tool identifies and visualizes ligand-receptor interactions between tumor and microenvironment cells using a rank-based approach for single-cell RNA-seq data. Use when user asks to score cell-cell communication, classify tumor microenvironment cell types using gene signatures, or visualize significant interaction pairs.
homepage: https://bioconductor.org/packages/release/bioc/html/scTHI.html
---

# bioconductor-scthi

name: bioconductor-scthi
description: Identify and visualize ligand-receptor interactions between tumor and microenvironment cells using single-cell RNA-seq data. Use when analyzing cell-cell communication (CCC) in cancer, scoring interactions based on top-ranked gene expression, or performing gene-signature-based classification of tumor microenvironment (TME) cell types.

# bioconductor-scthi

## Overview
The `scTHI` (single-cell Tumor-Host Interaction) package is designed to identify significant ligand-receptor interactions between malignant cells and the tumor microenvironment (TME). Unlike methods that rely solely on average expression, `scTHI` uses a rank-based approach, scoring interactions based on the percentage of cells where the partners are among the top-ranked genes. It also provides tools for TME cell-type classification using gene set enrichment (MWW-GST algorithm).

## Installation
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scTHI")
# Optional example data
BiocManager::install("scTHI.data")
```

## Workflow: Ligand-Receptor Interaction

### 1. Prepare Input
The package requires a normalized count matrix (e.g., TPM or log-transformed counts) with Hugo Symbols as row names and cells as column names.

```r
library(scTHI)
# Identify cell indices for two clusters (e.g., Malignant and Immune)
clusterA_cells <- colnames(expMat)[metadata$Type == "Malignant"]
clusterB_cells <- colnames(expMat)[metadata$Type == "Immune"]
```

### 2. Score Interactions
Use `scTHI_score` to compute interaction scores. The score reflects the enrichment of ligand-receptor pairs in the top percentage of the ranked gene list for each cell.

```r
results <- scTHI_score(
  expMat = expMat,
  cellCusterA = clusterA_cells,
  cellCusterB = clusterB_cells,
  cellCusterAName = "Malignant",
  cellCusterBName = "Immune",
  topRank = 10,        # Consider gene expressed if in top 10% of ranked list
  PValue = TRUE,       # Perform permutation testing
  pvalueCutoff = 0.05,
  nPermu = 100,        # Number of permutations
  ncore = 1
)

# View significant interactions
head(results$result)
```

### 3. Visualization
Visualize the scores or the percentage of cells expressing the partners.

```r
# Barplot of interaction scores
scTHI_plotResult(results, plotType = "score")

# Barplot of cell percentages for each partner
scTHI_plotResult(results, plotType = "pair")
```

## Workflow: TME Classification
`TME_classification` identifies cell types (e.g., Macrophages, Microglia, Oligodendrocytes) based on signature enrichment.

```r
# Run classification (can be time-consuming for large datasets)
class_results <- TME_classification(expMat = tme_exp_matrix, minLenGeneSet = 10)

# View classification table
table(class_results$Class)

# Plot classification on t-SNE coordinates
TME_plot(tsneData = tsne_coords, Class = class_results)
```

## Dimensionality Reduction and Spatial Mapping
You can integrate t-SNE coordinates into the results to visualize specific interaction pairs across the whole dataset.

```r
# Run t-SNE
results <- scTHI_runTsne(scTHIresult = results)

# Plot clusters
scTHI_plotCluster(results, legendPos = "bottomleft")

# Plot specific interaction expression (e.g., THY1 ligand and ITGAX:ITGB2 receptor)
scTHI_plotPairs(results, interactionToplot = "THY1_ITGAX:ITGB2")
```

## Tips
- **Directionality**: Interactions are not symmetric. `cellCusterA` is treated as the source (Partner A) and `cellCusterB` as the target (Partner B).
- **Complexes**: The package handles receptor complexes (e.g., "ITGAX:ITGB2").
- **Filtering**: Use `filterCutoff` (default 0.5) to ensure partners are expressed in a minimum percentage of cells in their respective clusters.

## Reference documentation
- [Using scTHI](./references/vignette.md)
- [Using scTHI (RMarkdown)](./references/vignette.Rmd)