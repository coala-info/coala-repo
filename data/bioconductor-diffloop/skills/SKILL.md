---
name: bioconductor-diffloop
description: The bioconductor-diffloop package provides tools for the identification, filtering, and visualization of differential chromatin loops from genomic interaction data. Use when user asks to identify differential looping between conditions, filter loops by genomic features, or annotate chromatin interactions with gene symbols.
homepage: https://bioconductor.org/packages/3.6/bioc/html/diffloop.html
---

# bioconductor-diffloop

## Overview
The `diffloop` package provides a suite of tools for the analysis of chromatin loops. It is designed to handle loop data from various sources, facilitating the identification of differential looping between conditions, filtering loops based on genomic features, and visualizing interactions. It primarily utilizes the `loops` class object to store interaction coordinates and counts.

## Core Workflow

### 1. Data Import and Object Creation
`diffloop` typically starts with importing interaction data (e.g., from Mango or other peak callers).

```r
library(diffloop)

# Import from BEDPE or specific caller outputs
# Example: Importing Mango-processed data
files <- c("sample1.mango", "sample2.mango")
samples <- c("Control", "Treatment")
lps <- loopsMake(files, samples)

# For ChIA-PET or similar formats
# lps <- loopsMake.mango(bedpe_files)
```

### 2. Filtering and Preprocessing
Refine the loop set by filtering based on width, count, or genomic location.

```r
# Filter by loop width (e.g., between 10kb and 1Mb)
lps <- filterLoops(lps, width > 10000 & width < 1000000)

# Filter by minimum counts
lps <- filterLoops(lps, rowSums(counts(lps)) > 5)

# Remove loops on specific chromosomes
lps <- rmChr(lps, "chrM")
```

### 3. Differential Looping Analysis
`diffloop` integrates with `edgeR` and `DESeq2` for robust differential analysis.

```r
# Using the internal wrapper for differential calling
# groups should be a factor defining conditions
res <- quick_diffloop(lps, groups = c("A", "A", "B", "B"))

# Accessing results
# res contains p-values and fold changes for each loop
diff_loops <- res[res$padj < 0.05, ]
```

### 4. Annotation and Integration
Associate loops with genes or enhancers using `GenomicRanges`.

```r
# Annotate loops with gene symbols or promoters
# Requires a GRanges object of features
# lps <- annotateLoops(lps, features = genes_gr)

# Find loops anchored at specific regions
# loops_at_promoters <- subsetByOverlaps(lps, promoters_gr)
```

### 5. Visualization
Visualize loops and their intensities across samples.

```r
# Plotting loop counts
plotLoop(lps, loop_index = 1)

# Summary plots
plotSizeDistribution(lps)
```

## Tips and Best Practices
- **Object Structure**: The `loops` object contains `@anchors` (GRanges), `@interactions` (matrix of indices), and `@counts` (matrix). Use `anchors(lps)`, `interactions(lps)`, and `counts(lps)` to access these components.
- **Normalization**: When performing differential analysis, ensure you account for library size. `quick_diffloop` handles standard normalization, but manual normalization can be applied to the `@counts` slot.
- **Memory Management**: For very large Hi-C datasets, pre-filter loops by distance or significance before creating the `loops` object to save memory.
- **Coordinate Systems**: Ensure your genome build (e.g., hg19, mm10) matches between your loop data and any annotation GRanges used.

## Reference documentation
- [diffloop: Identifying differential DNA loops from chromatin topology data](./references/diffloop.Rmd)