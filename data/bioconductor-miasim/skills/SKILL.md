---
name: bioconductor-miasim
description: This tool simulates microbial community dynamics using various ecological models to generate synthetic microbiome data. Use when user asks to simulate species abundance matrices, generate microbial time-series data, or model community interactions using Lotka-Volterra, Hubbell, or Consumer-Resource frameworks.
homepage: https://bioconductor.org/packages/release/bioc/html/miaSim.html
---


# bioconductor-miasim

name: bioconductor-miasim
description: A skill for simulating microbiome data using various ecological models. Use this skill when you need to generate synthetic species abundance matrices, time-series data, or interaction networks for microbial communities. It supports models like Generalized Lotka-Volterra (gLV), Hubbell Neutral model, Consumer-Resource models, and Stochastic Logistic models, returning results as TreeSummarizedExperiment objects.

# bioconductor-miasim

## Overview

The `miaSim` package provides a flexible framework for simulating microbial community dynamics based on ecological theory. It allows users to test hypotheses, benchmark bioinformatics pipelines, and model complex interactions within the Bioconductor `TreeSummarizedExperiment` ecosystem.

## Core Workflows

### 1. Generating Interaction Matrices
Most models require an interaction matrix ($A$) defining how species affect one another.

```r
library(miaSim)

# Normal distribution (Power law)
A_normal <- powerlawA(n_species = 10, alpha = 3)

# Uniform distribution with specific connectance
A_uniform <- randomA(n_species = 10, 
                     diagonal = -0.4, 
                     connectance = 0.5, 
                     interactions = runif(100, -0.8, 0.8))
```

### 2. Simulating Community Dynamics
Choose a model based on the ecological assumptions required:

*   **Generalized Lotka-Volterra (gLV):** For population dynamics with explicit interactions.
    ```r
    tse_glv <- simulateGLV(n_species = 5, A = A_normal, t_store = 100)
    ```
*   **Hubbell Neutral Model:** For diversity driven by migration and drift rather than interactions.
    ```r
    tse_hubbell <- simulateHubbell(n_species = 10, M = 10, carrying_capacity = 1000)
    ```
*   **Consumer-Resource Model:** For dynamics based on shared metabolic resources.
    ```r
    E_matrix <- randomE(n_species = 3, n_resources = 6)
    tse_crm <- simulateConsumerResource(n_species = 3, n_resources = 6, E = E_matrix)
    ```
*   **Stochastic Logistic Model:** For simple growth models with noise.
    ```r
    tse_logistic <- simulateStochasticLogistic(n_species = 5)
    ```

### 3. Working with Results
Simulations return a `TreeSummarizedExperiment` (TreeSE) object.

*   **Access Abundances:** `assay(tse_glv)`
*   **Access Metadata:** `colData(tse_glv)` (often contains time points)
*   **Visualization:** Use `miaViz` or `miaTime` for plotting the resulting time series or community compositions.

## Tips for Success
*   **Matrix Dimensions:** Ensure the number of species in your interaction matrix ($A$) matches the `n_species` parameter in your simulation function.
*   **Normalization:** Many functions include a `norm = TRUE/FALSE` argument. Set to `TRUE` if you require relative abundances (proportions) rather than absolute counts.
*   **Reproducibility:** Always set a seed (`set.seed()`) before running simulations to ensure results can be replicated.

## Reference documentation
- [miaSim: Microbiome Data Simulation](./references/miaSim.md)