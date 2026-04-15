---
name: bioconductor-massir
description: This tool predicts the sex of samples in microarray datasets by analyzing Y chromosome probe expression levels. Use when user asks to predict sample sex from gene expression data, identify sex in public datasets lacking metadata, or perform quality control on microarray samples.
homepage: https://bioconductor.org/packages/release/bioc/html/massiR.html
---

# bioconductor-massir

name: bioconductor-massir
description: Predicts the sex of samples in microarray data sets using Y chromosome probe expression. Use this skill when you need to identify or verify sample sex in gene expression data (data.frames or ExpressionSets), particularly for public datasets lacking metadata or as a quality control step.

# bioconductor-massir

## Overview

The `massiR` package provides a method to predict the sex of samples in microarray datasets by analyzing the expression of Y chromosome probes. It uses a k-medoids clustering algorithm to partition samples into two groups based on Y chromosome gene expression, identifying the cluster with higher expression as male and the lower as female.

## Typical Workflow

### 1. Data Preparation
The package requires two inputs:
- **Expression Data**: A `data.frame` (probes as rows, samples as columns) or an `ExpressionSet` object. Data should be normalized and log-transformed.
- **Y Chromosome Probes**: A `data.frame` with probe identifiers as `row.names`.

```R
library(massiR)
# Load your data
# data(massi.test.dataset) 
# data(massi.test.probes)
```

### 2. Extract and Filter Y Probes
Use `massi_y()` to extract Y chromosome probe data and calculate variance. Use `massi_y_plot()` to visualize probe variation (CV) to decide on an informativeness threshold.

```R
# Extract Y data
massi.y.out <- massi_y(expression_data, y_probes)

# Visualize probe variation
massi_y_plot(massi.y.out)
```

### 3. Select Informative Probes
Select a subset of probes based on a CV threshold (1=All, 2=Upper 75%, 3=Upper 50%, 4=Upper 25%). The default is 3.

```R
massi.select.out <- massi_select(expression_data, y_probes, threshold=4)
```

### 4. Predict Sex
Run the clustering algorithm using `massi_cluster()`.

```R
results <- massi_cluster(massi.select.out)

# Extract results table
sample.results <- data.frame(results[[2]])
# Columns: ID, mean_y_probes_value, y_probes_sd, z_score, sex
```

### 5. Visualization and Validation
Visualize the clustering results to identify outliers or problematic probes.

```R
# Heatmap, barplot of means, and PCA plot
massi_cluster_plot(massi.select.out, results)
```

### 6. Check for Sex Bias (Dip Test)
The method is most accurate when at least 15% of samples are of either sex. Use `massi_dip()` to test for unimodality (suggesting a heavily skewed dataset). A dip statistic > 0.08 generally indicates a balanced dataset.

```R
dip.result <- massi_dip(massi.select.out)
# dip.result[[1]] contains the dip statistic
```

## Working with ExpressionSets
If using an `ExpressionSet`, the workflow is identical, but you can easily append results back to the metadata:

```R
eset.select.out <- massi_select(my_eset, y_probes)
eset.results <- massi_cluster(eset.select.out)

# Extract and match order
sex_info <- data.frame(eset.results[[2]])
sex_info <- sex_info[match(sampleNames(my_eset), sex_info$ID),]

# Add to phenoData
pData(my_eset)$predicted_sex <- sex_info$sex
```

## Obtaining Y Probes
`massiR` includes pre-defined probe lists for common platforms:
```R
data(y.probes)
names(y.probes) # View available platforms (Illumina, Affymetrix)
```
Alternatively, use `biomaRt` to fetch probes mapping to the Y chromosome for your specific platform.

## Reference documentation
- [massiR: MicroArray Sample Sex Identifier](./references/massiR_Vignette.md)