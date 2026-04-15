---
name: bioconductor-hicexperiment
description: This package provides a standardized Bioconductor interface for importing, managing, and subsetting Hi-C contact matrices and pairs files. Use when user asks to import .cool or .hic files into R, convert Hi-C data to GInteractions objects, or subset contact matrices by genomic coordinates.
homepage: https://bioconductor.org/packages/release/bioc/html/HiCExperiment.html
---

# bioconductor-hicexperiment

name: bioconductor-hicexperiment
description: Specialized R package for importing, managing, and subsetting Hi-C contact matrices and pairs files. Use this skill when working with Hi-C data in R, specifically for importing .cool, .mcool, .hic, or HiC-Pro files into Bioconductor-compatible HiCExperiment objects for downstream genomic analysis.

# bioconductor-hicexperiment

## Overview

The `HiCExperiment` package provides a standardized Bioconductor interface for Hi-C data. It allows for efficient, random-access loading of large contact matrices (HDF5-based `.cool` or binary `.hic`) and provides a unified class to store interactions, genomic metadata, and topological features (like loops or compartments). It bridges the gap between specialized Hi-C file formats and the `GInteractions` / `InteractionSet` ecosystem.

## Core Workflow

### 1. Importing Data

The `import()` function is the primary entry point. It automatically detects file formats based on extensions or provided arguments.

```r
library(HiCExperiment)

# Import a .cool or .hic file
hic <- import("path/to/file.mcool", resolution = 10000)

# Import with a specific genomic focus (subsetting on-the-fly)
hic_sub <- import("path/to/file.cool", focus = "chr1:1000000-5000000")

# Import off-diagonal rectangular subsets
hic_rect <- import("path/to/file.cool", focus = "chr1:1-500000|chr1:2000000-2500000")
```

### 2. Supporting File Classes

For more control, use specific file wrappers, especially when linking matrix files with their corresponding pairs files.

- `CoolFile(path, pairsFile)`
- `HicFile(path, pairsFile)`
- `HicproFile(matrix, bed, pairsFile)`

```r
cf <- CoolFile("data.mcool", pairsFile = "data.pairs.gz")
hic <- import(cf, resolution = 5000)
```

### 3. Accessing Data

Use accessors to retrieve specific components of the `HiCExperiment` object:

- `interactions(hic)`: Returns a `GInteractions` object containing the contacts.
- `scores(hic, "balanced")`: Retrieves specific score vectors (e.g., ICE/KR normalized counts).
- `resolutions(hic)`: Lists available resolutions in a multi-resolution file.
- `bins(hic)`: Returns the genomic bins for the current resolution.
- `topologicalFeatures(hic)`: Accesses stored loops, domains, or compartments.

### 4. Data Transformation and Coercion

`HiCExperiment` objects can be easily converted to other standard R formats for analysis or visualization.

```r
# Convert to standard Bioconductor classes
gi <- as(hic, "GInteractions")
cm <- as(hic, "ContactMatrix")

# Convert to base R formats
mat <- as(hic, "matrix")
df  <- as(hic, "data.frame")
```

### 5. Modifying Objects

You can manually add scores or features to an existing object.

```r
# Add a custom score
scores(hic, 'normalized') <- my_custom_vector

# Add topological features
topologicalFeatures(hic, 'loops') <- my_loop_ranges # GRanges or Pairs
```

## Tips and Best Practices

- **Memory Efficiency**: Use the `focus` argument during `import()` to load only the genomic regions you need. This is significantly faster and more memory-efficient than importing a whole genome and subsetting later.
- **Resolution Selection**: When working with `.mcool` or `.hic` files, use `availableResolutions(file_path)` to check what is available before importing.
- **HiC-Pro Data**: Unlike binary formats, HiC-Pro files do not support random access; the entire matrix is loaded into memory during import.
- **Normalization**: Most `.cool` and `.hic` files come with pre-calculated normalization weights (e.g., "balanced"). Use `scores(hic)` to see what is available.

## Reference documentation

- [Introduction to HiCExperiment](./references/HiCExperiment.md)