---
name: r-noisyr
description: The noisyr package provides an end-to-end pipeline for quantifying and removing technical noise from high-throughput sequencing datasets. Use when user asks to calculate expression similarity across replicates, determine signal-to-noise thresholds, or remove low-abundance noisy features from count matrices and BAM files.
homepage: https://cran.r-project.org/web/packages/noisyr/index.html
---


# r-noisyr

## Overview
The `noisyr` package provides an end-to-end pipeline for quantifying and removing technical noise from HTS datasets. It operates on the principle that low-abundance features exhibit high stochasticity (noise), while high-abundance features show consistent similarity across replicates. The pipeline consists of three main steps: similarity calculation, noise quantification, and noise removal.

## Installation
To install the package from CRAN:
```r
install.packages("noisyr")
```

Note: `noisyr` depends on several Bioconductor packages (`preprocessCore`, `IRanges`, `GenomicRanges`, `Rsamtools`). Ensure `BiocManager` is installed to handle these dependencies.

## Core Workflow: Count Matrix Approach
The most common entry point is using a raw, un-normalized count matrix.

### 1. One-Step Pipeline
The `noisyr()` function can execute the entire workflow automatically.
```r
library(noisyr)
# df is a data frame or matrix of raw counts
denoised_matrix <- noisyr(
  approach.for.similarity.calculation = "counts",
  expression.matrix = df,
  similarity.measure = "correlation_pearson"
)
```

### 2. Step-by-Step Breakdown
For finer control or diagnostic plotting, run the steps individually:

**Step A: Similarity Calculation**
Calculates localized consistency in expression across samples using a sliding window.
```r
# Convert to numeric matrix first if necessary
expression_matrix <- cast_matrix_to_numeric(df)

expression_summary <- calculate_expression_similarity_counts(
  expression.matrix = expression_matrix,
  similarity.measure = "correlation_pearson",
  n.elements.per.window = NULL # Defaults to 10% of rows
)

# Visualize the abundance-similarity relationship
plots <- plot_expression_similarity(expression_summary)
plots[[1]] # View first sample
```

**Step B: Noise Quantification**
Determines the signal-to-noise threshold.
```r
# Calculate thresholds using the Boxplot-IQR method (default)
noise_thresholds <- calculate_noise_threshold(
  expression = expression_summary,
  similarity.threshold = 0.25,
  method.chosen = "Boxplot-IQR"
)
```

**Step C: Noise Removal**
Applies the thresholds to the original matrix.
```r
denoised_matrix <- remove_noise_from_matrix(
  expression.matrix = expression_matrix,
  noise.thresholds = noise_thresholds,
  add.threshold = TRUE,          # Add threshold to entries
  remove.noisy.features = TRUE   # Remove features below threshold in all samples
)
```

## Advanced Features
- **Method Optimization**: To find the best thresholding method, use `calculate_noise_threshold_method_statistics()`. It seeks to minimize the coefficient of variation across samples.
- **Window Optimization**: Use `optimise_window_length()` to find the most stable window size for similarity calculations.
- **BAM Approach**: If starting from alignment files, use `approach.for.similarity.calculation = "BAM"`. This requires a folder containing BAM files and a GRanges object (or BED/GTF file) for feature annotation.

## Tips for Success
- **Input Data**: Always use raw, un-normalized counts. `noisyr` relies on the raw distribution to identify technical noise.
- **Similarity Measures**: Pearson correlation is standard, but you can view all available metrics (distances and correlations) using `get_methods_correlation_distance()`.
- **Threshold Methods**: View available quantification methods with `get_methods_calculate_noise_threshold()`.
- **Downstream Impact**: Denoising typically reduces the number of false-positive differentially expressed genes and "tightens" volcano plots by removing low-abundance "whiskers."

## Reference documentation
- [noisyR count matrix approach workflow](./references/vignette_noisyr_counts.Rmd)