---
name: bioconductor-rgraphviz
description: This tool provides an interface to the Graphviz library for the visualization and layout of network graphs in R. Use when user asks to create, layout, and render graphNEL objects, visualize biological pathways or protein-protein interaction networks, and apply layout algorithms like dot, neato, or twopi.
homepage: https://bioconductor.org/packages/release/bioc/html/Rgraphviz.html
---

# bioconductor-rgraphviz

name: bioconductor-rgraphviz
description: Visualization and layout of network graphs using the Graphviz library. Use this skill when you need to create, layout, and render graphs (graphNEL objects) in R, specifically for biological pathways, protein-protein interaction networks, or any directed/undirected graph structure requiring sophisticated layout algorithms like dot, neato, or twopi.

## Overview

The `Rgraphviz` package provides an interface between R and the Graphviz graph layout engine. It allows for the programmatic creation of graphs, calculation of node coordinates and edge trajectories, and high-quality rendering. It supports two primary workflows: the classic `plot()` interface for quick visualization and the newer `layoutGraph()`/`renderGraph()` interface for finer control over graphical parameters and iterative styling.

## Core Workflows

### 1. The Modern Interface (Recommended)
This workflow separates the layout calculation from the rendering, allowing you to modify styles without recomputing positions.

```r
library(Rgraphviz)

# 1. Create or load a graph (usually a graphNEL object)
# g <- ... 

# 2. Compute layout
g_laid_out <- layoutGraph(g)

# 3. Render the graph
renderGraph(g_laid_out)
```

### 2. The Classic Interface
Useful for quick, one-line plotting where layout and rendering happen simultaneously.

```r
# Default 'dot' layout
plot(g)

# Specific layout engines: 'neato', 'twopi', 'circo', 'fdp'
plot(g, "neato")
```

## Customizing Appearance

### Global Styles
Use `graph.par()` to set session-wide defaults for nodes, edges, and the graph title.

```r
graph.par(list(
  nodes = list(fill = "lightgray", textCol = "blue", shape = "ellipse"),
  edges = list(col = "red", lwd = 2),
  graph = list(main = "Network Title")
))
renderGraph(g_laid_out)
```

### Individual Element Styles
Use `nodeRenderInfo` and `edgeRenderInfo` to target specific nodes or edges. Edge names are typically formatted as `"nodeA~nodeB"`.

```r
# Set specific node colors
nodeRenderInfo(g) <- list(fill = c(geneA = "orange", geneB = "green"))

# Set specific edge styles
edgeRenderInfo(g) <- list(col = c("geneA~geneB" = "blue"), lty = c("geneA~geneB" = "dashed"))

# Re-layout if shapes changed, then render
g <- layoutGraph(g)
renderGraph(g)
```

### Node Shapes and Attributes
Supported shapes include `circle`, `ellipse`, `box`, `rectangle`, and `plaintext`.
- **Labels**: Set custom labels via `nodeRenderInfo(g)$label`.
- **Subgraphs/Clusters**: Group nodes together using a `subGList` passed to `plot()` or `layoutGraph()`. Clusters (set `cluster=TRUE`) are drawn with a bounding box.

## Advanced Layout Control

### The `agopen` Function
For low-level control, `agopen` creates an `Ragraph` object which maintains a direct link to the Graphviz data structures.

```r
# Manual node/edge list building
nodes <- buildNodeList(g)
edges <- buildEdgeList(g)
vv <- agopen(name="myGraph", nodes=nodes, edges=edges, edgeMode="directed")
plot(vv)
```

### Handling Reciprocated Edges
In directed graphs, you can control how mutual edges (A->B and B->A) are displayed using the `recipEdges` argument:
- `combined`: A single edge with arrows at both ends (default).
- `distinct`: Two separate curved edges.

## Tips for Large Graphs
- Use the `neato` or `fdp` engines for large, non-hierarchical undirected graphs.
- Use `twopi` for radial layouts centered on a specific node.
- If labels are overlapping, try increasing the node size or decreasing `fontsize` in `graph.par`.

## Reference documentation

- [How To Plot A Graph Using Rgraphviz](./references/Rgraphviz.md)
- [A New Interface to Render Graphs Using Rgraphviz](./references/newRgraphvizInterface.md)