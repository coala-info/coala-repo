---
name: bioconductor-moanin
description: The moanin package provides a framework for analyzing time-course transcriptomics data using functional data analysis and splines. Use when user asks to model gene expression over time, perform differential expression testing between conditions with irregular sampling, or cluster genes based on their temporal profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/moanin.html
---

# bioconductor-moanin

## Overview
The `moanin` package provides a comprehensive framework for analyzing time-course transcriptomics data. It utilizes functional data analysis (splines) to model gene expression over time, allowing for robust differential expression testing between conditions even when time points are irregularly sampled or have low replication.

## Core Workflow

### 1. Initialization
Create a `Moanin` object, which extends `SummarizedExperiment`. This object stores the expression data, metadata, and the spline basis matrix.

```r
library(moanin)
# data: matrix of counts or log-counts
# meta: data.frame with 'Condition' and 'Time' columns
moanin_obj <- create_moanin_model(data=data, meta=meta,
                                  group_variable="Condition", 
                                  time_variable="Time",
                                  log_transform=TRUE)
```

### 2. Weekly Differential Expression
To compare conditions at specific time points, use `DE_timepoints`.

*   **Create Contrasts**: Use `create_timepoints_contrasts` to generate comparison strings.
    *   `type="per_timepoint_group_diff"`: Group differences at each time point (default).
    *   `type="per_group_timepoint_diff"`: Differences between consecutive time points within a group.
    *   `type="group_and_timepoint_diff"`: Difference-in-differences (change over time between groups).
*   **Run DE**:
```r
contrasts <- create_timepoints_contrasts(moanin_obj, "GroupA", "GroupB")
res_weekly <- DE_timepoints(moanin_obj, contrasts=contrasts, use_voom_weights=TRUE)
```

### 3. Spline-Based Time-Course DE
To test if the overall temporal profile differs between groups, fit splines to the data.

```r
# Define group comparisons
tc_contrasts <- c("GroupA-GroupB")
res_tc <- DE_timecourse(moanin_obj, contrasts=tc_contrasts, use_voom_weights=TRUE)

# Estimate log-fold change (e.g., sum of absolute differences)
lfc_tc <- estimate_log_fold_change(moanin_obj, contrasts=tc_contrasts, method="abs_sum")
```

### 4. Clustering and Visualization
Cluster genes based on their temporal profiles using K-means on the spline coefficients.

```r
# Cluster genes
km_clusters <- splines_kmeans(moanin_obj, n_clusters=3, random_seed=42)

# Assign scores and labels to genes
# Scores represent goodness-of-fit to the cluster centroid
scores_labels <- splines_kmeans_score_and_label(object=moanin_obj, 
                                                data=assay(moanin_obj), 
                                                kmeans_clusters=km_clusters)

# Visualize specific genes or cluster centroids
plot_splines_data(moanin_obj[gene_list, ], smooth=TRUE)
plot_splines_data(data=km_clusters$centroids, moanin_obj, smooth=TRUE)
```

## Key Parameters & Tips
*   **log_transform**: If input data are raw counts, set `log_transform=TRUE` in `create_moanin_model`. Internal calculations for splines use log-space, while `voom` weights use count-space.
*   **use_voom_weights**: Highly recommended for RNA-Seq count data to account for the mean-variance relationship.
*   **Spline Degrees of Freedom**: The default `df=4` is suitable for most medium-length time courses. Adjust based on the complexity of the expected temporal response.
*   **Missing Data**: `moanin` handles missing time points in specific groups by issuing warnings during contrast creation; ensure your contrasts are biologically valid for the available data.

## Reference documentation
- [moanin: An R Package for Time Course RNASeq Data Analysis](./references/documentation.md)