---
name: bioconductor-kegggraph
description: This tool parses KEGG pathway files into graph objects for network analysis and visualization in R. Use when user asks to convert KGML files to graphNEL objects, merge pathways, expand gene nodes, or perform graph-theory analysis on biological networks.
homepage: https://bioconductor.org/packages/release/bioc/html/KEGGgraph.html
---


# bioconductor-kegggraph

name: bioconductor-kegggraph
description: Expert guidance for the KEGGgraph R package to parse, analyze, and visualize KEGG pathways as graph objects. Use this skill when you need to convert KGML files into graphNEL objects, merge pathways, expand gene nodes, or perform graph-theory analysis (like centrality measures) on biological pathways.

## Overview
KEGGgraph is a Bioconductor package that serves as an interface between KEGG pathways and graph models in R. Unlike other tools that treat pathways as simple gene sets, KEGGgraph maintains the underlying topology (nodes and edges) by parsing KGML (KEGG XML) files. It allows for sophisticated graph operations such as merging crosstalking pathways, expanding protein complexes into individual gene nodes, and calculating network statistics like betweenness centrality.

## Core Workflows

### 1. Obtaining KGML Files
You can retrieve pathway files directly from the KEGG REST API.
```R
library(KEGGgraph)
tmp <- tempfile()
# Retrieve p53 signaling pathway (04115) for human (hsa)
retrieveKGML("04115", organism="hsa", destfile=tmp)
```

### 2. Parsing KGML to Graph Objects
The primary function is `parseKGML2Graph`.
```R
# expandGenes=TRUE: expands nodes containing multiple genes (e.g., paralogues) into individual nodes
# genesOnly=TRUE: ignores non-gene nodes like compounds
g <- parseKGML2Graph(tmp, expandGenes=TRUE, genesOnly=TRUE)
```

### 3. Extracting Metadata
Access node and edge attributes specific to KEGG.
```R
# Get node data (Type, Link, Display Name)
nodedata <- getKEGGnodeData(g)
# Get edge data (Subtype: activation, inhibition, phosphorylation, etc.)
edgedata <- getKEGGedgeData(g)

# Example: Get display name for a specific node
getDisplayName(nodedata[[1]])
```

### 4. Graph Operations
*   **Merging:** Combine pathways to study crosstalk.
    ```R
    # Assuming g1 and g2 are graph objects from different pathways
    mergedG <- mergeGraphs(list(path1=g1, path2=g2))
    ```
*   **Subsetting:** Extract specific parts of a network.
    ```R
    # Subset by node names
    subG <- subGraph(c("hsa:5594", "hsa:5595"), g)
    # Subset by node type
    geneG <- subGraphByNodeType(g, "gene")
    ```

### 5. Network Analysis
Since the output is a standard `graphNEL` object, use `RBGL` or `graph` packages for analysis.
```R
library(RBGL)
# Calculate betweenness centrality to find "bottleneck" genes
bc <- brandes.betweenness.centrality(g)
top_genes <- sort(bc$relative.betweenness.centrality.vertices[1,], decreasing=TRUE)[1:5]
```

### 6. ID Translation
KEGG uses its own identifiers (e.g., `hsa:5923`). Translate these to Entrez Gene IDs for downstream analysis.
```R
kegg_ids <- nodes(g)
entrez_ids <- translateKEGGID2GeneID(kegg_ids)
```

## Visualization
Use `Rgraphviz` for custom rendering of KEGG graphs.
```R
library(Rgraphviz)
plot(g, "neato")
```

## Tips for Success
*   **Node Expansion:** Always set `expandGenes=TRUE` if you intend to merge graphs or map gene-level expression data, as KEGG often groups paralogues into a single node.
*   **Metabolic Pathways:** For metabolic networks, use `KEGGpathway2reactionGraph` to focus on chemical compound reactions rather than protein-protein interactions.
*   **Remote Maps:** Use `parseKGMLexpandMaps` to automatically download and merge pathways that are "embedded" (referenced) within your target KGML file.

## Reference documentation
- [KEGGgraph: a graph approach to KEGG PATHWAY in R and Bioconductor](./references/KEGGgraph.md)
- [KEGGgraph: Application Examples](./references/KEGGgraphApp.md)