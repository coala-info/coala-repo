---
name: bioconductor-scfeatures
description: scFeatures generates multi-view feature matrices from single-cell and spatial transcriptomics or proteomics data for downstream machine learning and association studies. Use when user asks to construct cell proportions, calculate pathway scores, analyze cell-cell interactions, or compute spatial autocorrelation features for disease outcome prediction.
homepage: https://bioconductor.org/packages/release/bioc/html/scFeatures.html
---


# bioconductor-scfeatures

name: bioconductor-scfeatures
description: Multi-view feature generation for single-cell and spatial transcriptomics/proteomics data. Use this skill to construct 17 different feature types (cell proportions, gene means, pathway scores, cell-cell interactions, spatial autocorrelation) from Seurat objects or matrices for disease outcome prediction, classification, and association studies.

## Overview

scFeatures is a Bioconductor package designed to transform raw single-cell or spatial data into high-dimensional feature matrices. It generates "multi-view" representations where samples (e.g., patients) are rows and various biological metrics are columns. These features are specifically formatted for downstream machine learning tasks like disease state classification (using ClassifyR) or survival analysis.

## Core Workflow

### 1. Data Preparation
scFeatures requires data to be formatted as a list containing the expression matrix, cell type labels, and sample IDs. You can use the internal helper `formatData` or pass a Seurat object directly to the wrapper.

```r
library(scFeatures)
data("example_scrnaseq")

# Using a Seurat object directly
scfeatures_result <- scFeatures(
  data = example_scrnaseq,
  type = "scrna",
  feature_types = c("proportion_raw", "gene_mean_celltype"),
  ncores = 1
)
```

### 2. Feature Generation
The package supports 17 feature types. You can run them all at once using the `scFeatures()` wrapper or individually for specific analyses.

**Common Feature Types:**
*   **Cell Proportions:** `run_proportion_raw`, `run_proportion_logit`, `run_proportion_ratio`.
*   **Gene Expression:** `run_gene_mean_celltype`, `run_gene_prop_celltype`, `run_gene_cor_celltype`.
*   **Pathway Analysis:** `run_pathway_gsva`, `run_pathway_mean`, `run_pathway_prop`.
*   **Cell-Cell Communication:** `run_CCI` (uses CellChat logic).
*   **Spatial Features:** `run_Morans_I`, `run_L_function`, `run_nn_correlation`, `run_celltype_interaction`.

### 3. Spatial Data Handling
For spatial datasets (`type = "spatial_t"` or `"spatial_p"`), you must provide spatial coordinates.

```r
# Example for spatial data
alldata <- list(
  data = matrix_data,
  sample = sample_vector,
  celltype = celltype_vector,
  spatialCoords = list(x_coords, y_coords)
)
spatial_features <- run_Morans_I(alldata, type = "spatial_p")
```

### 4. Downstream Analysis
The output is typically a list of dataframes (samples x features).

*   **Classification:** Use `ClassifyR::crossValidate(X, y)` where `X` is one of the feature dataframes.
*   **Association Study:** Generate an automated HTML report to visualize which features correlate with conditions.

```r
# Generate association report
run_association_study_report(scfeatures_result, output_folder = "./reports")
```

## Tips and Best Practices
*   **Feature Selection:** Generating all 17 feature types can be computationally expensive. Use the `feature_types` argument in the `scFeatures` wrapper to select only relevant views.
*   **Parallelization:** Most functions support the `ncores` argument. Increase this for large datasets to speed up GSVA and correlation calculations.
*   **Gene Filtering:** Use `remove_mito_ribo()` before feature generation to remove uninformative mitochondrial and ribosomal genes that might dominate the feature space.
*   **Species:** Ensure the `species` argument ("Homo sapiens" or "Mus musculus") is set correctly for pathway-based features, as it pulls from MSigDB.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)
- [scFeatures Overview](./references/scFeatures_overview.md)