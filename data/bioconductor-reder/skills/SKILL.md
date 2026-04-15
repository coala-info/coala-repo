---
name: bioconductor-reder
description: Bioconductor-reder provides an interactive Java-based interface for the visualization and manipulation of modular and hierarchical networks from R. Use when user asks to visualize nested network structures, perform force-directed layouts on modular graphs, or create tree-and-leaf diagrams from biological data.
homepage: https://bioconductor.org/packages/release/bioc/html/RedeR.html
---

# bioconductor-reder

name: bioconductor-reder
description: Interactive visualization and manipulation of nested networks using the RedeR Bioconductor package. Use this skill to bridge R/igraph network analysis with the RedeR Java-based visual interface, specifically for hierarchical/nested network layouts, force-directed layouts, and tree-and-leaf diagrams.

# bioconductor-reder

## Overview

RedeR is a network visualization tool designed to handle modular and hierarchical structures in biological data. It integrates R's statistical power (via `igraph`) with an interactive Java-based graphical user interface. Key features include a force-directed layout algorithm that respects nested containers, the ability to map R data frames to visual attributes, and support for "tree-and-leaf" diagrams which improve upon traditional dendrograms.

## Core Workflow

### 1. Initialization
The package requires Java 11 or higher.
```r
library(RedeR)
library(igraph)

# Launch the Java application and interface
startRedeR()

# Check Java version if issues arise
RedPort(checkJava=TRUE)
```

### 2. Displaying Graphs
RedeR uses `igraph` objects as the primary data structure.
```r
# Create a simple graph
g <- make_lattice(c(3,3,3))

# Send to RedeR with a specific layout
addGraphToRedeR(g, layout=layout_with_kk(g))

# Retrieve the graph back from RedeR (including manual layout changes)
g_updated <- getGraphFromRedeR()

# Clear the application canvas
resetRedeR()
```

### 3. Working with Nested Containers
Containers allow for the representation of hierarchical modules or sub-networks.
```r
# Nest a graph into a container
addGraphToRedeR(g, isNested=TRUE, gcoord=c(30,30), gscale=50)

# Nest specific nodes into an existing container (e.g., "N1")
nestNodes(nodes=V(g)$name, parent="N1", theme='th2')

# Select nodes within a container and retrieve them
selectNodes(nodes="N2")
g_sub <- getGraphFromRedeR(status="selected")
```

### 4. Interactive Layout (Relaxation)
RedeR's force-directed layout is controlled via the `relaxRedeR` function.
```r
# Run the layout algorithm
# p1: edge length, p2: edge force, p3: node repulsion, p4: node overlap, p5: container force
relaxRedeR(p1=20, p2=150, p3=20, p4=100, p5=10)
```

## Attribute Mapping

RedeR attributes follow `igraph` syntax. Use `rederInfo()` to see all valid attribute names.

### Manual Assignment
```r
# Graph attributes
g$bgcolor <- "white"
g$nestLabel <- "Module A"

# Node attributes
V(g)$nodeColor <- "skyblue"
V(g)$nodeSize <- 30
V(g)$nodeShape <- "ELLIPSE" # Options: RECTANGLE, ROUNDED_RECTANGLE, TRIANGLE, DIAMOND

# Edge attributes
E(g)$edgeLineColor <- "grey"
E(g)$arrowType <- 1 # Directed
```

### Data-Driven Mapping
Use wrapper functions to map data frames to graph attributes.
```r
# Map data frame columns to vertices
# refcol: column index in 'df' matching V(g)$name
g <- att.mapv(g=g, dat=df, refcol=1)

# Transform mapped data into visual attributes
# Map 'Expression' column to node color using a palette
g <- att.setv(g, from="Expression", to="nodeColor", breaks=seq(-2,2,0.4), pal=2)

# Map 'Weight' column to node size
g <- att.setv(g, from="Weight", to="nodeSize", nquant=10, xlim=c(20,50,1))
```

## Tree-and-Leaf Diagrams
Useful for visualizing `hclust` objects as force-directed trees.
```r
library(TreeAndLeaf)

# Convert hclust to tree-and-leaf object
hc <- hclust(dist(iris[,-5]))
tal <- treeAndLeaf(hc)

# Map attributes and send to RedeR
tal <- att.mapv(tal, dat=iris, refcol=0)
addGraphToRedeR(tal)

# Anchor inner nodes and relax leaves
selectNodes(V(tal)$name[!V(tal)$isLeaf], anchor=TRUE)
relaxRedeR()
```

## Tips
- **Vertex Names**: Always ensure `V(g)$name` is populated before mapping attributes or nesting nodes.
- **Legends**: Use `addLegendToRedeR(g, type="nodecolor", title="LogFC")` to add visual scales to the GUI.
- **Edge Merging**: Use `mergeOutEdges(nlevels=2)` to simplify the view of edges between nested containers.

## Reference documentation
- [RedeR](./references/RedeR.md)