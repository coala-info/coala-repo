---
name: bioconductor-schot
description: scHOT identifies changes in higher order structures such as variability or correlation along developmental trajectories or spatial coordinates in single-cell data. Use when user asks to perform differential variability analysis, identify differential correlation between gene pairs, or test for changes in gene relationships across pseudotime or spatial locations.
homepage: https://bioconductor.org/packages/release/bioc/html/scHOT.html
---


# bioconductor-schot

name: bioconductor-schot
description: Single cell Higher Order Testing (scHOT) for identifying changes in higher order structure (e.g., variability or correlation) along developmental trajectories or across spatial coordinates. Use this skill to perform differential variability or differential correlation analysis on SingleCellExperiment objects.

## Overview

scHOT (Single cell Higher Order Testing) is designed to test for changes in "higher order" features—such as variance or correlation—across a continuous variable like pseudotime or spatial location. Unlike standard differential expression which looks at mean changes, scHOT identifies where the relationship between genes or the noise level of a single gene changes dynamically.

## Core Workflow

### 1. Object Initialization
scHOT objects are built from either a matrix or a `SingleCellExperiment` (SCE) object. You must specify the `positionType` ("trajectory" or "spatial") and the metadata column containing the coordinates.

```r
library(scHOT)

# From Matrix
scHOT_obj <- scHOT_buildFromMatrix(
  mat = expression_matrix,
  cellData = list(pseudotime = pseudotime_vector),
  positionType = "trajectory",
  positionColData = "pseudotime"
)

# From SingleCellExperiment
scHOT_obj <- scHOT_buildFromSCE(
  sce_object,
  assayName = "logcounts",
  positionType = "spatial",
  positionColData = c("x", "y")
)
```

### 2. Defining the Testing Scaffold
The scaffold defines which genes or gene pairs to test.
- **Variability:** A one-column matrix of gene names.
- **Correlation:** A two-column matrix where each row is a gene pair.

```r
# For variability
scaffold <- as.matrix(c("GeneA", "GeneB"))
# For correlation
scaffold <- matrix(c("GeneA", "GeneB", "GeneC", "GeneD"), ncol = 2, byrow = TRUE)

scHOT_obj <- scHOT_addTestingScaffold(scHOT_obj, scaffold)
```

### 3. Setting Parameters
You must define the weighting scheme (how local the "higher order" calculation is) and the function to be tested.

- **Weighting:** Controlled by `span` (default 0.25). A smaller span is more local.
- **Functions:** Common choices include `matrixStats::weightedVar` for variability or `scHOT::weightedSpearman` for correlation.

```r
scHOT_obj <- scHOT_setWeightMatrix(scHOT_obj, span = 0.05)
```

### 4. Execution (Wrapper vs. Step-by-Step)
The `scHOT` function acts as a wrapper for the entire pipeline.

```r
scHOT_res <- scHOT(
  scHOT_obj,
  testingScaffold = scaffold,
  higherOrderFunction = weightedSpearman,
  higherOrderFunctionType = "weighted",
  numberPermutations = 100,
  span = 0.05
)
```

### 5. P-value Estimation
For large datasets, use `scHOT_estimatePvalues` to borrow permutations from genes with similar global statistics to save time.

```r
scHOT_obj <- scHOT_estimatePvalues(scHOT_obj, nperm_estimate = 10000, maxDist = 5)
```

## Visualization

scHOT provides specific plotting functions to interpret the results:

- `plotHigherOrderSequence()`: Plots the local higher order statistic (e.g., local correlation) along the trajectory or space.
- `plotOrderedExpression()`: Plots the underlying gene expression levels across the same positions.

```r
# Visualize local correlation for a pair
plotHigherOrderSequence(scHOT_res, "GeneA_GeneB")

# Visualize expression along trajectory
plotOrderedExpression(scHOT_res, "GeneA")
```

## Tips for Success
- **Thinning:** For large datasets (>1000 cells), use `nrow.out` in `scHOT_setWeightMatrix` to reduce the number of local windows calculated, significantly speeding up the run.
- **Global Function:** Always calculate the global higher order function first; it serves as the baseline for the null distribution.
- **Parallelization:** Set `parallel = TRUE` in the `scHOT` wrapper or `scHOT_performPermutationTest` to utilize multiple cores.

## Reference documentation
- [scHOT](./references/scHOT.md)