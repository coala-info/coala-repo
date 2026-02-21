---
name: bioconductor-icobra
description: The package also contains a shiny application for interactive exploration of results.
homepage: https://bioconductor.org/packages/release/bioc/html/iCOBRA.html
---

# bioconductor-icobra

## Overview
iCOBRA (Comparison and Benchmarking of Ranking and Assignment methods) is an R package designed to evaluate and visualize the performance of methods that provide feature rankings or binary assignments. It is primarily used in bioinformatics to benchmark differential expression (DE) tools by comparing their results (p-values, adjusted p-values, or scores) against a known ground truth.

## Core Workflow

### 1. Data Preparation
The central object is a `COBRAData` container. It organizes results from multiple methods and the ground truth.

```r
library(iCOBRA)

# Create a COBRAData object from data frames
# Each data frame should have feature IDs as row names
cd <- COBRAData(pval = pval_df, 
                padj = padj_df, 
                score = score_df, 
                truth = truth_df)

# Calculate adjusted p-values if only nominal p-values are provided
cd <- calculate_adjp(cd)
```

### 2. Calculating Performance
Compute metrics such as TPR, FPR, FDR, and ROC curves. You must specify which columns in the `truth` slot represent the binary status (e.g., "DE" vs "non-DE") and the continuous truth (e.g., log-fold change).

```r
# binary_truth: column name for 0/1 status
# cont_truth: column name for true continuous values (e.g. logFC)
perf <- calculate_performance(cd, 
                              binary_truth = "status", 
                              cont_truth = "logFC")
```

### 3. Preparing for Visualization
Before plotting, use `prepare_data_for_plot` to define colors and handle stratification.

```r
# facetted: TRUE if you want to split plots by a stratification variable
plot_data <- prepare_data_for_plot(perf, 
                                   colorscheme = "Dark2", 
                                   facetted = TRUE)
```

### 4. Plotting Results
iCOBRA provides several specialized plotting functions that return `ggplot2` objects.

*   **TPR/FPR**: `plot_tpr(plot_data)`
*   **FDR-TPR Curves**: `plot_fdrtprcurve(plot_data)`
*   **ROC Curves**: `plot_roc(plot_data)`
*   **Overlap (Venn)**: `plot_overlap(plot_data)`
*   **Correlation**: `plot_corr(plot_data)`

## Advanced Features

### Stratification
To evaluate performance across different feature properties (e.g., expression level or GC content), use the `splv` (split variable) argument in `calculate_performance`.

```r
perf_strat <- calculate_performance(cd, 
                                    binary_truth = "status", 
                                    splv = "expr_cat")
```

### Interactive Exploration
Launch a Shiny application to explore the results interactively.

```r
# Launch with an existing object
COBRAapp(cd)

# Or launch empty to upload text files
COBRAapp()
```

### Data Export/Import
Convert `COBRAData` objects to and from text files for use in the Shiny app or external tools.

```r
# Export
COBRAData_to_text(cd, truth_file = "truth.txt", result_files = "results.txt")

# Import
cd_new <- COBRAData_from_text(truth_file = "truth.txt", result_files = "results.txt")
```

## Tips for Success
*   **Row Names**: Ensure that row names (feature IDs) are consistent across all input data frames (pval, padj, score, and truth).
*   **Missing Values**: iCOBRA handles missing values by assigning them the worst possible rank/score; check the `calculate_performance` documentation if specific NA handling is required.
*   **Customizing Plots**: Since most plots are `ggplot` objects, you can modify them by adding layers like `+ theme_bw()` or `+ facet_wrap(~splitval)`.

## Reference documentation
- [iCOBRA](./references/iCOBRA.md)