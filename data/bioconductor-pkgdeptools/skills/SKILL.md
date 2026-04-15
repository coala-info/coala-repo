---
name: bioconductor-pkgdeptools
description: This tool computes and analyzes dependency relationships among R packages from CRAN-style repositories by treating them as directed graphs. Use when user asks to build dependency graphs, calculate package installation orders, estimate download sizes, or identify reverse dependencies within Bioconductor and CRAN ecosystems.
homepage: https://bioconductor.org/packages/3.5/bioc/html/pkgDepTools.html
---

# bioconductor-pkgdeptools

name: bioconductor-pkgdeptools
description: Tools for computing and analyzing dependency relationships among R packages from CRAN-style repositories. Use this skill to build dependency graphs (graphNEL objects), calculate package installation orders, estimate download sizes, and identify downstream reverse dependencies within Bioconductor and CRAN ecosystems.

# bioconductor-pkgdeptools

## Overview

The `pkgDepTools` package allows users to treat R package repositories as directed graphs. In these graphs, nodes represent packages and directed edges represent dependencies (Depends, Imports, or Suggests). This is particularly useful for developers managing complex package ecosystems or users needing to understand the impact of a package update.

Key capabilities:
- Building comprehensive dependency graphs from repository URLs.
- Calculating the exact installation order for a package and its dependencies.
- Estimating total download size (requires `RCurl`).
- Analyzing reverse dependencies to see which packages rely on a specific library.

## Core Workflows

### 1. Building a Dependency Graph

Use `makeDepGraph` to create a `graphNEL` object from one or more repositories.

```r
library(pkgDepTools)
library(BiocInstaller) # or BiocManager for newer versions

# Get repository URLs
repos <- biocinstallRepos()

# Build the graph
# type: "source", "win.binary", or "mac.binary"
# dosize: Set to TRUE to fetch package sizes (requires RCurl)
depGraph <- makeDepGraph(repos, type = "source", dosize = FALSE)

# Inspect the graph
depGraph
edges(depGraph)["annotate"]
```

### 2. Determining Installation Order

The `getInstallOrder` function identifies which dependencies are missing from the local system and provides a valid sequence for installation.

```r
# Get needed packages only (not currently installed)
installInfo <- getInstallOrder("GOstats", depGraph, needed.only = TRUE)
installInfo$packages

# Get all dependencies regardless of local status
allDeps <- getInstallOrder("GOstats", depGraph, needed.only = FALSE)
allDeps$packages
```

### 3. Visualizing Dependencies

Since the output is a standard `graphNEL` object, you can use `Rgraphviz` or the `graph` package to subset and plot specific relationships.

```r
library(graph)
library(Rgraphviz)

# Get all nodes accessible from a specific package
pkgNodes <- c("Category", names(acc(depGraph, "Category")[[1]]))
subG <- subGraph(pkgNodes, depGraph)

# Plot
plot(subG, nodeAttrs = makeNodeAttrs(subG, shape = "ellipse"))
```

### 4. Analyzing Reverse Dependencies

To find out which packages depend on a specific package (e.g., "methods"), reverse the edge directions of the graph.

```r
# Reverse the graph edges
reversedGraph <- reverseEdgeDirections(depGraph)

# Use Dijkstra's algorithm or simple graph traversal to find dependents
# This shows how many steps away packages are from the target
library(RBGL)
depsOnMe <- dijkstra.sp(reversedGraph, start = "methods")$distance
depsOnMe <- depsOnMe[is.finite(depsOnMe)]

# Count packages that depend on "methods" (excluding itself)
length(depsOnMe) - 1
```

## Tips and Constraints

- **Package Sizes**: Setting `dosize = TRUE` in `makeDepGraph` triggers an HTTP request for every package in the repository. This is slow for large repositories like CRAN.
- **Built-in Packages**: By default, `makeDepGraph` excludes base R packages (e.g., `stats`, `graphics`). Set `keep.builtin = TRUE` if you need to see the full dependency chain down to the R core.
- **Suggests vs Depends**: Use the `suggests.only` argument to toggle between mandatory dependencies (`FALSE`, default) and optional suggested dependencies (`TRUE`).

## Reference documentation

- [How to Use pkgDepTools](./references/pkgDepTools.md)