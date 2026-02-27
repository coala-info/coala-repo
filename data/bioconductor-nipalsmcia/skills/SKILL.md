---
name: bioconductor-nipalsmcia
description: This tool performs Multiple Co-Inertia Analysis (MCIA) for joint dimensionality reduction and integration of multi-block datasets. Use when user asks to integrate multi-omics datasets, calculate global scores and loadings, visualize sample clusters, identify top contributing features, or predict scores for new samples.
homepage: https://bioconductor.org/packages/release/bioc/html/nipalsMCIA.html
---


# bioconductor-nipalsmcia

name: bioconductor-nipalsmcia
description: Performs Multiple Co-Inertia Analysis (MCIA) using the NIPALS algorithm for joint dimensionality reduction of multi-block (multi-view) data. Use this skill to integrate multi-omics datasets (e.g., mRNA, miRNA, protein), calculate global scores and loadings, visualize sample clusters, identify top contributing features, and predict scores for new samples.

# bioconductor-nipalsmcia

## Overview

The `nipalsMCIA` package provides an efficient R implementation of Multiple Co-Inertia Analysis (MCIA) using the Non-linear Iterative Partial Least Squares (NIPALS) algorithm. It is designed for joint dimensionality reduction of datasets containing multiple data blocks (views) measured on the same samples. Key features include faster computation than SVD-based methods for large datasets, out-of-sample global embedding (prediction), and comprehensive visualization tools for interpreting multi-omics relationships.

## Core Workflow

### 1. Data Preparation
The package primarily uses the `MultiAssayExperiment` (MAE) format. You can convert a list of data frames (where rows are samples and columns are features) into an MAE using the provided helper.

```r
library(nipalsMCIA)
library(MultiAssayExperiment)

# data_list: list of matrices/dataframes (samples as rows)
# metadata: dataframe with sample-level information
mae_data <- simple_mae(data_list, row_format = "sample", colData = metadata)
```

### 2. Running MCIA
Use `nipals_multiblock` to perform the decomposition.

```r
set.seed(42)
mcia_results <- nipals_multiblock(
  data_blocks = mae_data,
  num_PCs = 10,                # Number of factors to extract
  col_preproc_method = "colprofile", # Pre-processing (e.g., "colprofile", "unit_var")
  block_preproc_method = "unit_var", # Block-level scaling
  tol = 1e-12,
  plots = "none"               # Set to "all" for automatic scree and factor plots
)
```

### 3. Interpreting Results
The `NipalsResult` object contains several key slots:
- `global_scores`: Low-dimensional coordinates for samples ($n \times r$).
- `global_loadings`: Contribution of features to factors ($p \times r$).
- `block_score_weights`: Contribution of each omic block to each factor.

## Visualization and Analysis

### Sample Projections
Visualize how samples cluster in the global space, optionally colored by metadata.

```r
# Get colors based on metadata
meta_colors <- get_metadata_colors(mcia_results, color_col = "cancerType")

projection_plot(
  mcia_results, 
  projection = "global", 
  orders = c(1, 2), 
  color_col = "cancerType", 
  color_pal = meta_colors
)

# Heatmap of global scores across all factors
global_scores_heatmap(mcia_results, color_col = "cancerType", color_pal = meta_colors)
```

### Feature Loadings
Identify which features or omics blocks drive the variance in specific factors.

```r
# Plot block contributions (pseudoeigenvalues)
block_weights_heatmap(mcia_results)

# Plot feature loadings for two factors
vis_load_plot(mcia_results, axes = c(1, 2))

# Get ranked list of top features for a specific factor/omic
top_features <- ord_loadings(mcia_results, omic = "mrna", factor = 1, descending = TRUE)
vis_load_ord(mcia_results, omic = "all", factor = 1, n_feat = 30)
```

### Predicting Scores for New Samples
Project new test data into the existing MCIA space defined by a training set.

```r
# test_mae must have the same features as the training data
new_scores <- predict_gs(mcia_results = mcia_train_results, test_data = test_mae)
```

## Tips for Success
- **Pre-processing**: `col_preproc_method = "colprofile"` is often preferred for count-based omics to handle different scales.
- **Block Scaling**: Use `block_preproc_method = "largest_sv"` if you want to balance the influence of blocks with vastly different numbers of features.
- **Single-Cell Data**: For single-cell applications (e.g., CITE-seq), it is recommended to subset to highly variable features before running MCIA to reduce noise and computation time.
- **GSEA**: You can extract loadings for gene-centric blocks using `nmb_get_gl(mcia_results)` and pass them to `fgsea` or the internal `gsea_report` function for pathway analysis.

## Reference documentation
- [Analysis of MCIA Decomposition](./references/Analysis-of-MCIA-Decomposition.md)
- [Predicting New Scores](./references/Predicting-New-Scores.md)
- [Single Cell Analysis](./references/Single-Cell-Analysis.md)