---
name: bioconductor-biocgraph
description: This tool provides high-level interfaces for the visualization and layout of biological graphs and pathways using Graphviz. Use when user asks to render graphNEL objects, customize node and edge attributes, create subgraphs or clusters, and visualize biological pathways with expression data.
homepage: https://bioconductor.org/packages/release/bioc/html/biocGraph.html
---


# bioconductor-biocgraph

name: bioconductor-biocgraph
description: Visualization and layout of biological graphs and pathways using Rgraphviz. Use this skill when you need to render graphNEL objects, customize node/edge attributes (colors, shapes, labels), create subgraphs/clusters, or visualize biological pathways (like KEGG) with expression data.

## Overview

The `biocGraph` package provides high-level R interfaces for rendering graphs using the Graphviz library. It extends the capabilities of `Rgraphviz` and `graph` packages to facilitate the visualization of complex biological networks, such as metabolic pathways and protein-protein interaction maps. It supports fine-grained control over layout engines (dot, neato, twopi), attribute customization, and interactive HTML image maps.

## Core Workflows

### Basic Plotting
To plot a `graphNEL` object, use the `plot` method. You can specify different layout engines.

```R
library(biocGraph)
# g1 is a graphNEL object
plot(g1) # Default 'dot' layout
plot(g1, "neato")
plot(g1, "twopi")
```

### Customizing Attributes
Attributes can be set globally (for the whole graph) or per-element (node/edge).

1.  **Global Attributes**: Use the `attrs` argument with a list containing `graph`, `node`, `edge`, or `cluster` sub-lists.
2.  **Per-Node/Edge Attributes**: Use `nodeAttrs` and `edgeAttrs`.

```R
# Define custom labels and colors
nAttrs <- list()
nAttrs$label <- c(a="Node A", b="Node B")
nAttrs$fillcolor <- c(a="red", b="blue")

eAttrs <- list()
eAttrs$color <- c("a~b"="green") # Edge names use tail~head format

plot(g1, nodeAttrs=nAttrs, edgeAttrs=eAttrs, 
     attrs=list(node=list(shape="ellipse", fixedsize=FALSE)))
```

### Using Subgraphs and Clusters
Subgraphs help organize nodes. Clusters (subgraphs with `cluster=TRUE`) force Graphviz to keep nodes visually together.

```R
sg1 <- subGraph(c("a", "b"), g1)
subGList <- list(list(graph=sg1, cluster=TRUE, attrs=c(rank="source")))
plot(g1, subGList=subGList)
```

### Pathway Layout Workflow
For biological pathways (e.g., KEGG), a specific workflow using `layoutGraph` and `renderGraph` is often preferred for better control:

1.  **Initialize**: Set `rankdir="LR"` for a left-to-right pathway feel.
2.  **Labels**: Use `\n` in labels for multi-line text.
3.  **Layout**: Call `layoutGraph` with specific node widths/heights.
4.  **Render**: Call `renderGraph` to draw the result.

```R
attrs <- list(graph=list(rankdir="LR"))
g <- layoutGraph(IMCAGraph, attrs=attrs)
nodeRenderInfo(g) <- list(fill=c(Node1="lightgreen"), shape=c(Node1="rectangle"))
renderGraph(g)
```

### Advanced Ragraph Workflow
For iterative editing without re-calculating the entire layout:
1.  Convert to `Ragraph` using `agopen` or `agopenSimple`.
2.  Get/Set data defaults using `nodeDataDefaults(ng)` or `edgeDataDefaults(ng)`.
3.  Modify specific elements using `nodeData(ng, "nodeName", "attr") <- "value"`.
4.  Render to file using `toFile(ng, layoutType="dot", filename="out.svg", fileType="svg")`.

## Tips and Best Practices

*   **Edge Names**: Always use `edgeNames(g)` to verify the correct string format (usually `tail~head`) before assigning edge attributes.
*   **Reciprocated Edges**: Use `recipEdges="distinct"` in `plot()` to show two separate arrows for bidirectional edges instead of one double-headed arrow.
*   **Node Shapes**: Supported shapes include `circle`, `ellipse`, `box`, and `plaintext`.
*   **Interactive Maps**: Use `imageMap()` to generate HTML files where nodes act as hyperlinks to other data or plots.
*   **Expression Data**: Use `geneplotter::plotExpressionGraph` to automatically color pathway nodes based on a numeric expression vector.

## Reference documentation

- [How To Plot A Graph Using Rgraphviz](./references/biocGraph.md)
- [HowTo layout a pathway](./references/layingOutPathways.md)