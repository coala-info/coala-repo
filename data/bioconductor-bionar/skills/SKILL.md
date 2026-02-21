---
name: bioconductor-bionar
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BioNAR.html
---

# bioconductor-bionar

name: bioconductor-bionar
description: Comprehensive biological network analysis in R. Use this skill to build, annotate, and analyze protein-protein interaction (PPI) networks. It supports centrality estimation, community detection (clustering), network entropy, scale-free property testing, and disease-disease overlap analysis.

## Overview

BioNAR is a Bioconductor package designed for the topological analysis of biological networks, particularly proteomic data. It provides a unified pipeline to move from a list of protein interactions to biological insights by mapping functional and disease annotations onto network structures. Key capabilities include calculating multiple centrality measures, performing robust clustering with consensus matrices, and measuring the "bridgeness" of proteins that link different functional communities.

## Core Workflow

### 1. Network Construction
Build a network from a data frame of edges or load an existing graph file.

```r
library(BioNAR)
# From data frame (columns: entA, entB, weight)
gg <- buildNetwork(edge_df)

# From GML/GraphML using igraph
gg <- igraph::read_graph("network.gml", format="gml")
```

### 2. Annotation
Annotate vertices with gene names, GO terms, or disease ontology IDs.

```r
# Standard annotations
gg <- annotateGeneNames(gg)
gg <- annotateGOont(gg) # Requires GO.db

# Disease Ontology (HDO) annotation
# dis_df should contain gene-to-HDO mappings
gg <- annotateTopOntoOVG(gg, dis_df)

# Custom vertex annotation
gg <- annotate_vertex(gg, data_matrix, name="MyAnnotation")
```

### 3. Centrality and Topology
Calculate standard and specialized network metrics.

```r
# Calculate all centralities (DEG, BET, CC, SL, mnSP, PR, sdSP)
gg <- calcCentrality(gg)

# Get results as a matrix
mc <- getCentralityMatrix(gg)

# Test scale-free properties (Power Law fit)
pFit <- fitDegree(as.vector(igraph::degree(gg)), Nsim=100, plot=TRUE)

# Network Entropy
ent <- getEntropyRate(gg)
SRprime <- getEntropy(gg)
plotEntropy(SRprime, SRo=ent$SRo, maxSr=ent$maxSr)
```

### 4. Clustering and Community Detection
BioNAR supports multiple algorithms: `louvain`, `infomap`, `fc` (fast-greedy), `wt` (walktrap), `lec` (leading eigenvector), and `sgG1/2/5` (spinglass).

```r
# Run specific clustering
alg <- "louvain"
gg <- calcClustering(gg, alg)

# Compare multiple algorithms
ggc <- calcAllClustering(gg)
summary_stats <- clusteringSummary(ggc, att=c('lec', 'wt', 'louvain'))

# Layout by cluster for visualization
mem_df <- data.frame(names=V(gg)$name, membership=V(gg)$louvain)
lay <- layoutByCluster(gg, mem_df)
plot(gg, layout=lay, vertex.color=V(gg)$louvain)
```

### 5. Robustness and Bridgeness
Assess cluster stability and identify "bridge" proteins that connect different modules.

```r
# 1. Create consensus matrix (N should be >= 500 for publication)
conmat <- makeConsensusMatrix(gg, N=50, alg="louvain", type=2, mask=10)

# 2. Calculate Bridgeness
gg <- calcBridgeness(gg, alg="louvain", conmat)

# 3. Plot Bridgeness vs Semi-local centrality (SL)
plotBridgeness(gg, alg="louvain", Xatt='SL')
```

### 6. Disease Overlap Analysis
Measure the separation or overlap between two sets of annotated genes (e.g., two different diseases).

```r
# Calculate separation (sAB)
p <- calcDiseasePairs(gg, name="TopOnto_OVG_HDO_ID", 
                      diseases=c("DOID:10652", "DOID:3312"))

# Run permutations for significance
r <- runPermDisease(gg, name="TopOnto_OVG_HDO_ID", 
                    diseases=c("DOID:10652", "DOID:3312"), Nperm=100)
```

## Tips for Success
- **Vertex Names**: Ensure your graph vertices are named with Entrez IDs or consistent identifiers before annotation.
- **Memory Management**: `calcAllClustering` and `makeConsensusMatrix` with high `N` are computationally intensive; consider running them on a subset or using a high-performance environment.
- **Normalization**: Use `normModularity` to compare modularity scores across networks of different sizes or densities.

## Reference documentation
- [BioNAR: Biological Network Analysis in R](./references/BioNAR_overview.md)
- [BioNAR: Biological Network Analysis in R (Source)](./references/BioNAR_overview.Rmd)