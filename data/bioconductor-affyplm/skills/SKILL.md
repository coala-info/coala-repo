---
name: bioconductor-affyplm
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/affyPLM.html
---

# bioconductor-affyplm

name: bioconductor-affyplm
description: Expert guidance for the affyPLM Bioconductor package. Use this skill to fit Probe Level Models (PLM) to Affymetrix GeneChip data, perform model-based quality assessment (RLE, NUSE, pseudo-images), generate MA-plots for AffyBatch/ExpressionSet objects, and compute expression measures using the flexible threestep framework.

## Overview

The `affyPLM` package provides advanced tools for the analysis of Affymetrix oligonucleotide arrays. Its core functionality revolves around fitting Probe Level Models (PLM) using robust M-estimation (iteratively re-weighted least squares). This allows for detailed quality control diagnostics and flexible expression summarization that goes beyond standard RMA.

## Core Workflows

### 1. Fitting Probe Level Models (PLM)
The primary function is `fitPLM()`, which fits a model to probe-intensity data on a probeset-by-probeset basis.

```r
library(affyPLM)
library(affydata)
data(Dilution)

# Fit the default RMA-style model (chip effects + probe effects)
Pset <- fitPLM(Dilution)

# Access chip-level parameter estimates (expression values) and SEs
chip_coefs <- coefs(Pset)
chip_se <- se(Pset)

# Access probe-level effects
probe_coefs <- coefs.probe(Pset)
```

### 2. Quality Assessment Diagnostics
`affyPLM` is the standard tool for model-based QC.

*   **Pseudo-images**: Visualize weights or residuals to find spatial artifacts.
    ```r
    # Weights image (green = low weight/potential artifact)
    image(Pset, which=1, type="weights")
    # Residuals image (red = positive, blue = negative)
    image(Pset, which=1, type="resids")
    ```
*   **Relative Log Expression (RLE)**: Compares expression of a probeset on one array to the median across all arrays.
    ```r
    RLE(Pset, main="RLE Plot")
    stats_rle <- RLE(Pset, type="stats")
    ```
*   **Normalized Unscaled Standard Errors (NUSE)**: Standardizes SEs across arrays. High NUSE values indicate low-quality arrays.
    ```r
    NUSE(Pset, main="NUSE Plot")
    stats_nuse <- NUSE(Pset, type="stats")
    ```

### 3. Advanced MA-plots
The `MAplot()` function in `affyPLM` is more powerful than the base `affy` version, supporting `AffyBatch`, `ExpressionSet`, and `PLMset` objects.

```r
# Compare all arrays to a synthetic median reference
MAplot(Dilution)

# Use smoothScatter for large datasets
MAplot(Dilution, plot.method="smoothScatter")

# Compare specific arrays to a specific reference
MAplot(Dilution, which=c(2,3), ref=1)
```

### 4. The Threestep Framework
The `threestep()` function allows you to mix and match background correction, normalization, and summarization methods.

```r
# Custom pipeline: MAS background, Quantile norm, Tukey Biweight summary
eset <- threestep(Dilution, 
                  background.method = "MAS", 
                  normalize.method = "quantile", 
                  summary.method = "tukey.biweight")
```

## Advanced Model Specification
You can specify custom models in `fitPLM()` using a formula syntax. Reserved words include `samples`, `probes`, and `probe.type`.

*   **Include MM probes**: `PMMM ~ -1 + samples + probes`
*   **Treatment effects**: `PM ~ -1 + treatment + probes` (where `treatment` is in `pData(Dilution)`)
*   **No probe effects**: `PM ~ -1 + samples`

## Reference documentation
- [Fitting Probe Level Models](./references/AffyExtensions.md)
- [Advanced MA-plots](./references/MAplots.md)
- [Model Based QC Assessment](./references/QualityAssess.md)
- [The Threestep Function](./references/ThreeStep.md)