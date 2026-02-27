---
name: bioconductor-rcyjs
description: This tool provides an interface for interactive network visualization using cytoscape.js within R. Use when user asks to create, style, and animate biological networks, perform programmatic layouts, or map data attributes to visual properties in a web browser.
homepage: https://bioconductor.org/packages/release/bioc/html/RCyjs.html
---


# bioconductor-rcyjs

name: bioconductor-rcyjs
description: Interactive network visualization using cytoscape.js within R. Use this skill to create, style, and animate biological networks (graphNEL objects) in a web browser, perform programmatic layouts, and map data attributes to visual properties.

# bioconductor-rcyjs

## Overview
RCyjs provides an interface between R and cytoscape.js for interactive network visualization. It uses websockets to communicate between the R session and a web browser. It is specifically designed to work with Bioconductor `graphNEL` objects, allowing users to map node and edge attributes (like expression data or flux) to visual properties (size, color, shape) dynamically.

## Core Workflow

### 1. Graph Preparation
RCyjs primarily uses the `graphNEL` class. You must define nodes, edges, and default attributes before initialization.

```r
library(RCyjs)
library(graph)

# Create graph
nodes <- c("A", "T")
g <- graphNEL(nodes, edgemode="directed")
g <- addEdge("A", "T", g)

# Set required defaults for attributes
nodeDataDefaults(g, attr="label") <- "undefined"
nodeDataDefaults(g, attr="type") <- "undefined"
nodeDataDefaults(g, attr="flux") <- 0
edgeDataDefaults(g, attr="edgeType") <- "undefined"

# Assign specific values
nodeData(g, "A", "type") <- "activator"
nodeData(g, "T", "type") <- "target"
edgeData(g, "A", "T", "edgeType") <- "regulates"
```

### 2. Initialization and Display
Initialize the browser-based viewer and load the graph.

```r
rcy <- RCyjs(title="My Network")
setGraph(rcy, g)
layout(rcy, "grid")
fit(rcy, padding=100)
```

### 3. Visual Styling
You can control appearance via global defaults, specific assignments, or external style files.

**Global Defaults:**
```r
setDefaultNodeShape(rcy, "ellipse")
setDefaultNodeColor(rcy, "lightblue")
setDefaultEdgeTargetArrowShape(rcy, "arrow")
setBackgroundColor(rcy, "#FFFFFF")
redraw(rcy)
```

**Specific Assignments:**
```r
setNodeColor(rcy, "A", "red")
setNodeSize(rcy, "T", 100)
redraw(rcy)
```

### 4. Layout Management
RCyjs supports algorithmic layouts and manual positioning.

*   **Algorithmic:** `layout(rcy, "cose")` or `layout(rcy, "circle")`. Use `getLayoutStrategies(rcy)` for a full list.
*   **Manual/Ad hoc:** Use `getLayout(rcy)` to get a data.frame of coordinates and `setLayout(rcy, df)` to apply them.
*   **Persistence:** `saveLayout(rcy, "my_layout.RData")` and `restoreLayout(rcy, "my_layout.RData")`.

## Advanced Features

### Data-Driven Mapping (Styles)
To create dynamic visualizations (e.g., node size changing with expression), use CSS-like selectors in a Javascript style file. The `mapData` function is key:
`"background-color": "mapData(flux, 0, 1000, white, red)"`

### Animation and Updates
To animate a process, update the graph attributes in R and call `redraw()`:
```r
for(i in 1:10){
  nodeData(g, "A", "flux") <- i * 10
  setGraph(rcy, g) # Update the graph in the viewer
  redraw(rcy)
  Sys.sleep(0.1)
}
```

## Tips and Best Practices
*   **Redraw:** Most visual changes require a call to `redraw(rcy)` to take effect in the browser.
*   **Node IDs:** Use simple character strings for node names; use the "label" attribute for complex display names.
*   **Supported Shapes:** Check `getSupportedNodeShapes(rcy)` and `getSupportedEdgeDecoratorShapes(rcy)` for valid options.
*   **Igraph Compatibility:** If using `igraph`, convert to `graphNEL` using `igraph::igraph.to.graphNEL()` before passing to RCyjs.

## Reference documentation
- [RCyjs: interactive network visualization using cytoscape.js](./references/RCyjs.md)