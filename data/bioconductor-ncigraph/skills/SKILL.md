---
name: bioconductor-ncigraph
description: This tool converts NCI Pathway Interaction Database networks into graphNEL objects for biological network analysis in R. Use when user asks to import NCI PID networks, parse BioPAX-formatted pathways into gene-level interaction graphs, or propagate regulation relationships for gene expression modeling.
homepage: https://bioconductor.org/packages/release/bioc/html/NCIgraph.html
---


# bioconductor-ncigraph

name: bioconductor-ncigraph
description: Use this skill to work with the NCIgraph R package for analyzing biological networks from the NCI Pathway Interaction Database (PID). This skill is applicable when you need to import NCI PID networks as graphNEL objects, parse BioPAX-formatted networks into gene-level interaction graphs, or propagate regulation relationships for statistical analysis (like gene expression covariance modeling).

## Overview

NCIgraph bridges the gap between the NCI Pathway Interaction Database (PID) and R's graph-based statistical tools. It converts complex BioPAX pathway representations—which often include protein complexes, transport events, and biochemical reactions—into simplified `graphNEL` objects where nodes represent genes (Entrez IDs) and edges represent functional interactions. This is particularly useful for methods that use biological networks as priors for the covariance structure of gene expression data.

## Typical Workflow

### 1. Loading Data
The package typically works with pre-loaded raw networks from the `NCIgraphData` package or custom lists imported via `RCy3`.

```r
library(NCIgraph)
# Load example data provided in the package
data("NCIgraphVignette", package="NCIgraph")
# NCI.demo.cyList contains raw network objects
```

### 2. Parsing Networks
The core functionality is `getNCIPathways`, which transforms raw BioPAX/Cytoscape graphs into usable gene networks.

```r
# Parse networks to keep only Entrez ID nodes and propagate regulation
grList <- getNCIPathways(
  cyList = NCI.demo.cyList, 
  parseNetworks = TRUE, 
  entrezOnly = TRUE, 
  propagateReg = TRUE,
  verbose = TRUE
)$pList
```

### 3. Key Parsing Options
- `entrezOnly = TRUE`: Filters the graph to only include nodes that can be mapped to Entrez Gene IDs.
- `propagateReg = TRUE`: If Protein A activates Protein B (a transcription factor) which regulates Gene C, this option creates a direct edge from A to C. This is essential for expression-based statistical methods.
- `parseNetworks = TRUE`: Applies the transformation logic to convert BioPAX entities into a standard graph format.

### 4. Accessing Node Data
NCIgraph objects extend `graphNEL`. You can extract metadata (like Entrez IDs or BioPAX names) using `nodeData`.

```r
# Extract Entrez IDs from a parsed graph
graph <- grList[[1]]
entrez_ids <- unlist(lapply(graph@nodeData@data, function(e) e$biopax.xref.ENTREZGENE))
```

### 5. Visualization
To visualize the resulting networks, use the `Rgraphviz` package.

```r
library(Rgraphviz)
# Layout and render
plot_graph <- layoutGraph(graph)
renderGraph(plot_graph)
```

## Important Considerations
- **Reactome Networks**: Networks imported from Reactome within the NCI PID often lack Entrez IDs. Parsing these with `entrezOnly = TRUE` will result in empty graphs.
- **Integration**: NCIgraph is frequently used in conjunction with the `DEGraph` package for identifying differentially expressed pathways.
- **Object Class**: The package defines a specific `NCIgraph` class which inherits from `graphNEL` but includes specialized methods for sub-graphing and subtype retrieval.

## Reference documentation
- [NCIgraph: networks from the NCI pathway integrated database as graphNEL objects](./references/NCIgraph.md)