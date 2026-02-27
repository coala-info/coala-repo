---
name: bioconductor-ncigraphdata
description: This package provides pre-processed biological pathways from the NCI Pathway Interaction Database as R graph objects. Use when user asks to load NCI-Nature, BioCarta, or Reactome pathways, access curated biological networks as graphNEL objects, or prepare pathway data for analysis with the NCIgraph package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/NCIgraphData.html
---


# bioconductor-ncigraphdata

name: bioconductor-ncigraphdata
description: Provides access to NCI Pathways Database pathways as R graph objects. Use this skill when you need to load, explore, or visualize curated biological pathways from NCI-Nature, BioCarta, or Reactome formatted as graphNEL objects for use with the NCIgraph package or general network analysis.

# bioconductor-ncigraphdata

## Overview

The `NCIgraphData` package is a data-experiment package that provides pre-processed biological pathways from the National Cancer Institute (NCI) Pathway Interaction Database (PID). These pathways were originally imported from Cytoscape and are stored as `graphNEL` objects, making them compatible with standard R graph manipulation and visualization tools like `graph`, `RBGL`, and `Rgraphviz`. It serves as the primary data source for the `NCIgraph` package.

## Loading Data

The package contains two primary datasets. Note that the data names used in the `data()` function use hyphens, while the resulting objects in the R environment use dots.

### NCI-Nature and BioCarta Pathways
This dataset contains 460 pathways.
```r
library(NCIgraphData)
data("NCI-cyList")
# Accesses the object: NCI.cyList
length(NCI.cyList)
```

### Reactome Pathways
This dataset contains 487 pathways.
```r
library(NCIgraphData)
data("reactome-cyList")
# Accesses the object: reactome.cyList
length(reactome.cyList)
```

## Typical Workflow

### 1. Inspecting Pathway Metadata
Each element in the list is a `graphNEL` object. You can inspect the nodes and edges of a specific pathway:
```r
pathway <- NCI.cyList[[1]]
nodes(pathway)
edgeL(pathway)
```

### 2. Visualization
Since the objects are `graphNEL` class, they can be visualized using `Rgraphviz`:
```r
if (requireNamespace("Rgraphviz", quietly = TRUE)) {
  library(Rgraphviz)
  plot(NCI.cyList[[1]])
}
```

### 3. Integration with NCIgraph
This package is designed to be used with the `NCIgraph` software package to perform pathway-based analysis:
```r
# Example of converting to a more usable format if NCIgraph is installed
# library(NCIgraph)
# gr <- NCI.cyList[[1]]
# gr_processed <- parseNCINetwork(gr)
```

## Tips
- **Object Naming**: Remember that `data("NCI-cyList")` loads an object named `NCI.cyList` and `data("reactome-cyList")` loads `reactome.cyList`.
- **Graph Manipulation**: Use the `graph` package to manipulate these objects (e.g., adding/removing nodes, subgraphs).
- **Pathway Selection**: You can search for specific pathways if you know their index or by inspecting the attributes of the graph objects in the list.

## Reference documentation
- [NCIgraphData Reference Manual](./references/reference_manual.md)