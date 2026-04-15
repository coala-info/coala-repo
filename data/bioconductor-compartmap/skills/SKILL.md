---
name: bioconductor-compartmap
description: This tool infers higher-order chromatin structure and A/B compartments from single-cell RNA-seq, ATAC-seq, and DNA methylation data. Use when user asks to infer chromatin domains, generate denoised interaction maps using Random Matrix Theory, or visualize A/B compartment profiles from genomic signals.
homepage: https://bioconductor.org/packages/3.8/bioc/html/compartmap.html
---

# bioconductor-compartmap

name: bioconductor-compartmap
description: Inference of higher-order chromatin structure (A/B compartments) from scRNA-seq, scATAC-seq, and methylation arrays. Use this skill to perform single-cell or group-level chromatin domain inference, generate interaction maps via Random Matrix Theory denoising, and visualize A/B compartment profiles.

# bioconductor-compartmap

## Overview
The `compartmap` package enables the direct inference of higher-order chromatin structure (A/B compartments) from various genomic data types, including single-cell RNA-seq, single-cell ATAC-seq, and DNA methylation arrays. It utilizes shrinkage estimators and Random Matrix Theory (RMT) to denoise correlation matrices, allowing for sample-level or cell-level chromatin state analysis where traditional Hi-C data might be unavailable.

## Core Workflows

### 1. Data Preparation
The package primarily works with `RangedSummarizedExperiment` objects.

*   **From BigWigs (scRNA-seq):** Use `importBigWig` to bin signals (e.g., 1kb bins).
*   **From Counts (scATAC/scRNA):** Ensure the object has `rowRanges` populated.
*   **Transformation:** For scRNA-seq, apply TF-IDF transformation before compartment inference.

```r
library(compartmap)
# TF-IDF for scRNA-seq
tfidf_matrix <- transformTFIDF(assay(se_object, "counts"))
assay(se_object, "counts") <- t(tfidf_matrix)
```

### 2. Inferring A/B Compartments
The `scCompartments` function is the primary interface for single-cell/modern workflows, while `getCompartments` is often used for bulk ATAC or methylation arrays.

*   **Group-level:** Set `group = TRUE` to aggregate signals.
*   **Single-cell level:** Set `group = FALSE`. Use `bootstrap = TRUE` to estimate sign coherence.

```r
# Single-cell inference with bootstrapping
comp_results <- scCompartments(
  se_object,
  chr = "chr14",
  res = 1e6,
  group = FALSE,
  bootstrap = TRUE,
  genome = "hg19",
  assay = "rna"
)

# Fix sign coherence (flip discordant domains)
fixed_comp <- fixCompartments(comp_results, min.conf = 0.8)
```

### 3. Interaction Maps (RMT Denoising)
To generate "plaid-like" interaction maps similar to Hi-C, use Random Matrix Theory denoising on correlation matrices.

```r
rmt_matrix <- getDenoisedCorMatrix(
  se_object,
  res = 1e6,
  chr = "chr14",
  iter = 2,
  assay = "rna"
)

plotCorMatrix(rmt_matrix, uppertri = TRUE)
```

### 4. Visualization and Analysis
*   **Plotting:** Use `plotAB` to visualize the eigenscores. Positive scores typically represent 'A' (open) compartments, and negative scores represent 'B' (closed) compartments.
*   **Inflections:** Extract boundaries where chromatin transitions between states.

```r
# Plot with confidence intervals from bootstrap
plotAB(fixed_comp[[1]], chr = "chr14", with.ci = TRUE)

# Get domain boundaries
inflections <- getDomainInflections(fixed_comp[[1]], res = 1e6)
```

## Tips for Success
*   **Genome Assembly:** Ensure the `genome` argument (e.g., "hg19", "hg38") matches your input data coordinates.
*   **Resolution:** 1Mb (`1e6`) is the standard resolution for compartment inference, but it can be adjusted based on data sparsity.
*   **Sign Inversion:** Like Hi-C, the sign of the eigenvector is arbitrary. If the plot appears inverted relative to known open/closed regions, use `reverse = TRUE` in `plotAB`.
*   **Memory:** Processing many cells with bootstrapping can be memory-intensive; consider subsetting cells or processing by chromosome.

## Reference documentation
- [Direct inference of higher-order chromatin structure](./references/compartmap.Rmd)
- [A/B compartment inference from ATAC-seq and methylation arrays](./references/compartmap_vignette.md)