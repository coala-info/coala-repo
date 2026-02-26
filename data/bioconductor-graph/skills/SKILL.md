---
name: bioconductor-graph
description: The bioconductor-graph package provides S4 classes and methods for representing, manipulating, and performing algebraic operations on directed and undirected graphs in R. Use when user asks to create graph objects from adjacency lists or matrices, modify nodes and edges, manage graph metadata, or perform basic graph traversals and connectivity analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/graph.html
---


# bioconductor-graph

## Overview

The `graph` package is a foundational Bioconductor resource for representing and manipulating graphs in R. It provides S4 classes to handle different graph representations (list-based, matrix-based, and bit-array based) and supports both directed and undirected edges. It is designed to work seamlessly with `RBGL` (for graph algorithms) and `Rgraphviz` (for visualization).

## Core Graph Classes

- **graphNEL**: Node and Edge List representation. Efficient for sparse graphs and general-purpose manipulation.
- **graphAM**: Adjacency Matrix representation. Uses a standard R matrix.
- **graphBAM**: Bit Array Matrix representation. Highly memory-efficient for large graphs by using `raw` vectors to store adjacency.
- **MultiGraph**: Supports multiple edge sets sharing a single node set (e.g., different types of interactions between the same genes).
- **clusterGraph**: Represents partitioned nodes where each cluster is a complete graph (clique) with no between-cluster edges.
- **distGraph**: A graph where edge weights are derived from a distance matrix.

## Essential Workflows

### 1. Creating Graphs
```R
library(graph)

# Create a graphNEL from scratch
nodes <- c("A", "B", "C")
edge_list <- list(A=list(edges=c("B", "C")), B=list(edges="C"), C=list(edges=character(0)))
g <- graphNEL(nodes=nodes, edgeL=edge_list, edgemode="directed")

# Create a graphBAM from a data frame
df <- data.frame(from=c("A", "B"), to=c("B", "C"), weight=c(1, 2))
gbam <- graphBAM(df, edgemode="directed")
```

### 2. Basic Manipulations
- **Accessors**: `nodes(g)`, `edges(g)`, `numNodes(g)`, `numEdges(g)`, `isDirected(g)`.
- **Modification**: 
  - `addNode(node, object)` / `removeNode(node, object)`
  - `addEdge(from, to, graph, weights)` / `removeEdge(from, to, graph)`
  - `combineNodes(nodes, graph, newName)`: Merges multiple nodes into one.
  - `clearNode(node, graph)`: Removes all edges incident to the node.
- **Subsetting**: `subGraph(snodes, graph)` creates a new graph containing only the specified nodes and their internal edges.

### 3. Managing Attributes (Metadata)
Attributes must have a default value initialized before specific values can be set.

```R
# Edge Attributes
edgeDataDefaults(g, "weight") <- 1
edgeData(g, from="A", to="B", attr="weight") <- 5

# Node Attributes
nodeDataDefaults(g, "color") <- "white"
nodeData(g, n="A", attr="color") <- "red"
```

### 4. Graph Operations
- **Algebraic**: `union(g1, g2)`, `intersection(g1, g2)`, `complement(g)`. (Note: These usually require graphs to have the same node set).
- **Coercion**: Use `as(g, "matrix")` or `as(matrix, "graphNEL")` to convert between representations.
- **Connectivity**: `connComp(g)` returns connected components.
- **Traversal**: `DFS(g, node)` performs a Depth First Search.

### 5. Working with MultiGraphs
MultiGraphs are useful for multi-omic data where nodes (genes) have different types of relationships (e.g., physical interaction vs. co-expression).
```R
# Create MultiGraph from a list of data frames
esets <- list(type1=df1, type2=df2)
mg <- MultiGraph(esets, directed=TRUE)

# Extract a specific edge set as a graphBAM
g_type1 <- extractGraphBAM(mg, "type1")[["type1"]]
```

## Tips for Performance
- Use **graphBAM** for very large, dense graphs to save memory.
- Use **clusterGraph** specifically for clustering outputs to leverage its optimized structure.
- For complex algorithms (Shortest Path, Minimum Spanning Tree), always use the `RBGL` package, which accepts `graph` objects as input.

## Reference documentation

- [Graph Design](./references/GraphClass.md)
- [graphBAM and MultiGraph classes](./references/MultiGraphClass.md)
- [How To use the clusterGraph and distGraph classes](./references/clusterGraph.md)
- [How to use the graph package](./references/graph.md)
- [Attributes for Graph Objects](./references/graphAttributes.md)