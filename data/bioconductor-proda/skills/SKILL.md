---
name: bioconductor-proda
description: This tool analyzes label-free mass spectrometry data using a probabilistic dropout model to identify differentially abundant proteins without requiring imputation. Use when user asks to identify differentially abundant proteins, account for non-random missing values in LFQ-MS data, or estimate sample distances from protein intensity matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/proDA.html
---


# bioconductor-proda

name: bioconductor-proda
description: Analyze label-free mass spectrometry (LFQ-MS) data using a probabilistic dropout model. Use this skill to identify differentially abundant proteins while accounting for non-random missing values (dropouts) without the need for imputation. It supports linear models, empirical Bayesian priors, and provides tools for normalization and sample distance estimation.

## Overview

The `proDA` package provides a principled framework for the analysis of protein intensities from mass spectrometry. Unlike traditional methods that require imputing missing values (which can lead to overconfident results), `proDA` models the dropout mechanism—where lower intensity proteins are more likely to be missing—using a sigmoidal curve. This allows for more accurate estimation of protein abundance means and variances.

## Typical Workflow

### 1. Data Preparation
`proDA` requires a log-transformed abundance matrix where missing values are represented as `NA`.

```r
library(proDA)

# Load MaxQuant proteinGroups.txt or similar
raw_data <- read.delim("proteinGroups.txt", stringsAsFactors = FALSE)

# Extract intensity columns (e.g., LFQ intensities)
intensity_cols <- grep("^LFQ\\.intensity\\.", colnames(raw_data), value = TRUE)
abundance_matrix <- as.matrix(raw_data[, intensity_cols])

# 1. Replace 0 with NA
abundance_matrix[abundance_matrix == 0] <- NA

# 2. Log2 transformation
abundance_matrix <- log2(abundance_matrix)

# 3. Median Normalization
normalized_matrix <- median_normalization(abundance_matrix)
```

### 2. Fitting the Model
The `proDA()` function fits the probabilistic dropout model. You can provide a matrix, a `SummarizedExperiment`, or an `MSnSet`.

```r
# Define experimental design
sample_info <- data.frame(
  name = colnames(normalized_matrix),
  condition = factor(c("A", "A", "A", "B", "B", "B")),
  stringsAsFactors = FALSE
)

# Fit model using a formula
fit <- proDA(normalized_matrix, design = ~ condition, col_data = sample_info)

# Or fit using a design matrix directly
# fit <- proDA(normalized_matrix, design = model.matrix(~ condition, sample_info))
```

### 3. Differential Abundance Testing
Use `test_diff()` to perform Wald tests for specific contrasts or Likelihood Ratio Tests.

```r
# Wald test for a specific contrast
# If using a formula, the coefficients are named based on the levels
result <- test_diff(fit, contrast = "conditionB - conditionA")

# Sort by significance
result <- result[order(result$pval), ]

# Complex contrasts
# result <- test_diff(fit, contrast = "cond1 - (cond2 + cond3)/2")
```

### 4. Quality Control and Distances
Standard distance functions like `dist()` fail with `NA` values. `proDA` provides `dist_approx()` to estimate distances based on the dropout model.

```r
# Estimate sample distances
da <- dist_approx(fit)

# da$mean contains the distance estimates
# da$sd contains the uncertainty (standard deviation) of the estimates

# Plotting a heatmap (requires pheatmap)
pheatmap::pheatmap(as.matrix(da$mean))
```

## Key Functions

- `proDA()`: Main function to fit the model. Parameters include `design`, `col_data`, and `reference_level`.
- `test_diff()`: Conducts differential abundance tests. Returns a data frame with p-values, adjusted p-values (BH), and log2 fold changes (`diff`).
- `median_normalization()`: Robust normalization that ignores missing values.
- `dist_approx()`: Calculates the expected distance between samples or proteins.
- `generate_synthetic_data()`: Useful for creating mock datasets to test pipelines.

## Tips for Success

- **Missing Values**: Do not impute missing values before using `proDA`. The model is specifically designed to handle `NA` values natively.
- **Reference Levels**: When using a formula in `proDA()`, use the `reference_level` argument to specify the control group.
- **Object Access**: The `proDAFit` object (output of `proDA()`) acts like a `SummarizedExperiment`. You can access parameters using the `$` operator (e.g., `fit$hyper_parameters`).
- **Large Datasets**: For very large datasets, `proDA` is computationally efficient as it fits parameters protein-by-protein after estimating global hyperparameters.

## Reference documentation

- [Introduction](./references/Introduction.md)
- [Introduction (Rmd)](./references/Introduction.Rmd)
- [Proteomics Data Import](./references/data-import.md)
- [Proteomics Data Import (Rmd)](./references/data-import.Rmd)