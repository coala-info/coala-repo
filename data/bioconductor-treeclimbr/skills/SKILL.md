---
name: bioconductor-treeclimbr
description: treeclimbR is a framework for analyzing hierarchical data at an optimal resolution by evaluating signal aggregation across tree nodes. Use when user asks to perform differential abundance or differential state analysis on hierarchical data, find the optimal resolution for tree-based signals, or aggregate data across phylogenetic or clustering trees.
homepage: https://bioconductor.org/packages/release/bioc/html/treeclimbR.html
---

# bioconductor-treeclimbr

## Overview

`treeclimbR` is a framework for analyzing hierarchical data (like microbial phylogenies or cell-type clustering trees) at an optimal level of resolution. Instead of testing only at the leaves (e.g., species) or at a fixed taxonomic level (e.g., genus), it evaluates multiple aggregation candidates to find branches where signals are most concordant. This approach balances the increased power of aggregation with the precision of high-resolution analysis.

## Core Workflow

The typical `treeclimbR` workflow involves four main stages: aggregation, differential testing, candidate generation, and evaluation.

### 1. Data Preparation and Aggregation
Data should be stored in a `TreeSummarizedExperiment` (TSE) object containing a `rowTree` (for DA) or `colTree` (for DS).

```r
library(treeclimbR)
library(TreeSummarizedExperiment)

# For Differential Abundance (DA) - aggregate leaf counts to internal nodes
all_node <- showNode(tree = rowTree(tse), only.leaf = FALSE)
tse_agg <- aggTSE(x = tse, rowLevel = all_node, rowFun = sum)
```

### 2. Differential Analysis
Perform testing on all nodes (leaves + internal nodes). While any method works, `treeclimbR` provides wrappers for `edgeR`.

```r
# DA Analysis
da_res <- runDA(tse_agg, assay = "counts", option = "glmQL",
                design = model.matrix(~ group, data = colData(tse_agg)),
                contrast = c(0, 1))

# Extract results table
da_tbl <- nodeResult(da_res, n = Inf, type = "DA")
```

### 3. Finding Candidates
Generate a set of aggregation candidates based on a threshold parameter $t$.

```r
da_cand <- getCand(tree = rowTree(tse_agg), 
                   score_data = da_tbl,
                   node_column = "node", 
                   p_column = "PValue",
                   sign_column = "logFC")
```

### 4. Selecting the Optimal Resolution
Evaluate the candidates to find the best aggregation level that controls the False Discovery Rate (FDR).

```r
da_best <- evalCand(tree = rowTree(tse_agg), 
                    levels = da_cand$candidate_list,
                    score_data = da_tbl, 
                    node_column = "node",
                    p_column = "PValue", 
                    sign_column = "logFC")

# Extract significant nodes at the optimal level
da_out <- topNodes(object = da_best, n = Inf, p_value = 0.05)
```

## Differential State (DS) Analysis

For single-cell data where you want to find genes differentially expressed within clusters or groups of clusters:

1. **Aggregate**: Use `aggDS()` to create pseudobulk assays for every node in the tree.
2. **Test**: Use `runDS()` to perform testing per gene, per node.
3. **Candidates**: Generate candidates per gene (split the result table by feature).
4. **Evaluate**: Use `evalCand(..., type = "multiple")` to find the optimal resolution for each gene.

```r
# Example DS candidate generation per gene
ds_tbl_list <- split(ds_tbl, f = ds_tbl$feature)
ds_cand_list <- lapply(ds_tbl_list, function(x) {
    getCand(tree = colTree(ds_tse), score_data = x, ...)$candidate_list
})
```

## Visualization and Utilities

*   **TreeHeatmap()**: Visualize the tree alongside a heatmap of scaled counts.
*   **infoCand()**: View a summary of all evaluated candidates to see which was selected as `best`.
*   **findDescendant()**: Identify which leaves belong to a specific significant internal node.
*   **convertNode()**: Switch between node numbers and labels.

## Tips for Success

*   **Sign Consistency**: `treeclimbR` aggregates nodes that show the same direction of change (sign of logFC). If a branch has mixed signals, it will likely not be aggregated.
*   **Filtering**: Use `filter_min_total_count` in `runDA` or `runDS` to remove nodes with insufficient data before testing, as this improves the FDR adjustment.
*   **T-values**: The `threshold` in `getCand` (often 0.01 to 1) determines the granularity of candidates. A denser sequence of $t$ values provides a more refined search for the optimal level.

## Reference documentation

- [Finding optimal resolution of hierarchical hypotheses with treeclimbR](./references/treeclimbR.md)