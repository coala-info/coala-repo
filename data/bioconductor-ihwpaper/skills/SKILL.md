---
name: bioconductor-ihwpaper
description: This package provides data, scripts, and workflows to reproduce the simulations and benchmarks from the Independent Hypothesis Weighting (IHW) publication. Use when user asks to reproduce IHW paper figures, benchmark multiple testing methods, perform IHW-Bonferroni FWER control, or conduct hQTL analysis with Benjamini-Yekutieli adjustments.
homepage: https://bioconductor.org/packages/release/data/experiment/html/IHWpaper.html
---


# bioconductor-ihwpaper

## Overview

The `IHWpaper` package is a companion experiment data package for the Independent Hypothesis Weighting (IHW) method. It contains the scripts, data subsets, and workflows used to generate the figures and simulations in the original IHW publication. It is primarily used for benchmarking, pedagogical demonstrations of multiple testing concepts (like the Grenander estimator or tdr), and reproducing complex workflows like hQTL analysis with Benjamini-Yekutieli (BY) adjustments.

## Core Workflows

### 1. Reproducing Paper Simulations
The package provides pre-computed results and simulation functions to compare IHW against other methods (BH, FDRreg, GBH, etc.).

```r
library(IHWpaper)
library(ggplot2)

# Load pre-computed null simulation results
null_file <- system.file("simulation_benchmarks/result_files", 
                         "ihw_null_simulation_benchmark.Rds", package = "IHWpaper")
null_df <- readRDS(null_file)

# Visualize FDR control across methods
ggplot(null_df, aes(x=alpha, y=FDR, col=fdr_method)) +
  geom_line() +
  geom_abline(linetype="dashed")
```

### 2. IHW-Bonferroni for FWER Control
While standard IHW focuses on FDR, `IHWpaper` demonstrates the application of IHW to Bonferroni corrections for Family-Wise Error Rate (FWER) control.

```r
# Example of IHW-Bonferroni logic
# Weights are learned to maximize power while maintaining FWER
# Typically involves using the IHW framework with a Bonferroni-adjusted alpha
alpha_fwer <- 0.05 / m_tests
# ihw() is then called with this adjusted alpha
```

### 3. Advanced hQTL Analysis (IHW-BY)
For dependencies or specific structures like hQTL data, the package demonstrates using IHW with the Benjamini-Yekutieli (BY) procedure.

```r
# Calculate the BY-adjusted alpha
m <- 15725016812 # Total hypotheses
alpha_by <- 0.01 / (log(m) + 1)

# Apply IHW with the adjusted alpha and pre-calculated m_groups
# m_groups is used when only a subset of small p-values is available
ihw_res <- ihw(pvalues_subset, groups_subset, alpha_by, 
               m_groups = m_groups_all, lambdas = 2000)
```

### 4. Visualizing Multiple Testing Concepts
The package includes helpers to visualize why IHW outperforms standard methods by looking at the True Discovery Rate (tdr) and p-value thresholds.

```r
# Compare BH vs IHW thresholds as a function of a covariate
# BH uses a flat threshold; IHW adapts to the covariate
# See references/tdr_pvalue_rejection_thresholds.md for implementation
```

## Key Functions and Data
- `analyze_dataset()`: Helper to run standard pipelines (e.g., DESeq2) on provided datasets like "bottomly".
- `du_ttest_sim()`: Generates simulated p-values and covariates based on t-tests.
- `system.file("extdata", ...)`: Accesses real-world data subsets (RNA-seq, Proteomics, hQTL) used in the paper.

## Reference documentation

- [BH explanation / visualization](./references/BH-explanation.md)
- [IHW-Bonferroni simulations](./references/IHW_bonferroni_simulations.md)
- [Explaining tdr](./references/explaining_tdr.md)
- [Grenander Estimator vs ECDF](./references/grenander_vs_ecdf.md)
- [hQTL analysis with IHW-BY](./references/hqtl_IHW_BY.md)
- [Real data examples (Main Figures)](./references/real_data_examples.md)
- [Real data examples: 1-fold weight function](./references/real_data_examples_single_curve.md)
- [Simulation Results](./references/simulations_vignette.md)
- [Stratified Histograms](./references/stratified_histograms.md)
- [tdr and pvalue rejection regions](./references/tdr_pvalue_rejection_thresholds.md)
- [Weights vs Independent Filtering](./references/weights_vs_filtering.md)