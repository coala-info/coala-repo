---
name: bioconductor-rbgl
description: The RBGL package provides an R interface to the Boost Graph Library for performing high-performance graph theory algorithms on graph objects. Use when user asks to find shortest paths, identify connected components, calculate centrality measures, perform topological sorts, or find maximum cliques and spanning trees.
homepage: https://bioconductor.org/packages/release/bioc/html/RBGL.html
---


# bioconductor-rbgl

## Overview

The `RBGL` package provides an R interface to the Boost Graph Library, offering a robust suite of algorithms for analyzing `graph` objects (typically `graphNEL` or `graphAM` classes from the `graph` package). It is the primary Bioconductor tool for complex graph theory operations that require high-performance C++ implementations.

## Core Workflows

### 1. Graph Traversal
Search the graph structure starting from a specific node.
*   **Depth First Search**: `dfs(graph, node)` - Returns discovery and finish orders.
*   **Breadth First Search**: `bfs(graph, node)` - Returns discovery order.

### 2. Shortest Path Algorithms
Choose the algorithm based on graph properties (weights and cycles):
*   **Dijkstra**: `dijkstra.sp(graph, start)` - Best for non-negative weights.
*   **Bellman-Ford**: `bellman.ford.sp(graph, start)` - Handles negative weights.
*   **DAG**: `dag.sp(graph, start)` - Optimized for Directed Acyclic Graphs.
*   **All-Pairs**: `johnson.all.pairs.sp(graph)` (sparse) or `floyd.warshall.all.pairs.sp(graph)` (dense).
*   **Specific Path**: `sp.between(graph, start, end)` - Returns path details and length.

### 3. Connectivity and Components
Identify sub-structures and vulnerabilities in the graph:
*   **Connected Components**: `connectedComp(ugraph(g))` for undirected; `strongComp(g)` for directed.
*   **Biconnectivity**: `biConnComp(g)` and `articulationPoints(g)` to find nodes whose removal disconnects the graph.
*   **Incremental**: Use `init.incremental.components(g)` followed by `incremental.components(g)` when adding edges dynamically.

### 4. Spanning Trees and Flow
*   **MST**: `mstree.kruskal(g)` or `mstree.prim(g)` to find the minimum weight set of edges connecting all nodes.
*   **Max Flow**: `edmonds.karp.max.flow(g, source, sink)` or `push.relabel.max.flow(g, source, sink)`.

### 5. Community and Cluster Analysis
*   **Betweenness Centrality**: `brandes.betweenness.centrality(g)` measures node/edge importance.
*   **Clustering**: `highlyConnSG(g)` partitions the graph into subgraphs where connectivity > n/2.
*   **Cliques**: `maxClique(g)` finds all complete subgraphs; `kCliques(g)` finds subgraphs where max distance between nodes is ≤ k.
*   **K-Cores**: `kCores(g)` finds subgraphs where each vertex has at least k neighbors.

### 6. Layout and Ordering
*   **Topological Sort**: `tsort(g)` for DAGs to find linear ordering of dependencies.
*   **Matrix Ordering**: `cuthill.mckee.ordering(g)` or `minDegreeOrdering(g)` to reduce bandwidth/fill-in for sparse matrices.
*   **Isomorphism**: `isomorphism(g1, g2)` to check if two graphs are structurally identical.

## Usage Tips
*   **Input Format**: Most functions require a `graph` object. Ensure you have the `graph` package loaded.
*   **Weights**: If your graph has weights, ensure they are accessible via `edgeWeights(g)`. Many algorithms default to weight 1 if not specified.
*   **Undirected Graphs**: For algorithms requiring undirected graphs (like `connectedComp`), use `ugraph(g)` to convert a directed graph.
*   **Error Handling**: `tsort` will return an empty character vector and a console message if the graph contains a cycle.

## Reference documentation
- [RBGL](./references/RBGL.md)