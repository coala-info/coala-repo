---
name: bioconductor-neighbornet
description: This tool performs Neighbor Net analysis to identify active gene-gene interaction networks and biological mechanisms from differential expression data. Use when user asks to identify active sub-networks, perform Neighbor Net analysis, or integrate gene expression results with prior knowledge of gene interactions.
homepage: https://bioconductor.org/packages/3.8/bioc/html/NeighborNet.html
---


# bioconductor-neighbornet

name: bioconductor-neighbornet
description: Use this skill to perform Neighbor Net analysis (NNA) to identify active biological mechanisms and gene-gene interaction networks from differential expression data. This skill is appropriate for analyzing phenotypes (diseases, treatments) by integrating experimental results with prior knowledge of gene interactions (e.g., KEGG, HPRD).

## Overview

NeighborNet is an R package designed to identify putative mechanisms of action by leveraging gene-gene interaction networks. Unlike standard pathway analysis, it focuses on the "neighborhood" of genes to capture active sub-networks specific to a given condition. It requires two primary inputs: a list of differentially expressed genes (DEGs) and a reference list of gene-gene interactions (neighborhoods).

## Typical Workflow

### 1. Prepare Gene Interaction Knowledge
The package requires a list where each element represents the neighborhood of a gene (including the gene itself).

```r
# Load example interaction data (KEGG/HPRD based)
load(system.file("extdata/listofgenes.RData", package = "NeighborNet"))

# Structure: A list where names are Entrez IDs and values are character vectors of neighbors
# head(listofgenes)
```

### 2. Prepare Experimental Data
You need two character vectors of Entrez IDs:
- `de`: Differentially expressed genes (filtered by p-value and fold change).
- `ref`: The "universe" or reference set (all genes measured in the experiment).

```r
# Example: Filtering results from a limma-style data frame
pvThreshold <- 0.01
foldThreshold <- 1.5

de <- data$EntrezID[data$adj.P.Val < pvThreshold & abs(data$logFC) > foldThreshold]
ref <- unique(data$EntrezID)
```

### 3. Run Neighbor Net Analysis
The core function `neighborNet` identifies the active network.

```r
library(NeighborNet)
library(graph)

# Identify the significant network
sig_genes <- neighborNet(de = de, ref = ref, listofgenes = listofgenes)

# The output is a graphNEL object
print(sig_genes)
```

### 4. Visualization
The resulting network can be visualized using the standard R `plot` function for graph objects.

```r
# Basic plot
plot(sig_genes)

# Customized plot
attrs <- list(node = list(fontsize = 40, fixedsize = FALSE),
              graph = list(overlap = FALSE), 
              edge = list(lwd = 0.6))
plot(sig_genes, attrs = attrs)
```

## Tips and Best Practices
- **ID Consistency**: Ensure that the IDs used in your `de` and `ref` vectors match the ID type used in the `listofgenes` interaction list (typically Entrez IDs).
- **Combining Datasets**: If working with multiple datasets for the same condition, use `unique(c(de1, de2, ...))` to create a robust set of differentially expressed genes before running the analysis.
- **Graph Manipulation**: Since the output is a `graphNEL` object, you can use the `graph` and `Rgraphviz` packages for advanced network analysis or export.

## Reference documentation
- [Neighbor net analysis](./references/neighborNet.md)