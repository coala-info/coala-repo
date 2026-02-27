---
name: bioconductor-panvizgenerator
description: Bioconductor-panvizgenerator creates interactive, browser-based visualizations for functionally annotated pangenomes. Use when user asks to convert pangenome matrices into HTML visualizations, visualize gene presence/absence with GO terms, or generate PanViz plots from FindMyFriends objects.
homepage: https://bioconductor.org/packages/3.8/bioc/html/PanVizGenerator.html
---


# bioconductor-panvizgenerator

name: bioconductor-panvizgenerator
description: Create interactive PanViz visualizations for functionally annotated pangenomes. Use this skill when you need to convert pangenome matrices and functional annotations (GO terms, EC numbers) into self-contained, D3.js-based HTML visualizations, or when working with pangenome objects from the FindMyFriends package.

# bioconductor-panvizgenerator

## Overview

PanVizGenerator is a companion package for the PanViz visualization tool. It automates the data formatting and conversion required to create interactive, browser-based pangenome visualizations. These visualizations allow users to explore gene presence/absence across genomes alongside functional annotations like Gene Ontology (GO) terms.

## Core Workflows

### 1. Data Preparation
PanViz requires two primary data components:
- **Pangenome Matrix**: A presence/absence matrix where rows are gene groups and columns are genomes.
- **Functional Annotation**: GO terms (required for the GO graph navigation) and optionally E.C. numbers or gene names.

### 2. Creating Visualizations with `panviz()`
The `panviz()` function is the primary interface. It can handle various input types:

**From a CSV file:**
```r
library(PanVizGenerator)
# CSV should contain pangenome matrix and annotation columns
csvFile <- "path/to/pangenome.csv"
panviz(csvFile, location = "output_folder")
```

**From R objects (Matrix/Data Frame):**
```r
# pangenome: matrix of presence/absence
# name: vector of gene group names
# go: vector or list of GO terms (e.g., "GO:0005524; GO:0006508")
# ec: vector of E.C. numbers
panviz(pangenome, name = name, go = go, ec = ec, location = "output_folder")
```

**From FindMyFriends objects:**
If using the `FindMyFriends` package, ensure `groupInfo` contains 'GO' and 'EC' columns.
```r
library(FindMyFriends)
# pg is a FindMyFriends object
panviz(pg, location = "output_folder")
```

### 3. Customizing the Output
- **Consolidation**: By default, `panviz` creates a single self-contained HTML file. Use `consolidate = FALSE` to keep JavaScript and data files separate.
- **Showcase**: Set `showcase = TRUE` to automatically open the resulting visualization in your default web browser.
- **Clustering**: Adjust the genomic navigation plot using `dist` (distance measure, e.g., 'binary') and `clust` (clustering algorithm, e.g., 'complete').

### 4. Managing Gene Ontology Data
PanViz embeds the GO graph. The package manages this automatically, but you can manually refresh the cache if needed:
```r
getGO()
```

## Tips and Best Practices
- **GO Format**: GO terms can be provided as a semicolon-separated string or a list of character vectors.
- **Temporary Files**: Use `location = tempdir()` combined with `showcase = TRUE` for quick iterative previews without cluttering your workspace.
- **GUI**: For a non-programmatic interface, run `PanVizGenerator()` to launch the Shiny-based web application.

## Reference documentation
- [Creating PanViz visualizations with PanVizGenerator](./references/panviz_howto.md)
- [PanVizGenerator Vignette Source](./references/panviz_howto.Rmd)