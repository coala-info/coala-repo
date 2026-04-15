---
name: bioconductor-epiregulon.extra
description: This tool provides statistical and visualization methods for interpreting transcription factor activity and gene regulatory networks in single-cell multiomic data. Use when user asks to calculate TF activity scores, identify differential TF activity between cell clusters, perform gene set enrichment on regulons, or visualize network topology.
homepage: https://bioconductor.org/packages/release/bioc/html/epiregulon.extra.html
---

# bioconductor-epiregulon.extra

name: bioconductor-epiregulon.extra
description: Specialized for visualizing transcription factor (TF) activity and gene regulatory networks (GRN) using the epiregulon.extra R package. Use this skill when analyzing single-cell multiomic data to identify differential TF activity, perform gene set enrichment on regulons, and compare network topologies between cell clusters.

## Overview

`epiregulon.extra` is a companion to the `epiregulon` package. While `epiregulon` focuses on the construction of gene regulatory networks, `epiregulon.extra` provides the statistical and visualization framework to interpret these networks. It enables the calculation of TF activity scores, identification of cluster-specific TFs, and the analysis of differential network topology (e.g., identifying TFs that gain or lose centrality between conditions).

## Core Workflows

### 1. TF Activity Calculation and Differential Analysis
After constructing a regulon object with `epiregulon`, use this package to quantify TF activity per cell.

```r
library(epiregulon.extra)

# Calculate activity scores (usually weighted mean of target gene expression)
score.combine <- calculateActivity(
  expMatrix = GeneExpressionMatrix,
  regulon = regulon,
  mode = "weight",
  method = "weightedMean",
  exp_assay = "normalizedCounts"
)

# Find markers (TFs with differential activity between clusters)
markers <- findDifferentialActivity(
  activity_matrix = score.combine,
  clusters = GeneExpressionMatrix$hash_assignment,
  test.type = "t"
)

# Extract top significant TFs
markers.sig <- getSigGenes(markers, topgenes = 5)
```

### 2. Visualization of TF Activity
The package provides several ways to visualize activity scores, which are often less sparse than raw TF gene expression.

*   **Bubble Plots:** `plotBubble(score.combine, tf = c("GATA6", "NKX2-1"), clusters = clusters)`
*   **Violin Plots:** `plotActivityViolin(score.combine, tf = "GATA6", clusters = clusters)`
*   **Dimensional Reduction (UMAP/TSNE):** 
    ```r
    plotActivityDim(sce = GeneExpressionMatrix, activity_matrix = score.combine, tf = "GATA6", dimtype = "UMAP")
    ```
*   **Heatmaps:** `plotHeatmapActivity()` for activity scores or `plotHeatmapRegulon()` to see TF-target relationships.

### 3. Regulon Gene Set Enrichment
Identify biological pathways associated with specific TF regulons.

```r
# Perform enrichment on targets of specific TFs
enrichresults <- regulonEnrich(
  TF = c("GATA6", "NKX2-1"),
  regulon = regulon,
  weight_cutoff = 0.1,
  genesets = gs.list # data.frame with 'gs' and 'genes' columns
)

# Visualize enrichment
enrichPlot(results = enrichresults)
plotGseaNetwork(tf = "GATA6", enrichresults = enrichresults)
```

### 4. Network Topology Analysis
Analyze how the regulatory landscape changes between cell states by comparing network graphs.

*   **Differential Networks:** Visualize targets of a TF that are specific to certain clusters.
    ```r
    plotDiffNetwork(regulon, tf = "GATA6", clusters = c("Cluster1", "Cluster2"))
    ```
*   **Centrality Ranking:** Identify TFs that are "hubs" in one condition vs another.
    ```r
    # Build graphs for two conditions
    net1 <- buildGraph(regulon, weights = "weight", cluster = "C1")
    net2 <- buildGraph(regulon, weights = "weight", cluster = "C5")
    
    # Calculate differential centrality
    diff_graph <- buildDiffGraph(net1, net2)
    diff_graph <- addCentrality(diff_graph)
    rank_table <- rankTfs(diff_graph)
    ```

## Tips for Success
*   **Sparsity:** Use `plotActivityDim` to compare TF activity vs. TF gene expression; activity scores are typically much more robust for visualization in single-cell data.
*   **Pruning:** Ensure the `regulon` object has been pruned (e.g., via `epiregulon::pruneRegulon`) before performing differential network analysis to ensure cluster-specific weights are available.
*   **Normalization:** When calculating activity, if the number of targets varies significantly between TFs, ensure `normalize = TRUE` (default) in `calculateActivity` to account for regulon size.

## Reference documentation
- [Data visualization with epiregulon.extra](./references/Data_visualization.md)
- [Data visualization with epiregulon.extra (RMarkdown Source)](./references/Data_visualization.Rmd)