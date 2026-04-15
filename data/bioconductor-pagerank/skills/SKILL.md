---
name: bioconductor-pagerank
description: This tool prioritizes key transcription factors in gene regulatory networks using temporal and multiplex PageRank analysis. Use when user asks to calculate node importance in dynamic or multi-layered biological networks, construct gene regulatory networks from multi-omics data, or filter networks based on expression profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/pageRank.html
---

# bioconductor-pagerank

name: bioconductor-pagerank
description: Prioritize key transcriptional factors (TFs) in gene regulatory networks (GRNs) using temporal and multiplex PageRank analysis. Use this skill to calculate node importance in dynamic or multi-layered biological networks, generate GRNs from multi-omics data (ATAC-Seq, HiChIP, ARACNe), and filter networks based on expression profiles.

## Overview
The `pageRank` package implements advanced PageRank algorithms tailored for biological networks. It extends the classic steady-state PageRank to temporal networks (changing over time) and multiplex networks (multiple types of interactions between the same nodes). It is specifically designed for prioritizing Transcription Factors (TFs) by integrating gene expression, chromatin accessibility, and chromosome conformation data.

## Core Workflows

### 1. Temporal PageRank Analysis
Use `diff_graph()` to compare two igraph objects representing different time points or conditions.
```r
library(pageRank)
library(igraph)

# Graphs must have 'name' vertex attributes
diff_net <- diff_graph(graph1, graph2)

# Results:
# - 'moi' edge attribute: 1 (interaction gained), -1 (interaction lost)
# - 'pagerank' vertex attribute: temporal importance score
```

### 2. Multiplex PageRank Analysis
Use `multiplex_page_rank()` to calculate importance across layers, where a base network's topology is weighted by supplemental network information.
```r
# graph1: base network; graph2: supplemental network
# Both must have 'name' and 'pagerank' vertex attributes
multiplex_scores <- multiplex_page_rank(graph1, graph2)
```

### 3. Network Construction from Multi-Omics
The package provides functions to build GRNs from various data sources:

*   **ARACNe/Regulon:** Convert regulon objects to data frames.
    ```r
    net <- aracne_network(regulon_obj)
    ```
*   **Accessibility (ATAC-Seq):** Build networks using peaks, promoters, and TF motifs.
    ```r
    # Requires GenomicRanges, JASPAR2018, TFBSTools
    net <- accessibility_network(peak_table, promoter_regions, pfm_list, "BSgenome.Hsapiens.UCSC.hg19")
    ```
*   **Conformation (HiChIP/Hi-C):** Build networks from chromatin interaction records.
    ```r
    net <- conformation_network(interaction_table, promoter_regions, pfm_list, "BSgenome.Hsapiens.UCSC.hg19")
    ```

### 4. Filtering and Adjusting Graphs
*   **Statistical Filtering:** Use `P_graph()` to keep only significant regulator-target pairs based on joint/margin probability distributions from expression data.
    ```r
    filtered_net <- P_graph(expr_matrix, network_df, method="difference", threshold=0.05)
    ```
*   **Cleaning:** Remove small subgraphs or low-ranking nodes.
    ```r
    cleaned_graph <- clean_graph(graph, size = 5)
    ```
*   **Parameter Adjustment:** Re-calculate scores with new damping factors or personalization vectors.
    ```r
    adjusted_graph <- adjust_graph(graph, damping = 0.1)
    ```

## Tips for Success
*   **Vertex Naming:** Ensure all igraph objects have a `V(graph)$name` attribute. This is the primary key used for matching nodes across temporal or multiplex layers.
*   **Pre-requisites:** PageRank calculations often require an initial `pagerank` attribute. Use `V(graph)$pagerank <- page_rank(graph)$vector` before passing graphs to multiplex or cleaning functions.
*   **Integration:** These functions are modular. A typical pipeline involves: Constructing a network -> Filtering with `P_graph` -> Calculating temporal/multiplex scores -> Cleaning the final graph for visualization.

## Reference documentation
- [Introduction to the pageRank Package](./references/introduction.md)