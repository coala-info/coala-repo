---
name: networkx
description: NetworkX is a Python library for creating, manipulating, and studying the structure and dynamics of complex networks and graphs. Use when user asks to model relationships between entities, calculate network metrics, find shortest paths, or perform graph analysis.
homepage: https://github.com/networkx/networkx
---


# networkx

## Overview
NetworkX is a specialized Python library designed for the study of graphs and networks. It provides high-performance data structures for undirected, directed, and multigraphs, alongside a comprehensive library of standard graph algorithms. Use this skill to model relationships between entities, calculate network metrics (like centrality or clustering), and solve optimization problems such as shortest paths or flow analysis.

## Core Usage Patterns

### Graph Initialization
Choose the appropriate graph class based on your data's requirements:
- `nx.Graph()`: For undirected edges (e.g., a friendship network).
- `nx.DiGraph()`: For directed edges (e.g., a Twitter following network).
- `nx.MultiGraph()` / `nx.MultiDiGraph()`: When multiple edges can exist between the same pair of nodes.

### Basic Manipulation
```python
import networkx as nx

# Create a graph and add weighted edges
G = nx.Graph()
G.add_edge("A", "B", weight=4)
G.add_edge("B", "C", weight=2)

# Accessing data
nodes = G.nodes()
edges = G.edges(data=True)
degree_dict = dict(G.degree())
```

### Pathfinding and Analysis
The most common utility is finding the shortest path between nodes:
```python
# Find shortest path based on edge weights
path = nx.shortest_path(G, source="A", target="C", weight="weight")
length = nx.shortest_path_length(G, source="A", target="C", weight="weight")
```

## Expert Tips and Best Practices

- **Attribute Access**: When iterating over edges with attributes, use `G.edges(data=True)` to avoid multiple lookups.
- **Degree Analysis**: For recent versions of NetworkX, use `dict(G.degree)` instead of older iteration patterns to retrieve node degrees efficiently.
- **Floating Point Precision**: When working with algorithms that involve negative cycles or precise weights (like Floyd-Warshall), be mindful of floating-point considerations.
- **Performance**: For very large graphs, ensure you are using the `[default]` installation to include optimized dependencies.
- **Isomorphism**: Use `nx.is_isomorphic(G1, G2)` for basic checks, but for subgraph monomorphism or complex matching, look into the `vf2pp` or `ISMAGS` implementations within the library.

## Installation
Install the core library or the version with all optional dependencies for enhanced performance and visualization support:
- Basic: `pip install networkx`
- Full: `pip install networkx[default]`

## Reference documentation
- [NetworkX Main Repository](./references/github_com_networkx_networkx.md)
- [NetworkX Documentation Tree](./references/github_com_networkx_networkx_tree_main_doc.md)