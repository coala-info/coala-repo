---
name: bioconductor-flowcybar
description: The flowCyBar package implements cytometric barcoding to analyze and visualize variations in cell abundance across gates in flow cytometry datasets. Use when user asks to normalize cell counts, create barcode heatmaps and boxplots, perform nonmetric multidimensional scaling, or correlate cell abundances with abiotic parameters.
homepage: https://bioconductor.org/packages/release/bioc/html/flowCyBar.html
---


# bioconductor-flowcybar

## Overview

The `flowCyBar` package implements "cytometric barcoding," a method for evaluating cytometric datasets using gate information. It is designed to track cell abundance variations across gates over time or treatments. The workflow typically involves normalizing cell counts, visualizing changes through "barcodes" (heatmaps) and boxplots, and identifying drivers of community shifts by correlating cell abundances with abiotic parameters (e.g., pH, temperature, chemical concentrations).

## Typical Workflow

### 1. Data Preparation
Data should be in a tab-separated text file with samples in rows and gates/parameters in columns.
```R
library(flowCyBar)

# Load example data
data(Cell_number_sample)

# If reading from a file:
# cell_data <- read.table("data.txt", header=TRUE, sep="\t", row.names=1)
```

### 2. Normalization
Normalization ensures comparability between gates with vastly different cell densities.
- **Method "mean" (Default):** Divides each value by the mean of its gate. Best for general variation.
- **Method "first":** Divides each value by the first sample's value in that gate. Best for tracking changes from a specific starting condition.

```R
# Normalize using the mean (omitting the first column if it contains names)
norm_data <- normalize(Cell_number_sample[, -1], method = "mean", digits = 2)
```

### 3. Visualization (CyBar Plot)
The `cybar_plot` function creates a combined barcode (heatmap) and boxplot.
- `x`: Normalized data for the barcode.
- `y`: Relative/percental data for the boxplot.
- `order="sim"`: Orders boxplots by similarity to the barcode clustering.
- `to`: Adjusts the color key range (crucial if the histogram is skewed).

```R
# Basic plot
cybar_plot(norm_data, Cell_number_sample[, -1])

# Enhanced plot with vertical labels and similarity ordering
cybar_plot(norm_data, Cell_number_sample[, -1], labels = "vert", order = "sim")
```

### 4. NMDS (Nonmetric Multidimensional Scaling)
Visualize distances between samples based on cell abundance. It is highly recommended to use **normalized** data for NMDS to prevent high-abundance gates from dominating the result.

```R
# Basic NMDS
nmds(norm_data)

# NMDS with groups and abiotic overlays
groups <- data.frame("groups" = c(1,1,1,1,2,3,3,3,3,3))
data(Abiotic_data_sample)
nmds(norm_data, group = groups, abiotic = Abiotic_data_sample[, -1], p.max = 0.05)
```

### 5. Correlation Analysis
Investigate relationships between cell numbers (biotic) and abiotic parameters using Spearman's rank correlation. Use **relative/percental** numbers here, not normalized ones.

```R
data(Corr_data_sample)

# Run correlation and show heatmap
# verbose=TRUE returns estimates and p-values
cor_results <- correlation(Corr_data_sample[, -1], verbose = TRUE)

# Access specific results
estimates <- cor_results$est
p_values <- cor_results$pvals
```

## Tips for Success
- **Gate Consistency:** CyBar requires a fixed gate template applied to all samples in a series.
- **Data Cleaning:** Ensure gate names do not contain whitespace.
- **Color Keys:** If the barcode looks "washed out," check the histogram in the top-left corner and adjust the `to` parameter in `cybar_plot` to better fit the data distribution.
- **Row Names:** Assign sample names to `rownames(norm_data)` before plotting to see them in the heatmaps and NMDS plots.

## Reference documentation
- [flowCyBar-manual](./references/flowCyBar-manual.md)