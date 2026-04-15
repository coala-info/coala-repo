---
name: bioconductor-r3cpet
description: R3CPET is an R package that uses a non-parametric Bayesian model to infer protein networks that maintain 3D chromatin interactions from ChIA-PET and ChIP-Seq data. Use when user asks to identify chromatin maintainer networks, build interaction-specific protein networks, or cluster DNA loops based on protein enrichment.
homepage: https://bioconductor.org/packages/release/bioc/html/R3CPET.html
---

# bioconductor-r3cpet

## Overview

R3CPET (3D Chromatin Protein Enrichment Tool) is an R package designed to infer the set of proteins most likely to maintain chromatin interactions. It uses a non-parametric Bayesian model (Hierarchical Dirichlet Process - HLDA) to identify enriched protein networks (Chromatin Maintainer Networks or CMNs) from a "corpus" of interaction-specific networks. The workflow involves loading ChIA-PET and ChIP-Seq data, mapping these to a background PPI, building individual networks for each loop, and then clustering these to find common regulatory modules.

## Core Workflow

### 1. Data Loading and Initialization
The central object is a `ChiapetExperimentData` container. You must provide ChIA-PET interactions, Transcription Factor Binding Sites (TFBS), and a PPI network.

```r
library(R3CPET)

# 1. Initialize the object
# pet: path to file or GRanges
# tfbs: path to file or GRanges
# ppiType: "HPRD" or "Biogrid" (built-in)
x <- ChiapetExperimentData(pet = petFile, tfbs = tfbsFile, IsBed = FALSE, ppiType = "HPRD", filter = TRUE)

# 2. Load/Filter PPI (optional custom filtering)
# Keeps only proteins in the nucleus by default (GO:0005634)
x <- loadPPI(x, type = "HPRD", filter = TRUE)

# 3. Create internal indexes
x <- createIndexes(x)
```

### 2. Building Interaction Networks
For each DNA-DNA interaction, R3CPET builds a network of proteins that could bridge the two genomic regions based on the PPI.

```r
# minFreq/maxFreq: filter edges appearing too rarely or too often (noise reduction)
nets <- buildNetworks(x, minFreq = 0.1, maxFreq = 0.9)
```

### 3. Inferring Maintainer Networks (HLDA)
The `InferNetworks` function applies the HLDA model to find the most enriched protein complexes.

```r
# thr: threshold to select top edges in each network
hlda <- InferNetworks(nets, thr = 0.5, max_iter = 500)

# Convert results to igraph objects for analysis
hlda <- GenerateNetworks(hlda)
```

### 4. Clustering and Analysis
You can cluster the original DNA interactions based on which maintainer networks they are enriched for.

```r
# Cluster interactions into groups (e.g., 6 clusters)
hlda <- clusterInteractions(hlda, method = "sota", nbClus = 6)

# Access results
top_nodes <- topNodes(hlda)   # Top proteins per CMN
top_edges <- topEdges(hlda)   # Top PPI interactions per CMN
all_nets <- networks(hlda)    # List of igraph objects
```

## Visualization

R3CPET provides several plotting methods via `plot3CPETRes`:

*   **Heatmaps**: `plot3CPETRes(hlda, type = "heatmap")` shows interaction-network enrichment.
*   **Networks**: `plot3CPETRes(hlda, type = "networks")` generates a list of ggplot objects for the inferred CMNs.
*   **Circos**: `visualizeCircos(hlda, x, cluster = 1)` visualizes the physical DNA loops for a specific cluster.
*   **Similarity**: `plot3CPETRes(hlda, type = "netSim")` shows how much the inferred networks overlap.

## Tips for Success

*   **Data Formats**: ChIA-PET data can be a 6-column file (chrom1, start1, end1, chrom2, start2, end2) or a 4-column BED file with specific naming (`PET#1.1` for left, `PET#1.2` for right).
*   **Parallelization**: `buildNetworks` uses the `parallel` package. Ensure your environment allows for multiple R instances if processing large datasets.
*   **Expression Filtering**: Use `annotateExpression(hlda, RPKM_df)` to add cell-specific expression data to the network nodes, which helps in identifying biologically relevant maintainers.
*   **Hyperparameters**: If the number of inferred networks is too high or low, adjust the `gamma` parameter in `InferNetworks`. Smaller `gamma` leads to fewer clusters.

## Reference documentation
- [R3CPET User Manual](./references/R3CPET.md)