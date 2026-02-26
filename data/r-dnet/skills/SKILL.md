---
name: r-dnet
description: The r-dnet tool provides a comprehensive framework for integrative analysis of omics data using biological networks. Use when user asks to identify functional subnetworks, perform network propagation, conduct functional enrichment analysis, or visualize molecular networks.
homepage: https://cran.r-project.org/web/packages/dnet/index.html
---


# r-dnet

name: r-dnet
description: Integrative analysis of omics data using biological networks. Use for identifying functional subnetworks, performing network propagation, and conducting enrichment analysis (GO, KEGG, etc.) on high-throughput biological data.

# r-dnet

## Overview
The `dnet` package provides a comprehensive framework for network-based analysis of omics data. It excels at identifying significant subnetworks (modules) from large-scale biological networks based on node-level evidence (e.g., p-values from differential expression) and performing functional enrichment analysis.

## Installation
```r
install.packages("dnet")
# Note: dnet depends on several Bioconductor packages
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("Biobase", "graph", "RBGL"))
```

## Core Workflow

### 1. Loading Built-in Data
`dnet` provides various datasets including molecular networks and functional annotations via `dRDataLoader`.
```r
library(dnet)
# Load a specific network (e.g., STRING protein-protein interaction for Human)
network <- dRDataLoader(RData = "org.Hs.string")
# Load annotations (e.g., Gene Ontology)
GS <- dRDataLoader(RData = "org.Hs.egGO")
```

### 2. Subnetwork Identification
The primary workflow involves identifying a maximum-scoring subnetwork from a larger graph based on input p-values.
```r
# pvals: a numeric vector of p-values named by gene symbols/IDs
# The pipeline fits a mixture model to p-values to calculate scores
subnetwork <- dNetPipeline(pvals, network = network, significance_threshold = 0.05)
```

### 3. Network Visualization
`visNet` is used for customized network plots, supporting various layouts and node/edge attributes.
```r
# Basic visualization
visNet(g = subnetwork, vertex.label = V(subnetwork)$name)

# Highlight specific nodes
visNet(g = subnetwork, vertex.color = "orange")
```

### 4. Enrichment Analysis
Perform functional enrichment analysis using the `dEnricher` function, which supports various ontologies.
```r
# data: vector of gene IDs (e.g., Entrez IDs)
# ontology: e.g., "GOMF", "GOBP", "GOCC", "KEGG"
enrichment <- dEnricher(data = my_genes, genome = "hs", ontology = "GOMF")

# View top results
view(enrichment)
```

### 5. Network Propagation
Use `dNetDiffusion` to propagate information across the network, useful for gene prioritization.
```r
# seeds: initial scores for nodes
# normalise: diffusion method
propagated_scores <- dNetDiffusion(seeds, network, method = "rwr")
```

## Tips
- **Data Mapping**: Ensure your input gene identifiers match the identifiers used in the network (usually Entrez IDs or Gene Symbols).
- **Heuristic vs Exact**: `dNetPipeline` uses a heuristic approach by default which is efficient for large networks.
- **Custom Networks**: You can use any `igraph` object as a network, provided the node names match your data.
- **Random Forest**: Use `dRFfind` for identifying features using Random Forest in the context of networks.

## Reference documentation
- [dnet CRAN Repository](https://cran.r-project.org/web/packages/dnet/index.html)