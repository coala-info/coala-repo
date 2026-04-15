---
name: bioconductor-ramigo
description: bioconductor-ramigo interfaces with the AmiGO Visualize web service to retrieve, parse, and visualize Gene Ontology trees. Use when user asks to generate GO tree diagrams in PNG or SVG formats, parse GraphViz DOT files into R graph objects, or export GO networks for Cytoscape.
homepage: https://bioconductor.org/packages/3.5/bioc/html/RamiGO.html
---

# bioconductor-ramigo

name: bioconductor-ramigo
description: Interface with the AmiGO Visualize web service to retrieve, parse, and visualize Gene Ontology (GO) trees. Use this skill when you need to generate GO tree diagrams (PNG, SVG), parse GraphViz DOT files into R graph objects, or export GO networks for Cytoscape (GML).

## Overview
RamiGO provides an R interface to the AmiGO "Visualize" service. It allows users to submit a list of Gene Ontology IDs, highlight them with specific colors, and retrieve the resulting hierarchical tree structure. It is particularly useful for visualizing the results of Gene Set Enrichment Analysis (GSEA) or exploring the relationships between specific biological processes, molecular functions, and cellular components.

## Core Functions

### 1. Retrieving GO Trees
The primary function `getAmigoTree` communicates with the AmiGO server.

```R
library(RamiGO)

# Define GO IDs and corresponding colors
goIDs <- c("GO:0051130", "GO:0019912", "GO:0005783")
colors <- c("lightblue", "red", "yellow")

# Retrieve as PNG
pngRes <- getAmigoTree(goIDs = goIDs, 
                       color = colors, 
                       filename = "go_tree", 
                       picType = "png", 
                       saveResult = TRUE)

# Retrieve as SVG (returns XML string)
svgRes <- getAmigoTree(goIDs = goIDs, 
                       color = colors, 
                       filename = "go_tree", 
                       picType = "svg", 
                       saveResult = TRUE)
```

### 2. Parsing DOT Files
To analyze the tree structure programmatically, retrieve the "dot" format and parse it.

```R
# Get DOT format
dotRes <- getAmigoTree(goIDs = goIDs, color = colors, picType = "dot", saveResult = TRUE)

# Parse into an AmigoDot S4 object
treeObj <- readAmigoDot(object = dotRes)

# Access components
adj <- adjMatrix(treeObj)   # Adjacency matrix
nodes <- annot(treeObj)     # Node annotations
edges <- relations(treeObj) # Edge relationships
leafNodes <- leaves(treeObj) # Leaf nodes only
```

### 3. Exporting to Cytoscape
Convert the parsed tree into a GML file compatible with Cytoscape.

```R
adjM2gml(adjMatrix(treeObj), 
         relations(treeObj)$color, 
         annot(treeObj)$fillcolor, 
         annot(treeObj)$GO_ID, 
         annot(treeObj)$description, 
         filename = "cytoscape_output")
```

## Integration with GSEA
RamiGO includes a mapping object `c5.go.mapping` to link MSigDB C5 (GO) gene set names to official GO IDs, which is essential for visualizing GSEA results.

```R
data(c5.go.mapping)
# Example: Find ID for a specific term
term_info <- c5.go.mapping[c5.go.mapping$description == "NUCLEOPLASM", ]
# Use term_info$goid in getAmigoTree()
```

## Workflow Tips
- **Coloring**: Ensure the `color` vector is the same length as the `goIDs` vector.
- **File Extensions**: The `filename` argument should not include the extension; the package adds it automatically based on `picType`.
- **Object vs File**: `readAmigoDot` can accept either the raw character string returned by `getAmigoTree` or a path to a `.dot` file on disk.
- **Dependencies**: This package relies on `RCurl` for web requests and `igraph` for graph processing.

## Reference documentation
- [RamiGO](./references/RamiGO.md)