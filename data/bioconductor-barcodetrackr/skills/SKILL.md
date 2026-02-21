---
name: bioconductor-barcodetrackr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/barcodetrackR.html
---

# bioconductor-barcodetrackr

## Overview
The `barcodetrackR` package is designed for the analysis of clonal tracking data, typically represented as matrices of barcode counts across multiple samples (e.g., different cell types or timepoints). It utilizes the `SummarizedExperiment` framework to manage data and metadata, providing a suite of tools for visualization (heatmaps, chord diagrams, ridge plots) and statistical analysis (diversity indices, correlation, and clonal bias).

## Core Workflow

### 1. Data Preparation and Object Creation
The package requires a count dataframe (rows = barcodes, columns = samples) and a metadata dataframe. The metadata must contain a `SAMPLENAME` column matching the count matrix columns.

```r
library(barcodetrackR)
library(SummarizedExperiment)

# Create SummarizedExperiment (SE) object
# threshold = 0 includes all barcodes initially
my_SE <- create_SE(your_data = count_dataframe,
                   meta_data = metadata_dataframe,
                   threshold = 0)

# Access different data transformations (assays)
# Options: "counts", "proportions", "ranks", "normalized" (CPM), "logs"
assay(my_SE, "proportions")
```

### 2. Thresholding
Filter out low-abundance barcodes that may represent sequencing noise.

```r
# Estimate a biological threshold based on capture efficiency
my_thresh <- estimate_barcode_threshold(capture_efficiency = 0.4,
                                        population_size = 500000,
                                        proportion_labeled = 0.3,
                                        confidence_level = 0.95)

# Apply threshold to the SE object
# threshold_type can be "relative" (proportion) or "absolute" (counts)
my_SE_filtered <- threshold_SE(your_SE = my_SE,
                               threshold_value = 0.005,
                               threshold_type = "relative")
```

### 3. Visualizing Clonal Patterns

#### Heatmaps
Use `barcode_ggheatmap` to visualize the top N clones across samples.

```r
barcode_ggheatmap(your_SE = my_SE[, samples_of_interest],
                  n_clones = 10,
                  assay = "proportions",
                  dendro = TRUE,
                  cellnote_assay = "stars") # Mark top clones
```

#### Chord Diagrams
Visualize shared clones between compartments.

```r
# Unweighted: link width = number of shared clones
chord_diagram(my_SE[, samples], plot_label = "celltype")

# Weighted: link width = proportional contribution of shared clones
chord_diagram(my_SE[, samples], weighted = TRUE)
```

### 4. Clonal Bias and Diversity

#### Clonal Bias
Compare the abundance of clones between two lineages or conditions.

```r
# Ridge plot for density estimation of bias
bias_ridge_plot(your_SE = my_SE,
                split_bias_on = "celltype",
                bias_1 = "B",
                bias_2 = "Gr",
                split_bias_over = "months",
                weighted = TRUE)

# Line plot to track individual clone bias over time
bias_lineplot(your_SE = my_SE,
              split_bias_on = "celltype",
              bias_1 = "Gr",
              bias_2 = "Mo",
              split_bias_over = "months")
```

#### Diversity Indices
Calculate alpha diversity (within-sample) or beta diversity (between-sample).

```r
# Alpha diversity: Shannon, Simpson, or Invsimpson
clonal_diversity(my_SE,
                 plot_over = "months",
                 group_by = "celltype",
                 index_type = "shannon")

# Beta diversity: MDS/PCoA plot
mds_plot(my_SE, 
         group_by = "celltype",
         method_dist = "bray", 
         assay = "proportions")
```

## Statistical Testing
Most functions include a `return_table` argument. Set this to `TRUE` to retrieve the raw calculations instead of the plot.

```r
# Statistical comparison of barcode proportions between samples
stats <- barcode_stat_test(your_SE = my_SE[, samples],
                           sample_size = rep(40000, length(samples)),
                           stat_test = "chi-squared",
                           stat_option = "subsequent")
```

## Tips for Success
- **Sample Ordering**: Always ensure your `colData(my_SE)` is ordered correctly before plotting longitudinal data.
- **Assay Selection**: Use `"proportions"` for most visualizations and `"logs"` for distance-based clustering or MDS plots.
- **Shiny App**: For interactive exploration, use `barcodetrackR::launchApp()`.
- **Filtering**: Use `filter_by` and `filter_selection` within plotting functions to subset data dynamically without creating new SE objects.

## Reference documentation
- [Introduction to barcodetrackR](./references/Introduction_to_barcodetrackR.Rmd)