---
name: bioconductor-m3drop
description: bioconductor-m3drop performs feature selection for single-cell RNA-seq data by modeling the relationship between mean expression and dropout frequency. Use when user asks to identify informative genes, perform dropout-based modeling, or select features using Michaelis-Menten or Depth-Adjusted Negative Binomial models.
homepage: https://bioconductor.org/packages/release/bioc/html/M3Drop.html
---


# bioconductor-m3drop

name: bioconductor-m3drop
description: Feature selection for single-cell RNA-seq data using dropout-based modeling. Use when Claude needs to identify differentially expressed or informative genes by analyzing the relationship between mean expression and dropout frequency. Supports Michaelis-Menten modeling for full-transcript data (e.g., Smart-seq2) and Depth-Adjusted Negative Binomial (DANB) modeling for UMI-tagged data (e.g., 10X Chromium).

# bioconductor-m3drop

## Overview

M3Drop is an R package for feature selection in single-cell RNA sequencing (scRNA-seq) data. It identifies genes whose expression is dominated by biological variation rather than technical noise by modeling "dropouts" (zeros). The package provides two primary frameworks:
1.  **M3Drop**: Uses the Michaelis-Menten equation, ideal for full-transcript protocols without UMIs.
2.  **NBumi**: Uses a depth-adjusted negative binomial (DANB) model, designed for UMI-tagged data where dropouts often result from limited sequencing depth.

## Core Workflows

### 1. M3Drop for Non-UMI Data (Smart-seq2)

Use this workflow for datasets where dropouts are primarily driven by reverse transcription efficiency.

```r
library(M3Drop)

# 1. Prepare data (converts counts to normalized matrix, removes undetected genes)
# Set is.counts=TRUE for raw counts; is.log=TRUE if data is already log-transformed
norm <- M3DropConvertData(count_matrix, is.counts = TRUE)

# 2. Feature Selection
# Returns a data frame of genes ranked by p-value/FDR
selected_genes <- M3DropFeatureSelection(norm, mt_method = "fdr", mt_threshold = 0.01)
```

### 2. NBumi for UMI Data (10X Chromium)

Use this workflow for UMI data to account for sequencing depth effects on dropout rates.

```r
# 1. Prepare data (raw counts are highly preferred)
count_mat <- NBumiConvertData(raw_counts, is.counts = TRUE)

# 2. Fit the DANB model
danb_fit <- NBumiFitModel(count_mat)

# 3. Feature Selection
# Performs a binomial test to identify significant features
nbumi_features <- NBumiFeatureSelectionCombinedDrop(danb_fit, method = "fdr", qval.thres = 0.01)
```

### 3. Pearson Residual Normalization

For UMI data, calculate Pearson residuals as an alternative normalization method using the DANB model.

```r
# Exact residuals using the full DANB model
pearson_res <- NBumiPearsonResiduals(count_mat, danb_fit)

# Optional: Clip residuals to the square root of the number of cells
max_val <- sqrt(ncol(count_mat))
pearson_res[pearson_res > max_val] <- max_val
pearson_res[pearson_res < -max_val] <- -max_val
```

### 4. Downstream Analysis and Visualization

M3Drop includes utilities for visualizing selected features and identifying markers for cell subpopulations.

```r
# Create a heatmap of selected features
heat_out <- M3DropExpressionHeatmap(selected_genes$Gene, norm, cell_labels = labels)

# Extract clusters from the heatmap dendrogram
cell_clusters <- M3DropGetHeatmapClusters(heat_out, k = 4, type = "cell")

# Identify marker genes for the clusters using ROC analysis
marker_genes <- M3DropGetMarkers(norm, cell_clusters)
```

## Implementation Tips

*   **Data Input**: `M3DropConvertData` and `NBumiConvertData` can extract matrices directly from `Seurat`, `scater` (SingleCellExperiment), or `monocle` objects.
*   **Normalization**: M3Drop requires a normalized but **not** log-transformed matrix. If your input is log-transformed, use `is.log = TRUE` in `M3DropConvertData` to de-log the data.
*   **Model Selection**: If the dataset has UMIs, always prefer the `NBumi` functions. The Michaelis-Menten model in `M3DropFeatureSelection` assumes saturation that UMI datasets rarely reach.
*   **Marker Ranking**: `M3DropGetMarkers` ranks genes by Area Under the ROC Curve (AUC). An AUC of 1.0 indicates a perfect marker for a specific cluster.

## Reference documentation

- [Dropout-based Feature Selection with M3Drop and NBumi](./references/M3Drop_Vignette.md)