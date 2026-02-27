---
name: bioconductor-multiclust
description: This tool performs feature selection, sample clustering, and clinical survival analysis on transcriptomic data. Use when user asks to identify gene expression patterns, select informative probes using various ranking methods, perform K-means or Hierarchical clustering, and correlate clusters with clinical outcomes.
homepage: https://bioconductor.org/packages/release/bioc/html/multiClust.html
---


# bioconductor-multiclust

name: bioconductor-multiclust
description: Expert guidance for the multiClust R package to perform feature selection, clustering, and clinical survival analysis on transcriptomic data. Use this skill when a user needs to identify gene expression patterns, select informative probes (Fixed, Percent, Poly, or GMM methods), perform K-means or Hierarchical clustering, and correlate clusters with clinical outcomes (Kaplan-Meier plots).

# bioconductor-multiclust

## Overview
The `multiClust` package is a comprehensive tool for analyzing gene expression datasets. It streamlines the workflow of feature selection (ranking genes), sample clustering, and clinical validation. It is particularly useful for researchers who want to experiment with different combinations of gene selection algorithms (like Coefficient of Variation or Standard Deviation ranking) and clustering methods (K-means or Hierarchical) to find clinically relevant subgroups in transcriptomic data.

## Typical Workflow

The package follows a strict seven-step functional sequence:

1.  **Data Input**: Load expression matrices.
2.  **Probe Number Selection**: Determine how many genes to keep.
3.  **Probe Ranking**: Rank and filter genes based on variability.
4.  **Cluster Number Determination**: Decide how many sample groups to create.
5.  **Cluster Analysis**: Assign samples to groups.
6.  **Average Expression**: Calculate cluster-specific expression profiles.
7.  **Survival Analysis**: Validate clusters against clinical outcomes.

## Core Functions and Usage

### 1. Data Preparation
Load a tab-delimited expression matrix where rows are probes/genes and columns are samples.
```r
library(multiClust)
exp_file <- "path/to/expression_data.txt"
data.exprs <- input_file(input = exp_file)
```

### 2. Feature Selection
First, determine the number of probes to select, then rank them.

**Step A: Number of Probes**
*   `Fixed`: Specific integer (e.g., 300).
*   `Percent`: Percentage of total probes (e.g., 10).
*   `Poly`: Based on polynomial fitting of mean/SD.
*   `Adaptive`: Uses Gaussian Mixture Modeling (GMM).

```r
gene_num <- number_probes(input = exp_file, data.exp = data.exprs, Fixed = 300, Percent = NULL, Poly = NULL, Adaptive = NULL)
```

**Step B: Ranking Probes**
Methods: `CV_Rank`, `CV_Guided`, `SD_Rank`, or `Poly`.
```r
ranked.exprs <- probe_ranking(input = exp_file, probe_number = gene_num, probe_num_selection = "Fixed_Probe_Num", data.exp = data.exprs, method = "SD_Rank")
```

### 3. Clustering Samples
Determine the number of clusters (`Fixed` or `gap_statistic`) and perform the analysis.

```r
# Determine cluster count
cluster_num <- number_clusters(data.exp = data.exprs, Fixed = 3, gap_statistic = NULL)

# Perform clustering (HClust or Kmeans)
hclust_analysis <- cluster_analysis(sel.exp = ranked.exprs, cluster_type = "HClust", distance = "euclidean", linkage_type = "ward.D2", gene_distance = "correlation", num_clusters = cluster_num, data_name = "MyProject", probe_rank = "SD_Rank", probe_num_selection = "Fixed_Probe_Num", cluster_num_selection = "Fixed_Clust_Num")
```

### 4. Clinical Validation
Correlate clusters with survival data. The clinical file must have two columns: Time (months) and Event (0 for censored, 1 for event).

```r
surv_results <- surv_analysis(samp_cluster = hclust_analysis, clinical = "clinical_data.txt", survival_type = "RFS", data_name = "MyProject", cluster_type = "HClust", distance = "euclidean", linkage_type = "ward.D2", probe_rank = "SD_Rank", probe_num_selection = "Fixed_Probe_Num", cluster_num_selection = "Fixed_Clust_Num")

# Access the P-value
print(surv_results$pvalue)
```

## Tips for Success
*   **Normalization**: Ensure data is normalized (e.g., RMA or Quantile) and Log2 scaled before using `input_file`.
*   **Computational Time**: The `Adaptive` probe selection and `gap_statistic` cluster determination methods are computationally intensive and may take significant time on large datasets.
*   **Output Files**: Many functions (like `cluster_analysis` and `surv_analysis`) automatically generate PDF plots and CSV files in the working directory.
*   **Visualization**: For Hierarchical clustering, the package generates `.atr`, `.gtr`, and `.cdt` files specifically formatted for Java TreeView.

## Reference documentation
- [A Guide to multiClust](./references/multiClust.md)