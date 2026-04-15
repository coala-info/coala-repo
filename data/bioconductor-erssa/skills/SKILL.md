---
name: bioconductor-erssa
description: This tool performs empirical RNA-seq sample size analysis to determine if a dataset has sufficient biological replicates for differential expression discovery. Use when user asks to evaluate sample size sufficiency, estimate the marginal gain in differentially expressed gene discovery, or plan for additional sequencing replicates.
homepage: https://bioconductor.org/packages/release/bioc/html/ERSSA.html
---

# bioconductor-erssa

name: bioconductor-erssa
description: Perform Empirical RNA-seq Sample Size Analysis (ERSSA) to determine if an RNA-seq dataset has sufficient biological replicates. Use this skill to evaluate the marginal gain in differentially expressed gene (DEG) discovery as sample size increases, helping to justify current sample sizes or plan for additional sequencing.

# bioconductor-erssa

## Overview

ERSSA (Empirical RNA-seq Sample Size Analysis) provides a data-driven approach to sample size estimation. Unlike power analysis tools that rely on a priori assumptions, ERSSA uses an existing dataset to simulate smaller experiments through subsampling. By evaluating how many DEGs are discovered at each replicate level (n=2 to N), it identifies the point of diminishing returns where adding more samples provides minimal new biological insight.

## Installation

Install the package via BiocManager:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("ERSSA")
```

## Data Preparation

ERSSA requires two primary inputs:

1.  **Count Table**: A dataframe with gene names as row indices and sample IDs as column names.
2.  **Condition Table**: A dataframe with two columns:
    *   Column 1: Sample IDs (matching the count table columns).
    *   Column 2: Condition names (exactly two conditions supported).

## Main Workflow

The `erssa` function is a wrapper that executes the full pipeline: filtering, subsampling, differential expression (DE) analysis, and visualization.

```r
library(ERSSA)

# Set seed for reproducible subsampling
set.seed(1)

# Run the analysis
ssa_results = erssa(count_table, condition_table, DE_ctrl_cond = 'control_group_name')
```

### Key Parameters for `erssa()`

*   `DE_ctrl_cond`: String specifying which condition is the control.
*   `DE_software`: Choose `'edgeR'` (default, faster) or `'DESeq2'`.
*   `num_workers`: Integer for parallel processing via `BiocParallel`.
*   `comb_gen_repeat`: Number of subsamples per replicate level (default: 30).
*   `DE_cutoff_stat`: Adjusted p-value/FDR threshold (default: 0.05).
*   `DE_cutoff_Abs_logFC`: Absolute log2 fold-change threshold (default: 1).
*   `filter_cutoff`: CPM threshold for filtering low-expressed genes (default: 1).

## Interpreting Results

The output object contains four primary ggplot2 objects to evaluate sample size sufficiency:

1.  **Number of DEGs (`gg.dotPlot.obj`)**: Shows the distribution of DEGs found at each replicate level. If the curve flattens before reaching the total sample size (N), the current N is likely sufficient.
2.  **Marginal Discovery (`gg.marginPlot.obj`)**: Displays the percentage increase in DEGs for each additional replicate. A marginal gain < 1% suggests saturation.
3.  **Intersect DEGs (`gg.intersectPlot.obj`)**: Shows the number of genes consistently identified as DE across all subsamples at a given level. High overlap indicates high confidence and consistency.
4.  **TPR/FPR Plot (`gg.TPR_FPRPlot.obj`)**: Visualizes True Positive Rate and False Positive Rate using the full dataset (N) as the "ground truth."

## Advanced Usage and Customization

### Parallel Execution
For large datasets or many subsamples, use multiple cores:
```r
ssa = erssa(counts, conditions, DE_ctrl_cond='ctrl', num_workers=4)
```

### Accessing Raw Data and Plots
The result object is a list. You can extract and modify the underlying ggplot objects:
```r
# Extract the dot plot
p = ssa$gg.dotPlot.obj$gg_object
# Customize with ggplot2
library(ggplot2)
p + ylab("Total DEGs Identified") + theme_bw()
```

### Manual Step Execution
If the wrapper is too restrictive, call individual functions:
1.  `count_filter()`: Remove low-count genes.
2.  `comb_gen()`: Generate unique subsample combinations.
3.  `erssa_edger()` or `erssa_deseq2()`: Perform the iterative DE tests.

## Reference documentation

- [ERSSA Package Introduction](./references/ERSSA.md)
- [ERSSA Vignette (Rmd Source)](./references/ERSSA.Rmd)