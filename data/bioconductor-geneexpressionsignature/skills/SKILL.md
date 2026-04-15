---
name: bioconductor-geneexpressionsignature
description: This package compares biological states by converting gene expression profiles into ranked lists and calculating similarity distances between them. Use when user asks to rank gene expression data, merge replicates into prototype ranked lists, or calculate distance matrices for drug repositioning and mode of action studies.
homepage: https://bioconductor.org/packages/release/bioc/html/GeneExpressionSignature.html
---

# bioconductor-geneexpressionsignature

## Overview

The `GeneExpressionSignature` package provides a framework for comparing different biological states by converting gene expression profiles into ranked lists. It is particularly useful for drug repositioning studies or identifying common modes of action across different experiments. The workflow typically involves ranking genes by differential expression, merging replicates or related conditions into a single "Prototype Ranked List" (PRL), and then calculating a similarity/distance matrix between these states.

## Core Workflow

### 1. Data Ranking
Before analysis, expression data must be ranked. While users can provide their own ranked matrices, the package provides `getRLs` for C-MAP style preprocessing.

```r
library(GeneExpressionSignature)
# control and treatment are matrices of expression values
# Returns a matrix of ranks
ranked_list <- getRLs(control, treatment)
```

### 2. Rank Merging
When multiple experiments or cell lines represent the same biological state (e.g., the same drug), they should be merged into a Prototype Ranked List (PRL).

```r
# Input: ExpressionSet where assayData contains ranks and phenoData defines states
# Method: "Spearman" (recommended) or "Kendall"
MergingSet <- RankMerging(exampleSet, "Spearman", weighted = TRUE)
```

### 3. Similarity Measuring
Calculate the distance between biological states using either GSEA or PGSEA. A distance of 0 indicates high similarity; 1 indicates no similarity (or inverse correlation).

```r
# Using GSEA (Non-parametric)
# 250 is the signature length (top/bottom genes)
# "avg" is the distance scoring method
dist_matrix <- ScoreGSEA(MergingSet, 250, "avg")

# Using PGSEA (Parametric)
dist_matrix_p <- ScorePGSEA(MergingSet, 250, "avg")
```

### 4. Integrated Entry Point
The `SignatureDistance` function wraps the merging and scoring steps into a single call.

```r
ds <- SignatureDistance(
  exampleSet,
  SignatureLength = 250,
  MergingDistance = "Spearman",
  ScoringMethod = "GSEA",
  ScoringDistance = "avg",
  weighted = TRUE
)
```

## Downstream Analysis

The resulting distance matrix can be used for clustering to identify groups of similar biological states.

```r
if (require(apcluster)) {
  # Convert distance to similarity for apcluster
  clusterResult <- apcluster(1 - ds)
  plot(clusterResult)
}
```

## Tips and Best Practices
- **Platform Consistency**: This package is designed for data from the same platform (e.g., HG-U133A). It does not inherently handle cross-platform normalization.
- **Signature Length**: The default `SignatureLength = 250` is standard for genome-wide profiles, representing the top 250 up-regulated and bottom 250 down-regulated genes.
- **Performance**: Use "Spearman" for `MergingDistance` as "Kendall" is significantly more computationally expensive.
- **Input Format**: Ensure your `ExpressionSet` has a `state` column in its `phenoData` to guide the `RankMerging` function.

## Reference documentation
- [GeneExpressionSignature: Computing pairwise distances between different biological states](./references/GeneExpressionSignature.md)
- [GeneExpressionSignature Vignette Source](./references/GeneExpressionSignature.Rmd)