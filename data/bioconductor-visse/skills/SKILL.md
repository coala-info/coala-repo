---
name: bioconductor-visse
description: This tool summarizes and visualizes gene set enrichment analysis results using network-based clustering and text-mining. Use when user asks to cluster significant gene sets, generate word clouds for biological themes, or visualize gene-level statistics and protein-protein interactions within functional groups.
homepage: https://bioconductor.org/packages/release/bioc/html/vissE.html
---

# bioconductor-visse

name: bioconductor-visse
description: Summarize and visualize gene set enrichment analysis (GSEA) results using network-based clustering and text-mining. Use this skill when you need to interpret long lists of significant gene sets by grouping them into functional clusters, generating word clouds for biological themes, or visualizing gene-level statistics and protein-protein interactions (PPI) within those clusters.

## Overview

The `vissE` package (Visualising Set Enrichment Analysis Results) addresses the challenge of interpreting large lists of significant gene sets resulting from enrichment analyses (e.g., GSEA, limma::fry). It uses a similarity-based network approach to cluster related gene sets and applies text-mining to automate the characterization of biological themes.

## Core Workflow

### 1. Data Preparation
Load the necessary libraries and prepare your gene set collection (typically from MSigDB).

```r
library(vissE)
library(msigdb)
library(GSEABase)

# Load MSigDB and subset to relevant collections (e.g., H, C2, C5)
msigdb_hs = getMsigdb()
msigdb_hs = subsetCollection(msigdb_hs, c('h', 'c2', 'c5'))

# Filter MSigDB to only include your significant gene sets from your analysis
# geneset_res is a character vector of gene set names
geneset_gsc = msigdb_hs[geneset_res]
```

### 2. Network Construction and Clustering
Compute overlaps between gene sets and identify clusters.

```r
# Compute overlap (Jaccard index is default)
gs_ovlap = computeMsigOverlap(geneset_gsc, thresh = 0.25)

# Create the network
gs_ovnet = computeMsigNetwork(gs_ovlap, msigdb_hs)

# Identify clusters (walktrap algorithm is recommended for dense graphs)
# geneset_stats is a named vector of enrichment scores/statistics
library(igraph)
grps = findMsigClusters(gs_ovnet, 
                        genesetStat = geneset_stats, 
                        alg = cluster_walktrap, 
                        minSize = 5)
```

### 3. Visualization and Interpretation
`vissE` provides several ways to visualize the clusters and their biological meaning.

*   **Network Plot:** Visualize the connectivity of gene sets.
    ```r
    plotMsigNetwork(gs_ovnet, markGroups = grps[1:6], genesetStat = geneset_stats)
    ```
*   **Word Clouds:** Extract biological themes using text-mining on gene set names or descriptions.
    ```r
    # type can be 'Name' or 'Short' (description)
    plotMsigWordcloud(msigdb_hs, grps[1:6], type = 'Name')
    ```
*   **Gene Statistics:** View the distribution of gene-level statistics (e.g., logFC) within clusters.
    ```r
    # gene_stats is a named vector of gene-level statistics
    plotGeneStats(gene_stats, msigdb_hs, grps[1:6])
    ```
*   **PPI Networks:** Visualize protein-protein interactions for genes within a cluster.
    ```r
    ppi = getIMEX('hs', inferred = TRUE)
    plotMsigPPI(ppi, msigdb_hs, grps[1:6], geneStat = gene_stats)
    ```

## Tips for Effective Use
*   **Overlap Metric:** Use the default Jaccard index for general similarity. Consider the "overlap coefficient" if you want to emphasize hierarchical relationships (e.g., in Gene Ontology).
*   **Filtering:** Use `rmUnmarkedGroups = TRUE` in `plotMsigNetwork` to focus only on the identified clusters and reduce visual clutter.
*   **Integration:** Use the `patchwork` package to combine word clouds, networks, and gene plots into a single explanatory figure for publication.

## Reference documentation
- [vissE: Visualising Set Enrichment Analysis Results.](./references/vissE.Rmd)
- [vissE: Visualising Set Enrichment Analysis Results.](./references/vissE.md)