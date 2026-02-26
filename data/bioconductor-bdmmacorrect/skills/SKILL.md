---
name: bioconductor-bdmmacorrect
description: This tool performs Bayesian Dirichlet-multinomial regression meta-analysis for batch effect correction and taxon selection in microbiome data. Use when user asks to correct for batch effects in metagenomic read counts, identify microbial taxa associated with phenotypes, or perform variable selection while accounting for overdispersion and confounding variables.
homepage: https://bioconductor.org/packages/3.8/bioc/html/BDMMAcorrect.html
---


# bioconductor-bdmmacorrect

name: bioconductor-bdmmacorrect
description: Bayesian Dirichlet-multinomial regression meta-analysis (BDMMA) for batch effect correction and taxon selection in microbiome data. Use this skill when analyzing metagenomic read counts across multiple batches to identify taxa associated with phenotypes while controlling for batch-to-batch variation and overdispersion.

# bioconductor-bdmmacorrect

## Overview

The `BDMMAcorrect` package implements the Bayesian Dirichlet-multinomial regression meta-analysis (BDMMA) model. It is specifically designed for microbiome data, which often exhibits high dimensionality, sparsity, and overdispersion. The package allows researchers to simultaneously correct for batch effects and perform variable selection to identify microbial taxa associated with phenotypes (e.g., case vs. control) while accounting for confounding variables.

## Core Workflow

### 1. Data Preparation
The package requires data to be formatted as a `SummarizedExperiment` object.

```r
library(BDMMAcorrect)
library(SummarizedExperiment)

# Required components:
# 1. counts: Matrix of taxonomic read counts (Taxa as rows, Samples as columns)
# 2. col_data: DataFrame containing phenotypes and batch labels
# 3. mcols(col_data): Metadata indicating if variables are continuous (1L) or discrete (0L)

col_data <- DataFrame(main = main_vec, confounder = conf_vec, batch = batch_vec)
mcols(col_data)$continuous <- c(0L, 1L, 0L) # 0 for discrete, 1 for continuous

Microbiome_dat <- SummarizedExperiment(assays = list(counts = counts_matrix), 
                                       colData = col_data)
```

### 2. Visualizing Batch Effects
Use `VBatch` to perform Principal Coordinate Analysis (PCoA) and visualize composition differences across batches using Bray-Curtis or other distance metrics.

```r
# Visualize overall batch effects
fig <- VBatch(Microbiome_dat = Microbiome_dat, method = "bray")
print(fig)

# Visualize batch effects stratified by a main variable (e.g., Case/Control)
fig_list <- VBatch(Microbiome_dat = Microbiome_dat, 
                   main_variable = colData(Microbiome_dat)$main, 
                   method = "bray")
print(fig_list[[1]]) # Plot for group 1
```

### 3. Running the BDMMA Model
The `BDMMA` function performs the MCMC sampling. It automatically handles variable selection using a spike-and-slab prior.

```r
# Run MCMC
# burn_in: Number of initial iterations to discard
# sample_period: Number of iterations for posterior estimation
output <- BDMMA(Microbiome_dat = Microbiome_dat, 
                burn_in = 5000, 
                sample_period = 5000)
```

### 4. Interpreting Results
The output object contains posterior estimates and selection results.

*   **Selected Taxa**: `output$selected.taxa` lists taxa that exceed the Posterior Inclusion Probability (PIP) threshold (default 0.5) and control the Bayesian False Discovery Rate (bFDR).
*   **Parameter Summaries**: `output$parameter_summary` provides means and quantiles for intercepts ($\alpha$) and coefficients ($\beta$).
*   **PIPs**: `output$PIP` shows the probability of each taxon being associated with the variables of interest.
*   **bFDR**: `output$bFDR` provides the false discovery rate for the selected set.

### 5. Convergence Diagnostics
Always check the MCMC chains for convergence using trace plots.

```r
# Plot trace for specific parameters (e.g., intercept for taxon 1, coefficient for taxon 10)
fig_trace <- trace_plot(trace = output$trace, param = c("alpha_1", "beta1_10"))
print(fig_trace)
```

## Tips for Success
*   **Low Abundance**: BDMMA allows for filtering low-abundance taxa to improve computational efficiency and power.
*   **Batch Labels**: Ensure batch information is provided as a factor or integer vector within the `colData`.
*   **MCMC Length**: For complex datasets, increase `burn_in` and `sample_period` if trace plots show poor mixing or lack of convergence.

## Reference documentation
- [Batch Effects Correction for Microbiome Data with Dirichlet-multinomial Regression](./references/Vignette.md)