---
name: bioconductor-basics
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BASiCS.html
---

# bioconductor-basics

name: bioconductor-basics
description: Bayesian Analysis of Single-Cell Sequencing data (BASiCS) for normalization, technical noise quantification, and supervised downstream analyses. Use this skill to identify highly/lowly variable genes (HVG/LVG) within a single group of cells or to perform differential expression (DE) analysis (mean and variability) between two or more known groups of cells. It supports datasets with or without spike-in molecules.

## Overview

BASiCS is a Bayesian hierarchical model designed for supervised single-cell mRNA sequencing experiments. It simultaneously performs normalization and technical noise quantification to identify genes with heterogeneous expression. Unlike traditional tools that focus only on mean expression, BASiCS also quantifies cell-to-cell variability (over-dispersion) and residual over-dispersion (variability relative to a global mean-variance trend).

## Typical Workflow

### 1. Data Preparation
Data must be stored in a `SingleCellExperiment` object.

```r
library(BASiCS)
library(SingleCellExperiment)

# Case A: With Spike-ins
# Counts: matrix (biological + spike-in rows)
# Tech: logical vector (TRUE for spike-ins)
# SpikeInfo: data.frame (SpikeID, SpikeInput molecules)
Data <- newBASiCS_Data(Counts, Tech, SpikeInfo, BatchInfo = BatchVector)

# Case B: Without Spike-ins (Requires multiple batches)
Data <- SingleCellExperiment(
  assays = list(counts = Counts),
  colData = data.frame(BatchInfo = BatchVector)
)
```

### 2. Parameter Estimation (MCMC)
The `BASiCS_MCMC` function performs the heavy lifting. Recommended settings for publication are `N=20000`, `Thin=20`, and `Burn=10000`.

```r
# Regression = TRUE is the recommended default
Chain <- BASiCS_MCMC(
  Data = Data, 
  N = 1000, Thin = 10, Burn = 500, # Use higher values for real data
  WithSpikes = TRUE, 
  Regression = TRUE,
  PrintProgress = FALSE
)
```

### 3. Single Group Analysis (HVG/LVG Detection)
Identify genes with high or low biological variability.

```r
# HVG: >60% variability attributed to biological component
HVG <- BASiCS_DetectHVG(Chain, VarThreshold = 0.6, EFDR = 0.10)
# LVG: <20% variability attributed to biological component
LVG <- BASiCS_DetectLVG(Chain, VarThreshold = 0.2, EFDR = 0.10)

# View results
head(as.data.frame(HVG))
BASiCS_PlotVG(HVG)
```

### 4. Two-Group Analysis (Differential Expression)
Compare mean expression and variability between two conditions.

```r
# Requires two independent chains
Test <- BASiCS_TestDE(
  Chain1 = ChainGroup1, Chain2 = ChainGroup2,
  GroupLabel1 = "Cond1", GroupLabel2 = "Cond2",
  EpsilonM = log2(1.5), # Detect 50% change in mean
  EpsilonD = log2(1.5), # Detect 50% change in over-dispersion
  Offset = TRUE         # Recommended to adjust for mRNA content
)

# Plotting results
BASiCS_PlotDE(Test, Plots = c("MA", "Volcano"))

# Extracting data
de_mean <- as.data.frame(Test, Parameter = "Mean")
de_disp <- as.data.frame(Test, Parameter = "Disp")
```

## Implementation Tips

- **Convergence**: Always check MCMC convergence before downstream analysis. Acceptance rates displayed in the console should be around 0.44.
- **No-Spikes Mode**: If `WithSpikes = FALSE`, you must provide `BatchInfo` with at least two batches, as BASiCS uses a horizontal integration strategy.
- **Regression Mode**: Setting `Regression = TRUE` allows the calculation of *residual over-dispersion*, which identifies genes that are more (or less) variable than expected given their mean expression level.
- **Supervised Only**: BASiCS is designed for known groups (e.g., Case vs. Control). Do not use it for unsupervised clustering or cell-type discovery.

## Reference documentation

- [Introduction to BASiCS](./references/BASiCS.md)