---
name: bioconductor-rnadecay
description: This tool analyzes RNA degradation kinetics from time-course data using maximum likelihood modeling. Use when user asks to normalize RNA-seq decay data, model constant or decaying decay rates, and compare RNA stability across different treatments or genotypes.
homepage: https://bioconductor.org/packages/release/bioc/html/RNAdecay.html
---

# bioconductor-rnadecay

name: bioconductor-rnadecay
description: Specialized for RNA decay analysis using the RNAdecay R package. Use this skill to normalize RNA-seq time-course data, perform maximum likelihood modeling of decay rates (constant vs. decaying decay), and visualize results with decay and half-life plots.

## Overview

The `RNAdecay` package provides a framework for analyzing RNA degradation kinetics from time-course data (e.g., following transcriptional inhibition with Actinomycin D or cordycepin). It supports both constant exponential decay and "decaying decay" models, which account for changes in decay rates over time. The package is particularly useful for comparing decay kinetics across different genotypes or treatments (up to 4 groups).

## Core Workflow

### 1. Data Preparation and Normalization

Data must be formatted as a data frame with columns: `geneID`, `treatment`, `t.decay`, `rep`, and `value`.

*   **T0 Normalization**: Divide all RPM values by the mean T0 (time zero) value for that gene/treatment.
*   **Decay Factor Correction**: Correct for the "stable RNA" bias (where stable RNAs appear to increase in abundance as the total RNA pool shrinks).
    *   Identify a set of stable reference genes.
    *   Calculate normalization factors based on the mean T0-normalized values of these stable genes.
    *   Apply these factors to the entire dataset.

```r
library(RNAdecay)
# Example of formatting data for modeling
decay_data <- RNAdecay::decay_data
decay_data <- decay_data[order(decay_data$t.decay, decay_data$rep, 
                               as.numeric(decay_data$treatment), decay_data$geneID), ]
```

### 2. Modeling Decay Rates

The package uses Maximum Likelihood Estimation (MLE) to fit models. It tests various "equivalence constraint groups" to determine if treatments share the same decay parameters ($\alpha$ for initial rate, $\beta$ for rate of decay change).

*   **Define Groups**: Use `groupings()` to generate the constraint matrices.
*   **Set Bounds**: Use `a_low()`, `a_high()`, and `b_low()` to set search boundaries for $\alpha$ and $\beta$ based on your time points.
*   **Optimization**: Run `mod_optimization()` for specific genes or across the genome.

```r
# Define bounds
a_bounds <- c(a_low(max(decay_data$t.decay)), a_high(min(unique(decay_data$t.decay)[unique(decay_data$t.decay)>0])))
b_bounds <- c(b_low(max(decay_data$t.decay)), 0.075)

# Run optimization for a gene
results <- mod_optimization(geneID = "AT2G18150", 
                            data = decay_data, 
                            group = groups, 
                            mod = mods, 
                            alpha_bounds = a_bounds, 
                            beta_bounds = b_bounds, 
                            models = paste0("mod", 1:240))
```

### 3. Model Selection and Interpretation

*   **AICc**: Select the "best" model for each gene based on the lowest AICc value.
*   **Model Comparison**: Models with $\Delta AICc < 2$ are considered statistically similar.
*   **Parameters**: 
    *   $\alpha$: Initial decay rate.
    *   $\beta$: Decay of the decay rate (if $\beta = 0$, the model is constant exponential decay).

### 4. Visualization

The package provides specialized plotting functions to overlay raw data, mean/SE, and the fitted MLE models.

*   **`decay_plot()`**: Standard abundance vs. time plots.
*   **`hl_plot()`**: Half-life distribution plots.

```r
# Plotting a specific gene
decay_plot(geneID = "AT1G02860", 
           DATA = decay_data, 
           mod.results = results, 
           treatments = c("WT", "vcs.sov"),
           what = c("meanSE", "models", "alphas&betas"))
```

## Key Functions

*   `cols()`: Helper to index columns based on naming patterns (e.g., "WT_00").
*   `groupings()`: Generates the combinatorial constraint groups for treatments.
*   `mod_optimization()`: The core MLE fitting engine.
*   `a_low()`, `a_high()`, `b_low()`: Heuristics for parameter boundary setting.
*   `decay_plot()`: High-level ggplot2 wrapper for decay curves.

## Reference documentation

- [RNAdecay Workflow](./references/RNAdecay_workflow.md)