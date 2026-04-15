---
name: bioconductor-tmixclust
description: TMixClust performs soft-clustering of longitudinal gene expression data using a Gaussian mixed-effects model with nonparametric smoothing splines. Use when user asks to cluster time-series gene expression data, perform stability analysis for clustering, or generate silhouette plots to validate cluster numbers.
homepage: https://bioconductor.org/packages/release/bioc/html/TMixClust.html
---

# bioconductor-tmixclust

## Overview
TMixClust is a soft-clustering Bioconductor package designed for longitudinal gene expression data. It employs a Gaussian mixed-effects model framework with nonparametric smoothing spline fitting. This approach is robust to noise and can handle missing values, allowing for the stratification of genes based on complex time-series patterns.

## Core Workflow

### 1. Data Preparation
The input must be a data frame where rows are genes and columns are time points. Row names should be gene identifiers; column names should be time point labels.

```r
library(TMixClust)

# From a data frame
data(toy_data_df)
plot_time_series_df(toy_data_df)

# From a tab-delimited file
toy_data <- get_time_series_df(system.file("extdata", "toy_time_series.txt", package = "TMixClust"))

# From a Biobase ExpressionSet
# library(SPEM); data(sos)
# sos_data = get_time_series_df_bio(sos)
```

### 2. Clustering
The main function `TMixClust` performs the clustering. By default, it looks for 2 clusters.

```r
# Basic clustering
cluster_obj <- TMixClust(toy_data_df, nb_clusters = 3)

# Accessing results
# cluster_obj$em_cluster_assignment  # Cluster membership
# cluster_obj$em_posterior_prob      # Posterior probabilities
# cluster_obj$em_ll                  # Log-likelihood
```

### 3. Stability Analysis and Optimization
Because the EM algorithm can get stuck in local optima, it is critical to run the clustering multiple times to find the global optimum.

```r
# Run clustering 10 times and pick the best solution
best_clust_obj <- analyse_stability(toy_data_df, 
                                    nb_clusters = 3, 
                                    nb_clustering_runs = 10, 
                                    nb_cores = 2)

# Plotting the results of a specific cluster
c_df <- toy_data_df[which(best_clust_obj$em_cluster_assignment == 1), ]
plot_time_series_df(c_df, plot_title = "Cluster 1")
```

### 4. Validation with Silhouette Analysis
Use silhouette widths to determine if the chosen number of clusters (K) is appropriate. Higher average silhouette widths indicate better-defined clusters.

```r
# Generate silhouette plot
plot_silhouette(best_clust_obj)
```

### 5. Reporting
Generate a comprehensive report containing plots, convergence data, and cluster lists.

```r
# Generates a folder "TMixClust_report/" in the working directory
generate_TMixClust_report(best_clust_obj)
```

## Key Functions
- `TMixClust()`: Main clustering function using EM.
- `analyse_stability()`: Runs multiple iterations to find the highest likelihood solution and assesses Rand index stability.
- `plot_time_series_df()`: Visualizes the expression trends for a given data frame.
- `plot_silhouette()`: Visualizes clustering cohesion and helps in choosing the optimal K.
- `get_time_series_df()` / `get_time_series_df_bio()`: Utility functions for data ingestion.

## Reference documentation
- [TMixClust](./references/TMixClust.md)