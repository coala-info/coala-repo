---
name: bioconductor-netbiov
description: The netbiov package provides specialized layout algorithms for the visualization of large-scale biological networks and their modular or hierarchical structures. Use when user asks to visualize networks using minimum spanning trees, plot modular community structures, create hierarchical level plots, or generate abstract representations of large graphs.
homepage: https://bioconductor.org/packages/3.5/bioc/html/netbiov.html
---

# bioconductor-netbiov

## Overview

The `netbiov` package is a Bioconductor tool designed for the visualization of large-scale biological networks. It extends the capabilities of `igraph` by providing specialized layout algorithms that highlight the modular and hierarchical nature of biological systems. Key features include Minimum Spanning Tree (MST) based global layouts, modular visualizations where different components can have distinct layouts, and "information flow" or level plots that visualize network hierarchy starting from specific seed nodes.

## Core Workflows

### 1. Loading Data and Initialization
The package works with `igraph` objects. It includes several example datasets: `artificial1.graph`, `artificial2.graph`, `gnet_bcell`, and `PPI_Athalina`.

```R
library(netbiov)
library(igraph)

# Load example PPI network
data("PPI_Athalina") 
# g1 is the loaded igraph object
```

### 2. Global Layouts (MST-based)
The `mst.plot.mod` and `mst.plot` functions use the Minimum Spanning Tree to organize the network, which is highly effective for large, dense graphs.

```R
# Basic MST plot with Fruchterman-Reingold layout
mst.plot(g1, layout.function=layout.fruchterman.reingold)

# Advanced MST plot with expression data and custom colors
data("color_list")
gparm <- mst.plot.mod(g1, 
                      v.size=1.5, 
                      e.size=.25,
                      colors=c("red", "orange", "yellow"),
                      mst.edge.col="white",
                      expression=abs(runif(vcount(g1))))
```

### 3. Modular Visualizations
`plot.modules` allows you to visualize a network based on its community structure. If modules are not provided, it uses the `fastgreedy` algorithm by default.

```R
# Plot modules with random colors and specific layout
plot.modules(g1, 
             color.random=TRUE, 
             v.size=0.5, 
             layout.function=layout.graphopt)

# Highlighting specific modules (e.g., module 1 in green, others in blue)
# Assuming 'lm' is a list of vertex IDs for modules
cl <- rep("blue", length(lm))
cl[1] <- "green"
plot.modules(g1, mod.list=lm, modules.color=cl)
```

### 4. Information Flow and Level Plots
`level.plot` visualizes the network hierarchy starting from a set of "root" nodes.

```R
# Define seed nodes (e.g., high degree nodes)
seeds <- order(degree(g1), decreasing=TRUE)[1:5]

# Create level plot
level.plot(g1, 
           initial_nodes=seeds, 
           level.spread=TRUE, 
           e.curve=0.25)
```

### 5. Abstract Representations
For extremely large networks, `plot.abstract.nodes` collapses modules into single nodes to show the high-level connectivity.

```R
# Node size represents module size; edge width represents inter-module connectivity
plot.abstract.nodes(g1, 
                    layout.function=layout.fruchterman.reingold,
                    v.sf=-30, 
                    lab.color="white")
```

## Key Functions and Parameters

- `mst.plot.mod`: Main function for MST-based global layouts.
- `plot.modules`: Visualizes internal module structure and inter-module edges.
- `level.plot`: Creates hierarchical/information flow layouts.
- `plot.abstract.nodes`: Simplifies networks by representing modules as single nodes.
- `plot.spiral.graph`: Arranges nodes in a spiral based on degree or other rankings.
- `v.sf` / `sf`: Scaling factors for vertex and edge sizes (often requires tuning for large graphs).
- `layout.function`: Accepts standard `igraph` layout functions (e.g., `layout.kamada.kawai`).

## Tips for Large Networks
- **Plotting Time**: MST plots for 10k nodes take ~5 minutes; modular/abstract plots are significantly faster (~10-30 seconds).
- **Interactive Mode**: Use `tkplot.netbiov(plot_output)` to open an interactive window for manual node adjustment.
- **Coloring**: Use the `color_list` dataset provided by the package for pre-defined professional color schemes (e.g., `color.list$bright`, `color.list$citynight`).

## Reference documentation
- [NetBioV: An R package for visualizing large network data in biology and medicine](./references/netbiov-intro.md)