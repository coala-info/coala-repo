---
name: bioconductor-netsam
description: NetSAM identifies hierarchical modules in networks and optimizes leaf node ordering through seriation. Use when user asks to perform network modularization, construct correlation networks from expression data, optimize network leaf ordering, or conduct functional enrichment analysis on network modules.
homepage: https://bioconductor.org/packages/release/bioc/html/NetSAM.html
---

# bioconductor-netsam

name: bioconductor-netsam
description: Network Seriation and Modularization (NetSAM) for identifying hierarchical modules in networks and optimizing leaf ordering. Use this skill when you need to perform network modularization, seriation (linear ordering), correlation network construction, or functional enrichment of network modules using Bioconductor.

## Overview

NetSAM (Network Seriation and Modularization) is designed to reveal the hierarchical organization of complex networks. It addresses limitations in traditional hierarchical clustering by optimizing leaf node ordering (seriation) and assessing the statistical significance of modular structures. It is particularly useful for integrating omics data and preparing network visualizations for tools like NetGestalt.

## Core Workflows

### 1. Network Seriation and Modularization
The primary function `NetSAM()` takes an edge-list or an R network object and identifies hierarchical modules.

```r
library(NetSAM)

# Input can be a file path (.net) or an igraph/matrix object
input_net <- system.file("extdata", "exampleNetwork.net", package = "NetSAM")
output_path <- paste0(getwd(), "/NetSAM_Results")

result <- NetSAM(
  inputNetwork = input_net,
  outputFileName = output_path,
  outputFormat = "nsm",       # "nsm" for NetGestalt, "gmt" for GSEA, or "none"
  edgeType = "unweighted",    # or "weighted"
  organism = "hsapiens",      # supports mmusculus, rnorvegicus, etc.
  minModule = 0.003,          # Min percentage of nodes for a module
  nThreads = 3                # Parallel processing
)
```

### 2. Correlation Network Construction
Use `MatNet()` to build a network from a data matrix (e.g., gene expression) or `MatSAM()` to perform the entire pipeline from matrix to modules.

```r
# Construct correlation network from matrix
mat_net <- MatNet(
  inputMat = "expression_data.cct",
  corrType = "spearman",
  matNetMethod = "rank",      # "rank", "value", or "directed"
  rankBest = 0.003
)

# Full pipeline: Matrix -> Network -> Modules
mat_results <- MatSAM(
  inputMat = "expression_data.cct",
  sampleAnn = "annotations.tsi",
  outputFormat = "msm",
  organism = "hsapiens"
)
```

### 3. Functional Analysis and Associations
After identifying modules, you can calculate associations with sample features or GO terms.

```r
# Association with sample features (Clinical data, etc.)
feat_asso <- featureAssociation(
  inputMat = "expression_data.cct",
  sampleAnn = "annotations.tsi",
  NetSAMOutput = result,
  outputHtmlFile = "feature_report"
)

# GO Term Enrichment for modules
go_asso <- GOAssociation(
  NetSAMOutput = result,
  organism = "hsapiens",
  outputType = "significant",
  fdrth = 0.05
)
```

## Key Functions and Parameters

- **`NetAnalyzer()`**: Calculates network topology metrics (degree, clustering coefficient, betweenness, closeness) and generates distribution plots.
- **`mapToSymbol()`**: Converts various IDs (Entrez, Affy, etc.) to Gene Symbols, which is required for NetGestalt enrichment.
- **`mergeDuplicate()`**: Handles duplicate IDs in matrices using methods like `maxSD`, `mean`, or `median`.
- **`consensusNet()`**: Uses bootstrapping to construct a robust consensus network from matrix data.

## Data Formats

- **.net**: Edge list file (NodeA [tab] NodeB [tab] Weight).
- **.cct / .cbt**: Continuous/Binary data matrices (first column IDs, first row sample names).
- **.tsi**: Sample annotation files. The second row must specify feature types: `BIN` (binary), `CAT` (category), `CON` (continuous), or `SUR` (survival).

## Implementation Tips

- **Memory Management**: NetSAM is memory-intensive due to pair-wise distance calculations. Use 64-bit R. For >10,000 nodes, at least 16GB RAM is recommended.
- **Random Walks**: The `stepIte` parameter optimizes the random walk length. For large networks (>200,000 edges), set `stepIte = FALSE` and use a fixed `maxStep` (default 4) to save time.
- **Significance Testing**: Use `moduleSigMethod = "permutation"` for the most rigorous module significance testing, though `"cutoff"` is faster for initial exploration.

## Reference documentation
- [NetSAM](./references/NetSAM.md)