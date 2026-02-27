---
name: bioconductor-multistateqtl
description: This tool analyzes multi-state Quantitative Trait Loci (QTL) summary statistics across different conditions or tissues using the QTLExperiment framework. Use when user asks to process QTL data, simulate multi-state datasets, impute missing values, call significance across states, or visualize sharing patterns using heatmaps and UpSet plots.
homepage: https://bioconductor.org/packages/release/bioc/html/multistateQTL.html
---


# bioconductor-multistateqtl

name: bioconductor-multistateqtl
description: Expert guidance for using the multistateQTL R package to analyze multi-state QTL (Quantitative Trait Loci) data. Use this skill when you need to process, simulate, or visualize QTL summary statistics across multiple conditions (states), including missing data imputation, significance calling, and categorization of global vs. unique effects.

## Overview

The `multistateQTL` package is designed for the analysis of QTL summary statistics across multiple states (e.g., tissues, cell types, or environmental conditions). It utilizes the `QTLExperiment` (QTLE) object class, which extends `SummarizedExperiment`. The package provides tools for data simulation, handling missing values, multi-test correction, and visualizing sharing patterns between states.

## Core Workflow

### 1. Data Loading and Initialization
Data is typically imported from summary statistic files into a `QTLExperiment` object.

```r
library(QTLExperiment)
library(multistateQTL)

# Example: Loading from a data frame of paths
input <- data.frame(
    state = c("lung", "spleen"),
    path = c("path/to/lung_qtl.tsv", "path/to/spleen_qtl.tsv")
)

qtle <- sumstats2qtle(input, feature_id="gene_id", variant_id="snp_id", 
                      betas="beta", errors="se", pvalues="pvalue")
```

### 2. Handling Missing Data
Missing values (NAs) are common in multi-state datasets. Use `getComplete` to filter and `replaceNAs` to impute.

- `getComplete(qtle, n=0.5)`: Keeps rows with data in at least 50% of states.
- `replaceNAs(qtle, method="zero")`: Replaces NAs with 0 (default) or row means/medians.

### 3. Simulation
Useful for benchmarking or power analysis. Parameters can be estimated from real data using `qtleEstimate`.

```r
# Estimate parameters from real data
params <- qtleEstimate(qtle, threshSig=0.05, threshNull=0.5)

# Simulate data with specific proportions
sim <- qtleSimulate(nTests=1000, nStates=5, global=0.2, multi=0.4, unique=0.2)
```

### 4. Significance Calling
The `callSignificance` function supports single-threshold or two-step approaches (e.g., using `lfsr` or `pvalues`).

```r
# Simple threshold
sim <- callSignificance(sim, assay="lfsrs", thresh=0.05)

# Two-step threshold (more flexible)
sim <- callSignificance(sim, mode="simple", assay="lfsrs", 
                        thresh=0.001, secondThresh=0.01)
```

### 5. Categorization and Metrics
Identify whether a QTL is global, multi-state, or unique.

- `runTestMetrics(qtle)`: Adds `qtl_type` (global, multistate, unique) to `rowData`.
- `runPairwiseSharing(qtle)`: Calculates sharing between all pairs of states.

## Visualization

The package provides several plotting functions for global patterns:

- `plotPairwiseSharing(qtle)`: Heatmap of sharing between states.
- `plotUpSet(qtle)`: UpSet plot showing intersections of significant hits.
- `plotCompareStates(qtle, x="State1", y="State2")`: Scatter plot comparing effect sizes between two states.
- `plotQTLClusters(qtle)`: Heatmap of effect sizes (betas) across states.
- `plotSimulationParams(params)`: Visualizes the gamma distributions used for simulation.

## Tips for Success
- **Object Structure**: Remember that `QTLExperiment` stores statistics in assays (`betas`, `errors`, `pvalues`, `lfsrs`). Access them using `betas(qtle)`, etc.
- **Top Hits**: Use `getTopHits(qtle, assay="lfsrs", mode="state")` to reduce the dataset to the most significant association per feature before plotting.
- **Integration**: `multistateQTL` works well with `mashr`. After running `mashr`, you can import the results back into the `QTLE` object for downstream visualization.

## Reference documentation
- [multistateQTL: Orchestrating multi-state QTL analysis in R](./references/multistateQTL.md)