---
name: bioconductor-rcx
description: This tool manages biological networks in the Cytoscape Exchange (CX) format within the R environment. Use when user asks to create, read, write, or manipulate CX networks, convert between RCX and igraph or graphNEL formats, visualize networks with Cytoscape styles, or interact with the NDEx platform.
homepage: https://bioconductor.org/packages/release/bioc/html/RCX.html
---


# bioconductor-rcx

name: bioconductor-rcx
description: Expert guidance for the Bioconductor R package RCX. Use this skill to create, read, write, and manipulate biological networks in the Cytoscape Exchange (CX) format. It supports conversion between RCX objects and standard R graph formats (igraph, graphNEL), visualization using Cytoscape-compatible styles, and interaction with the NDEx platform.

# bioconductor-rcx

## Overview
The `RCX` package implements the Cytoscape Exchange (CX) data model in R. It uses an "aspect-oriented" approach where networks are divided into independent modules (nodes, edges, attributes, visual properties). This skill helps you manage complex biological networks, preserve Cytoscape visual styles, and integrate with the NDEx platform.

## Core Workflows

### 1. Reading and Writing CX Files
The primary way to interact with CX data is through JSON-based files.
```r
library(RCX)

# Read a CX file into an RCX object
rcx <- readCX("network.cx")

# Write an RCX object to a CX file
writeCX(rcx, "output_network.cx")
```

### 2. Exploring RCX Objects
RCX objects are lists of data frames (aspects). Use `summary` and `metaData` to inspect them.
```r
# View contained aspects and element counts
rcx$metaData

# Get a summary of a specific aspect
summary(rcx$nodes)
summary(rcx$nodeAttributes)

# Access specific data
node_names <- rcx$nodes$name
```

### 3. Creating Networks from Scratch
Build networks by creating individual aspects and combining them.
```r
# 1. Create Nodes
nodes <- createNodes(name = c("GeneA", "GeneB", "GeneC"))

# 2. Create Edges (using internal IDs starting at 0)
edges <- createEdges(source = c(0, 1), target = c(1, 2), interaction = "regulates")

# 3. Create Attributes
nodeAttrs <- createNodeAttributes(propertyOf = 0, name = "type", value = "kinase")

# 4. Combine into RCX object
rcx <- createRCX(nodes = nodes, edges = edges, nodeAttributes = nodeAttrs)
```

### 4. Visualization
RCX uses the same JavaScript library as NDEx for consistent rendering.
```r
# Basic visualization in RStudio viewer or browser
visualize(rcx)

# Apply a specific layout algorithm (e.g., force-directed)
visualize(rcx, layout = c(name = "cose"))
```

### 5. Conversion to Other Graph Formats
RCX supports seamless conversion to common R graph objects.
```r
# Convert to igraph
ig <- toIgraph(rcx)

# Convert to Bioconductor graphNEL
gnel <- toGraphNEL(rcx)

# Convert from igraph back to RCX
rcx_new <- fromIgraph(ig)
```

## Advanced Usage Tips
- **Internal IDs**: CX uses 0-based integer IDs for nodes and edges. RCX manages these automatically during creation, but you must reference them correctly when manually building attributes or layouts.
- **Visual Properties**: The `cyVisualProperties` aspect is complex. It is often easier to style a network in Cytoscape or NDExEdit, save the CX, and then use `updateCyVisualProperties(newRcx, oldRcx$cyVisualProperties)` to apply that style to new data.
- **Custom Aspects**: You can extend the data model by creating custom classes and defining `rcxToJson` and `jsonToRCX` methods for them.

## Reference documentation
- [Appendix: The RCX and CX Data Model](./references/Appendix_The_RCX_and_CX_Data_Model.md)
- [Creating RCX from scratch](./references/Creating_RCX_from_scratch.md)
- [Extending the RCX Data Model](./references/Extending_the_RCX_Data_Model.md)
- [RCX: An R package implementing the Cytoscape Exchange format](./references/RCX_an_R_package_implementing_the_Cytoscape_Exchange_format.md)