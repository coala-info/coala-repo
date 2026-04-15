---
name: bioconductor-microbiomedasim
description: microbiomeDASim simulates longitudinal microbiome sequencing data to evaluate statistical methods for detecting differential abundance over time. Use when user asks to simulate longitudinal microbiome data, generate feature matrices with differential abundance trends, or visualize mathematical trends for microbiome simulations.
homepage: https://bioconductor.org/packages/release/bioc/html/microbiomeDASim.html
---

# bioconductor-microbiomedasim

## Overview
The `microbiomeDASim` package provides tools for simulating longitudinal microbiome sequencing data. It is designed to help researchers evaluate statistical methods for detecting differential abundance over time. It addresses common microbiome data challenges like non-negative restrictions, missing data, and small sample sizes by using a Multivariate Normal Distribution framework as an asymptotic ideal for normalized counts.

## Installation
```R
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("microbiomeDASim")
library(microbiomeDASim)
```

## Core Functions

### 1. Single Feature Simulation (`mvrnorm_sim`)
Generates data for one feature across control and treatment groups.
- **Key Parameters**:
  - `n_control`, `n_treat`: Number of subjects per group.
  - `num_timepoints`: Number of repeated measures per subject.
  - `corr_str`: Correlation structure ("ar1", "compound", or "independent").
  - `func_form`: The shape of the differential abundance (e.g., "linear", "quadratic", "M", "L_up").
  - `beta`: Coefficients for the functional form.
  - `rho`: Correlation coefficient.
  - `sigma`: Standard deviation.

### 2. Community Simulation (`gen_norm_microbiome`)
Generates a feature matrix (OTU table) containing multiple features, where a subset is differentially abundant.
- **Key Parameters**:
  - `features`: Total number of features.
  - `diff_abun_features`: Number of features with the differential trend.
  - `missing_pct`: Percentage of missing data (zeros).
  - `miss_val`: Value to use for missing data (default is 0).

### 3. Trend Visualization (`mean_trend`)
Visualizes the mathematical trend before running the full simulation.
```R
# Example: Hockey stick trend
mean_trend(timepoints=1:10, form="L_up", beta=0.5, IP=5, plot_trend=TRUE)
```

## Typical Workflow

### Simulating a Single Feature
```R
sim_data <- mvrnorm_sim(
  n_control = 10, 
  n_treat = 10, 
  control_mean = 2,
  sigma = 1, 
  num_timepoints = 5, 
  t_interval = c(0, 4), 
  rho = 0.8,
  corr_str = "ar1", 
  func_form = "linear",
  beta = c(0, 0.5), # Intercept 0, Slope 0.5
  dis_plot = TRUE
)

# Access the data frame
head(sim_data$df)
```

### Simulating a Microbiome Community
```R
community <- gen_norm_microbiome(
  features = 50, 
  diff_abun_features = 5, 
  n_control = 20,
  n_treat = 20, 
  control_mean = 3, 
  sigma = 1,
  num_timepoints = 4, 
  func_form = "M", # Oscillating trend
  beta = c(2, 1), 
  IP = c(1, 2, 3)  # Inflection points for complex trends
)

# 'Y' is the feature matrix (features x samples)
# 'bug_feat' contains metadata (ID, time, group)
otu_table <- community$Y
metadata <- community$bug_feat
```

## Functional Forms and Parameters
- **Linear**: `beta` = c(intercept, slope).
- **Quadratic/Cubic**: `beta` = coefficients for polynomial terms.
- **L_up / L_down (Hockey Stick)**: Requires `IP` (Inflection Point) where the trend changes.
- **M / W (Oscillating)**: Requires multiple `IP` values to define peaks and valleys.

## Tips for Success
- **Asynchronous Timing**: Set `asynch_time = TRUE` in `mvrnorm_sim` to simulate subjects sampled at slightly different intervals, which is more realistic for clinical studies.
- **Missingness**: Use `missing_pct` and `missing_per_subject` in `gen_norm_microbiome` to simulate the sparsity typically found in microbiome datasets.
- **Normalization**: Since the package simulates from a Normal distribution, the output should be treated as "already normalized" (e.g., log-transformed or CSS-normalized) data.

## Reference documentation
- [microbiomeDASim](./references/microbiomeDASim.md)