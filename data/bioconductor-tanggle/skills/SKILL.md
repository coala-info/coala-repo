---
name: bioconductor-tanggle
description: The tanggle package provides ggplot2-based visualizations for implicit and explicit phylogenetic networks by extending the ggtree framework. Use when user asks to plot split networks, visualize rooted networks with reticulation events, or customize phylogenetic network layouts using ggplot2 syntax.
homepage: https://bioconductor.org/packages/release/bioc/html/tanggle.html
---


# bioconductor-tanggle

name: bioconductor-tanggle
description: Visualization of phylogenetic networks in R using ggplot2 syntax. Use when Claude needs to plot implicit (split) networks or explicit (rooted/directed) networks with reticulations, extending ggtree functionality for evolutionary biology and phylogenetics.

# bioconductor-tanggle

## Overview

The `tanggle` package extends the `ggtree` framework to provide `ggplot2`-based visualizations for phylogenetic networks. It supports two primary types of networks:
1. **Split (Implicit) Networks**: Unrooted and undirected (e.g., Neighbor-Nets, Consensus Networks).
2. **Explicit Networks**: Rooted and directed trees that include reticulation events (e.g., hybridization, horizontal gene transfer).

## Getting Started

Install and load the necessary suite of packages:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("tanggle")

library(tanggle)
library(phangorn)
library(ggtree)
```

## Working with Split Networks

Split networks are typically represented as `networx` objects created via `phangorn`.

### Loading Data
Read a Nexus file from SplitsTree or compute a network from gene trees:

```r
# From Nexus
Nnet <- phangorn::read.nexus.networx("path/to/network.nxs")

# From gene trees (Consensus Network)
# trees <- read.tree("genetrees.tre")
# Nnet <- consensusNet(trees, prob = 0.1)
```

### Plotting
Use `ggsplitnet` for the base plot and `ggtree` geoms for annotation:

```r
# Basic plot with tip labels
ggsplitnet(Nnet) + 
  geom_tiplab2() + 
  xlim(-0.02, 0.01) # Adjust limits to prevent label clipping

# Customizing nodes and labels
ggsplitnet(Nnet) + 
  geom_tiplab2(col = "blue", font = 4) + 
  geom_nodepoint(col = "green", size = 0.5)
```

### Modifying Labels
Rename tip labels directly in the `networx` object:

```r
Nnet$translate$label <- c("Species_A", "Species_B", ...)
```

## Working with Explicit Networks

Explicit networks use the `evonet` class from the `ape` package, often parsed from Extended Newick format.

### Loading and Plotting
Use `ggevonet` with specific layouts:

```r
# Read Extended Newick
z <- read.evonet(text = "((1,((2,(3,(4)Y#H1)g)e,(((Y#H1,5)h,6)f)X#H2)c)a,((X#H2,7)d,8)b)r;")

# Plot with rectangular layout
ggevonet(z, layout = "rectangular") + 
  geom_tiplab() + 
  geom_nodelab()

# Plot with slanted layout and custom aesthetics
ggevonet(z, layout = "slanted") + 
  geom_tiplab(color = "purple") + 
  geom_nodepoint(alpha = 0.5)
```

## Advanced Functions

- **`minimize_overlap(net)`**: Use this to reduce the number of crossing reticulation lines in explicit network plots.
- **`node_depth_evonet(net)`**: Calculate node depths or heights specifically for network objects.
- **`geom_splitnet()`**: Add a split network layer to an existing ggplot object to combine the network with other data visualizations.

## Reference documentation

- [tanggle: Visualization of phylogenetic networks in a ggplot2 framework](./references/tanggle_vignette.md)
- [tanggle: Visualization of phylogenetic networks in a ggplot2 framework (Source)](./references/tanggle_vignette.Rmd)
- [tanggle: Visualización de redes filogenéticas con ggplot2](./references/tanggle_vignette_espanol.md)
- [tanggle: Visualización de redes filogenéticas con ggplot2 (Source)](./references/tanggle_vignette_espanol.Rmd)