---
name: bioconductor-ctsge
description: This tool clusters time-series gene expression data using a two-step sorting and sub-clustering approach based on expression profiles. Use when user asks to build expression matrices from time-series data, define expression indexes, perform structure-based clustering on gene groups, or visualize expression patterns through line graphs and an interactive Shiny GUI.
homepage: https://bioconductor.org/packages/release/bioc/html/ctsGE.html
---


# bioconductor-ctsge

name: bioconductor-ctsge
description: Clustering of time-series gene-expression data using a two-step sorting and clustering approach. Use this skill to: (1) Build expression matrices from time-series data, (2) Define expression indexes (sequences of 1, -1, 0) based on median/mean scaling, (3) Perform structure-based clustering using K-means on specific index groups, and (4) Visualize gene-expression patterns through line graphs or an interactive Shiny GUI.

# bioconductor-ctsge

## Overview
The `ctsGE` package provides a specialized workflow for analyzing time-series gene expression data. Instead of traditional noise filtering, it employs a "sorting" step that categorizes genes into groups based on their expression profile relative to the time-series center (median or mean). Each gene is assigned an index (e.g., `1, 0, -1`) for each time point. Genes sharing the same index are then sub-clustered using K-means. This approach preserves data while organizing it into structurally similar patterns.

## Workflow and Core Functions

### 1. Data Preparation
The input should be a normalized expression table (RNA-Seq counts or microarray data).

```r
library(ctsGE)

# From a list of data frames (one per time point)
# gseList is a list where each element is a data.frame(Genes, Value)
rts <- readTSGE(gseList, labels = c("0h", "6h", "12h", "24h", "48h", "72h"))

# From files in a directory
data_dir <- system.file("extdata", package = "ctsGE")
files <- dir(path = data_dir, pattern = "\\.xls$")
rts <- readTSGE(files, path = data_dir, labels = c("0h", "6h", "12h", "24h", "48h", "72h"))

# Add gene annotations using the 'desc' argument if available
# rts <- readTSGE(files, path = data_dir, labels = labels, desc = annotation_df)
```

### 2. Defining Expression Indexes
Standardize the data and convert values to index integers:
- **1**: Expression > center + cutoff
- **0**: Expression within center +/- cutoff
- **-1**: Expression < center - cutoff

```r
# Find optimal cutoff (minimizes chi-squared to equalize group sizes)
prts <- PreparingTheIndexes(x = rts, min_cutoff = 0.5, max_cutoff = 0.7, mad.scale = TRUE)

# Check the selected cutoff
prts$cutoff

# Access scaled data and indexes
head(prts$scaled)
head(prts$index)
```

### 3. Clustering
Perform K-means clustering on genes within the same index group. The package can automatically suggest an optimal `k` using the Elbow method (WSS/TSS < 0.2).

```r
# Cluster all indexes (can be time-consuming)
ClustIndexes <- ClustIndexes(prts, scaling = TRUE)

# View recommended k and cluster assignments
head(ClustIndexes$optimalK)
head(ClustIndexes$ClusteredIdxTable)
```

### 4. Visualization
Visualize specific patterns or use the interactive GUI.

```r
# Plot a specific index (e.g., "1100-1-1")
# The function calculates k if not provided
indexPlot <- PlotIndexesClust(prts, idx = "1100-1-1", scaling = TRUE)

# View line graphs
indexPlot$graphs

# Launch interactive Shiny App for exploration
ctsGEShinyApp(rts)
```

## Tips for Success
- **MAD vs SD**: Use `mad.scale = TRUE` (default) for median-based scaling, which is more robust to outliers in gene expression data.
- **Cutoff Selection**: A narrow cutoff range increases sensitivity to small fluctuations; a wide range results in more zeros in the index.
- **Session Blocking**: Note that `ctsGEShinyApp` will block your R session until the window is closed.
- **Data Export**: Use `write.table(indexPlot[[1]], "filename.txt", sep = "\t")` to save the cluster assignments for a specific index.

## Reference documentation
- [ctsGE Package Vignette](./references/ctsGE.Rmd)
- [ctsGE Documentation](./references/ctsGE.md)