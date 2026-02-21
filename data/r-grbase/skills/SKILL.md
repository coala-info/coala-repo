---
name: r-grbase
description: R package grbase (documentation from project home).
homepage: https://cran.r-project.org/web/packages/grbase/index.html
---

# r-grbase

## Overview
`gRbase` is a foundational R package for graphical modeling. It provides the infrastructure for other packages like `gRain` (Bayesian networks) and `gRim` (graphical interaction models). Its primary strengths lie in efficient graph manipulation, finding cliques, graph triangulation, and advanced operations on multidimensional tables (arrays) which are essential for probability propagation.

## Installation
To install the stable version from CRAN:
```R
install.packages("gRbase")
```

To install the development version from GitHub:
```R
remotes::install_github("hojsgaard/gRbase")
```

## Main Functions and Workflows

### Graph Creation and Manipulation
`gRbase` uses standard R objects to represent graphs, often interfacing with the `graph` and `igraph` packages.
- `ug()`: Create an undirected graph.
- `dag()`: Create a directed acyclic graph.
- `adjList()` / `adjMatrix()`: Convert between different graph representations.

### Graph Algorithms
- `is_dag()` / `is_ug()`: Check graph properties.
- `triangulate()`: Triangulate an undirected graph (essential for junction tree algorithms).
- `get_cliques()`: Find all maximal cliques of a graph.
- `moralize()`: Convert a directed graph into a moralized undirected graph.
- `separates()`: Check for separation in a graph.

### Table Operations (Multidimensional Arrays)
`gRbase` provides highly optimized functions for "tables" (arrays where dimensions are named variables).
- `tableMargin()`: Marginalize a table over specific variables.
- `tablePerm()`: Permute the dimensions of a table.
- `tableOp()`: Perform arithmetic operations (addition, multiplication, division) on two tables, automatically aligning variables.
- `tableSlice()`: Extract a slice of a table based on variable values.

### Data Sets
The package includes several classic datasets for graphical modeling:
- `reinis`: Socio-economic data (6 binary variables).
- `cad`: Coronary artery disease data.
- `chest_sim`: Simulated data for the "Chest Clinic" (Asia) network.

## Tips for Efficient Usage
1. **Variable Ordering**: When performing table operations, `gRbase` is sensitive to variable names. Ensure your arrays have the `dimnames` attribute set correctly.
2. **Integration**: Use `gRbase` for the underlying graph theory and table algebra, then pass these objects to `gRain` for inference or `gRim` for model selection.
3. **Performance**: For large-scale table operations, `gRbase` functions are generally faster than base R `apply()` or `sweep()` because they are optimized for the specific structure of contingency tables.

## Reference documentation
- [Packages for graphical modelling with R](./references/home_page.md)