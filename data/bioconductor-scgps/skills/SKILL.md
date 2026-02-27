---
name: bioconductor-scgps
description: "bioconductor-scgps provides a framework for stable clustering and relationship prediction between cell subpopulations in single-cell transcriptomics data. Use when user asks to identify stable cell clusters using bagging and bootstrapping, find cluster marker genes, or estimate transition potentials between subpopulations using supervised learning."
homepage: https://bioconductor.org/packages/release/bioc/html/scGPS.html
---


# bioconductor-scgps

## Overview
The `scGPS` package provides a framework for two primary tasks in single-cell analysis:
1. **SCORE (Stable Clustering at Optimal REsolution):** An unsupervised clustering approach that uses bagging and bootstrapping to find stable cell subpopulations.
2. **scGPS Prediction:** A supervised learning approach (using LDA and ElasticNet) to estimate the relationship or "transition potential" between identified subpopulations, either within a single dataset or across different time points/samples.

## Core Workflow

### 1. Data Preparation
`scGPS` uses a specialized object created from an expression matrix and metadata.

```r
library(scGPS)

# Create scGPS object
# ExpressionMatrix: genes (rows) x cells (columns)
# CellMetadata: dataframe with at least one column for cluster/cell info
scgps_obj <- new_scGPS_object(
    ExpressionMatrix = count_matrix,
    GeneMetadata = gene_info,
    CellMetadata = cell_info
)
```

### 2. Subpopulation Discovery (SCORE/CORE)
If clusters are unknown, use `CORE_clustering` or the more robust `CORE_bagging` (SCORE).

```r
# Standard CORE clustering
core_results <- CORE_clustering(scgps_obj, remove_outlier = c(0), PCA = FALSE)

# SCORE (CORE with bagging for stability)
score_results <- CORE_bagging(
    scgps_obj, 
    bagging_run = 20, 
    subsample_proportion = 0.8,
    PCA = FALSE
)

# Visualizing clusters
plot_CORE(score_results$tree, list_clusters = score_results$Cluster)
```

### 3. Marker Identification
Identify differentially expressed genes to characterize clusters and provide features for the prediction model.

```r
# Find markers for all clusters
DE_genes <- find_markers(
    expression_matrix = assay(scgps_obj),
    cluster = colData(scgps_obj)[,1],
    selected_cluster = unique(colData(scgps_obj)[,1])
)

# Annotate clusters using enrichment analysis
enrichment <- annotate_clusters(DE_genes$id[1:500], pvalueCutoff = 0.05, gene_symbol = TRUE)
```

### 4. Relationship Prediction (scGPS)
Estimate the transition scores between a source subpopulation and target subpopulations.

```r
# Define features (e.g., top 200 markers of the source cluster)
selected_genes <- DE_genes$id[1:200]

# Run bootstrap prediction
# c_selectID: the index of the subpopulation to start from
prediction_data <- bootstrap_prediction(
    nboots = 50,
    mixedpop1 = scgps_obj, # Source population
    mixedpop2 = scgps_obj, # Target population (can be the same or different)
    genes = selected_genes,
    c_selectID = 1,
    cluster_mixedpop1 = colData(scgps_obj)[,1],
    cluster_mixedpop2 = colData(scgps_obj)[,1]
)

# Summarize results
summary_prediction_lda(prediction_data, nPredSubpop = 4)
summary_prediction_lasso(prediction_data, nPredSubpop = 4)
```

### 5. Visualization of Relationships
Use Sankey diagrams to visualize how cells from one subpopulation are classified into others, representing potential transitions.

```r
# Reformat LASSO results for Sankey
lasso_formatted <- reformat_LASSO(
    c_selectID = 1, 
    mp_selectID = 2, 
    LSOLDA_dat = prediction_data,
    nPredSubpop = 4,
    Nodes_group = "#7570b3"
)

# Plotting requires networkD3
library(networkD3)
# (Follow vignette patterns for preparing the combined D3 object)
```

## Tips and Best Practices
- **nboots:** For publication-quality results, use `nboots = 50-100` in `bootstrap_prediction`. Use low values (2-5) only for testing code.
- **Gene Selection:** The accuracy of scGPS prediction is highly dependent on the gene list. Using top DE genes (markers) for the cluster of interest is the recommended approach.
- **Outliers:** `CORE_clustering` allows for outlier removal by setting `remove_outlier`.
- **Dimensionality Reduction:** Use the built-in `tSNE` function or `plot_reduced` to validate clustering results visually.

## Reference documentation
- [scGPS introduction](./references/vignette.md)
- [scGPS RMarkdown Source](./references/vignette.Rmd)