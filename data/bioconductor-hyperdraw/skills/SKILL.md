---
name: bioconductor-hyperdraw
description: This package provides a specialized algorithm for visualizing hypergraphs by representing them as bipartite graphs and rendering smooth Bezier curves. Use when user asks to visualize hypergraphs, create bipartite graph representations, or render complex directed relationships using smooth curves.
homepage: https://bioconductor.org/packages/release/bioc/html/hyperdraw.html
---

# bioconductor-hyperdraw

## Overview

The `hyperdraw` package provides a specialized algorithm for visualizing hypergraphs. Unlike standard graphs where edges connect two nodes, hypergraphs have edges that can connect multiple nodes. `hyperdraw` visualizes these by representing the hypergraph as a bipartite graph (consisting of "normal nodes" and "edge-nodes") and rendering smooth Bezier curves that pass through the edge-nodes to create a unified visual flow.

## Core Workflow

Visualizing a hypergraph involves three primary steps:
1. Create a bipartite representation (`graphBPH` object).
2. Arrange the layout (`graphLayout`).
3. Render the graph (`plot`).

### 1. Creating the graphBPH Object

You can create the required `graphBPH` object from either a `graphNEL` object or a `Hypergraph` object.

**From graphNEL:**
The `graphNEL` must be directed, and you must distinguish between normal nodes and nodes representing the hyperedges.
```r
library(hyperdraw)
# Define nodes (A-E are normal, R1-R3 are edge-nodes)
nodes <- c(LETTERS[1:5], paste0("R", 1:3))
# Define directed edges connecting normal nodes to edge-nodes and vice versa
edgeL <- list(
  A=list(edges=c("R1", "R2")),
  R1=list(edges="B"),
  R2=list(edges=c("C", "D"))
)
gnel <- new("graphNEL", nodes=nodes, edgeL=edgeL, edgemode="directed")

# Convert to graphBPH using a pattern to identify edge-nodes
bph <- graphBPH(gnel, edgeNodePattern="^R")
```

**From Hypergraph:**
Requires the `hypergraph` package and `DirectedHyperedge` objects.
```r
library(hypergraph)
dh1 <- DirectedHyperedge("A", "B", "R1")
hg <- Hypergraph(LETTERS[1:5], list(dh1))
bph <- graphBPH(hg)
```

### 2. Layout and Rendering

You can plot directly or separate the layout step to customize attributes.

**Simple Plot:**
```r
plot(bph)
```

**Two-step Layout (for customization):**
```r
# 1. Compute layout
laidOutBph <- graphLayout(bph)

# 2. Customize attributes (optional)
nodeDataDefaults(laidOutBph, "shape") <- "box"
edgeData(laidOutBph, "A", "R1", "color") <- "red"

# 3. Render
plot(laidOutBph)
```

## Customization Attributes

Use `nodeData()`, `edgeData()`, and `graphData()` to modify the appearance.

| Attribute | Level | Description |
|-----------|-------|-------------|
| `arrowLoc` | Graph | Where arrows appear: "middle" (at edge-nodes), "end", "start", "both", or "none". |
| `margin` | Node | Space around label. Must be a character evaluating to a grid unit, e.g., `'unit(3, "mm")'`. |
| `lwd` | Edge | Line width. |
| `shape` | Node | Supported: "circle", "box", "plain". |
| `color` | Edge/Node | Color of the element. |

## Implementation Details

- **Bezier Curves:** The algorithm calculates tangents at edge-nodes to ensure that curves entering and exiting an edge-node appear as a single smooth line.
- **Performance:** Calculation and trimming of Bezier curves can be slow for very large graphs.
- **Text Scaling:** There is currently no automatic scaling of text; manual adjustment of node margins or font sizes may be required.

## Reference documentation

- [hyperdraw](./references/hyperdraw.md)