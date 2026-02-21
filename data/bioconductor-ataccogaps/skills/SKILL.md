---
name: bioconductor-ataccogaps
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.16/bioc/html/ATACCoGAPS.html
---

# bioconductor-ataccogaps

## Overview
ATACCoGAPS is a specialized extension of the CoGAPS (Coordinated Gene Association in Pattern Sets) algorithm tailored for single-cell ATAC-sequencing (scATAC-seq) data. It utilizes Bayesian Nonnegative Matrix Factorization (NMF) to decompose a peak-by-cell or motif-by-cell count matrix into two lower-dimensional matrices:
1.  **Amplitude (A) Matrix**: Represents feature weights (e.g., peaks or motifs) for each latent pattern.
2.  **Pattern (P) Matrix**: Represents sample weights (cells) for each latent pattern.

This decomposition allows researchers to identify biological processes driving chromatin accessibility differences across cell populations.

## Core Workflow

### 1. Data Preprocessing
Before running CoGAPS, data should be filtered for sparsity. The package provides `dataSubsetBySparsity()` to remove highly sparse cells and peaks (e.g., >99% zeros).

### 2. Setting Parameters
Use `CogapsParams()` to configure the NMF run. Key arguments for scATAC-seq:
*   `nPatterns`: Number of latent spaces to learn.
*   `nIterations`: Number of Gibbs sampling steps (typically 10,000+).
*   `sparseOptimization`: Set to `TRUE` for scATAC-seq data.
*   `distributed`: Set to `"genome-wide"` if features (peaks) >> samples (cells), or `"single-cell"` if cells >> peaks.

```r
params <- CogapsParams(
    nPatterns = 7, 
    nIterations = 10000, 
    sparseOptimization = TRUE, 
    distributed = "genome-wide",
    geneNames = peak_names,
    sampleNames = cell_names
)
```

### 3. Running CoGAPS
Execute the factorization using the `CoGAPS()` function.
```r
result <- CoGAPS(data = count_matrix, params = params, nThreads = 4)
```

### 4. Visualization and Interpretation
*   **Pattern Weights**: Visualize how patterns align with cell types using `cgapsPlot()` or `heatmapPatternMatrix()`.
*   **Statistical Association**: Use `pairwise.wilcox.test()` on the sample factors (Pattern matrix) to identify which cell types are significantly associated with a specific pattern.
*   **Unsupervised Clustering**: If cell labels are unknown, use `patternMarkerCellClassifier(result)` to assign cells to patterns.

### 5. Downstream Analysis
*   **Pattern Markers**: Identify peaks most characteristic of a pattern using the `patternMarker` statistic. Visualize with `heatmapPatternMarkers()`.
*   **Pathway Analysis**: Map pattern-specific peaks to genes using `genePatternMatch()` and test for enrichment (e.g., MSigDB Hallmark sets) using `pathwayMatch()`.
*   **Motif Analysis**: Match pattern-specific peaks to DNA motifs and Transcription Factors (TFs) using `simpleMotifTFMatch()`.
*   **Gene Accessibility**: Check the accessibility of specific TFs across cell types using `geneAccessibility()` and `foldAccessibility()`.

## Tips for Success
*   **Parallelization**: Use the `nThreads` argument in `CoGAPS()` to speed up the Bayesian sampling process.
*   **Memory Management**: scATAC-seq matrices are large; ensure you are using sparse matrix objects (e.g., `dgCMatrix`) where possible.
*   **Pattern Selection**: Choosing `nPatterns` is often iterative. Start with a number close to the expected number of cell types or biological states.

## Reference documentation
- [ATACCoGAPS Vignette (Rmd)](./references/ATACCoGAPS.Rmd)
- [ATACCoGAPS Documentation (md)](./references/ATACCoGAPS.md)