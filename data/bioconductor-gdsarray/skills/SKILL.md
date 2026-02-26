---
name: bioconductor-gdsarray
description: The GDSArray package represents Genomic Data Structure files as array-like objects for memory-efficient analysis within the Bioconductor ecosystem. Use when user asks to load GDS files as DelayedArray objects, explore GDS file nodes, perform subsetting on large genomic datasets, or integrate GDS data with SummarizedExperiment workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/GDSArray.html
---


# bioconductor-gdsarray

name: bioconductor-gdsarray
description: Specialized guidance for using the GDSArray Bioconductor package to represent Genomic Data Structure (GDS) files as array-like objects. Use when the user needs to: (1) Load GDS files into R as DelayedArray or GDSArray objects, (2) Explore GDS file nodes and structures, (3) Perform memory-efficient subsetting and numeric calculations on large genomic datasets without loading them entirely into RAM, or (4) Integrate GDS data with SummarizedExperiment workflows.

# bioconductor-gdsarray

## Overview

GDSArray is a Bioconductor package that represents GDS (Genomic Data Structure) files as objects derived from the `DelayedArray` class. This allows users to work with large-scale genomic datasets (often much larger than available RAM) using familiar R array-like syntax and methods. It provides a bridge between the high-performance GDS format and the standard Bioconductor data ecosystem.

## Installation

Install the package using BiocManager:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("GDSArray")
library(GDSArray)
```

## Core Workflows

### Exploring GDS Files

Before loading data, identify which nodes are available within the GDS file.

*   **List all nodes**: Use `gdsnodes()` to see paths that can be converted to GDSArray instances.
    ```r
    file <- "path/to/your.gds"
    nodes <- gdsnodes(file)
    print(nodes)
    ```
*   **Interactive exploration**: Use `GDSFile()` to create a light-weight representation that supports `$` completion for navigating subnodes.
    ```r
    gf <- GDSFile(file)
    gf$annotation$info  # Explore subnodes
    gf$genotype$data    # Access specific data
    ```

### Loading Data as Arrays

Use the `GDSArray()` constructor to wrap a GDS node.

*   **Basic loading**: Provide the file path and the specific node name.
    ```r
    # Returns a GDSArray (or GDSMatrix if 2D)
    ga <- GDSArray(file, "genotype/data")
    ```
*   **Automatic Matrix conversion**: If the node is 2-dimensional, `GDSArray()` automatically returns a `GDSMatrix` object.

### Data Manipulation and Subsetting

GDSArray objects behave like standard R arrays but perform operations "lazily" via the DelayedArray framework.

*   **Subsetting**: Use standard `[` syntax with numeric or logical vectors.
    ```r
    # Subset first 10 rows and 5 columns
    sub_ga <- ga[1:10, 1:5]
    ```
*   **Numeric Calculations**: Perform operations like `log()`, `rowMeans()`, or arithmetic directly on the object.
    ```r
    log_data <- log(ga + 1)
    filtered <- ga[rowMeans(ga) > 0.5, ]
    ```

## Key Functions Reference

*   `GDSArray(file, name)`: Main constructor for creating array-like objects from GDS nodes.
*   `GDSFile(file)`: Creates a file-level object for easy node navigation using `$`.
*   `gdsnodes(file)`: Returns a character vector of all nodes compatible with GDSArray.
*   `gdsfile(object)`: Returns the underlying GDS file path from a GDSArray object.
*   `seed(object)`: Accesses the `GDSArraySeed`, which contains the file path and node metadata.

## Tips for Efficient Usage

*   **Memory Management**: GDSArray does not load the data into memory until it is explicitly realized (e.g., via `as.array()` or when plotting). This is ideal for datasets with millions of variants.
*   **Dimension Consistency**: By default, `GDSArray()` attempts to return objects where rows represent features (variants/SNPs) and columns represent samples, matching the `SummarizedExperiment` convention.
*   **Tab Completion**: When using `GDSFile` objects in RStudio, use the `$` operator and press `Tab` to browse the internal hierarchy of the GDS file.

## Reference documentation

- [GDSArray: Representing GDS files as array-like objects](./references/GDSArray.md)