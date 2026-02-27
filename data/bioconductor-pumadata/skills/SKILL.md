---
name: bioconductor-pumadata
description: This package provides example datasets and data structures for the puma Bioconductor package to support uncertainty-aware microarray analysis. Use when user asks to load example microarray data for puma analysis, access pre-calculated ExpressionSet objects, or run puma package demonstrations.
homepage: https://bioconductor.org/packages/release/data/experiment/html/pumadata.html
---


# bioconductor-pumadata

## Overview
The `pumadata` package is a specialized Bioconductor experiment data package. It provides the necessary data structures and example datasets required to demonstrate and utilize the functionality of the `puma` (Propagating Uncertainty in Microarray Analysis) package. It is primarily used for educational purposes, vignettes, and benchmarking uncertainty-aware microarray processing.

## Loading the Data
To use the datasets provided by this package, you must first load the library and then use the `data()` function to bring specific objects into your R environment.

```r
# Load the package
library(pumadata)

# List available datasets in the package
data(package = "pumadata")

# Load the primary example AffyBatch object
data(eset_mmgmos)
```

## Typical Workflow
The data in `pumadata` is designed to be passed directly into `puma` functions. A common workflow involves using these pre-calculated objects to test differential expression or clustering without having to process raw CEL files.

1. **Load the data**: Load an `ExpressionSet` or `AffyBatch` object provided by the package.
2. **Inspect the object**: Check the dimensions and phenoData to understand the experimental design.
3. **Apply puma functions**: Use functions from the `puma` package (like `pumactrl` or `pumaDE`) on these objects.

```r
library(pumadata)
library(puma)

# Load example ExpressionSet created with mmgmos
data(eset_mmgmos)

# Perform differential expression analysis using puma
# (Requires the 'puma' package to be installed)
p_results <- pumaDE(eset_mmgmos)
```

## Tips
- This package does not contain standalone analysis functions; it is a data-only container.
- If you are looking for the methodology on how to propagate uncertainty, refer to the main `puma` package documentation.
- The datasets are often subsets of larger experiments (like the Golden Spike or Spike-in datasets) to keep the package size manageable while remaining computationally useful.

## Reference documentation
- [pumadata User Guide](./references/pumadata.md)