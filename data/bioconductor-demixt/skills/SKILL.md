---
name: bioconductor-demixt
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DeMixT.html
---

# bioconductor-demixt

name: bioconductor-demixt
description: Transcriptomic deconvolution of heterogeneous tumor samples using the DeMixT R package. Use this skill to estimate component-specific proportions (tumor, stroma, immune) and reconstitute individual expression profiles from mixed transcriptomic data (two or three components).

# bioconductor-demixt

## Overview
DeMixT is a frequentist-based deconvolution method for transcriptomic data from mixed samples. Unlike many methods that only provide proportions, DeMixT estimates both the proportions of each component (e.g., Tumor, Normal 1, Normal 2) and the component-specific expression profiles for each individual sample. It supports two-component (Tumor-Normal) and three-component (Tumor-Stroma-Immune) models.

## Core Workflow

### 1. Data Preparation
DeMixT requires raw (non-log) expression data.
- **Mixed Samples (data.Y)**: The observed expression matrix from tumor tissues.
- **Reference Samples (data.N1, data.N2)**: Expression matrices from known components (e.g., matched or unmatched normal/stromal/immune tissues).
- **Preprocessing**: Use `DeMixT_preprocessing` to filter genes based on standard deviation to improve stability.

```r
# Example Preprocessing
preprocessed_data = DeMixT_preprocessing(CountMatrix, Normal.id, Tumor.id, 
                                         selected.genes = 9000)
PRAD_filter = preprocessed_data$count.matrix
```

### 2. Proportion Estimation
The primary function `DeMixT` handles the full pipeline. It defaults to the `GS` (Gene Selection) method, which uses profile likelihood.

```r
library(DeMixT)
library(SummarizedExperiment)

# Prepare data objects
data.Y = SummarizedExperiment(assays = list(counts = PRAD_filter[, Tumor.id]))
data.N1 = SummarizedExperiment(assays = list(counts = PRAD_filter[, Normal.id]))

# Run Deconvolution
res = DeMixT(data.Y = data.Y,
             data.N1 = data.N1,
             gene.selection.method = "GS",
             nspikein = 5,           # Number of simulated normal samples
             ngene.selected.for.pi = 1000,
             nthread = 8)            # Parallel computing (Linux/Windows recommended)
```

### 3. Interpreting Results
The output object contains:
- `res$pi`: A matrix of estimated proportions. For 2-component, `res$pi[2, ]` is the Tumor Proportion (PiT).
- `res$ExprT`: Reconstituted expression profiles for the unknown (Tumor) component.
- `res$ExprN1`: Reconstituted expression profiles for the N1 component.

### 4. Advanced Functions
- `DeMixT_GS`: Standalone function for proportion estimation using profile likelihood gene selection.
- `DeMixT_DE`: Standalone function for proportion estimation using differential expression gene selection (faster, better for sparse data).
- `DeMixT_S2`: Used to deconvolve expression profiles if proportions (`pi`) are already known.

## Key Parameters and Tips
- **Spike-ins**: Setting `nspikein` (e.g., 5-50) helps correct for bias when tumor proportions are skewed toward the high end.
- **Gene Selection**: For `DeMixT_GS`, testing a range of `ngene.selected.for.pi` (e.g., 500, 1000, 1500) and choosing the one with the highest average pairwise correlation across different spike-in settings is recommended.
- **Platform Note**: OpenMP parallelization is not supported on R 4.0+ for macOS; use Linux for large datasets to utilize `nthread`.
- **Input Scale**: Ensure data is on the raw scale (counts or TPM), not log-transformed, as the model assumes a log-normal distribution internally.

## Reference documentation
- [DeMixT Vignette](./references/demixt.md)