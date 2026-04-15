---
name: bioconductor-pathrender
description: This tool visualizes KEGG and Biocarta pathways as graphs and maps genomic data onto pathway nodes. Use when user asks to render biological pathways, map gene expression values to pathway nodes, or create color-coded pathway diagrams from Bioconductor data.
homepage: https://bioconductor.org/packages/release/bioc/html/pathRender.html
---

# bioconductor-pathrender

name: bioconductor-pathrender
description: Visualizing KEGG and Biocarta pathways as graphs and linking genomic data (like ExpressionSets) to pathway nodes for integrated analysis. Use when you need to render biological pathways, map gene expression values to pathway nodes, or create color-coded pathway diagrams from Bioconductor data.

# bioconductor-pathrender

## Overview

The `pathRender` package provides tools for the visualization of biological pathways from sources like KEGG and Biocarta. It transforms pathway information into R graph structures that can be rendered using `Rgraphviz`. A key feature is the ability to map quantitative genomic data (e.g., gene expression levels) onto pathway nodes, allowing for the visual interpretation of experimental results within a biological context.

## Typical Workflow

### 1. Basic Pathway Rendering
To visualize a pathway without experimental data, use `graphcMAP` to retrieve the pathway structure and `plot` to render it.

```R
library(pathRender)
library(Rgraphviz)

# Load a specific Biocarta pathway
G1 <- graphcMAP("p53pathway")

# Basic plot
plot(G1)

# Improve readability using pwayRendAttrs
plot(G1, nodeAttrs = pwayRendAttrs(G1))
```

### 2. Mapping Expression Data to Pathways
To visualize quantitative data on a pathway, you typically reduce an `ExpressionSet` to the genes present in the pathway and then use `plotExGraph`.

```R
library(pathRender)
library(ALL)
library(hgu95av2.db)

# 1. Load pathway and data
data(pancrCaIni)
data(ALL)

# 2. Reduce ExpressionSet to pathway nodes
# collapseFun = mean handles multiple probes for the same gene symbol
collap1 <- reduceES(ALL, 
                    nodes(pancrCaIni), 
                    revmap(hgu95av2SYMBOL), 
                    "symbol", 
                    collapseFun = mean)

# 3. Render a specific sample (e.g., sample 1) onto the graph
# Nodes will be colored based on expression levels
plotExGraph(pancrCaIni, collap1, 1)
```

## Key Functions

- `graphcMAP(pathwayName)`: Retrieves a graph representation of a Biocarta pathway.
- `pwayRendAttrs(graph)`: Generates a set of rendering attributes (colors, shapes, font sizes) optimized for pathway legibility.
- `reduceES(eset, nodeNames, annMap, geneIdType, collapseFun)`: Filters an `ExpressionSet` to match the nodes of a pathway. It maps probe IDs to gene symbols and can collapse multiple probes into a single value per gene.
- `plotExGraph(graph, eset, sampleIndex)`: The primary high-level function for rendering a pathway graph with nodes colored according to the expression values in a specific sample of an `ExpressionSet`.

## Tips and Best Practices

- **Readability**: Standard R graph plots can be cluttered. Always try `nodeAttrs = pwayRendAttrs(g)` within the `plot()` call to improve the visual layout.
- **ID Mapping**: Ensure the `annMap` provided to `reduceES` correctly matches the ID type used in your pathway graph (usually HUGO symbols).
- **Color Schemes**: `plotExGraph` uses `RColorBrewer` internally. Ensure this package is installed for the default heat-map style node coloring.
- **Node Inspection**: Use `nodes(G1)` to see the exact strings used for gene/molecule identification in the graph to ensure your data mapping is accurate.

## Reference documentation

- [pathRender: KEGG and Biocarta pathway visualization](./references/pathRender.md)
- [Rendering pathways to convey quantitative genomic relationships](./references/plotExG.md)