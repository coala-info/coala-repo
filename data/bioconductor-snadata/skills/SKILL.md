---
name: bioconductor-snadata
description: This package provides access to classic social network analysis datasets from the Wasserman and Faust textbook for use in R. Use when user asks to load social network datasets, analyze Krackhardt's managers or Padgett's Florentine families, and visualize graphNEL objects.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SNAData.html
---


# bioconductor-snadata

name: bioconductor-snadata
description: Access and analyze social network analysis (SNA) datasets from the Wasserman and Faust (1994) textbook. Use this skill when you need to load, manipulate, or visualize classic network datasets including Krackhardt's managers, Padgett's Florentine families, Freeman's EIES network, and global trade data.

## Overview

The `SNAData` package is a data-experiment package providing `graphNEL` objects and attribute data frames for the social network datasets described in Appendix B of "Social Network Analysis" by Wasserman and Faust. It is primarily used for educational purposes, benchmarking network algorithms, and demonstrating graph theory applications in R using the `graph` and `Rgraphviz` packages.

## Loading Data

All datasets are loaded using the standard `data()` function. You must first load the library and the `graph` package to interact with the objects.

```r
library(SNAData)
library(graph)

# Load a specific dataset
data(advice)
data(krackhardtAttrs)
```

## Available Datasets

The package organizes data into five main groups:

### 1. Krackhardt’s High-tech Managers (21 nodes)
- **Graphs**: `advice`, `friendship`, `reportsTo` (Directed)
- **Attributes**: `krackhardtAttrs` (Age, Tenure, Level, Dept)

### 2. Padgett’s Florentine Families (16 nodes)
- **Graphs**: `business`, `marital` (Undirected)
- **Attributes**: `florentineAttrs` (Wealth, NumberPriorates, NumberTies)

### 3. Freeman’s EIES Network (32 nodes)
- **Graphs**: `acqTime1`, `acqTime2`, `messages` (Directed, Weighted)
- **Attributes**: `freemanAttrs` (Citations, Discipline)

### 4. Countries Trade Data (24 nodes)
- **Graphs**: `basicGoods`, `food`, `crudeMaterials`, `minerals`, `diplomats` (Directed)
- **Attributes**: `countriesAttrs` (PopGrowth, GNP, Schools, Energy)

### 5. Galaskiewicz’s CEO and Clubs
- **Graph**: `CEOclubsBPG` (Bipartite graph)
- **Matrix**: `CEOclubsAM` (Affiliation matrix)

## Common Workflows

### Network Exploration
Use `graph` package functions to inspect the `graphNEL` objects.

```r
# Check nodes and edges
nodes(advice)
edgeL(advice)

# Get adjacency list for a specific node
adj(business, "Bischeri")

# Calculate degrees
degree(basicGoods) # Returns inDegree and outDegree for directed graphs
```

### Working with Attributes
Attributes are stored as standard data frames. Row names typically match the node names in the corresponding graph objects.

```r
# Filter nodes based on attributes
high_wealth <- rownames(florentineAttrs[florentineAttrs$Wealth > 50, ])
sub_marital <- subGraph(high_wealth, marital)
```

### Visualization
Visualization requires the `Rgraphviz` package.

```r
library(Rgraphviz)

# Basic plot
plot(reportsTo)

# Plotting a subset of a bipartite graph
cc5 <- c(paste("CEO", 1:5, sep=""), paste("Club", 1:5, sep=""))
subG <- subGraph(cc5, CEOclubsBPG)
plot(subG)
```

## Tips for Analysis
- **Graph Type**: Always check if the graph is directed or undirected using `edgemode(graph_object)` before running centrality or connectivity algorithms.
- **Missing Data**: Some attribute files (like `florentineAttrs` or `countriesAttrs`) contain `NA` values. Handle these before performing statistical analysis.
- **Bipartite Data**: For the CEO/Clubs data, you can convert the affiliation matrix `CEOclubsAM` to a projection (CEO-CEO or Club-Club) using matrix multiplication: `CEO_overlap <- CEOclubsAM %*% t(CEOclubsAM)`.

## Reference documentation
- [SNAData](./references/SNAData.md)