---
name: bioconductor-duoclustering2018
description: This package provides access to benchmark datasets and pre-computed clustering results from the DuoClustering2018 study for single-cell RNA-seq analysis. Use when user asks to retrieve SingleCellExperiment benchmark datasets, access pre-computed clustering performance summaries, or visualize clustering metrics like ARI, stability, and timing.
homepage: https://bioconductor.org/packages/release/data/experiment/html/DuoClustering2018.html
---

# bioconductor-duoclustering2018

name: bioconductor-duoclustering2018
description: Access and visualize scRNA-seq clustering benchmark data and results from the DuoClustering2018 study. Use this skill to retrieve SingleCellExperiment objects, compare clustering method performance (ARI, stability, timing), and explore benchmark datasets.

# bioconductor-duoclustering2018

## Overview

The `DuoClustering2018` package provides a collection of 12 single-cell RNA-seq datasets (9 real, 3 simulated) and pre-computed clustering results from a systematic evaluation of various clustering methods. It is designed to facilitate benchmarking and visualization of clustering performance using metrics like Adjusted Rand Index (ARI), stability, and computational timing.

## Core Workflows

### 1. Retrieving Datasets

Datasets are provided as `SingleCellExperiment` objects. You can access them via shortcut functions or `ExperimentHub`.

```r
library(DuoClustering2018)

# Using shortcut functions (e.g., Koh dataset with 10% expression filtering)
sce <- sce_filteredExpr10_Koh()

# Listing all available records via ExperimentHub
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "DuoClustering2018")

# Loading by ID
sce_full <- eh[["EH1500"]]
```

### 2. Accessing Clustering Summaries

Clustering results for various methods (e.g., SC3, Seurat, CIDR, FlowSOM) are stored in data frames.

```r
# Retrieve pre-computed results
res <- clustering_summary_filteredExpr10_Koh_v2()

# The data frame contains:
# - dataset, method, cell, run, k, resolution, cluster, trueclass, est_k, elapsed
```

### 3. Visualizing Performance

The package provides several functions to generate `ggplot2` objects for benchmarking.

```r
# Define consistent colors for methods
method_colors <- c(SC3 = "#CC6677", Seurat = "#DDCC77", CIDR = "#332288", ...)

# Plot ARI performance
perf_plots <- plot_performance(res, method_colors = method_colors)
print(perf_plots$median_ari_vs_k)

# Plot stability (ARI between random starts)
stab_plots <- plot_stability(res, method_colors = method_colors)

# Plot computational timing
time_plots <- plot_timing(res, method_colors = method_colors)
```

### 4. Interactive Exploration with iSEE

You can merge clustering results into the `SingleCellExperiment` object to explore them interactively.

```r
library(SingleCellExperiment)
library(dplyr)
library(tidyr)

# Filter and spread results to add to colData
res_wide <- res %>% 
  filter(run == 1 & k == 5) %>%
  select(cell, method, cluster) %>%
  spread(key = method, value = cluster)

colData(sce) <- DataFrame(
  as.data.frame(colData(sce)) %>%
    left_join(res_wide, by = c("Run" = "cell"))
)

# Launch iSEE
if (require(iSEE)) {
  iSEE(sce)
}
```

## Tips for Usage

- **Filtering Levels**: Most datasets come in four versions: `full` (unfiltered), `filteredExpr10` (top 10% by expression), `filteredHVG10` (top 10% highly variable genes), and `filteredM3Drop10` (top 10% by dropout pattern).
- **Plot Lists**: All `plot_*` functions return a named list of `ggplot` objects. Access specific plots using the `$` operator (e.g., `plots$median_ari_heatmap_truek`).
- **Custom Benchmarking**: To compare a new method, follow the `apply_method` pattern: create a function that returns timing, cluster assignments, and estimated k, then use the parameter settings from `duo_clustering_all_parameter_settings_v2()`.

## Reference documentation

- [Visualize data sets and clustering results with iSEE](./references/combine_data_clustering.md)
- [Plot performance summaries](./references/plot_performance.md)
- [Apply clustering method](./references/run_clustering.md)