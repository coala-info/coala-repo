---
name: bioconductor-scsr
description: The scsR package identifies and mitigates off-target effects in genome-wide siRNA screens caused by seed sequence biases. Use when user asks to model seed-based biases, correct siRNA screen scores, visualize seed effects, or benchmark screen results against functional enrichments.
homepage: https://bioconductor.org/packages/3.8/bioc/html/scsR.html
---


# bioconductor-scsr

## Overview
The `scsR` (Seed Correction for siRNA) package is designed to identify and mitigate off-target effects in genome-wide siRNA screens. These effects, often caused by the siRNA seed sequence acting in a miRNA-like fashion, can lead to high false-positive rates. `scsR` provides tools to model and correct these effects, visualize seed-based biases, and benchmark the results against other screens or functional enrichments.

## Data Preparation
To use `scsR`, your data must be in a data frame with the following columns:
- `GeneID`: Gene identifier (Symbol or ID).
- `siRNA_seq`: The sequence of the siRNA (guide/antisense strand).
- `score`: The numerical result of the screen (typically z-scores).

If you have the **target sequence** instead of the siRNA sequence, use `transcribe_seqs()` to convert it to the antisense strand.

## Basic Workflow

### 1. Load and Preprocess Data
Ensure your data is consistent and handle any replicates by taking the median score.

```r
library(scsR)

# Load your data
# data <- read.table("your_data.txt", header=TRUE, stringsAsFactors=FALSE)

# Check for inconsistencies
data <- check_consistency(data)

# Handle replicates (for unpooled libraries)
data <- median_replicates(data)

# Extract the 7-mer seed sequence (nucleotides 2-8)
data <- add_seed(data)
```

### 2. Seed Analysis
Analyze the impact of specific seeds across the entire screen.

```r
# Analyze seeds and map to miRBase if available
# data(miRBase_20) # Example miRBase data
seeds_result <- seeds_analysis(data, miRBase = miRBase_20)

# For screens where high scores are the "hits", set enhancer = TRUE
# seeds_result <- seeds_analysis(data, enhancer = TRUE)
```

### 3. Correcting Off-Target Effects
There are two primary methods for correction:

**Method A: Seed Correction (Additive Model)**
This method adjusts the scores based on the average effect of the seed.
```r
# For unpooled libraries
screen_corrected <- seed_correction(data)

# For pooled libraries (e.g., Dharmacon)
# screen_corrected_pool <- seed_correction_pooled(data_pooled)
```

**Method B: Seed Removal**
This method discards oligos that possess seeds with a strong phenotypic effect.
```r
screen_filtered <- seed_removal(data)
```

## Visualization
`scsR` provides several functions to visualize the distribution and impact of seeds:

*   **`plot_screen_hits(df)`**: Shows the top hits and the associated seed effects.
*   **`plot_effective_seeds_head(df)`**: Displays the most influential seeds compared to a randomized control.
*   **`plot_seeds_oligo_count(df)`**: Shows how many oligos share each seed.
*   **`plot_seed_score_sd(df)`**: Visualizes the relationship between average seed score and standard deviation.

## Benchmarking
To validate the effectiveness of the correction, you can compare results against a second independent screen or perform enrichment analysis.

### Comparing Shared Hits
```r
# Compare top 400 hits between uncorrected, RSA-ranked, and scsR-corrected data
benchmark_shared_hits(
  glA = list(
    uncorrected = arrange(add_rank_col(data), median)$GeneID,
    corrected = arrange(add_rank_col(screen_corrected), median)$GeneID
  ),
  glB = list(other_screen_data$GeneID),
  title = "Comparison of Hits"
)
```

### Enrichment Heatmap
Compare the enrichment of GO terms or KEGG pathways before and after correction.
```r
em <- enrichment_heatmap(
  list(data$GeneID, screen_corrected$GeneID),
  list("Before Correction", "After scsR"),
  enrichmentType = "Process",
  fdr_threshold = 0.01,
  limit = 400
)
```

## Reference documentation
- [scsR](references/scsR.md)