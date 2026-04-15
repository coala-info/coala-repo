---
name: bioconductor-tradeseq
description: This tool performs trajectory-based differential expression analysis for single-cell RNA-seq data using Generalized Additive Models. Use when user asks to perform statistical inference on gene expression changes along pseudotime, compare expression patterns between lineages, or identify early drivers of differentiation.
homepage: https://bioconductor.org/packages/release/bioc/html/tradeSeq.html
---

# bioconductor-tradeseq

name: bioconductor-tradeseq
description: Trajectory-based differential expression analysis for single-cell RNA-seq (and other modalities) using Generalized Additive Models (GAMs). Use this skill when you need to perform statistical inference on gene expression changes along pseudotime, compare lineages, or identify marker genes for specific trajectory stages using the tradeSeq R package.

# bioconductor-tradeseq

## Overview
`tradeSeq` is an R package designed for differential expression (DE) analysis along trajectories. It fits a negative binomial Generalized Additive Model (NB-GAM) for each gene, allowing for flexible smoothing of expression patterns across pseudotime. It is compatible with various trajectory inference methods (e.g., Slingshot, Monocle 3, CellRank) and provides a suite of statistical tests to identify genes associated with pseudotime, genes that differ between lineages, and early drivers of differentiation.

## Core Workflow

### 1. Data Preparation
`tradeSeq` requires a count matrix (raw counts), pseudotime values, and cell weights (probability of a cell belonging to a lineage).

```r
library(tradeSeq)
# counts: matrix of raw counts (genes x cells)
# pseudotime: matrix (cells x lineages)
# cellWeights: matrix (cells x lineages)
```

### 2. Choosing the Number of Knots (K)
Knots define the flexibility of the GAM smoother. Use `evaluateK` to find the optimal bias-variance tradeoff using AIC.

```r
set.seed(5)
icMat <- evaluateK(counts = counts, 
                   pseudotime = pseudotime, 
                   cellWeights = cellWeights, 
                   k = 3:10, 
                   nGenes = 200)
# Look for where the AIC drop levels off in the diagnostic plots.
```

### 3. Fitting the Models
The `fitGAM` function is the primary engine. It can take a `SlingshotDataSet` directly or manual matrices.

```r
# Using Slingshot object
sce <- fitGAM(counts = counts, sds = crv, nknots = 6)

# Using manual input
sce <- fitGAM(counts = counts, 
              pseudotime = pseudotime, 
              cellWeights = cellWeights, 
              nknots = 6)

# Check convergence
table(rowData(sce)$tradeSeq$converged)
```

## Statistical Tests

### Within-Lineage Tests
*   **associationTest**: Tests if expression changes significantly along pseudotime.
*   **startVsEndTest**: Compares expression at the beginning (progenitor) vs. the end (differentiated) of a lineage.

```r
assoc_res <- associationTest(sce)
startEnd_res <- startVsEndTest(sce, lineages = TRUE)
```

### Between-Lineage Tests
*   **diffEndTest**: Compares expression at the endpoints of different lineages (differentiated markers).
*   **patternTest**: Tests if the overall expression pattern (shape of the curve) differs between lineages.
*   **earlyDETest**: Tests for DE between lineages at a specific region (e.g., near a bifurcation) by specifying knots.

```r
end_res <- diffEndTest(sce)
pattern_res <- patternTest(sce)
early_res <- earlyDETest(sce, knots = c(1, 2))
```

## Visualization and Clustering
*   **plotSmoothers**: Visualizes the fitted GAM curves for specific genes.
*   **plotGeneCount**: Visualizes raw counts along the trajectory or in reduced dimensions.
*   **clusterExpressionPatterns**: Clusters genes based on their fitted smoothers.

```r
plotSmoothers(sce, counts, gene = "GeneName")
plotGeneCount(crv, counts, gene = "GeneName")

# Clustering
clusPat <- clusterExpressionPatterns(sce, nPoints = 20, genes = de_genes)
```

## Advanced Features
*   **Covariates**: Add batch effects or other conditions using the `U` argument (design matrix).
*   **Zero-Inflation**: Provide observation-level weights (e.g., from `zinbwave`) to the `weights` argument.
*   **Large Datasets**: Use the `l2fc` argument in tests to enforce a log2 fold-change threshold for biological relevance.
*   **Parallelization**: Set `parallel = TRUE` and provide a `BPPARAM` object.

## Reference documentation
- [Using Monocle as input to tradeSeq](./references/Monocle.md)
- [CellRank](./references/cellRankVignette.Rmd)
- [Fitting the models and additional control of fitGAM in tradeSeq](./references/fitGAM.md)
- [Working with multiple conditions](./references/multipleConditions.md)
- [The tradeSeq workflow](./references/tradeSeq.md)