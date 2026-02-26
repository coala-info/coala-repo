---
name: bioconductor-hypergraph
description: This tool provides S4 classes and methods for representing and manipulating hypergraph data structures in R. Use when user asks to create hyperedges, construct hypergraphs, generate incidence matrices, perform k-core decomposition, or find vertex cover approximations for complex networks.
homepage: https://bioconductor.org/packages/release/bioc/html/hypergraph.html
---


# bioconductor-hypergraph

name: bioconductor-hypergraph
description: Use when representing and manipulating hypergraph data structures in R. This skill is applicable for modeling complex networks where edges (hyperedges) can connect more than two nodes, such as protein complexes, set-based relationships, or multi-way interactions.

## Overview

The `hypergraph` package provides S4 classes and methods for constructing and analyzing hypergraphs. Unlike standard graphs where edges connect exactly two nodes, hypergraphs allow edges to contain any number of nodes. This package supports both undirected and directed hyperedges (hyperarcs) and provides algorithms for k-core decomposition and vertex cover approximation.

## Core Workflows

### 1. Creating Hyperedges

Hyperedges are the building blocks of a hypergraph.

*   **Undirected Hyperedges**: Use `Hyperedge(nodes, label)` to create a set of connected nodes.
    ```r
    library(hypergraph)
    nodes <- c("A", "B", "C")
    he1 <- Hyperedge(nodes, label = "edge1")
    ```
*   **Directed Hyperedges**: Use `DirectedHyperedge(head, tail, label)` to define a relationship from a tail set to a head set.
    ```r
    dhe <- DirectedHyperedge(head = c("A", "B"), tail = c("C", "D"), label = "arc1")
    ```
*   **Batch Creation**: Use `l2hel(list_of_vectors)` to quickly convert a list of character vectors into a list of `Hyperedge` objects.
    ```r
    edge_list <- list(e1 = c("A", "B"), e2 = c("B", "C", "D"))
    h_edges <- l2hel(edge_list)
    ```

### 2. Constructing a Hypergraph

A `Hypergraph` object requires a unique vector of node labels and a list of `Hyperedge` objects.

```r
all_nodes <- c("A", "B", "C", "D")
hg <- Hypergraph(nodes = all_nodes, hyperedges = h_edges)
```

### 3. Analysis and Manipulation

*   **Incidence Matrix**: Generate a matrix where rows are nodes and columns are hyperedges.
    ```r
    mat <- inciMat(hg)
    ```
*   **K-Cores**: Find the k-core decomposition of the hypergraph. A k-core is a maximal subhypergraph where each node is adjacent to at least k hyperedges.
    ```r
    cores <- kCoresHypergraph(hg)
    ```
*   **Vertex Cover**: Find an approximate minimum weight vertex cover (a subset of vertices that touches every hyperedge).
    ```r
    vc <- vCoverHypergraph(hg)
    ```
*   **Conversion**: Convert a hypergraph to a bipartite `graphNEL` object (nodes and hyperedges become the two sets of nodes in the bipartite graph).
    ```r
    gNEL <- toGraphNEL(hg)
    ```

## Tips and Best Practices

*   **Node Labels**: Always use character vectors for node labels to ensure compatibility with the S4 slots.
*   **Directed to Undirected**: Use `toUndirected(dhe)` to coerce a `DirectedHyperedge` into a standard `Hyperedge`.
*   **Accessors**: Use `nodes(object)`, `hyperedges(hg)`, and `hyperedgeLabels(hg)` instead of accessing slots directly with `@`.
*   **Memory**: For very large, sparse hypergraphs, be aware that `inciMat` returns a standard dense matrix; check dimensions before generation.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)