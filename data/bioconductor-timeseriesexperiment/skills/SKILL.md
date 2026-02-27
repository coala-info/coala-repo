---
name: bioconductor-timeseriesexperiment
description: This tool provides a specialized workflow for analyzing RNA-seq time-course data using the TimeSeriesExperiment R package. Use when user asks to normalize time-course data, perform dimensionality reduction, cluster gene trajectories, or identify genes with differential kinetics between experimental groups.
homepage: https://bioconductor.org/packages/3.8/bioc/html/TimeSeriesExperiment.html
---


# bioconductor-timeseriesexperiment

name: bioconductor-timeseriesexperiment
description: Specialized workflow for analyzing RNA-seq time-course data using the TimeSeriesExperiment R package. Use this skill when you need to perform data normalization, dimensionality reduction (PCA), gene clustering, differential trajectory analysis, and pathway enrichment for short time-series biological datasets.

## Overview

The `TimeSeriesExperiment` package is designed for analyzing time-course transcriptomic data, particularly datasets with few time points and replicates. It provides a non-parametric framework to handle the dependency structure of time-series data by incorporating lag differences. The core workflow involves creating a `TimeSeriesExperiment` object, normalizing counts, transforming data for gene-to-gene comparison, clustering trajectories, and identifying genes with differential kinetics between experimental groups.

## Core Workflow

### 1. Object Initialization
Create the S4 object from raw counts, row metadata, and column metadata. Time variables must be numeric.

```r
library(TimeSeriesExperiment)

# From matrices
te <- TimeSeriesExperiment(
  assays = list(counts = cnts_matrix),
  rowData = gene_info,
  colData = sample_info,
  timepoint = "time",
  replicate = "replicate",
  group = "condition"
)

# From SummarizedExperiment
te <- makeTimeSeriesExperimentFromSummarizedExperiment(
  se_object, time = "time_col", group = "group_col", replicate = "rep_col"
)
```

### 2. Pre-processing and Normalization
Normalize for library size and filter low-expression features.

```r
# Normalize to CPM
te <- normalizeData(te)

# Filter features (example: mean CPM > 5 in at least one group)
# User must identify 'genes_to_keep' vector first
te <- filterFeatures(te, genes_to_keep)

# Aggregate replicates to see mean behavior
te <- collapseReplicates(te, FUN = mean)
```

### 3. Time-Course Formatting and Lags
Transform data for fair comparison (e.g., scaling by gene sum or variance stabilization) and add lag features to capture temporal dependencies.

```r
# Scale gene expression to even sum for clustering
te <- makeTimeSeries(te, feature.trans.method = "scale_feat_sum")

# Add first and second order lags with weights (lambda)
te <- addLags(te, lambda = c(0.5, 0.25))
```

### 4. Visualization and PCA
Explore sample relationships and gene profiles.

```r
# Run PCA with variance stabilization
te <- runPCA(te, var.stabilize.method = "asinh")

# Plot samples
plotSamplePCA(te, col.var = "timepoint")

# Plot feature trajectories over PCA grid
plotTimeSeriesPCA(te, m = 15, n = 15)

# Heatmap of top variable genes
plotHeatmap(te, num.feat = 100)
```

### 5. Gene Clustering
Group genes with similar trajectories using hierarchical clustering.

```r
# Cluster top 1000 variable genes
te <- clusterTimeSeries(
  te, 
  n.top.feat = 1000, 
  groups = "all",
  clust.params = list(dynamic = TRUE)
)

# Visualize clusters
plotTimeSeriesClusters(te)
```

### 6. Differential Expression (DE)
Identify genes that differ at specific time points or exhibit different overall trajectories.

```r
# Point-wise DE (Limma-Voom wrapper)
te <- timepointDE(te, timepoints = "all", alpha = 0.05)
de_results <- differentialExpression(te, "timepoint_de")

# Trajectory DE (MANOVA/Adonis approach)
# R2 indicates percentage of variance explained by the group/condition
te <- trajectoryDE(te, dist_method = "euclidean")
traj_results <- differentialExpression(te, "trajectory_de")
```

### 7. Pathway Enrichment
Perform enrichment analysis on clusters of interest or DE gene sets.

```r
# Enrichment for a specific set of Entrez IDs
enrich_res <- pathwayEnrichment(
  object = te,
  features = de_entrez_ids,
  species = "Mm", 
  ontology = "BP"
)

# Plot results for a specific cluster
plotEnrichment(enrich_res[["C1"]], n_max = 15)
```

## Tips for Success
- **Time Variable**: Ensure the column designated as `timepoint` in `colData` is numeric, not a factor or character string.
- **Lag Weights**: The `lambda` parameter in `addLags` controls the influence of the "slope" of the curve on clustering and DE.
- **Ranking**: For short time courses with low power, use the $R^2$ value from `trajectoryDE` to rank genes by the magnitude of difference between conditions rather than relying solely on p-values.

## Reference documentation
- [Cop1 role in pro-inflammatory response](./references/cop1_knockout_timecourse.Rmd)
- [Gene expression time course data analysis](./references/cop1_knockout_timecourse.md)