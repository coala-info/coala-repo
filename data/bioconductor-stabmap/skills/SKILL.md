---
name: bioconductor-stabmap
description: StabMap performs mosaic single-cell data integration by projecting datasets with partially overlapping features into a common low-dimensional space. Use when user asks to integrate heterogeneous single-cell datasets, generate joint embeddings, transfer cell-type labels, or impute missing modalities.
homepage: https://bioconductor.org/packages/release/bioc/html/StabMap.html
---


# bioconductor-stabmap

## Overview

StabMap is an R package designed for "mosaic" single-cell data integration. It addresses the challenge where different datasets share only some (or even zero) features. By leveraging a mosaic data topology—a network where nodes are datasets and edges represent shared features—StabMap projects all cells into a common low-dimensional space. This allows for downstream tasks like joint clustering, UMAP visualization, cell-type label transfer, and imputation of missing modalities.

## Core Workflow

### 1. Data Preparation
Input data should be a named list of matrices (or sparse matrices) where rows are features and columns are cells.

```r
library(StabMap)

# Example: assay_list contains 'RNA' and 'Multiome' (RNA + ATAC)
# Check feature overlap
mosaicDataUpSet(assay_list)

# Inspect the topology (connectivity)
mdt <- mosaicDataTopology(assay_list)
plot(mdt)
```

### 2. Generating Joint Embeddings
The `stabMap()` function creates the integrated embedding. You must specify a `reference_list` (usually the dataset with the most features or the most informative ones).

```r
# Generate joint embedding
stab <- stabMap(assay_list,
                reference_list = "Multiome",
                ncomponentsReference = 50,
                ncomponentsSubset = 20)

# Result is a matrix: cells x components
dim(stab)
```

### 3. Downstream Analysis
Once the embedding is generated, use standard tools for visualization or classification.

```r
# Visualization with UMAP (requires scater/uwot)
library(scater)
stab_umap <- calculateUMAP(t(stab))
plot(stab_umap, col = factor(dataset_labels))

# Label Transfer (KNN-based)
# referenceLabels is a named vector of annotations for the reference cells
predictions <- classifyEmbedding(stab, referenceLabels)
```

### 4. Imputation
Predict missing feature values (e.g., imputing ATAC values for cells that only have RNA data).

```r
# Impute missing values from reference to query
imp <- imputeEmbedding(assay_list,
                       stab,
                       reference = colnames(assay_list[["Multiome"]]),
                       query = colnames(assay_list[["RNA"]]))
```

## Key Functions

- `mosaicDataUpSet()`: Visualizes the intersection of features across multiple datasets.
- `mosaicDataTopology()`: Builds an igraph object representing the connections between datasets based on shared features.
- `stabMap()`: The main integration function. It performs PCA on the reference and projects other datasets via the shortest path in the topology.
- `imputeEmbedding()`: Uses the joint embedding to predict expression/accessibility values for missing features.
- `classifyEmbedding()`: Transfers labels from a reference dataset to query cells using the integrated space.

## Tips for Success

- **Connectivity**: StabMap requires the mosaic data topology to be a connected graph. If two datasets share no features, they can still be integrated if there is an intermediate dataset (a "bridge") connecting them.
- **Feature Selection**: Perform feature selection (e.g., using `scran::modelGeneVar`) on individual datasets before integration to reduce noise and computational load.
- **Reference Selection**: Choose the dataset with the highest feature richness (like a Multiome dataset) as the reference to provide the most stable coordinate system.
- **Scaling**: Ensure data is normalized (e.g., log-transformed counts) before passing to `stabMap`.

## Reference documentation

- [StabMap: Stabilised mosaic single cell data integration using unshared features](./references/stabMap_PBMC_Multiome.md)
- [StabMap Rmd Vignette](./references/stabMap_PBMC_Multiome.Rmd)