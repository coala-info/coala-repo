---
name: bioconductor-spatzie
description: This tool identifies statistically significant spatial co-enrichment of transcription factor binding motifs in spatial transcriptomics or chromatin interaction data. Use when user asks to identify TF-TF co-localization, analyze spatial genomic patterns, or test for non-random spatial associations between genomic features.
homepage: https://bioconductor.org/packages/release/bioc/html/spatzie.html
---


# bioconductor-spatzie

name: bioconductor-spatzie
description: Identification of statistically significant spatial co-enrichment of transcription factor binding motifs in spatial transcriptomics data or chromatin interaction data. Use this skill when analyzing spatial genomic patterns, identifying TF-TF co-localization, or testing for non-random spatial associations between genomic features.

# bioconductor-spatzie

## Overview
The `spatzie` package provides methods for identifying statistically significant spatial co-enrichment of transcription factor (TF) binding motifs. It is primarily designed to analyze data where genomic features have spatial coordinates, such as spatial transcriptomics or 3D chromatin architecture data (e.g., Hi-C, ChIA-PET). It helps researchers determine if two TFs tend to bind near each other more often than expected by chance, accounting for the underlying spatial distribution of genomic elements.

## Typical Workflow

### 1. Data Preparation
The package typically works with `GenomicRanges` objects representing binding sites and spatial interaction data.

```r
library(spatzie)
library(GenomicRanges)

# Load motif occurrences (e.g., from FIMO or MOODS)
# motifs should be a GRanges object where names/metadata indicate the TF
```

### 2. Defining Neighborhoods
`spatzie` identifies co-enrichment within defined spatial neighborhoods.

```r
# Create a neighborhood list from interaction data
# interactions: a GInteractions object or similar spatial mapping
nhoods <- find_neighborhoods(interactions, distance_threshold = 50000)
```

### 3. Counting Motif Occurrences
Count how many times motifs appear within the defined neighborhoods.

```r
# Count motifs in neighborhoods
counts <- count_motifs(nhoods, motifs)
```

### 4. Statistical Testing for Co-enrichment
The core of the package is testing whether pairs of motifs are co-enriched.

```r
# Perform co-enrichment analysis
# method can be "hypergeometric" or "permutation"
results <- run_spatzie(counts, method = "hypergeometric")
```

### 5. Visualization and Interpretation
Visualize the significant interactions using heatmaps or dot plots.

```r
# Plot the co-enrichment matrix
plot_coenrichment(results, p_threshold = 0.05)
```

## Key Functions
- `find_neighborhoods`: Defines the spatial context for testing (e.g., anchor points in chromatin loops).
- `count_motifs`: Overlaps motif instances with the defined spatial neighborhoods.
- `run_spatzie`: The main wrapper for statistical testing.
- `filter_motifs`: Useful for removing low-frequency motifs before analysis to increase power.

## Tips for Success
- **Background Control**: Ensure your input motifs are filtered for quality. High false-positive rates in motif scanning will lead to noisy co-enrichment results.
- **Distance Thresholds**: When defining neighborhoods in 3D genomic data, the `distance_threshold` significantly impacts the number of identified co-enrichments.
- **Method Selection**: Use the `hypergeometric` test for speed during exploratory analysis, and consider the `permutation` test for more robust p-values if the genomic background is highly non-uniform.

## Reference documentation
- [spatzie Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/spatzie.html)