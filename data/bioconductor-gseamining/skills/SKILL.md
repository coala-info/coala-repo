---
name: bioconductor-gseamining
description: GSEAmining visualizes and clusters Gene Set Enrichment Analysis results based on leading-edge gene overlap to identify biological themes. Use when user asks to cluster gene sets, visualize enriched terms in word clouds, identify core genes driving enrichment, or reduce redundancy in GSEA outputs.
homepage: https://bioconductor.org/packages/release/bioc/html/GSEAmining.html
---

# bioconductor-gseamining

name: bioconductor-gseamining
description: Visualizing and mining Gene Set Enrichment Analysis (GSEA) results by clustering gene sets based on leading-edge gene overlap. Use this skill when you need to interpret complex GSEA outputs, reduce redundancy in enriched terms, or identify core genes driving enrichment across multiple related gene sets.

# bioconductor-gseamining

## Overview

GSEAmining is an R package designed to simplify the interpretation of Gene Set Enrichment Analysis (GSEA) results. It addresses the challenge of "result overload" by clustering gene sets that share similar "leading edge" (core enrichment) genes. By grouping gene sets with overlapping biological drivers, it allows researchers to identify themes through word clouds of enriched terms and bar plots of the most frequent core genes within each cluster.

## Workflow and Core Functions

### 1. Data Preparation and Filtering

GSEAmining requires a data frame with at least three columns: `ID` (gene set name), `NES` (Normalized Enrichment Score), and `core_enrichment` (a string of gene symbols separated by `/`).

```r
library(GSEAmining)

# Filter results to focus on significant or high-impact gene sets
# p.adj: p-value threshold
# neg_NES: threshold for negative enrichment (absolute value)
# pos_NES: threshold for positive enrichment
gs.filt <- gm_filter(gsea_results, 
                     p.adj = 0.05, 
                     neg_NES = 2.0, 
                     pos_NES = 2.0)
```

### 2. Clustering Gene Sets

The package uses the binary distance of core enrichment genes to perform hierarchical clustering.

```r
# Create a gm_clust object
gs.cl <- gm_clust(gs.filt)
```

### 3. Visualization

GSEAmining provides three primary visualization methods to explore the clusters:

*   **Dendrograms**: Visualize the hierarchy and enrichment direction.
    ```r
    gm_dendplot(gs.filt, gs.cl)
    ```
*   **Enriched Terms (Word Clouds)**: Identify common biological themes in gene set names within clusters.
    ```r
    # Set clust = FALSE to see terms across all filtered sets without grouping
    gm_enrichterms(gs.filt, gs.cl)
    ```
*   **Core Gene Enrichment (Bar Plots)**: Identify the specific genes appearing most frequently in the leading edge of each cluster.
    ```r
    # Use 'top' to limit the number of genes displayed
    gm_enrichcores(gs.filt, gs.cl, top = 10)
    ```

### 4. Reporting

Generate a comprehensive PDF report containing word clouds and bar plots for every identified cluster.

```r
gm_enrichreport(gs.filt, gs.cl, output = 'GSEA_Mining_Report')
```

## Usage Tips

*   **Input Compatibility**: While designed to work seamlessly with `clusterProfiler` output, any data frame meeting the column naming requirements (`ID`, `NES`, `core_enrichment`) is compatible.
*   **Leading Edge Format**: Ensure the `core_enrichment` column uses the forward slash `/` as a separator between gene symbols.
*   **Color Customization**: Most plotting functions allow customization of colors for positive (`col_pos`) and negative (`col_neg`) enrichment to match publication requirements.
*   **Cluster Granularity**: If the dendrogram is too crowded, increase the stringency of the `gm_filter` parameters to focus on the most significant biological signals.

## Reference documentation

- [GSEAmining](./references/GSEAmining.md)