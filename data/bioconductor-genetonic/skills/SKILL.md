---
name: bioconductor-genetonic
description: GeneTonic integrates RNA-seq differential expression results with functional enrichment analysis for comprehensive data interpretation. Use when user asks to launch an interactive Shiny dashboard, create enrichment maps, generate bipartite graphs, or visualize gene set expression patterns.
homepage: https://bioconductor.org/packages/release/bioc/html/GeneTonic.html
---

# bioconductor-genetonic

name: bioconductor-genetonic
description: Use when analyzing and integrating RNA-seq results from differential expression (DE) and functional enrichment analysis. This skill helps in creating GeneTonicList objects, launching the interactive Shiny application, and generating visualizations like enrichment maps, bipartite graphs, and signature heatmaps for gene sets.

# bioconductor-genetonic

## Overview

GeneTonic is a Bioconductor package designed for the streamlined interpretation of RNA-seq data. It integrates three main components: expression data (DESeqDataSet), differential expression results (DESeqResults), and functional enrichment results (data.frame). It provides both an interactive Shiny dashboard for exploration and a suite of standalone R functions for static visualization and automated reporting.

## Core Workflow

### 1. Required Input Objects

To use GeneTonic, you must prepare four specific objects:

*   **dds**: A `DESeqDataSet` (from `DESeq2`) containing the expression matrix.
*   **res_de**: A `DESeqResults` object containing the DE analysis results.
*   **res_enrich**: A `data.frame` containing functional enrichment results (e.g., from topGO or clusterProfiler).
*   **annotation_obj**: A `data.frame` with at least `gene_id` (matching dds rownames) and `gene_name` (symbols).

### 2. Data Preparation

Before launching the app, format the enrichment results and calculate aggregate scores:

```R
library(GeneTonic)

# Convert enrichment results from common tools
res_enrich <- shake_topGOtableResult(topgo_output) 
# or shake_enrichResult(clusterProfiler_output)

# Calculate z-scores and aggregate scores for gene sets
res_enrich <- get_aggrscores(
  res_enrich = res_enrich,
  res_de = res_de,
  annotation_obj = anno_df,
  aggrfun = mean
)
```

### 3. Creating a GeneTonicList (GTL)

The `GeneTonicList` is the recommended container for all inputs:

```R
gtl <- GeneTonicList(
  dds = dds,
  res_de = res_de,
  res_enrich = res_enrich,
  annotation_obj = anno_df
)

# Validate the object
checkup_gtl(gtl)
```

### 4. Launching the Interactive App

```R
GeneTonic(gtl = gtl)
```

## Standalone Visualizations

GeneTonic provides functions to generate plots without the Shiny interface:

*   **Enrichment Map**: Shows relationships between gene sets based on gene overlap.
    ```R
    enrichment_map(gtl = gtl, n_gs = 30)
    ```
*   **Bipartite Graph**: Connects genes to the gene sets they belong to.
    ```R
    ggs_graph(gtl = gtl, n_gs = 20)
    ```
*   **Signature Heatmap**: Displays expression of genes within a specific gene set.
    ```R
    gs_heatmap(gtl = gtl, geneset_id = "GO:0060337")
    ```
*   **Volcano Plot (Gene Sets)**: Plots gene set significance vs. Z-score.
    ```R
    gs_volcano(gtl = gtl, p_threshold = 0.05)
    ```
*   **Sankey/Alluvial Diagram**: Visualizes N:N membership relationships.
    ```R
    gs_alluvial(gtl = gtl, n_gs = 5)
    ```

## Automated Reporting

Use the `happy_hour()` function to generate a comprehensive HTML report based on specific genes or gene sets of interest:

```R
happy_hour(
  gtl = gtl,
  project_id = "my_analysis",
  mygenesets = c("GO:0002250", "GO:0060333"),
  mygenes = c("IRF1", "GBP2"),
  open_after_creating = TRUE
)
```

## Tips for Success

*   **Identifiers**: Ensure `rownames(dds)` match the `gene_id` column in the `annotation_obj`.
*   **Gene Symbols**: The `res_de` object should ideally have a `SYMBOL` column for better labeling in plots.
*   **Simplification**: If enrichment results are too redundant, use `gs_simplify(res_enrich, gs_overlap = 0.7)` to merge similar terms.
*   **Fuzzy Clustering**: Use `gs_fuzzyclustering()` to identify groups of related gene sets where a set can belong to multiple clusters.

## Reference documentation

- [GeneTonic User's Guide](./references/GeneTonic_manual.md)