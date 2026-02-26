---
name: bioconductor-deconvr
description: The deconvR package performs computational deconvolution of bulk omic samples to estimate cell-type proportions. Use when user asks to deconvolute bulk methylation or RNA-seq data, map WGBS data to probe IDs, identify signature matrices, or simulate cell mixtures for benchmarking.
homepage: https://bioconductor.org/packages/release/bioc/html/deconvR.html
---


# bioconductor-deconvr

## Overview
The `deconvR` package provides tools for the computational deconvolution of bulk omic samples. It is primarily designed for DNA methylation data but supports RNA-seq. It includes a built-in human methylome atlas (25 cell types), utilities to map WGBS data to probe IDs, and functions to simulate data for benchmarking.

## Core Functions

### 1. Deconvolution
The primary function `deconvolute` estimates cell-type proportions.
```r
library(deconvR)
# reference: dataframe with IDs and cell-type columns
# bulk: dataframe with IDs and sample columns
results <- deconvolute(reference = HumanCellTypeMethAtlas, 
                       bulk = my_bulk_data, 
                       model = "nnls") # Options: nnls, svr, qp, rlr

# Access results
proportions <- results$proportions
r_squared <- results$R_squared # Partial R-squared values
```

### 2. Mapping WGBS to Probes
To use Whole Genome Bisulfite Sequencing (WGBS) data with methylation atlases, map genomic coordinates to Illumina probe IDs.
```r
data("IlluminaMethEpicB5ProbeIDs")
# WGBS_data can be a GRanges or methylKit object
mapped_data <- BSmeth2Probe(probe_id_locations = IlluminaMethEpicB5ProbeIDs, 
                            WGBS_data = my_wgbs_granges,
                            multipleMapping = TRUE,
                            cutoff = 10)
```

### 3. Signature Matrix Management
You can extend the existing atlas with new cell types or find specific signatures.
```r
# Extend atlas with new samples
extended_atlas <- findSignatures(samples = new_samples, 
                                 sampleMeta = metadata, 
                                 atlas = HumanCellTypeMethAtlas,
                                 IDs = "IDs")

# Construct tissue-specific signature matrix
signatures <- findSignatures(samples = samples,
                             sampleMeta = meta,
                             atlas = atlas,
                             IDs = "IDs", 
                             tissueSpecCpGs = TRUE)
```

### 4. Simulation
Generate synthetic bulk samples to test deconvolution accuracy.
```r
sim_data <- simulateCellMix(numberOfSamples = 5, 
                            reference = HumanCellTypeMethAtlas)
bulk_sim <- sim_data$simulated
true_proportions <- sim_data$proportions
```

## Typical Workflow

1.  **Prepare Reference**: Load `data("HumanCellTypeMethAtlas")` or create a custom one using `findSignatures`.
2.  **Prepare Bulk Data**: 
    *   If using WGBS, use `BSmeth2Probe` to convert to probe-ID-based methylation values.
    *   Ensure the first column is named `IDs` (for methylation) or contains `Gene names` (for RNA-seq).
3.  **Run Deconvolution**: Use `deconvolute`. NNLS (non-negative least squares) is the default and generally recommended for methylation.
4.  **Evaluate**: Check the partial R-squared values. High R-squared indicates the deconvolution provides a better fit than a simple average of the reference atlas.

## Tips for Success
*   **ID Matching**: Ensure the `IDs` column in your bulk data matches the `IDs` in your reference atlas (e.g., Illumina cg IDs).
*   **RNA-seq**: When using RNA-seq, ensure your reference and bulk data are normalized and the `IDs` column contains matching gene symbols.
*   **Parallelization**: For large datasets, register a parallel backend using `doParallel` before running `deconvolute` or `findSignatures`.

## Reference documentation
- [deconvR : Simulation and Deconvolution of Omic Profiles](./references/deconvRVignette.md)
- [deconvR Vignette Source](./references/deconvRVignette.Rmd)