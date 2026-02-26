---
name: bioconductor-cytofpower
description: This tool performs power analysis for CyTOF experiments to predict the experimental power of differential state tests. Use when user asks to determine sample sizes, predict experimental power, or run in-silico data simulations for mass spectrometry studies.
homepage: https://bioconductor.org/packages/release/bioc/html/CyTOFpower.html
---


# bioconductor-cytofpower

name: bioconductor-cytofpower
description: Power analysis for CyTOF (Mass Spectrometry) experiments. Use this skill to predict the experimental power of differential state tests using either precomputed parameter grids or custom in-silico data simulations. It supports models from CytoGLMM and diffcyt.

## Overview

CyTOFpower is designed to help researchers determine the necessary sample size and experimental design for CyTOF studies. It focuses on "Differential State" (DS) analysis—identifying changes in marker expression within cell populations across conditions. The package provides a Shiny interface for exploring power across various parameters (number of donors, cells per sample, subject effect, and fold change) and allows for custom simulations using Negative Binomial distributions.

## Core Workflows

### Launching the Interactive Interface
The primary way to use CyTOFpower is through its Shiny application, which contains both precomputed power grids and a personalized simulation engine.

```r
library(CyTOFpower)
CyTOFpower()
```

### Power Analysis Options

1.  **Precomputed Dataset Tab**:
    *   Best for quick estimates based on standard experimental designs.
    *   Allows searching a grid of parameters: Donors, Subject Effect, Cells per Sample, Markers, and Fold Change (1.1 to 3.0).
    *   Supports multiple models: `CytoGLMM`, `diffcyt-limma` (fixed/random), and `diffcyt-lme4`.
    *   Tip: Selecting "NA" for a parameter will generate a power curve across the range of that parameter.

2.  **Personalized Dataset Tab**:
    *   Best for specific pilot data or unique experimental designs.
    *   Requires at least 3 donors, 10 cells per sample, and 3 markers.
    *   Users must specify a matrix of Fold Change, Mean, and Dispersion for each marker.
    *   Recommendation: Run at least 10 simulations for stable power estimates (higher is better but slower).

## Simulation Parameters

When setting up a personalized power analysis, understand the underlying data generation:
*   **Subject Effect ($S$):** Defines inter-donor variability.
*   **Fold Change ($\rho$):** The effect size for differentially expressed markers.
*   **Distribution:** Cell values are drawn from a Negative Binomial distribution where the mean is influenced by the donor's baseline (Gamma distributed) and the condition's fold change.
*   **Significance:** Power is calculated based on the proportion of simulations where the adjusted p-value is $< 0.05$.

## Model Selection
The package evaluates power for the following differential analysis methods:
*   **CytoGLMM**: Generalized Linear Mixed Models for cytometry.
*   **diffcyt (limma)**: Empirical Bayes moderated tests (fixed or random effects).
*   **diffcyt (lme4)**: Linear Mixed Models via lme4.

## Reference documentation

- [Power analysis for CyTOF experiments](./references/CyTOFpower.md)