---
name: bioconductor-degraph
description: DEGraph performs differential expression testing on gene networks by incorporating graph topology and multivariate statistics. Use when user asks to perform pathway analysis that accounts for network structure, test if a gene network is differentially expressed between two conditions, or visualize expression statistics on gene network graphs.
homepage: https://bioconductor.org/packages/release/bioc/html/DEGraph.html
---

# bioconductor-degraph

name: bioconductor-degraph
description: Differential expression testing for gene networks using multivariate statistics and graph topology. Use this skill when you need to perform pathway analysis that accounts for network structure (e.g., KEGG pathways) rather than simple gene-set enrichment, or when you want to visualize differential expression on gene network graphs.

# bioconductor-degraph

## Overview

DEGraph implements multivariate hypothesis testing methods to determine if a gene network (graph) is differentially expressed between two conditions. Unlike standard enrichment analysis which treats gene sets as unordered lists, DEGraph utilizes the network topology to improve statistical power. It specifically uses a Hotelling $T^2$ test in a lower-dimensional space defined by the graph Laplacian (Fourier components), which is particularly effective when expression shifts are coherent with the network structure.

## Typical Workflow

### 1. Data Preparation
Ensure your expression data is a matrix with genes as rows and samples as columns. You also need a class vector (0/1 or factor) defining the two groups.

```r
library(DEGraph)
library(KEGGgraph)

# Load example data
data("Loi2008_DEGraphVignette", package="DEGraph")
exprData <- exprLoi2008
classData <- classLoi2008
annData <- annLoi2008
grList <- grListKEGG # List of graph objects
```

### 2. Testing a Single Graph
The `testOneGraph` function is the primary interface for testing a specific network.

```r
# prop: fraction of Fourier components to retain (e.g., 0.2 for 20%)
res <- testOneGraph(grList[[1]], exprData, classData, prop=0.2)

# Access results
p_value <- res[[1]]$p.value
k_dims <- res[[1]]$k # Number of dimensions used
```

### 3. Testing Multiple Pathways
To test a collection of KEGG pathways, iterate through a list of graph objects. Note that `testOneGraph` returns a list of results for each connected component of the graph.

```r
resList <- lapply(grList, function(gr) {
  testOneGraph(gr, exprData, classData, prop=0.2)
})

# Filter out NULL results (components too small to test)
resList <- resList[!sapply(resList, is.null)]
```

### 4. Visualization
DEGraph provides `plotValuedGraph` to overlay statistics (like t-scores or log-fold changes) onto the network structure.

```r
# Calculate individual t-statistics for visualization
# (Assuming X1 and X2 are matrices for the two groups)
t_stats <- apply(exprData, 1, function(x) t.test(x ~ classData)$statistic)

# Map IDs if necessary (e.g., to KEGG IDs)
names(t_stats) <- translateGeneID2KEGGID(names(t_stats))

# Plot the graph
plotValuedGraph(grList[[1]], 
                values=t_stats, 
                nodeLabels=annData[nodes(grList[[1]]), "NCBI.gene.symbol"],
                colorPalette=heat.colors(100))
```

## Key Functions

- `testOneGraph`: Performs multivariate tests on connected components of a graph. It compares a standard Hotelling $T^2$ test against a "Fourier" $T^2$ test using network topology.
- `plotValuedGraph`: Renders a graph where node colors represent quantitative values (e.g., differential expression levels).
- `translateGeneID2KEGGID` / `translateKEGGID2GeneID`: Utility functions for converting between standard Entrez/NCBI IDs and KEGG-specific identifiers.

## Tips for Success

- **Connected Components**: `testOneGraph` automatically splits a graph into its connected components and tests them individually. If a component is too small (e.g., only 1 node), it will return `NULL`.
- **Dimension Reduction (`prop`)**: The `prop` argument (defaulting to 0.2) is crucial. It determines how many low-frequency components of the graph Laplacian are used. Smaller values focus on "smooth" expression changes across the network.
- **Data Matching**: Ensure the node names in your graph objects match the row names (gene IDs) of your expression matrix. Use the translation utilities if there is a mismatch between NCBI and KEGG naming conventions.

## Reference documentation

- [DEGraph: differential expression testing for gene networks](./references/DEGraph.md)