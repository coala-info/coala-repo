---
name: bioconductor-cbnplot
description: CBNplot infers and visualizes Bayesian networks for genes or pathways by integrating expression data with enrichment analysis results. Use when user asks to infer gene-level networks within a pathway, visualize relationships between multiple enriched pathways, or perform network inference based on clusterProfiler results.
homepage: https://bioconductor.org/packages/release/bioc/html/CBNplot.html
---


# bioconductor-cbnplot

## Overview
CBNplot (Bayesian Network plot) is an R package designed to bridge the gap between enrichment analysis and network inference. It uses expression data to infer Bayesian networks based on the results of `clusterProfiler` or `ReactomePA`. This allows researchers to visualize not just which pathways are enriched, but how genes within those pathways (or the pathways themselves) interact based on conditional dependencies.

## Core Functions

### Gene-level Networks (`bngeneplot`)
Infers a Bayesian network for genes within a specific enriched pathway.
- **Key Arguments**:
  - `results`: Enrichment object (e.g., from `enrichKEGG` or `enrichGO`).
  - `exp`: Normalized expression matrix (rows as genes, columns as samples).
  - `pathNum`: The row number of the pathway in the enrichment result to plot.
  - `expRow`: The ID type used in the expression matrix (e.g., "ENTREZID" or "SYMBOL").
  - `returnNet`: Set to `TRUE` to return the network object, strength data, and raw values.

### Pathway-level Networks (`bnpathplot`)
Infers a network showing the relationships between different pathways.
- **Key Arguments**:
  - `nCategory`: Number of top enriched pathways to include in the network.
  - `shadowText`: Boolean to add a shadow effect to labels for better readability.

### Custom Visualizations (`bngeneplotCustom`, `bnpathplotCustom`)
Provides advanced styling options for the networks.
- **glowEdgeNum**: Highlights specific edges.
- **hub**: Highlights hub nodes (nodes with high centrality).
- **fontFamily**: Sets the font for the plot (e.g., "sans", "serif").

## Typical Workflow

1.  **Perform Enrichment**: Use `clusterProfiler` to identify enriched terms.
    ```r
    library(clusterProfiler)
    library(org.Hs.eg.db)
    pway <- enrichKEGG(gene = gene_list, organism = 'hsa')
    pway <- setReadable(pway, org.Hs.eg.db, keyType="ENTREZID")
    ```

2.  **Prepare Expression Data**: Ensure your expression matrix row names match the ID type in your enrichment results.
    ```r
    # counts should be a matrix or data frame of normalized values
    ```

3.  **Generate Plot**:
    ```r
    library(CBNplot)
    bngeneplot(results = pway, exp = counts, pathNum = 1)
    ```

4.  **Extract Network Data**:
    ```r
    ret <- bngeneplot(results = pway, exp = counts, pathNum = 1, returnNet = TRUE)
    # Access strength of connections
    head(ret$str)
    # Access the averaged network
    avg_net <- ret$av
    ```

## Tips and Best Practices
- **ID Matching**: The `expRow` parameter is critical. If your enrichment results use Gene Symbols but your matrix uses Entrez IDs, the function will fail to map the data.
- **Network Analysis**: The output of `returnNet=TRUE` includes an `av` (averaged network) slot. You can convert this to an `igraph` object using `bnlearn::as.igraph(ret$av)` for further topological analysis (e.g., centrality measures).
- **Sample Size**: Bayesian network inference is sensitive to sample size. Ensure your `exp` matrix contains enough samples for meaningful conditional probability estimation.
- **Interactive Exploration**: For complex networks, use the `Custom` versions of the functions to highlight "hubs" to identify key regulatory genes within a pathway.

## Reference documentation
- [CBNplot: Bayesian network plot for clusterProfiler results](./references/CBNplot_basic_usage.md)
- [CBNplot Basic Usage RMarkdown](./references/CBNplot_basic_usage.Rmd)