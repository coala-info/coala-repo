---
name: bioconductor-probatch
description: The proBatch package provides a comprehensive pipeline for diagnosing and correcting technical variation and batch effects in large-scale mass spectrometry proteomics data. Use when user asks to normalize proteomics data, correct continuous signal drift, perform batch effect diagnostics, or apply ComBat and LOESS normalization to mass spectrometry experiments.
homepage: https://bioconductor.org/packages/3.9/bioc/html/proBatch.html
---

# bioconductor-probatch

## Overview

The `proBatch` package provides a comprehensive pipeline for correcting technical variation in large-scale proteomics experiments. It is specifically designed to handle mass spectrometry-specific issues like continuous signal drift (using LOESS fitting) and discrete batch effects (using ComBat or median centering). The workflow follows a logical progression: data preparation, initial assessment, normalization, batch diagnostics, correction, and final quality control.

## Core Workflow

### 1. Data Preparation
`proBatch` requires three main components: a measurement table (long or wide), sample annotation, and feature (peptide) annotation.

```r
library(proBatch)

# Load example data
data("example_proteome", "example_sample_annotation", "example_peptide_annotation", package = "proBatch")

# 1. Define sample order from date/time
sample_annotation <- date_to_sample_order(
  example_sample_annotation,
  time_column = c("RunDate", "RunTime"),
  dateTimeFormat = c("%b_%d", "%H:%M:%S")
)

# 2. Convert long to matrix if needed
data_matrix <- long_to_matrix(
  example_proteome,
  feature_id_col = "peptide_group_label",
  measure_col = "Intensity",
  sample_id_col = "FullRunName"
)

# 3. Log transform
log_matrix <- log_transform_dm(data_matrix, log_base = 2, offset = 1)

# 4. Define consistent color scheme
color_list <- sample_annotation_to_colors(
  sample_annotation,
  factor_columns = c("MS_batch", "Strain", "Diet"),
  numeric_columns = c("order")
)
```

### 2. Initial Assessment & Normalization
Visualize the raw data to identify global trends or distribution shifts.

```r
# Plot global average vs run order
plot_sample_mean(log_matrix, sample_annotation, batch_col = "MS_batch")

# Normalization (Median Centering or Quantile)
quantile_normalized_matrix <- normalize_data_dm(
  log_matrix, 
  normalize_func = "quantile"
)
```

### 3. Batch Diagnostics
Identify the driving forces of variation in the normalized data.

```r
# Hierarchical Clustering
plot_hierarchical_clustering(
  quantile_normalized_matrix, 
  sample_annotation = sample_annotation,
  factors_to_plot = c("MS_batch", "Diet")
)

# PCA
plot_PCA(
  quantile_normalized_matrix, 
  sample_annotation, 
  color_by = "MS_batch"
)

# PVCA (Quantify variance components - computationally expensive)
plot_PVCA(
  quantile_normalized_matrix, 
  sample_annotation,
  technical_factors = c("MS_batch", "digestion_batch"),
  biological_factors = c("Strain", "Diet")
)
```

### 4. Batch Correction
Address both continuous drift (within-batch) and discrete shifts (between-batch).

```r
# Option A: Step-by-step
# 1. Correct continuous drift (LOESS)
quantile_long <- matrix_to_long(quantile_normalized_matrix)
loess_fit_df <- adjust_batch_trend_df(quantile_long, sample_annotation, span = 0.7)

# 2. Correct discrete shifts (ComBat)
final_df <- correct_with_ComBat_df(loess_fit_df, sample_annotation, batch_col = "MS_batch")

# Option B: Universal Function (Recommended)
batch_corrected_df <- correct_batch_effects_df(
  df_long = quantile_long,
  sample_annotation = sample_annotation,
  discrete_func = "ComBat",
  continuous_func = "loess_regression",
  abs_threshold = 5
)
```

### 5. Quality Control
Evaluate if biological signal is preserved and technical noise is reduced.

```r
# Compare sample correlation before/after
plot_sample_corr_distribution(
  batch_corrected_matrix, 
  sample_annotation, 
  batch_col = "MS_batch",
  plot_param = "batch_replicate"
)

# Check peptide correlation within proteins
plot_peptide_corr_distribution(
  batch_corrected_matrix, 
  example_peptide_annotation, 
  protein_col = "Gene"
)
```

## Key Functions Reference

| Function | Purpose |
| :--- | :--- |
| `date_to_sample_order` | Infers run order from timestamp strings. |
| `normalize_data_dm` | Performs "medianCentering" or "quantile" normalization. |
| `plot_sample_mean` | Visualizes signal drift over time/order. |
| `plot_PVCA` | Quantifies % variance explained by technical vs biological factors. |
| `adjust_batch_trend_df` | Fits LOESS curves to correct MS-specific signal drift. |
| `correct_with_ComBat_df` | Applies Empirical Bayes batch correction. |
| `correct_batch_effects_df` | One-stop function for both drift and batch correction. |

## Reference documentation
- [proBatch package overview](./references/proBatch.md)
- [proBatch R Markdown Source](./references/proBatch.Rmd)