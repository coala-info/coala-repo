---
name: bioconductor-lute
description: The lute package provides a unified framework for performing cell-type deconvolution experiments in R while accounting for cell size scale factors. Use when user asks to perform bulk deconvolution, incorporate cell size scaling factors, or generate pseudobulk simulations from single-cell data.
homepage: https://bioconductor.org/packages/release/bioc/html/lute.html
---

# bioconductor-lute

## Overview

The `lute` package provides a unified framework for deconvolution experiments in R. It standardizes the interface for multiple deconvolution algorithms using a class-based system (based on `bluster`). A key feature of `lute` is its ability to incorporate cell size scale factors ($S$), which corrects for biases in tissues where cell types differ significantly in RNA content (e.g., neurons vs. glia).

## Core Workflow

The primary entry point is the `lute()` function, which orchestrates marker selection and deconvolution in a single call.

### 1. Basic Deconvolution
To run a standard deconvolution using the default Non-negative Least Squares (NNLS) algorithm:

```r
library(lute)

# Required inputs:
# singleCellExperiment: Reference data with cell type labels
# bulkExpression: Matrix of bulk samples (genes x samples)
# cellTypeVariable: Column name in colData(sce) containing types

results <- lute(
  singleCellExperiment = sce_object,
  bulkExpression = bulk_matrix,
  cellTypeVariable = "cell_type",
  assayName = "counts"
)

# Access predictions
predictions <- results$deconvolution.results@predictionsTable
```

### 2. Incorporating Cell Size Scaling
To correct for cell size differences, provide a named vector of scale factors:

```r
# Example: Neurons are roughly 3.3x larger than Glia
scales <- c("neuron" = 10, "glial" = 3)

results_scaled <- lute(
  singleCellExperiment = sce_object,
  bulkExpression = bulk_matrix,
  cellScaleFactors = scales,
  cellTypeVariable = "k2"
)
```

### 3. Pseudobulk Simulation
Use `ypb_from_sce()` to generate simulated bulk data from single-cell data for benchmarking:

```r
pseudobulk <- ypb_from_sce(
  singleCellExperiment = sce_object,
  assayName = "counts",
  cellTypeVariable = "cell_type",
  cellScaleFactors = scales # Optional: simulate size bias
)
```

## Algorithm-Specific Parameters

`lute` uses "Param" classes to wrap different algorithms. This allows for fine-grained control while maintaining a consistent `deconvolution()` generic.

| Algorithm | Param Class | Package Requirement |
|-----------|-------------|---------------------|
| NNLS | `nnlsParam` | `nnls` |
| Bisque | `bisqueParam` | `BisqueRNA` |
| MuSiC | `musicParam` | `MuSiC` |
| EPIC | `epicParam` | `EPIC` |

**Example using a specific Param object:**
```r
param <- bisqueParam(
  bulkExpression = bulk_matrix,
  referenceExpression = reference_matrix,
  batchVariable = "batch"
)
deconvolution_output <- deconvolution(param)
```

## Marker Selection
`lute` can identify marker genes before deconvolution.
- Set `typemarkerAlgorithm = "findMarkers"` to use `scran`.
- Set `typemarkerAlgorithm = "meanratios"` to use the Mean Ratios method (requires `DeconvoBuddies`).
- Use `markersPerType` to control the number of signature genes.

## Tips for Success
- **Object Classes**: `lute` prefers `SingleCellExperiment` for references and `matrix` for bulk data.
- **Gene Matching**: Ensure row names (gene IDs) match between the bulk matrix and the single-cell reference.
- **Non-negativity**: Most algorithms in `lute` assume non-negative inputs (counts or log-normalized counts).
- **Supported Algorithms**: Run `luteSupportedDeconvolutionAlgorithms()` to see a list of available methods and their required R packages.

## Reference documentation

- [lute algorithm class definitions and uses](./references/lute_algorithm_classes.Rmd)
- [Pseudobulk cell size rescaling example](./references/lute_pseudobulk_example.Rmd)
- [The lute user's guide](./references/lute_users_guide.Rmd)