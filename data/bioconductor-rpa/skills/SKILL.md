---
name: bioconductor-rpa
description: This tool implements the Robust Probabilistic Averaging algorithm for probe-level preprocessing and summarization of oligonucleotide microarrays. Use when user asks to estimate probe-specific affinity and noise, preprocess Affymetrix or HITChip microarray data, or perform scalable gene expression summarization for large-scale datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/RPA.html
---

# bioconductor-rpa

name: bioconductor-rpa
description: Robust Probabilistic Averaging (RPA) for probe-level preprocessing of oligonucleotide microarrays. Use when analyzing Affymetrix gene expression arrays or phylogenetic microarrays (HITChip) to estimate probe-specific affinity and noise, especially for large-scale microarray atlases where scalability is required.

# bioconductor-rpa

## Overview

The RPA package implements the Robust Probabilistic Averaging (RPA) algorithm, a probabilistic model for the multi-probe analysis of oligonucleotide microarrays. It provides data-driven estimates of probe-specific affinity and noise, allowing for more accurate gene expression summaries than standard methods like RMA. It is specifically designed to be fully scalable, making it suitable for processing tens of thousands of samples through an online learning implementation.

## Installation

Install the package using BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RPA")
```

## Typical Workflow

### 1. Load Data
RPA typically works with `AffyBatch` objects for standard Affymetrix arrays.

```r
library(RPA)
library(affydata)
data(Dilution)
```

### 2. Standard RPA Preprocessing
Use the `rpa` function to perform the complete preprocessing pipeline (background correction, normalization, and summarization).

```r
# Run RPA with default settings
# This returns an ExpressionSet object
eset <- rpa(Dilution)

# Access expression values
exprs_data <- exprs(eset)
```

### 3. Large-scale (Online) Processing
For very large datasets that do not fit in memory, use the online version which processes data in batches.

```r
# List CEL files
cel.files <- list.celfiles(path_to_data, full.names = TRUE)

# Run online RPA
# This is memory-efficient for thousands of samples
eset_online <- rpa.online(cel.files)
```

### 4. Advanced Configuration
You can customize the probabilistic model parameters, such as the prior for probe noise or the number of iterations.

```r
# Example with custom priors and epsilon
eset_custom <- rpa(Dilution, 
                   priors = list(alpha = 1, beta = 1),
                   epsilon = 1e-2)
```

## Key Functions

- `rpa()`: Main wrapper for standard preprocessing. Performs background correction (RMA), normalization (quantile), and RPA summarization.
- `rpa.online()`: Scalable version for large microarray collections.
- `estimate.affinities()`: Specifically estimate probe-specific affinity parameters.
- `rpa.summarize()`: Perform only the RPA summarization step on pre-normalized probe-level data.

## Tips and Best Practices

- **Memory Management**: For datasets exceeding 100-200 samples, prefer `rpa.online` to avoid memory exhaustion.
- **Comparison**: RPA is often compared to RMA. While RMA assumes equal noise for all probes in a probeset, RPA learns which probes are more reliable and weights them accordingly.
- **HITChip Data**: For phylogenetic microarrays, ensure you use the appropriate wrappers or mapping files compatible with the RPA probabilistic model.
- **Parallelization**: RPA can be computationally intensive; ensure your R environment is configured to use available cores if the specific implementation supports it (check `mc.cores` parameters in sub-functions).

## Reference documentation

- [Robust Probabilistic Averaging (RPA)](./references/RPA.md)