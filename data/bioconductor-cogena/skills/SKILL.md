---
name: bioconductor-cogena
description: The cogena package performs gene set enrichment analysis on co-expressed gene clusters to identify biological pathways and drug repositioning candidates. Use when user asks to identify co-expressed gene modules, perform cluster-based enrichment analysis, or discover drugs targeting specific disease-related expression patterns.
homepage: https://bioconductor.org/packages/release/bioc/html/cogena.html
---


# bioconductor-cogena

## Overview
The `cogena` package implements a workflow for gene set enrichment analysis of co-expressed genes. Unlike standard GSEA which often looks at all differentially expressed genes, `cogena` identifies clusters of genes with similar expression patterns and then determines which biological pathways or drugs are specifically enriched within those clusters. This is particularly powerful for drug repositioning, as it can identify drugs that target specific disease-related co-expression modules.

## Core Workflow

### 1. Data Preparation
Input data must be a matrix or ExpressionSet of differentially expressed genes (rows) across samples (columns). Gene names must be **Gene Symbols**.

```r
library(cogena)
data(Psoriasis) # Example data: DEexprs and sampleLabel

# Ensure sampleLabel is a factor with the control level first
sampleLabel <- factor(sampleLabel, levels=c("ct", "Psoriasis"))
```

### 2. Co-expression Analysis (`coExp`)
Perform clustering using various methods (e.g., hierarchical, pam, kmeans, som) and a range of cluster numbers.

```r
# Run multiple clustering methods across specified cluster numbers
genecl_result <- coExp(DEexprs, 
                       nClust=10, 
                       clMethods=c("hierarchical", "pam"), 
                       metric="correlation", 
                       method="complete", 
                       ncore=2)
```

### 3. Gene Set Enrichment (`clEnrich`)
Enrich the clusters using pre-defined gene sets (KEGG, Reactome, GO, or CMap).

```r
# Define path to GMT file (built-in or custom)
annofile <- system.file("extdata", "c2.cp.kegg.v7.01.symbols.gmt.xz", package="cogena")

# Perform enrichment
clen_res <- clEnrich(genecl_result, annofile=annofile, sampleLabel=sampleLabel)

# For a single specific clustering result (faster)
cmap_res <- clEnrich_one(genecl_result, "pam", "10", 
                         annofile=system.file("extdata", "CmapDn100.gmt.xz", package="cogena"), 
                         sampleLabel=sampleLabel)
```

## Visualization and Interpretation

### Heatmaps
*   **Expression Profiling**: `heatmapCluster(clen_res, "pam", "10")` shows the expression of genes within clusters.
*   **Enrichment Heatmap**: `heatmapPEI(clen_res, "pam", "10")` shows the -log2(FDR) enrichment scores for pathways across clusters. Use `geom="circle"` for a bubble-plot style.
*   **CMap Merged Heatmap**: `heatmapCmap(cmap_res, "pam", "10")` merges multiple instances of the same drug (e.g., different doses/times) using "mean" or "max".

### Cluster Inspection
*   **Get Genes**: `geneInCluster(clen_res, "pam", "10", "cluster_id")` returns the symbols in a specific cluster.
*   **Correlation**: `corInCluster(clen_res, "pam", "10", "cluster_id")` visualizes the correlation matrix of genes within a cluster.
*   **Expression Data**: `geneExpInCluster(clen_res, "pam", "10")` extracts the expression values and labels for further analysis.

## Drug Repositioning Logic
1.  Identify a cluster that is **up-regulated** in the disease state.
2.  Run enrichment using the **CmapDn100.gmt.xz** gene set (drugs that down-regulate these genes).
3.  Identify drugs with high enrichment scores in that specific cluster; these are candidates to reverse the disease signature.
4.  Conversely, for **down-regulated** disease clusters, use **CmapUp100.gmt.xz**.

## Reference documentation
- [cogena, a workflow for gene set enrichment analysis of co-expressed genes](./references/cogena-vignette_html.md)
- [a workflow of cogena](./references/cogena-vignette_pdf.md)