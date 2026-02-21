---
name: r-bipartite
description: Functions to visualise webs and calculate a series of indices commonly used to describe pattern in (ecological) webs. It focuses on webs consisting of only two levels (bipartite), e.g. pollination webs or predator-prey-webs. Visualisation is important to get an idea of what we are actually looking at, while the indices summarise different aspects of the web's topology. </p>
homepage: https://cloud.r-project.org/web/packages/bipartite/index.html
---

# r-bipartite

name: r-bipartite
description: Visualizing bipartite networks and calculating ecological indices. Use this skill when analyzing two-level networks (e.g., plant-pollinator, predator-prey, host-parasite) in R. It provides tools for creating bipartite plots (web diagrams), calculating network-level and species-level indices (H2', modularity, nestedness), and handling abundance data in network visualizations.

## Overview

The `bipartite` package is the standard R tool for ecological network analysis of bipartite (two-mode) systems. It focuses on visualizing interactions between two distinct groups (trophic levels) and quantifying the topology of these webs through various indices.

## Installation

```R
install.packages("bipartite")
library(bipartite)
```

## Data Structure

A "web" in `bipartite` is a numeric matrix where:
- **Rows** represent the lower trophic level (e.g., plants).
- **Columns** represent the higher trophic level (e.g., pollinators).
- **Cell values** represent the frequency or strength of interaction.

```R
# Example: Create a random web
web <- genweb(N1 = 5, N2 = 6)
rownames(web) <- paste0("Plant_", 1:5)
colnames(web) <- paste0("Pollinator_", 1:6)
```

## Visualization with plotweb()

The `plotweb()` function is the primary tool for visualizing bipartite networks.

### Basic Usage
```R
data(Safariland)
plotweb(Safariland)
```

### Key Arguments for Customization
- `horizontal = TRUE`: Rotates the plot 90 degrees (useful for long species names).
- `srt = 90`: Rotates axis labels (e.g., to 90 degrees).
- `text_size = "auto"`: Automatically scales labels to fit without overlap.
- `spacing = "auto"`: Adjusts the gap between boxes to prevent label collision.
- `curved_links = TRUE`: Changes straight interaction lines to smooth curves.
- `sorting = "ca"`: Uses Correspondence Analysis to minimize link crossings. Other options: `"dec"` (decreasing totals), `"inc"` (increasing totals).

### Coloring and Aesthetics
```R
# Highlight specific species and their links
my_colors <- rep("grey80", nrow(Safariland))
names(my_colors) <- rownames(Safariland)
my_colors["Alstroemeria aurea"] <- "orange"

plotweb(Safariland, 
        lower_color = my_colors, 
        link_color = "lower", # Links take color of the lower level
        curved_links = TRUE)
```

## Handling Abundances

You can visualize independent abundance data (individuals observed but not necessarily interacting) alongside the interaction matrix.

- `lower_abundances` / `higher_abundances`: Resizes boxes based on external abundance data.
- `add_lower_abundances` / `add_higher_abundances`: Adds "extra" boxes (usually red) to show individuals not involved in interactions.
- `scaling = "absolute"`: Ensures the total width of both levels is proportional to their total abundance (default is `"relative"`).

## Ecological Indices

`bipartite` provides numerous functions to quantify network structure:

- `networklevel(web)`: Calculates a suite of indices for the entire web (e.g., connectance, nestedness, robustness).
- `specieslevel(web)`: Calculates indices for each species (e.g., degree, betweenness, species specificity).
- `H2fun(web)`: Calculates the network-level specialization index H2'.
- `computeModules(web)`: Identifies modules (sub-communities) within the network.

## Tips for Large Networks
1. **Rotate**: Use `horizontal = TRUE` for networks with many species to make labels readable.
2. **Filter**: For extremely dense webs, consider removing rare interactions before plotting to reduce visual noise.
3. **Labeling**: Use `higher_italic = TRUE` or `lower_italic = TRUE` for scientific names.

## Reference documentation

- [How to plot networks with bipartite](./references/PlottingWithBipartite.Rmd)