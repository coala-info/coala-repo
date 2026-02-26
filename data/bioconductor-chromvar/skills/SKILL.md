---
name: bioconductor-chromvar
description: chromVAR analyzes sparse chromatin accessibility data by computing bias-corrected deviations in accessibility for genomic annotations like transcription factor motifs. Use when user asks to calculate motif accessibility deviations, analyze single-cell ATAC-seq data, or identify variable transcription factor motifs across samples.
homepage: https://bioconductor.org/packages/release/bioc/html/chromVAR.html
---


# bioconductor-chromvar

## Overview
`chromVAR` is designed to analyze sparse chromatin accessibility data by computing "deviations" in accessibility for specific genomic annotations (like transcription factor motifs). It accounts for technical biases such as GC content and average accessibility by comparing observed counts against a background set of peaks. It is particularly effective for single-cell ATAC-seq (scATAC-seq) data where sparsity is a major challenge.

## Core Workflow

### 1. Data Preparation
Load the package and required Bioconductor dependencies:
```R
library(chromVAR)
library(motifmatchr)
library(SummarizedExperiment)
library(BSgenome.Hsapiens.UCSC.hg19) # Or appropriate genome
```

### 2. Input Processing
`chromVAR` requires a `SummarizedExperiment` object containing a count matrix (peaks x cells).

*   **Read Peaks:** Use `getPeaks()` for BED files or `readNarrowpeaks()` for narrowPeak files.
*   **Get Counts:** Use `getCounts()` to generate a count matrix from BAM files.
*   **Add GC Bias:** Essential for background peak selection.
    ```R
    example_counts <- addGCBias(example_counts, genome = BSgenome.Hsapiens.UCSC.hg19)
    ```

### 3. Filtering
Filter low-quality cells and uninformative peaks to improve signal-to-noise ratio.
```R
# Filter samples based on library depth and fraction of reads in peaks
counts_filtered <- filterSamples(example_counts, min_depth = 1500, min_in_peaks = 0.15)

# Filter peaks to ensure at least one fragment exists across all samples
counts_filtered <- filterPeaks(counts_filtered, non_overlapping = TRUE)
```

### 4. Motif Matching
Identify which peaks contain specific motifs using `motifmatchr`.
```R
motifs <- getJasparMotifs()
motif_ix <- matchMotifs(motifs, counts_filtered, genome = BSgenome.Hsapiens.UCSC.hg19)
```

### 5. Computing Deviations
The core function `computeDeviations` calculates the bias-corrected accessibility deviations.
```R
# Computes both 'deviations' and 'z-scores'
dev <- computeDeviations(object = counts_filtered, annotations = motif_ix)

# Access results
dev_scores <- deviations(dev)
z_scores <- deviationScores(dev)
```

### 6. Variability and Visualization
Identify which motifs show the most variation across the dataset.
```R
# Compute variability
variability <- computeVariability(dev)
plotVariability(variability, use_plotly = FALSE)

# Dimensionality reduction (TSNE) based on deviations
tsne_results <- deviationsTsne(dev, threshold = 1.5, perplexity = 10)
plotDeviationsTsne(dev, tsne_results, annotation_name = "TEAD3")
```

## Key Functions Reference
*   `getCounts()`: Creates a `SummarizedExperiment` from BAM files.
*   `addGCBias()`: Adds GC content metadata to peaks (required for normalization).
*   `filterSamples()`: Removes low-quality cells (supports `shiny = TRUE` for interactive filtering).
*   `matchMotifs()`: Maps motifs to genomic coordinates in the peak set.
*   `computeDeviations()`: The main engine for calculating normalized accessibility scores.
*   `computeVariability()`: Ranks motifs by how much their accessibility varies across samples.

## Parallelization
`chromVAR` uses `BiocParallel`. Register a backend before running heavy computations:
```R
library(BiocParallel)
# For Linux/Mac:
register(MulticoreParam(workers = 8))
# For Windows:
register(SnowParam(workers = 4))
```

## Reference documentation
- [Introduction](./references/Introduction.md)