---
name: bioconductor-netboxr
description: This tool identifies pathway modules by mapping altered genes onto a human interaction network to find significant linker genes and functional communities. Use when user asks to identify pathway modules, find linker genes in a biological network, or perform statistical validation of network connectivity.
homepage: https://bioconductor.org/packages/3.11/bioc/html/netboxr.html
---

# bioconductor-netboxr

## Overview
The `netboxr` package implements the NetBox algorithm to identify pathway modules in cancer and other biological contexts. It maps a list of altered genes onto a Human Interaction Network (HIN) to find "linker" genes that connect disparate alterations into cohesive functional units. It includes robust statistical validation through global and local network null models and supports community detection for module discovery.

## Core Workflow

### 1. Data Preparation
Load the package and the default 2010 Human Interaction Network (HIN).
```r
library(netboxr)
data(netbox2010)

# Extract network and gene list
sifNetwork <- netbox2010$network
geneList <- as.character(netbox2010$geneList)

# Simplify network (remove loops and duplicates)
graphReduced <- networkSimplify(sifNetwork, directed = FALSE)
```

### 2. Network Mapping and Module Discovery
The `geneConnector` function is the primary interface for mapping genes and identifying modules.
```r
# communityMethod: "ebc" (edge betweenness) or "lec" (leading eigenvector)
results <- geneConnector(
  geneList = geneList, 
  networkGraph = graphReduced, 
  directed = FALSE,
  pValueAdj = "BH", 
  pValueCutoff = 0.05, 
  communityMethod = "ebc", 
  keepIsolatedNodes = FALSE
)
```

### 3. Statistical Validation
Validate if the discovered network is more connected or modular than random chance.
*   **Global Null Model:** Tests if the giant component size is significant.
*   **Local Null Model:** Tests if the modularity (Z-score) is significant.
```r
# Global test (can be time-consuming)
globalTest <- globalNullModel(results$netboxGraph, graphReduced, iterations = 100, numOfGenes = length(geneList))

# Local test
localTest <- localNullModel(netboxGraph = results$netboxGraph, iterations = 1000)
```

### 4. Visualization and Annotation
Annotate the graph with colors based on interaction types and plot using `igraph` layouts.
```r
library(RColorBrewer)
# Define colors for interaction types
interactionType <- unique(results$netboxOutput[, 2])
edgeColors <- data.frame(INTERACTION_TYPE = interactionType, 
                         COLOR = brewer.pal(length(interactionType), "Spectral"))

netboxGraphAnnotated <- annotateGraph(netboxResults = results, edgeColors = edgeColors, linker = TRUE)

# Plot
plot(results$netboxCommunity, netboxGraphAnnotated, layout = layout_with_fr)
```

## Key Functions
- `networkSimplify()`: Cleans SIF data for network analysis.
- `geneConnector()`: Main execution function; returns a list containing the graph, community memberships, and linker gene data.
- `annotateGraph()`: Prepares the igraph object for plotting with specific aesthetics.
- `globalNullModel()` / `localNullModel()`: Statistical significance functions.

## Tips for Success
- **Linker Genes:** These are non-altered genes that significantly connect your input genes. Check `results$neighborData` to see their FDR-adjusted p-values.
- **Performance:** For large networks, use `communityMethod = "lec"` (Leading Eigenvector) instead of "ebc" to speed up module detection.
- **Custom Networks:** You can use your own SIF (Simple Interaction Format) data. Ensure it has three columns: `PARTICIPANT_A`, `INTERACTION_TYPE`, and `PARTICIPANT_B`.
- **Downstream Analysis:** Use the `results$moduleMembership` data frame to extract gene lists for Gene Ontology (GO) enrichment using packages like `clusterProfiler`.

## Reference documentation
- [NetBoxR Tutorial](./references/netboxrTutorial.md)