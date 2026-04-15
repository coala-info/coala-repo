---
name: bioconductor-demuxmix
description: demuxmix uses negative binomial regression mixture models to demultiplex single-cell RNA sequencing data labeled with hashtag oligonucleotides. Use when user asks to demultiplex HTO data, classify droplets as singlets or multiplets, or incorporate RNA content as a covariate to improve cell assignment accuracy.
homepage: https://bioconductor.org/packages/release/bioc/html/demuxmix.html
---

# bioconductor-demuxmix

## Overview

The `demuxmix` package provides a robust probabilistic framework for demultiplexing single-cell RNA sequencing data labeled with hashtag oligonucleotides (HTOs). Unlike simple threshold-based methods, `demuxmix` uses negative binomial regression mixture models. A key advantage is its ability to incorporate the number of detected genes per droplet as a covariate, leveraging the often-observed positive correlation between HTO counts and RNA content to improve classification accuracy, especially in datasets with high background noise.

## Core Workflow

### 1. Data Preparation
The package requires two main inputs:
- **HTO Count Matrix**: A matrix where rows are HTOs and columns are droplets.
- **RNA Metrics**: A numeric vector representing the number of detected genes (features with >0 counts) per droplet.

```r
library(demuxmix)

# Example: hto is a matrix, rna is a vector of gene counts
# Ensure empty droplets are removed before processing
dmm <- demuxmix(hto, rna = rna)
```

### 2. Classification
After fitting the models, use `dmmClassify` to assign droplets to samples.

```r
# Generate classification data frame
classLabels <- dmmClassify(dmm)

# Results include:
# HTO: The assigned sample (or comma-separated list for multiplets)
# Prob: Posterior probability of the assignment
# Type: singlet, multiplet, negative, or uncertain
```

### 3. Model Selection and Tuning
- **Model Types**: By default, `demuxmix` automatically chooses between `regression` (uses RNA info) and `naive` (HTO counts only) models based on which provides better separation. You can force a type using `model = "naive"` or `model = "regression"`.
- **Acceptance Probability (`pAcpt`)**: Controls the stringency of classification. Droplets with a posterior probability below this threshold are marked "uncertain".
  - Default is typically ~0.7-0.9.
  - Lower `pAcpt` to recover more cells at the cost of higher FDR.
  - Set `pAcpt(dmm) <- 0` to force classification of all droplets.

## Quality Control and Visualization

Effective demultiplexing requires verifying the model fit and the separation between positive and negative populations.

- **Histogram of Fits**: `plotDmmHistogram(dmm)`
  - Shows the HTO count distribution overlaid with the mixture model components (blue = negative, red = positive).
  - Look for bimodal distributions and minimal overlap.
- **Overlap Calculation**: `dmmOverlap(dmm)`
  - Quantifies the intersection between components. Values < 0.03 are excellent; > 0.05 may indicate high background or poor labeling.
- **Posterior Probabilities**: `plotDmmPosteriorP(dmm)`
  - Ideally, most droplets should have probabilities near 0 or 1.
- **Decision Boundaries**: `plotDmmScatter(dmm)`
  - Visualizes the HTO vs. RNA relationship and the 0.5 probability boundary.

## Summary and Error Estimation

The `summary()` function provides a high-level view of the demultiplexing performance, including estimated False Discovery Rates (FDR) for each class.

```r
summary(dmm)
# Provides: NumObs, RelFreq, MedProb, ExpFPs (Expected False Positives), and FDR
```

## Tips for Success
- **Rare Cell Pooling**: If pooling labeled cells with non-labeled cells (e.g., rare clinical samples), the non-labeled cells will be identified as the "negative" population.
- **High Sequencing Depth**: In very high-depth HTO libraries, the positive component may appear flat in histograms. Use `coord_cartesian(xlim = c(0, ...))` to zoom into the overlap region for better inspection.
- **Multiplet Detection**: `demuxmix` identifies multiplets where cells from *different* samples are in one droplet. It cannot detect multiplets from the *same* sample (which require genetic or other methods).

## Reference documentation
- [Demultiplexing oligonucleotide-labeled scRNA-seq data with demuxmix](./references/demuxmix.md)