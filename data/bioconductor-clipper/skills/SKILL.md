---
name: bioconductor-clipper
description: The bioconductor-clipper package performs topological pathway analysis to identify significant differences in gene expression means and interactions between experimental conditions. Use when user asks to perform topological pathway analysis, test for differences in pathway mean or covariance, identify significant sub-paths, or prune redundant pathway results.
homepage: https://bioconductor.org/packages/release/bioc/html/clipper.html
---

# bioconductor-clipper

## Overview

The `clipper` package implements a two-step approach for pathway analysis that exploits pathway topology. Unlike standard enrichment methods (like GSEA) that treat pathways as simple gene lists, `clipper` uses graph decomposition theory to:
1.  Identify pathways where the mean expression and/or the strength of gene interactions (covariance) differ significantly between experimental conditions.
2.  Pinpoint the specific portions (sub-paths) of the pathway most associated with the phenotype.

## Core Workflow

### 1. Data Preparation
`clipper` requires three main inputs: an expression matrix (or ExpressionSet), a class vector, and a pathway graph.

```R
library(clipper)
library(graphite)
library(graph)

# 1. Get pathway topology (e.g., from graphite)
kegg <- pathways("hsapiens", "kegg")
p_graph <- pathwayGraph(convertIdentifiers(kegg[["Chronic myeloid leukemia"]], "entrez"))

# 2. Prepare expression data (log-transformed recommended)
# Rows must be genes (matching graph nodes), columns are samples
# Example: "ENTREZID:123"
exp_data <- exprs(myExpressionSet) 

# 3. Define classes (numeric vector: 1 and 2)
# Ensure names(classes) matches colnames(exp_data)
classes <- c(rep(1, n1), rep(2, n2))
names(classes) <- colnames(exp_data)
```

### 2. Global Pathway Testing
Use `pathQ` to test if a whole pathway is significantly altered in terms of mean or variance.

```R
# nperm: permutations for p-value calculation
# alphaV: significance level for the variance test
pathwayAnalysis <- pathQ(exp_data, classes, p_graph, nperm=100, alphaV=0.05)

# Results
pathwayAnalysis$alphaVar  # p-value for concentration matrices (variance/interactions)
pathwayAnalysis$alphaMean # p-value for means
```

### 3. Identifying Significant Sub-paths
If a pathway is significant, use `clipper` or `easyClip` to find the specific "clipped" sub-paths.

```R
# Identify sub-paths based on variance ("var") or mean ("mean")
clipped <- clipper(exp_data, classes, p_graph, "var", trZero=0.01, permute=FALSE)

# Prune overlapping paths to simplify results
# thr: dissimilarity threshold (higher = more pruning)
clipped_pruned <- prunePaths(clipped, thr=0.2)

# Quick summary of genes involved
easyLook(clipped_pruned)
```

### 4. Visualization
Results can be visualized in Cytoscape via the `RCy3` package.

```R
# Highlights the most significant path in the graph
plotInCytoscape(p_graph, clipped_pruned[1,])
```

## Key Functions

- `pathQ()`: Performs the global test on pathway means and concentration matrices.
- `clipper()`: The primary engine for identifying significant sub-paths within a pathway.
- `easyClip()`: A wrapper function that executes the standard analysis pipeline (testing and clipping) in one step.
- `prunePaths()`: Reduces redundancy in the output by removing highly similar sub-paths.
- `easyLook()`: Formats the output of `clipper` or `easyClip` for easier human readability, showing max scores and involved Entrez IDs.

## Tips for Success
- **Log-transformation**: Always use log-transformed data as the method assumes Gaussian graphical models.
- **ID Consistency**: Ensure gene identifiers in your expression matrix exactly match the node names in the graph (e.g., including the "ENTREZID:" prefix if using `graphite`).
- **Graph Objects**: The package expects `graphNEL` objects. Use `pathwayGraph()` from the `graphite` package to convert pathway objects.
- **Interpretation**: A significant `alphaVar` suggests the biological wiring/interaction strength between genes has changed, even if individual gene means haven't.

## Reference documentation
- [Along signal paths: an empirical gene set approach exploiting pathway topology](./references/clipper.md)