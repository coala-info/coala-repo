---
name: bioconductor-rbcbook1
description: This package provides infrastructure, datasets, and graph objects for the "Bioconductor Case Studies" book. Use when user asks to access example datasets, manage cached graph objects, or follow bioinformatics workflows from the Bioconductor Case Studies.
homepage: https://bioconductor.org/packages/release/bioc/html/RbcBook1.html
---


# bioconductor-rbcbook1

name: bioconductor-rbcbook1
description: Use this skill when working with the Bioconductor package RbcBook1. This package provides infrastructure and data for the book "Bioconductor Case Studies." It is primarily used for accessing example datasets, graph objects, and specific case study workflows in bioinformatics.

# bioconductor-rbcbook1

## Overview
The RbcBook1 package is a support package for the "Bioconductor Case Studies" book. It contains various datasets, graph objects, and helper functions used throughout the book's chapters to demonstrate biological data analysis using R and Bioconductor. It is particularly useful for users following the book's tutorials or needing standardized graph objects for testing graph-theory algorithms in a biological context.

## Loading the Package
To begin using the package, load it into your R session:

```r
library(RbcBook1)
library(graph) # Often used in conjunction with RbcBook1
```

## Key Workflows and Functions

### Working with Cached Objects
The package uses a `cache` mechanism to manage large or computationally expensive objects used in the case studies.

- **Accessing Data**: You can load specific objects like random graphs or biological networks.
- **Example: Random Graphs**:
  ```r
  # Create and cache a random graph object
  cache(bigran <- randomGraph(paste("a", 1:50), 1:30, 0.4))
  ```

### Data Exploration
The package serves as a repository for specific datasets. Use standard R introspection to explore available data:

```r
# List datasets in the package
data(package = "RbcBook1")

# Load a specific dataset (replace 'datasetName' with actual name from the list)
# data(datasetName)
```

## Usage Tips
- **Graph Manipulation**: Since many objects in RbcBook1 are of class `graphNEL` or similar, use the `graph` and `RBGL` packages to manipulate and analyze these objects.
- **Educational Context**: This package is best used as a companion to the "Bioconductor Case Studies" text. If a specific function or object is referenced in the book, it is likely contained here.
- **Dependencies**: Ensure `graph` is installed, as RbcBook1 frequently interacts with graph-based data structures.

## Reference documentation
- [RbcBook1](./references/RbcBook1.md)