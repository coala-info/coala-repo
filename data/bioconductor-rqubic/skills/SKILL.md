---
name: bioconductor-rqubic
description: This tool performs qualitative biclustering on gene expression data by discretizing microarray or NGS datasets into ranks. Use when user asks to discretize expression data, identify co-expressed gene sets, or find biclusters using the QUBIC algorithm.
homepage: https://bioconductor.org/packages/release/bioc/html/rqubic.html
---

# bioconductor-rqubic

name: bioconductor-rqubic
description: Qualitative Biclustering (QUBIC) for gene expression data. Use this skill to discretize microarray or NGS data and identify co-expressed gene sets (biclusters) using a heuristic, qualitative approach that is robust to outliers.

## Overview

The `rqubic` package implements the Qualitative Biclustering (QUBIC) algorithm. Unlike quantitative methods that rely on exact expression values, QUBIC uses a qualitative approach by discretizing data into levels (e.g., up-regulated, down-regulated, or unchanged). This makes it particularly effective for identifying patterns in noisy data or combining different data types (Microarray, RNA-Seq).

## Typical Workflow

The standard pipeline involves three main steps: discretization, seed generation, and bicluster identification.

### 1. Data Preparation and Discretization
Input data should be an `ExpressionSet` or a numeric matrix. The `quantileDiscretize` function converts continuous expression values into discrete ranks.

```r
library(rqubic)
library(Biobase)
library(biclust)

# Load data (example using BicatYeast)
data(BicatYeast)
eset <- new("ExpressionSet", exprs = BicatYeast)

# Discretize data (default rank = 1: -1, 0, 1)
# Higher ranks allow for more levels (e.g., rank 2 gives -2, -1, 0, 1, 2)
eset_disc <- quantileDiscretize(eset, rank = 1)
```

### 2. Seed Generation
Seeds are pairs of genes that share expression patterns across a subset of samples. This step identifies starting points for the heuristic search.

```r
# Generate seeds from discretized data
# Note: This can be computationally intensive for large datasets (>10k genes)
seeds <- generateSeeds(eset_disc)
```

### 3. Biclustering
The `quBicluster` function expands seeds into maximal biclusters.

```r
# Identify biclusters
bicluster_set <- quBicluster(seeds, eset_disc)

# View summary
print(bicluster_set)
```

## Inspecting Results

The output is a `QUBICBiclusterSet` object. You can extract specific information using the following accessors:

*   **Summary**: `print(bicluster_set)` shows parameters and sizes of the top clusters.
*   **Features (Genes)**: `features(bicluster_set)` or `BCfeatures(bicluster_set, index)` for a specific cluster.
*   **Conditions (Samples)**: `conditions(bicluster_set)` or `BCconditions(bicluster_set, index)`.
*   **Counts**: `featureCount(bicluster_set)` and `conditionCount(bicluster_set)`.

## Visualization
Since `rqubic` integrates with the `biclust` package, you can use standard bicluster visualization tools like parallel coordinates plots.

```r
# Plot the 1st bicluster
drawHeatmap(eset, bicluster_set, number = 1)
parallelCoordinates(eset, bicluster_set, number = 1)
```

## Tips and Best Practices
*   **Rank Selection**: Use `rank = 1` for a simple up/down/neutral classification. Increase the rank if you need to distinguish between "weak" and "strong" regulation.
*   **Performance**: For very large datasets, consider filtering genes with low variance before discretization to speed up `generateSeeds`.
*   **External Results**: If you have results from the standalone C implementation of QUBIC, use `parseQubicRules` to import them into R for analysis.

## Reference documentation
- [Qualitative Biclustering with rqubic](./references/rqubic.md)