---
name: bioconductor-distinct
description: Bioconductor-distinct performs differential state analysis in single-cell data by comparing full cumulative distribution functions between groups using hierarchical non-parametric permutation tests. Use when user asks to perform differential state analysis, compare expression distributions within cell clusters, or identify changes in distribution shape such as unimodal versus bimodal shifts.
homepage: https://bioconductor.org/packages/release/bioc/html/distinct.html
---


# bioconductor-distinct

name: bioconductor-distinct
description: Statistical method for differential state analysis in single-cell data (scRNA-seq, HDCyto) using hierarchical non-parametric permutation tests. Use when comparing full distributions (CDFs) between two groups to identify changes in mean or shape (e.g., unimodal vs. bimodal) within cell clusters.

# bioconductor-distinct

## Overview
`distinct` is a statistical framework for differential testing between two or more groups of distributions. Unlike methods that focus solely on mean abundance, `distinct` compares full cumulative distribution functions (CDFs) using hierarchical non-parametric permutation tests. This allows for the detection of subtle variations, such as shifts from unimodal to bimodal distributions, even if the mean remains constant. It is specifically designed for "differential state" analysis in single-cell RNA-seq or high-dimensional cytometry data, where testing is performed within specific cell clusters.

## Core Workflow

### 1. Data Preparation
The input should be a `SingleCellExperiment` object containing cell-type/cluster labels and sample identifiers in the `colData`.

```r
library(distinct)
library(SingleCellExperiment)

# Example: Kang_subset dataset
data("Kang_subset", package = "distinct")
```

### 2. Experimental Design
Create a design matrix where rows correspond to unique sample IDs.

```r
samples = Kang_subset@metadata$experiment_info$sample_id
group = Kang_subset@metadata$experiment_info$stim
design = model.matrix(~group)
rownames(design) = samples
```

### 3. Differential Testing
Use `distinct_test` to perform the permutation tests. It is highly recommended to use log-normalized data (e.g., `logcounts`).

```r
set.seed(61217)
res = distinct_test(x = Kang_subset, 
                    name_assays_expression = "logcounts",
                    name_cluster = "cell",
                    name_sample = "sample_id",
                    design = design,
                    column_to_test = 2, # Index of the condition in design matrix
                    min_non_zero_cells = 20,
                    n_cores = 2)
```

### 4. Calculating Fold Changes
To compute Fold Change (FC) and log2-FC, use normalized but **non-logarithmic** data (e.g., CPM).

```r
res = log2_FC(res = res,
              x = Kang_subset, 
              name_assays_expression = "cpm",
              name_group = "stim",
              name_cluster = "cell")
```

### 5. Extracting and Filtering Results
Use `top_results` to rank and filter significant hits.

```r
# View top global results
head(top_results(res))

# View results for a specific cluster, sorted by log2FC
top_results(res, cluster = "Dendritic cells", sort_by = "log2FC")

# Filter for down-regulated genes in a specific cluster
top_results(res, up_down = "down", cluster = "Dendritic cells")
```

## Visualization

### Distribution Plots
Visualize the differences in expression distributions between groups.

```r
# Density plot per sample
plot_densities(x = Kang_subset, gene = "ISG15", cluster = "Dendritic cells",
               name_assays_expression = "logcounts", name_cluster = "cell",
               name_sample = "sample_id", name_group = "stim")

# Aggregated group-level density
plot_densities(x = Kang_subset, gene = "ISG15", cluster = "Dendritic cells",
               name_group = "stim", group_level = TRUE, ...)

# CDF plot
plot_cdfs(x = Kang_subset, gene = "ISG15", cluster = "Dendritic cells",
          name_assays_expression = "logcounts", name_cluster = "cell",
          name_sample = "sample_id", name_group = "stim")
```

## Advanced Usage and Tips

*   **Covariates and Batch Effects**: Add batch factors to the `model.matrix`. `distinct` fits a linear model per cluster and performs testing on the residuals.
*   **Permutation Precision**: For finer p-value ranking of highly significant genes, increase the `P_4` parameter (e.g., `P_4 = 20000`).
*   **Normalization**: Always use normalized data. Log-normalized data is preferred for the test itself (especially with covariates), while CPM/non-log data is required for FC calculations.
*   **Sample Requirements**: The method requires at least 2 biological replicates per group.
*   **P-value Adjustment**: The output provides both `p_adj.loc` (adjusted within each cluster) and `p_adj.glb` (adjusted across all clusters and genes).

## Reference documentation
- [distinct: a method for differential analyses via hierarchical permutation tests](./references/distinct.Rmd)
- [distinct: a method for differential analyses via hierarchical permutation tests](./references/distinct.md)