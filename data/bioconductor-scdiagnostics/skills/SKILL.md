---
name: bioconductor-scdiagnostics
description: This tool provides diagnostic utilities for evaluating single-cell genomics data through anomaly detection and dataset alignment. Use when user asks to detect anomalies in cell type annotations, evaluate alignment between query and reference datasets, or quantify batch effects and annotation quality.
homepage: https://bioconductor.org/packages/release/bioc/html/scDiagnostics.html
---


# bioconductor-scdiagnostics

name: bioconductor-scdiagnostics
description: Diagnostic tools for single-cell genomics data, focusing on anomaly detection in cell type annotations, evaluation of dataset alignment (query vs. reference), and marker gene consistency. Use this skill when performing quality control on single-cell annotations, comparing new datasets to established references, or identifying technical artifacts and mislabeled cells in SingleCellExperiment objects.

# bioconductor-scdiagnostics

## Overview
The `scDiagnostics` package provides a suite of tools for the systematic evaluation of single-cell RNA-seq data, particularly focusing on the reliability of cell type annotations. It enables researchers to detect anomalies using isolation forests, assess the alignment between query and reference datasets through various statistical metrics (PCA/CCA subspaces, Wasserstein distances), and validate marker gene consistency.

## Core Workflows

### 1. Anomaly Detection
Identify cells that deviate from the expected profile of a specific cell type or the global dataset.

```r
library(scDiagnostics)
library(SingleCellExperiment)

# Detect anomalies in query data relative to a reference
anomaly_output <- detectAnomaly(
    reference_data = ref_sce, 
    query_data = query_sce, 
    ref_cell_type_col = "expert_annotation", 
    query_cell_type_col = "SingleR_annotation",
    pc_subset = 1:10,
    n_tree = 500,
    anomaly_threshold = 0.6
)

# Plot results for a specific cell type
plot(anomaly_output, cell_type = "CD4", data_type = "query")

# Identify top anomalous cell names
top_anomalies <- names(sort(anomaly_output$Combined$query_anomaly_scores, decreasing = TRUE)[1:10])
```

### 2. Dataset Alignment and Similarity
Evaluate how well a query dataset matches a reference dataset in reduced-dimensional space.

*   **Subspace Comparison**: Use `comparePCASubspace` to calculate weighted cosine similarity between PC loadings.
*   **Distance Distributions**: Use `plotPairwiseDistancesDensity` to compare Query-Query, Ref-Ref, and Query-Ref distance distributions.
*   **Wasserstein Distance**: Quantify the "drift" between datasets using optimal transport metrics.

```r
# Compare PCA subspaces
subspace_res <- comparePCASubspace(
    query_data = query_sce,
    reference_data = ref_sce,
    pc_subset = 1:5
)
print(subspace_res$weighted_cosine_similarity)

# Statistical testing for distribution differences
cramer_p <- calculateCramerPValue(
    reference_data = ref_sce,
    query_data = query_sce,
    ref_cell_type_col = "label",
    query_cell_type_col = "label",
    pc_subset = 1:5
)
```

### 3. Regression Analysis (Batch & Annotation Quality)
Quantify the variance explained by cell types or batch effects using `regressPC`.

```r
# Assess if cell types are the primary driver of PC variance
regress_res <- regressPC(
    query_data = query_sce,
    query_cell_type_col = "annotation",
    pc_subset = 1:10
)
plot(regress_res, plot_type = "variance_contribution")

# Check for batch-annotation interactions
regress_batch <- regressPC(
    query_data = query_sce,
    query_cell_type_col = "annotation",
    query_batch_col = "sample_id",
    pc_subset = 1:10
)
plot(regress_batch, plot_type = "coefficient_heatmap")
```

### 4. Marker Gene and HVG Consistency
Verify if the same genes drive variation across datasets.

```r
# Calculate overlap of Highly Variable Genes (HVGs)
ref_hvg <- scran::getTopHVGs(ref_sce, n = 500)
query_hvg <- scran::getTopHVGs(query_sce, n = 500)
hvg_overlap <- calculateHVGOverlap(ref_hvg, query_hvg)

# Compare gene importance using Random Forest
rf_overlap <- calculateVarImpOverlap(
    reference_data = ref_sce,
    query_data = query_sce,
    n_top = 50
)
```

## Key Functions Reference
*   `detectAnomaly()`: Main entry point for isolation forest-based outlier detection.
*   `calculateCellDistances()`: Computes Euclidean distances between query and reference cells in PC space.
*   `calculateCellDistancesSimilarity()`: Provides Bhattacharyya coefficients and Hellinger distances for distribution overlap.
*   `calculateCellSimilarityPCA()`: Measures cosine similarity between specific cells and PC loadings to see which components an anomaly influences.
*   `calculateHotellingPValue()`: Multivariate test for differences in means between datasets.

## Reference documentation
- [Detection and Analysis of Annotation Anomalies](./references/AnnotationAnomalies.md)
- [Evaluation of Dataset and Marker Gene Alignment](./references/DatasetMarkerGeneAlignment.md)
- [Visualization Tools for Diagnostics](./references/VisualizationTools.md)
- [scDiagnostics Package Overview](./references/scDiagnostics.md)