---
name: bioconductor-cytofast
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.9/bioc/html/cytofast.html
---

# bioconductor-cytofast

## Overview
`cytofast` is an R package designed for the downstream analysis of clustered cytometry data. While it is optimized for output from Cytosplore (HSNE/t-SNE), it can handle any clustered data. Its primary strength lies in its ability to quickly relate cell populations to phenotypes and experimental conditions through integrated visualizations and statistical tests.

The core data structure is the `cfList`, an S4 object containing:
- `@expr`: Expression data with `sampleID` and `clusterID`.
- `@counts`: Cell counts or frequencies per cluster per sample.
- `@samples`: Metadata for each sample.

## Core Workflow

### 1. Data Import and Initialization
If using Cytosplore output, use the dedicated reader. For other sources, manually construct a `cfList`.

```r
library(cytofast)

# Import from a directory of .fcs files (one per cluster)
dirFCS <- "path/to/fcs_files"
cfData <- readCytosploreFCS(dir = dirFCS, colNames = "description")

# Manual cfList creation (if not using Cytosplore)
# cfData <- new("cfList", expr = your_expr_df, samples = your_sample_df)
```

### 2. Data Cleaning and Metadata
Filter unnecessary channels and attach experimental metadata to the `@samples` slot.

```r
# Remove unwanted channels (e.g., DNA, Time, Barcodes)
cfData@expr <- cfData@expr[, -c(1:5)] 

# Add metadata (ensure row names match sampleID)
# meta should be a data frame where rows correspond to samples
cfData@samples <- cbind(cfData@samples, meta_information)
```

### 3. Quantifying Clusters
Before visualization, calculate cell counts. It is highly recommended to use frequencies and scaling to account for varying sample sizes.

```r
# Calculate relative abundance and standardize (mean 0, unit variance)
cfData <- cellCounts(cfData, frequency = TRUE, scale = TRUE)
```

### 4. Visualization
`cytofast` provides three main visualization types:

*   **Heatmaps**: `cytoHeatmaps` produces two aligned plots. The top panel shows the phenotype (marker expression per cluster), and the bottom panel shows cluster abundance across samples.
*   **Boxplots**: `cytoBoxplots` visualizes the distribution of cluster percentages across groups.
*   **MSI Plots**: `msiPlot` creates density plots of Median Signal Intensity for specific markers to compare expression levels across groups.

```r
# Generate aligned heatmaps
cytoHeatmaps(cfData, group = "condition_column", legend = TRUE)

# Boxplots for cluster proportions
cytoBoxplots(cfData, group = "condition_column")

# Density plots for specific markers
msiPlot(cfData, markers = c("CD45", "MHCII"), byGroup = "condition_column")
```

### 5. Statistical Testing
Quantify differences in cluster abundance between experimental conditions.

```r
# T-test for differences between two groups
cfData <- cytottest(cfData, group = "condition_column", adjustMethod = "bonferroni")

# Results can be found in the output object or printed
print(cfData@results)
```

## Integration with FlowSOM
If you prefer FlowSOM for clustering instead of Cytosplore, you can map the clusters back into a `cfList`:

```r
# After running FlowSOM
clusterID_FS <- as.factor(fSOM$FlowSOM$map$mapping[,1])
levels(clusterID_FS) <- fSOM$metaclustering

# Update the cfList
cfData@expr$clusterID <- clusterID_FS
cfData <- cellCounts(cfData)
```

## Reference documentation
- [Cytofast - vignette for the Spitzer study](./references/spitzer.md)