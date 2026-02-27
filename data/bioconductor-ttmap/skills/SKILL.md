---
name: bioconductor-ttmap
description: TTMap is a topological data analysis tool that clusters gene expression data based on the shape of deviation from a control group. Use when user asks to perform topological data analysis on transcriptomic data, calculate hyperrectangle deviation assessment, or cluster samples using a two-tier Mapper algorithm.
homepage: https://bioconductor.org/packages/release/bioc/html/TTMap.html
---


# bioconductor-ttmap

## Overview

TTMap (Two-Tier Mapper) is a topological data analysis (TDA) tool designed for gene expression analysis. It shifts the focus from raw expression values to the "shape" of deviation from a control group. The workflow consists of two main phases:
1.  **Data Adjustment and Deviation Assessment (HDA):** Correcting the control group for outliers and calculating how test samples deviate from this "normal" hyperrectangle.
2.  **Global-to-Local Mapper (GtLMap):** Using a two-tier cover and mismatch distance to cluster samples into a network that reveals global patterns and local variations (quartiles of deviation).

## Typical Workflow

### 1. Data Preparation
The package requires two matrices: a control group and a test group. Use `make_matrices` to format your data (e.g., from a SummarizedExperiment or normalized count table).

```r
library(TTMap)
# Assuming 'airway' is a SummarizedExperiment object
# col_ctrl and col_test are indices of the columns
experiment <- make_matrices(airway, col_ctrl = 1:4, col_test = 5:8, 
                            NAME = rownames(airway), CLID = rownames(airway))
```

### 2. Control Group Adjustment
This step identifies and replaces outliers in the control group to create a robust baseline.

```r
# e: outlier threshold (default is data-driven)
# P: percentage of outliers allowed per gene before removal
# B: batch effect vector (optional)
adjusted_ctrl <- control_adjustment(normal.pcl = experiment$CTRL, 
                                    tumor.pcl = experiment$TEST, 
                                    normalname = "Control", 
                                    dataname = "TestProject", 
                                    e = 1, P = 1.1)
```

### 3. Hyperrectangle Deviation Assessment (HDA)
Calculates the deviation components ($D_c$) for each test sample relative to the adjusted control group.

```r
hda_results <- hyperrectangle_deviation_assessment(x = adjusted_ctrl, 
                                                   k = dim(adjusted_ctrl$Normal.mat)[2],
                                                   dataname = "TestProject", 
                                                   normalname = "Control")
# hda_results$Dc.Dmat contains the deviation matrix
```

### 4. Mismatch Distance and Clustering (TTMap)
Generate a similarity measure based on the shape of deviation and run the Mapper algorithm.

```r
# alpha: cutoff to decide what deviation is considered noise
dist_matrix <- generate_mismatch_distance(hda_results, alpha = 1)

# Calculate 'e' (closeness parameter) automatically
e_param <- calcul_e(dist_matrix, 0.95, adjusted_ctrl, 1)

# Run the main TTMap clustering
# annot: a dataframe where rownames match sample names + ".Dis"
ttmap_output <- ttmap(hda_results, hda_results$m, 
                      select = rownames(hda_results$Dc.Dmat),
                      annot = my_annotation_df, 
                      e = e_param, 
                      dd = dist_matrix,
                      filename = "my_analysis")
```

### 5. Identifying Significant Genes
Extract the features that characterize specific clusters at different tiers (Overall, Low, Mid, High deviation).

```r
ttmap_sgn_genes(ttmap_output, hda_results, adjusted_ctrl, 
                annot = my_annotation_df, n = 2, a = 1, 
                filename = "significant_features")
```

## Key Functions and Parameters

-   `control_adjustment`: Essential for cleaning the control group. It generates PDF plots of mean vs. variance to visualize the correction.
-   `generate_mismatch_distance`: The core similarity metric. It compares samples based on whether they deviate in the same direction (positive, negative, or neutral) for each gene.
-   `ttmap`: The main engine. It produces an interactive 3D RGL plot (if using `rgl`) showing the network of clusters.
-   `alpha`: A critical parameter in distance calculation; higher values increase the threshold for what is considered a "significant" deviation from the control.

## Reference documentation
- [TTMap](./references/TTMap.md)