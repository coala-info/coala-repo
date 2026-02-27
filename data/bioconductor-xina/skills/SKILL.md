---
name: bioconductor-xina
description: XINA analyzes and clusters multi-condition time-series proteomics or transcriptomics data to identify co-abundance patterns. Use when user asks to cluster time-course data across multiple treatments, visualize protein co-regulation with alluvial plots, or integrate expression clusters with STRING protein-protein interaction networks.
homepage: https://bioconductor.org/packages/release/bioc/html/XINA.html
---


# bioconductor-xina

## Overview
XINA is an R package designed for the analysis of quantitative proteomics or transcriptomics data across multiple time points and conditions. Its primary strength lies in "tagging" datasets in silico to combine them into a single "Super dataset" for clustering. This allows researchers to identify proteins that exhibit similar abundance patterns not just within one experiment, but across different stimulations or treatments. XINA integrates model-based clustering (mclust), coregulation analysis (alluvial plots), and network analysis (STRING DB) to provide a comprehensive biological interpretation of time-series data.

## Core Workflow

### 1. Data Preparation
XINA requires input data as CSV files where rows are proteins/genes and columns represent time points. Column names for time points must be identical across all condition files.

```r
library(XINA)

# Define the time points (column names) to be analyzed
time_points <- c("0hr", "2hr", "6hr", "12hr", "24hr", "48hr", "72hr")

# List of CSV files representing different conditions (e.g., Control, Stim1, Stim2)
data_files <- c("Control.csv", "Stimulus1.csv", "Stimulus2.csv")
```

### 2. Clustering Analysis
XINA uses model-based clustering by default to determine the optimal number of clusters based on Bayesian Information Criterion (BIC).

```r
# Set seed for reproducibility (mclust requirement)
set.seed(0)

# Run clustering (nClusters is the maximum limit for mclust to test)
clustering_result <- xina_clustering(data_files, data_column=time_points, nClusters=20)

# Alternatively, use k-means
clustering_result_km <- xina_clustering(data_files, data_column=time_points, nClusters=20, chosen_model='kmeans')
```

### 3. Visualization of Clusters
Visualize the expression patterns and the distribution of conditions within each cluster.

```r
# Plot line graphs of clusters
plot_clusters(clustering_result)

# Plot pie charts showing condition composition for each cluster
condition_composition <- plot_condition_compositions(clustering_result)
```

### 4. Coregulation (Alluvial) Analysis
Identify proteins that "comigrate" (show the same pattern) across different conditions.

```r
# Define the conditions to compare
conditions <- c("Control", "Stimulus1", "Stimulus2")

# Generate alluvial plot to show protein movement between clusters across conditions
# Use comigration_size to filter for groups with a minimum number of proteins
all_cor <- alluvial_enriched(clustering_result, conditions, comigration_size=5)
```

### 5. Network Integration
Integrate results with STRING DB to perform PPI network analysis and identify central nodes (hubs).

```r
library(STRINGdb)

# Initialize STRING database (example for Human, species 9606)
string_db <- STRINGdb$new(version="10", species=9606, score_threshold=0)

# Run comprehensive XINA analysis including network construction
xina_result <- xina_analysis(clustering_result, string_db)

# Generate network plots for all clusters (saved to working directory)
xina_plot_all(xina_result, clustering_result)
```

## Tips and Best Practices
- **Normalization**: By default, XINA performs sum-normalization to standardize datasets. Ensure your input data is already quality-controlled and log-transformed if necessary before import.
- **Reproducibility**: Always use `set.seed()` before `xina_clustering` as the underlying `mclust` package relies on random starts.
- **Condition Tags**: XINA automatically tags proteins with their source condition. This is what allows it to track a single protein's behavior across multiple experimental arms simultaneously.
- **Network Centrality**: The `xina_analysis` function calculates betweenness, closeness, and eigenvector scores to help you find the most "influential" proteins in a co-abundance cluster.

## Reference documentation
- [XINA User Code and Examples](./references/xina_user_code.md)