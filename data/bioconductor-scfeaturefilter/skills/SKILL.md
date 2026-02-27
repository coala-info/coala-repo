---
name: bioconductor-scfeaturefilter
description: This package filters features in single-cell RNA-seq data using a correlation-based approach to identify statistically sound expression thresholds. Use when user asks to filter single-cell RNA-seq features, determine expression thresholds for gene selection, or remove lowly expressed genes based on correlation to a reference bin.
homepage: https://bioconductor.org/packages/release/bioc/html/scFeatureFilter.html
---


# bioconductor-scfeaturefilter

## Overview

The `scFeatureFilter` package provides a correlation-based method for filtering features in single-cell RNA-seq data. It operates on the principle that highly expressed features (reference bin) capture biological signal more reliably than lowly expressed ones. By correlating subsequent bins of decreasing expression against this reference and randomized controls, the package helps users determine a statistically sound expression threshold for feature selection.

## Core Workflow

### 1. Data Preparation
The package accepts a `matrix`, `data.frame`, `tibble`, or `SingleCellExperiment` object. Features should be in rows and cells in columns. Normalized values (TPM, FPKM) are recommended over raw counts.

```r
library(scFeatureFilter)
# Load your data (e.g., a matrix or SingleCellExperiment)
# scData <- ... 
```

### 2. Integrated Usage (Quick Start)
For a standard analysis using default parameters (max 75% zeros, top window of 100 genes, 1000 genes per bin), use the wrapper function:

```r
filtered_data <- sc_feature_filter(scData)
```

### 3. Step-by-Step Analysis
For more control over the filtering process, follow the modular workflow:

**A. Calculate Statistics and Bin Data**
```r
# Calculate Mean and CV, then define the reference 'top' bin and subsequent bins
binned_data <- scData %>%
    calculate_cvs(max_zeros = 0.75) %>%
    define_top_genes(window_size = 100) %>%
    bin_scdata(window_size = 1000)

# Visualize the mean-variance relationship and binning
plot_mean_variance(binned_data, colourByBin = TRUE)
```

**B. Correlation Analysis**
Correlate every feature in each bin against the reference bin and randomized controls.
```r
cor_distrib <- correlate_windows(binned_data, n_random = 3)

# Calculate metrics (mean/median) for the distributions
metrics <- get_mean_median(cor_distrib)
```

**C. Determine Threshold and Filter**
Identify where the biological signal (correlation to top bin) drops toward the background noise level.
```r
# Visualize the correlation decay
plot_metric(metrics, show_ctrl = TRUE, show_threshold = TRUE, threshold = 2)

# Determine the bin cutoff (first bin falling below threshold * background)
cutoff <- determine_bin_cutoff(metrics, threshold = 2)

# Apply the filter to the original binned data
final_filtered_table <- filter_expression_table(binned_data, bin_cutoff = cutoff)
```

## Working with SingleCellExperiment

While the package accepts `SingleCellExperiment` (SCE) objects as input, it returns a `tibble`. To maintain the SCE structure, use the returned gene names to subset the original object:

```r
# Run filter on SCE assay
filtered_tibble <- sc_feature_filter(sce_object, sce_assay = "logcounts")

# Subset original SCE
sce_filtered <- sce_object[rownames(filtered_tibble), ]
```

## Key Parameters

- `max_zeros` (default 0.75): Maximum fraction of zero-expression allowed per feature. Lowering this (e.g., 0.5) increases stringency.
- `top_window_size` (default 100): Number of highest-expressed genes used as the biological reference. Use `plot_top_window_autocor()` to verify if this size captures sufficient signal.
- `other_window_size` (default 1000): Number of genes per bin. Smaller bins provide higher resolution for the threshold but increase computation.
- `threshold` (default 2): The multiplier applied to background noise to determine the cutoff. Increase for higher stringency.

## Reference documentation

- [Introduction to the scFeatureFilter package](./references/Introduction.md)