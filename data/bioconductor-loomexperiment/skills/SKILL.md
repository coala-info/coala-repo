---
name: bioconductor-loomexperiment
description: The LoomExperiment package provides a bridge between the Loom file format and Bioconductor experiment containers to support graph-based single-cell data. Use when user asks to import or export loom files, create SingleCellLoomExperiment objects, or manage row and column graphs for single-cell analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/LoomExperiment.html
---

# bioconductor-loomexperiment

## Overview

The `LoomExperiment` package provides a bridge between the Loom file format (HDF5-based) and Bioconductor's standard experiment containers. It introduces the `LoomExperiment` and `SingleCellLoomExperiment` classes, which extend `SummarizedExperiment` and `SingleCellExperiment` respectively. A key feature of this package is the support for `rowGraphs` and `colGraphs`, which store graph-based data (like KNN networks) often found in single-cell analysis.

## Core Workflows

### 1. Creating LoomExperiment Objects

You can create objects by wrapping existing Bioconductor objects or by using constructors directly.

```r
library(LoomExperiment)

# From an existing SingleCellExperiment
scle <- SingleCellLoomExperiment(sce)

# Or via coercion
scle <- as(sce, "SingleCellLoomExperiment")

# Direct construction
scle <- SingleCellLoomExperiment(assays = list(counts = counts_matrix))
```

### 2. Importing and Exporting Loom Files

The package uses the `BiocIO` framework for seamless I/O.

```r
# Import a .loom file
scle <- import("path/to/file.loom", type = "SingleCellLoomExperiment")

# Export to a .loom file
export(scle, "output_file.loom")
```

### 3. Managing Graphs (LoomGraph/LoomGraphs)

Loom files store relationships as graphs. These are handled via `LoomGraph` (a single graph) and `LoomGraphs` (a list of graphs).

```r
# Create a graph
lg <- LoomGraph(from = c(1, 2), to = c(3, 4), weight = c(0.5, 0.8))

# Create a list of graphs
lgs <- LoomGraphs(graph1 = lg)

# Assign to an experiment
colGraphs(scle) <- lgs
rowGraphs(scle) <- lgs

# Access graphs
colGraphs(scle)
colGraphs(scle)[["graph1"]]
```

### 4. Subsetting and Manipulation

Subsetting a `LoomExperiment` automatically subsets the associated graphs to maintain consistency.

```r
# Subset rows and columns
# rowGraphs are subset by i, colGraphs are subset by j
scle_subset <- scle[1:10, 1:5]

# Combining objects (graphs are merged)
scle_combined <- rbind(scle, scle)
```

## Key Classes and Methods

- **`LoomExperiment`**: Base class extending `SummarizedExperiment`.
- **`SingleCellLoomExperiment`**: Extends `SingleCellExperiment`; preferred for single-cell data.
- **`colGraphs(x)` / `rowGraphs(x)`**: Accessors for the graph slots.
- **`LoomGraph`**: Extends `SelfHits`; represents edges between nodes (cells or genes).

## Tips for Success

- **Weights**: When creating a `LoomGraph`, the weight column must be named `w` in the metadata or passed as the `weight` argument in the constructor.
- **Indices**: `LoomGraph` indices are 1-based in R, following standard Bioconductor conventions, even though the underlying HDF5 format is 0-based.
- **Memory**: Since Loom files are HDF5-based, `LoomExperiment` can leverage `HDF5Array` for on-disk representation of large datasets.

## Reference documentation

- [The LoomExperiment Classes](./references/LoomExperiment.md)