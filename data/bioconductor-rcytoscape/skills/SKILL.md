---
name: bioconductor-rcytoscape
description: This tool provides an interface to visualize and manipulate biological networks in Cytoscape from an R session. Use when user asks to send graph objects to Cytoscape, apply visual styles based on node or edge attributes, and programmatically control network layouts.
homepage: https://bioconductor.org/packages/3.6/bioc/html/RCytoscape.html
---


# bioconductor-rcytoscape

name: bioconductor-rcytoscape
description: Use this skill to visualize and manipulate biological networks in Cytoscape from an R session. It is ideal for mapping Bioconductor graph objects (graphNEL) to Cytoscape windows, applying visual styles (vizmapping) based on node/edge attributes, and programmatically controlling the Cytoscape desktop for network analysis and animation.

# bioconductor-rcytoscape

## Overview

RCytoscape provides an interface between R/Bioconductor and Cytoscape. It allows users to send graph objects to Cytoscape, where they can be visually explored and manipulated. The package uses XMLRPC to communicate with a running Cytoscape instance (version 2.8.1 with the CytoscapeRPC plugin). Key capabilities include mapping data attributes (like expression levels or molecule types) to visual properties (color, shape, size) and programmatically controlling node positions or panel visibility.

## Prerequisites

Before using RCytoscape, ensure the following environment is set up:
- **Cytoscape 2.8.1** must be running.
- **CytoscapeRPC plugin** (v1.7+) must be installed and activated (typically on port 9000).
- The R package `XMLRPC` must be installed.

## Core Workflow

### 1. Creating and Displaying a Graph
RCytoscape works primarily with `graphNEL` objects.

```R
library(RCytoscape)
library(graph)

# Create a simple graph
g <- new("graphNEL", edgemode="directed")
g <- addNode(c("A", "B", "C"), g)

# Create a window and display
cw <- new.CytoscapeWindow("My Network", graph=g)
displayGraph(cw)
layoutNetwork(cw, layout.name="grid")
redraw(cw)
```

### 2. Managing Attributes
Attributes must be initialized with a specific type (`char`, `integer`, or `numeric`) before values are assigned.

```R
# Initialize node attributes
g <- initNodeAttribute(graph=g, attribute.name="moleculeType", attribute.type="char", default.value="undefined")
g <- initNodeAttribute(graph=g, attribute.name="lfc", attribute.type="numeric", default.value=0.0)

# Assign values
nodeData(g, "A", "moleculeType") <- "kinase"
nodeData(g, "A", "lfc") <- -1.2

# Update the Cytoscape window with the new graph data
cw = setGraph(cw, g)
displayGraph(cw)
```

### 3. Visual Mapping (Vizmap) Rules
Rules connect data attributes to visual styles.

**Lookup (Discrete) Rules:**
Used for categorical data like molecule types.
```R
node.shapes <- c("diamond", "triangle", "rect")
attribute.values <- c("kinase", "TF", "cytokine")
setNodeShapeRule(cw, "moleculeType", attribute.values, node.shapes)
```

**Interpolation Rules:**
Used for continuous data like log fold change (lfc).
```R
# Colors: Low (Green), Mid (White), High (Red)
control.points <- c(-3.0, 0.0, 3.0)
colors <- c("#00FF00", "#FFFFFF", "#FF0000")
setNodeColorRule(cw, "lfc", control.points, colors, mode="interpolate")
```

### 4. Selecting and Manipulating Nodes
You can interact with the Cytoscape selection state from R.

```R
# Get selected nodes from Cytoscape
selected <- getSelectedNodes(cw)

# Select neighbors of current selection
selectFirstNeighborsOfSelectedNodes(cw)

# Set specific node positions (x, y)
setNodePosition(cw, "A", 200, 200)
```

### 5. UI Control
Manage the Cytoscape desktop interface programmatically.

```R
hidePanel(cw, "Data Panel")
floatPanel(cw, "Control Panel")
dockPanel(cw, "c") # 'c' for Control Panel
```

## Tips and Best Practices
- **Redraw Requirement:** While setting rules often updates the view automatically, changing default values (e.g., `setDefaultNodeColor`) usually requires a call to `redraw(cw)`.
- **Type Strictness:** Because Cytoscape is Java-based, you must be explicit about `numeric` vs `integer` types during attribute initialization.
- **Animation:** Use `setNodeAttributesDirect` within a loop to update values and call `redraw(cw)` to create animations (e.g., time-course data).
- **Cleanup:** Use `deleteWindow(cw)` or `deleteAllWindows()` to manage the Cytoscape desktop workspace.

## Reference documentation
- [RCytoscape](./references/RCytoscape.md)