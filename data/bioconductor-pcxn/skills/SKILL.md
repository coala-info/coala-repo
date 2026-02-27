---
name: bioconductor-pcxn
description: This tool explores and analyzes correlation relationships between biological pathways and gene sets. Use when user asks to discover correlated pathways, analyze relationships between pathway groups, visualize correlations via heatmaps or networks, or retrieve gene members for specific pathways.
homepage: https://bioconductor.org/packages/3.8/bioc/html/pcxn.html
---


# bioconductor-pcxn

name: bioconductor-pcxn
description: Explore and analyze correlation relationships between biological pathways and gene sets using the pcxn package. Use this skill to discover correlated pathways, analyze relationships between groups of pathways (e.g., from GSEA results), visualize correlations via heatmaps or networks, and retrieve gene members for specific pathways across collections like MSigDB (H, C2, C5) and Pathprint.

# bioconductor-pcxn

## Overview

The `pcxn` package (Pathway Co-expression Network) allows users to explore correlations between biological pathways and gene sets. It helps identify how pathways are related to one another, which is critical for understanding biological context beyond simple enrichment analysis. It supports four major collections: MSigDB H (Hallmark), MSigDB C2 (Canonical Pathways), MSigDB C5 (GO Biological Process), and Pathprint.

## Core Workflows

### 1. Data Preparation
The package requires `pcxnData` to be loaded to access the correlation matrices and gene set definitions.

```r
library(pcxn)
library(pcxnData)

# Load necessary data objects for the specific collection being used
data(list = c("pathprint.Hs.gs", 
              "pathCor_pathprint_v1.2.3_dframe", 
              "pathCor_pathprint_v1.2.3_unadjusted_dframe",
              "pathCor_CPv5.1_dframe", 
              "gobp_gs_v5.1"))
```

### 2. Exploring a Single Pathway
Use `pcxn_explore` to find pathways correlated with a specific query.

```r
# Find the top 10 pathways correlated with Alzheimer's disease in Pathprint
pcxn.obj <- pcxn_explore(collection = "pathprint", 
                         query_geneset = "Alzheimer's disease (KEGG)",
                         adj_overlap = TRUE, 
                         top = 10, 
                         min_abs_corr = 0.05, 
                         max_pval = 0.05)
```

### 3. Analyzing Multiple Pathway Groups
Use `pcxn_analyze` to discover relationships between sets of pathways (e.g., comparing two different phenotypes or GSEA results).

```r
# Compare two groups of pathways
phenotype_0 <- c("ABC transporters (KEGG)", "ACE Inhibitor Pathway (Wikipathways)")
phenotype_1 <- c("DNA Repair (Reactome)")

pcxn.obj <- pcxn_analyze(collection = "pathprint", 
                         phenotype_0, 
                         phenotype_1, 
                         adj_overlap = FALSE, 
                         top = 10, 
                         min_abs_corr = 0.05, 
                         max_pval = 0.05)
```

### 4. Visualization
The output of explore/analyze functions can be visualized as a heatmap or a network.

```r
# Generate a heatmap with hierarchical clustering
# Clustering methods: "complete", "average", "ward.D", etc.
hp <- pcxn_heatmap(pcxn.obj, clustering_method = "complete")

# Generate an interactive network
net <- pcxn_network(pcxn.obj)
```

### 5. Retrieving Gene Members
To see which genes are actually in a pathway:

```r
genes <- pcxn_gene_members("Alzheimer's disease (KEGG)")
```

## Key Parameters and Tips

- **Collections**: Valid strings are `"pathprint"`, `"cp"` (MSigDB C2), `"gobp"` (MSigDB C5), and `"hallmark"` (MSigDB H).
- **adj_overlap**: If `TRUE`, correlation coefficients are adjusted for gene overlap between pathways to prevent "artificial" correlations caused by shared genes.
- **top**: Limits the results to the N most correlated neighbors.
- **Input Consistency**: All pathways in a single `pcxn_analyze` or `pcxn_explore` call must belong to the same collection.

## Reference documentation

- [Using pcxn wrapper functions to query and visualize the data](./references/using_pcxn.md)