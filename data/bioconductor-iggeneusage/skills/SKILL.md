---
name: bioconductor-iggeneusage
description: This tool performs statistical analysis of immunoglobulin gene usage in immune receptor repertoires using Bayesian regression. Use when user asks to detect differential gene usage between biological conditions, identify over-dispersion in repertoire data, or perform leave-one-out robustness analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/IgGeneUsage.html
---

# bioconductor-iggeneusage

name: bioconductor-iggeneusage
description: Statistical analysis of immunoglobulin (Ig) gene usage in immune receptor repertoires (IRRs). Use this skill to detect differential gene usage (DGU) between biological conditions (e.g., healthy vs. disease) using Bayesian zero-inflated beta-binomial regression.

# bioconductor-iggeneusage

## Overview
The `IgGeneUsage` package provides tools for the quantitative analysis of immune receptor repertoires. It specifically addresses the challenge of identifying differential gene usage (DGU) while accounting for common issues in repertoire data, such as over-dispersion and zero-inflation (where certain genes are not sampled or are dysfunctional in specific individuals).

## Input Data Requirements
The package requires a `data.frame` with a specific structure:
1.  **individual_id**: Unique identifier for the repertoire (e.g., Patient ID).
2.  **condition**: The biological group (e.g., "healthy", "tumor").
3.  **gene_name**: The Ig gene identifier (e.g., "IGHV1-10").
4.  **gene_usage_count**: Numeric counts of the gene in that specific individual/condition.
5.  **repertoire** (Optional): Identifier for biological replicates within an individual.

## Core Workflow

### 1. Differential Gene Usage (DGU) Analysis
The primary function is `DGU()`, which fits a Bayesian model using `rstan`.

```r
library(IgGeneUsage)

# Basic DGU call
M <- DGU(ud = your_data_frame,
         mcmc_warmup = 500,
         mcmc_steps = 1500,
         mcmc_chains = 4,
         mcmc_cores = 4)

# View summary of results
summary(M)
```

### 2. Interpreting Results
The output object contains several key components:
*   **M$dgu**: Summary of effect sizes ($\gamma$) and 95% Highest Density Intervals (HDI).
*   **M$dgu_prob**: Probability of differential gene usage ($\pi$).
    *   $\pi \approx 1$: Strong evidence of differential usage.
    *   $\pi \approx 0$: Negligible differential usage.
*   **M$gu**: Condition-specific relative gene usage probabilities.

### 3. Model Diagnostics
Since the package relies on MCMC sampling, always verify the fit:
*   **Check HMC Diagnostics**: `rstan::check_hmc_diagnostics(M$fit)`
*   **Rhat**: Ensure Rhat < 1.05 for all parameters.
*   **Posterior Predictive Checks (PPC)**: Compare observed vs. predicted counts using the data in `M$ppc$ppc_rep` and `M$ppc$ppc_condition`.

### 4. Robustness Analysis (LOO)
To ensure results aren't driven by a single outlier repertoire, use the Leave-One-Out (LOO) function:

```r
L <- LOO(ud = your_data_frame,
         mcmc_warmup = 500,
         mcmc_steps = 1000,
         mcmc_chains = 1)

# Extract and compare results
L_dgu <- do.call(rbind, lapply(L, function(x) x$dgu))
```

## Visualization Tips
*   **Effect Size vs. Probability**: Plot `pmax` ($\pi$) on the x-axis and `es_mean` ($\gamma$) on the y-axis to identify "promising hits" (typically $\pi \geq 0.95$).
*   **Usage Comparison**: Use `M$gu` to plot the mean probability of usage for specific genes across conditions with error bars representing the 95% HDI.

## Reference documentation
- [User Manual: IgGeneUsage](./references/User_Manual.md)
- [User Manual: IgGeneUsage (Rmd)](./references/User_Manual.Rmd)