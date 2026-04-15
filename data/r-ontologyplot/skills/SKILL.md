---
name: r-ontologyplot
description: This tool visualizes ontological terms and their relationships as Directed Acyclic Graphs using the ontologyPlot R package. Use when user asks to create DAG plots of ontologies, highlight specific terms like HPO or GO, or generate grids of ontological term sets for comparative analysis.
homepage: https://cran.r-project.org/web/packages/ontologyplot/index.html
---

# r-ontologyplot

name: r-ontologyplot
description: Visualizing ontological terms and their relationships using the ontologyPlot R package. Use this skill when you need to create Directed Acyclic Graph (DAG) plots of ontologies (such as HPO, GO, or custom ontologies), highlight specific terms, or generate grids of ontological term sets for comparative analysis.

## Overview

The ontologyPlot package is designed for the visualization of ontological data. It works in conjunction with the ontologyIndex package to produce high-quality plots of terms and their ancestry. It is particularly useful for bioinformatics tasks involving the Human Phenotype Ontology (HPO) or Gene Ontology (GO).

## Installation

To use ontologyPlot, ensure the package and its Bioconductor dependency (Rgraphviz) are installed:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("Rgraphviz")
install.packages("ontologyPlot")
install.packages("ontologyIndex")
```

## Core Workflow

### Basic Plotting

To plot a set of terms, you need an ontology object (typically created via `ontologyIndex::get_ontology`) and a character vector of term IDs.

```r
library(ontologyIndex)
library(ontologyPlot)

# Load an ontology (example using a dummy or local file)
# data(hpo) 

# Basic plot of specific terms and their ancestors
ontology_plot(ontology = hpo, terms = c("HP:0000118", "HP:0000707"))
```

### Customizing Node Appearance

You can map properties to visual attributes like color, shape, and labels.

- **fillcolor**: Set node colors (e.g., based on frequency or significance).
- **label**: Custom text for nodes (defaults to term names).
- **shape**: Change node shapes (e.g., "circle", "box", "ellipse").

```r
# Color nodes by a property
term_colors <- c("HP:0000118" = "red", "HP:0000707" = "blue")
ontology_plot(hpo, terms = names(term_colors), fillcolor = term_colors)
```

### Plotting Term Grids

Use term grids to visualize multiple sets of terms (e.g., different patients or experimental groups) simultaneously.

```r
term_sets <- list(
  Patient1 = c("HP:0000118", "HP:0000707"),
  Patient2 = c("HP:0000118", "HP:0000601")
)

# Create a grid plot
# Note: This often requires the paintmap package
ontology_plot(hpo, terms = unique(unlist(term_sets)), edge_attributes = list(color = "grey"))
```

## Tips and Best Practices

- **Ancestry**: By default, `ontology_plot` includes all ancestors of the specified terms to show the path to the root.
- **Attribute Functions**: Many arguments (like `fillcolor`) can accept functions that take the ontology and terms as arguments, allowing for dynamic styling.
- **Layout**: The package uses `Rgraphviz` for layout. If the plot is too crowded, try subsetting the terms or using the `fixedsize = TRUE` attribute in `node_attributes`.
- **Logical Subsetting**: Use `ontologyIndex` functions like `get_ancestors` or `get_descendants` to refine the list of terms before passing them to `ontology_plot`.

## Reference documentation

- [ontologyPlot Home Page](./references/home_page.md)