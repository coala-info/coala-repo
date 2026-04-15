---
name: bioconductor-reb
description: This tool identifies regional expression biases in gene expression data to detect genomic alterations such as amplifications or deletions. Use when user asks to identify chromosomal regions with expression biases, summarize expression data by genomic location, apply smoothing functions to expression profiles, or visualize regional biases using heatmaps and idiograms.
homepage: https://bioconductor.org/packages/3.8/bioc/html/reb.html
---

# bioconductor-reb

name: bioconductor-reb
description: Analysis of regional expression biases (REB) in gene expression data to identify genomic amplifications, deletions, or density changes. Use this skill when you need to: (1) Identify chromosomal regions with disproportionate positive or negative expression ratios, (2) Summarize expression data by chromosome, arm, or cytogenetic band, (3) Apply smoothing functions (moving binomial tests, lowess, supsmu) to expression profiles, and (4) Visualize regional biases using heatmaps or idiograms.

# bioconductor-reb

## Overview

The `reb` package is designed to identify regional expression biases in transcriptomic data. These biases often correlate with physical genomic alterations like copy number variations (CNVs). The package provides tools to subset expression data based on genomic locations and apply statistical summaries or smoothing techniques to highlight regions of interest. It integrates closely with the `idiogram` package for visualization.

## Core Workflow

### 1. Data Preparation and Mapping
To analyze expression by region, you must map probe/gene identifiers to genomic coordinates using a `chromLocation` object.

```r
library(reb)
library(idiogram)

# Build a chromLocation object for whole chromosomes
# 'annotation_pkg' is the metadata package for your platform (e.g., "hgu133plus2")
chr_loc <- buildChromLocation("annotation_pkg")

# For higher resolution (arms or bands), use buildChromMap
# Hs.arms and Hs.cytoband are provided data structures
data(Hs.arms)
arm_map <- buildChromMap("hgu133plus2", Hs.arms)
```

### 2. Basic Regional Summarization
Use `summarizeByRegion` to calculate summary statistics for defined genomic regions. This is useful for a quick overview of chromosome-level changes.

```r
# expr_matrix: log-transformed expression values
# ref: indices of samples to use as the baseline/reference
# vai.chr: a chromLocation object
mcr.sum <- summarizeByRegion(expr_matrix, vai.chr, ref = ref_indices)

# Handle multiple clones at the same locus to avoid artificial bias
mcr.sum <- summarizeByRegion(expr_matrix, vai.chr, ref = ref_indices, aggregate.by.loc = TRUE)
```

### 3. Advanced Smoothing (REB Prediction)
For higher resolution and noise reduction, use `smoothByRegion` (or the alias `reb`). This applies a smoothing function (default is a multiple span moving binomial test) across the genome.

```r
# Returns an ExpressionSet containing smoothed values
mcr.cset <- smoothByRegion(expr_matrix, vai.chr, ref = ref_indices)

# Alternative smoothing methods: "supsmu" or "lowess"
mcr.smoothed <- smoothByRegion(expr_matrix, vai.chr, method = "lowess")
```

### 4. Visualization
The package provides `regmap` for simple heatmaps and integrates with `idiogram` for chromosome-specific plots.

```r
# Simple regional heatmap
# .rwb is a built-in red-white-blue color scheme
regmap(mcr.sum, col = .rwb, scale = c(-3, 3))

# Detailed idiogram plot for a specific chromosome (e.g., Chromosome 5)
# 'data' should be the smoothed matrix from smoothByRegion
idiogram(smoothed_matrix, vai.chr, method = "m", chr = 5, dlim = c(-5, 5), type = "l")
```

## Tips and Best Practices
- **Reference Samples**: Ensure the `ref` argument correctly identifies control samples. If using two-color arrays where ratios are already computed, the reference handling may differ.
- **Filtering Noise**: When plotting, it is often helpful to mask values near zero (e.g., `data[abs(data) < 1.96] <- NA`) to highlight statistically significant regional biases.
- **Aggregation**: Always consider setting `aggregate.by.loc = TRUE` if your platform has high redundancy (many probes for one gene) to prevent single-gene fluctuations from appearing as regional biases.

## Reference documentation
- [reb package - Identification of Regional Expression Biases](./references/reb.md)