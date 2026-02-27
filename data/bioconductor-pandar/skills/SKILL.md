---
name: bioconductor-pandar
description: This tool models gene regulatory networks by integrating transcription factor motifs, protein-protein interactions, and gene expression data using the PANDA algorithm. Use when user asks to model gene regulation, estimate regulatory edge weights, or identify transcription factor cooperation and gene co-regulation.
homepage: https://bioconductor.org/packages/release/bioc/html/pandaR.html
---


# bioconductor-pandar

name: bioconductor-pandar
description: Expert guidance for using the pandaR Bioconductor package to perform PANDA (Passing Attributes between Networks for Data Assimilation). Use this skill when you need to model gene regulatory networks by integrating transcription factor (TF) sequence motifs, protein-protein interactions (PPI), and gene expression data.

# bioconductor-pandar

## Overview

The `pandaR` package implements the PANDA algorithm, which models gene regulation as a bipartite network between transcription factors and genes. It uses an iterative message-passing approach to estimate edge weights by finding agreement between:
1. **Gene Expression**: Correlation between genes.
2. **Motif Data**: Prior evidence of TF-gene binding.
3. **Protein-Protein Interactions (PPI)**: Cooperation between transcription factors.

The algorithm converges on a final set of edge weights representing the strength of evidence for regulatory interactions, gene co-regulation, and TF cooperation.

## Core Workflow

### 1. Data Preparation
PANDA requires three primary inputs:
- **Motif Matrix**: A data.frame or matrix ($m$ TFs by $n$ genes) representing prior regulatory potential.
- **Expression Data**: A data.frame or matrix of gene expression levels across samples.
- **PPI Matrix**: A data.frame or matrix ($m$ TFs by $m$ TFs) representing interaction priors between transcription factors.

```r
library(pandaR)
data(pandaToyData)

# Inputs from toy data
motif <- pandaToyData$motif
expr <- pandaToyData$expression
ppi <- pandaToyData$ppi
```

### 2. Running PANDA
The `panda()` function is the primary entry point. It returns a `panda` object containing three networks.

```r
pandaResult <- panda(motif, expr, ppi)

# View summary
pandaResult
```

### 3. Accessing Results
The `panda` object contains three specific slots:
- `regNet`: The bipartite Regulatory Network (TFs to Genes).
- `coregNet`: The Gene Co-regulation Network (Genes to Genes).
- `coopNet`: The TF Cooperation Network (TFs to TFs).

Edge weights are Z-scores (approximate mean 0, SD 1). Higher values indicate stronger evidence for an interaction.

### 4. Network Filtering and Analysis
Because PANDA produces complete graphs, you must filter for the most significant edges.

- **Extract Top Edges**: Use `topedges()` to get a binary network of the highest-scoring interactions.
- **Find Targets**: Use `targetedGenes()` to identify genes regulated by a specific TF in a filtered network.
- **Subsetting**: Use `subnetwork()` to focus on specific TFs and their targets.

```r
# Get top 1000 edges
topNet <- topedges(pandaResult, 1000)

# Find genes targeted by "AR"
arTargets <- targetedGenes(topNet, "AR")

# Create a subnetwork for specific TFs
smallNet <- subnetwork(topNet, c("AR", "ELK1"))
```

### 5. Visualization and Comparison
- **Plotting**: Use `plotGraph()` for basic network visualization (requires `igraph`).
- **Comparison**: Use `plotZ()` to compare edge weight distributions between two different PANDA runs (e.g., Case vs. Control).
- **TF Analysis**: Use `plotZbyTF()` to visualize Z-scores relative to TF out-degree.

```r
# Compare two PANDA results
plotZ(panda.res1, panda.res2)

# Visualize a subnetwork
plotGraph(smallNet)
```

## Tips for Success
- **Interpretation**: PANDA weights are relative. Negative values do not necessarily mean "inhibition"; they indicate a lack of evidence for a regulatory relationship compared to the rest of the network.
- **Convergence**: If the algorithm fails to converge, check for high noise in the expression data or extremely sparse motif priors.
- **Memory**: For very large gene sets, the `coregNet` (Gene x Gene) can become memory-intensive.

## Reference documentation
- [An Introduction to the pandaR Package](./references/pandaR.md)