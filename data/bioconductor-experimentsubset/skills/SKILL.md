---
name: bioconductor-experimentsubset
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ExperimentSubset.html
---

# bioconductor-experimentsubset

name: bioconductor-experimentsubset
description: Efficient management of data subsets within Bioconductor Experiment objects (SummarizedExperiment, SingleCellExperiment). Use this skill to create, track, and manipulate subsets of genomic or single-cell data without redundant data copying, and to perform subset-specific analyses like normalization or PCA while maintaining a hierarchical relationship with the parent dataset.

# bioconductor-experimentsubset

## Overview
The `ExperimentSubset` package provides a container to manage multiple subsets of data within a single Bioconductor experiment object. It acts as a drop-in replacement for classes like `SingleCellExperiment` and `SummarizedExperiment`. Instead of creating multiple independent objects for different filtering steps or cell types, it stores references to row and column indices in a `subsets` slot. This minimizes memory usage and maintains a clear provenance of how each subset relates to the original data.

## Core Workflow

### 1. Initialization
Convert an existing experiment object into an `ExperimentSubset` object.

```r
library(ExperimentSubset)
library(SingleCellExperiment)

# From an existing SCE object
es <- ExperimentSubset(sce)

# Or directly from a counts matrix
counts <- matrix(rpois(100, lambda = 10), ncol=10, nrow=10)
es <- ExperimentSubset(list(counts = counts))
```

### 2. Creating Subsets
Use `createSubset` to define a new view of the data. This does not copy the underlying matrix but stores the indices.

```r
# Create a subset by indices
es <- createSubset(es, 
                   subsetName = "filteredCells", 
                   rows = 1:100, 
                   cols = c(1, 5, 10), 
                   parentAssay = "counts")

# View the hierarchy and available subsets
subsetSummary(es)
```

### 3. Managing Subset-Specific Assays
If you perform a transformation (like normalization) on a subset, you can store that specific result back into the subset.

```r
# Get the subset data
sub_mat <- assay(es, "filteredCells")

# Perform operation (e.g., log transformation)
log_sub <- log1p(sub_mat)

# Store it back specifically for that subset
assay(es, "filteredCells", subsetAssayName = "filteredLog") <- log_sub
```

### 4. Accessing Data and Metadata
Most standard Bioconductor accessors are overridden to support the `subsetName` parameter.

*   **Assays**: `assay(es, "subsetName")` retrieves the matrix.
*   **Column/Row Data**: `subsetColData(es, "subsetName", parentColData = TRUE)` retrieves metadata, optionally merging it with the parent's metadata.
*   **Reduced Dimensions**: `reducedDim(es, type = "PCA", subsetName = "subsetName") <- pca_results`.

## Helper Methods
- `subsetNames(es)`: List all defined subsets.
- `subsetDim(es, "subsetName")`: Get dimensions of a specific subset.
- `subsetParent(es, "subsetName")`: Identify the parent assay or subset.
- `subsetCount(es)`: Total number of subsets.

## Best Practices
- **Hierarchical Subsetting**: You can create a subset from another subset. `ExperimentSubset` tracks this lineage (e.g., `counts -> filtered -> highlyVariable`).
- **Memory Efficiency**: Use `createSubset` for filtering steps. Only use `setSubsetAssay` or `assay<-` when the actual values in the matrix change (e.g., after normalization or scaling).
- **Drop-in Compatibility**: Since `ExperimentSubset` objects inherit from their input classes (e.g., `SubsetSingleCellExperiment`), they can be passed to most Bioconductor functions (like `scater` or `scran` functions) by extracting the specific assay or subset needed.

## Reference documentation
- [ExperimentSubset](./references/ExperimentSubset.md)