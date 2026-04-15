---
name: curesim
description: This tool simulates cure models and performs extrapolation studies for survival data. Use when user asks to analyze survival data with a cure fraction or perform simulations to understand model behavior.
homepage: https://github.com/BenKearns/CureSim
metadata:
  docker_image: "quay.io/biocontainers/curesim:1.3--0"
---

# curesim

A tool for simulating cure models and performing extrapolation studies.
  Use when you need to analyze survival data with a cure fraction,
  or when performing simulations to understand model behavior under
  different scenarios. This tool is particularly useful for
  long-term survival data analysis and for comparing different
  modeling approaches.
---
## Overview

CureSim is a specialized R package designed for the analysis and simulation of cure models. It allows users to fit models that account for a "cure fraction" – a portion of the population that is permanently cured of a disease and will not experience mortality from it. Beyond fitting, CureSim facilitates extrapolation studies and simulations to assess model performance and behavior under various conditions. This makes it ideal for researchers and analysts working with long-term survival data where a cure fraction is a relevant consideration.

## Usage Instructions

CureSim is primarily an R package. Its usage involves writing and executing R scripts that leverage the package's functions.

### Core Functionality

The main functionalities revolve around fitting cure models and performing simulations.

1.  **Fitting Cure Models**:
    *   The `Fit_Models.R` script appears to be a central script for fitting various cure models.
    *   The `Fit_DynamicModels.R` script suggests the capability to fit dynamic cure models, which might account for time-varying effects or population dynamics.
    *   The `DynamicModels.stan` file indicates the use of Stan for model fitting, implying a Bayesian approach for complex model specifications.

2.  **Simulation Studies**:
    *   The repository contains R scripts (`Fit_DynamicModels.R`, `Fit_Models.R`) that are likely used to run simulations based on fitted models or predefined scenarios.
    *   The `README.md` file mentions "R code for cure models extrapolation simulation study," directly pointing to its simulation capabilities.

### Expert Tips and Best Practices

*   **Understand Your Data**: Before fitting, ensure your survival data is properly formatted and includes event times, censoring information, and any relevant covariates.
*   **Model Selection**: Experiment with different cure model formulations (e.g., using `DynamicModels.stan` for more complex, potentially time-dependent, cure fractions) to find the best fit for your data.
*   **Simulation Design**: When designing simulations, carefully consider the parameters you wish to vary (e.g., cure fraction, hazard rates, covariate effects) and the number of replicates needed for robust conclusions.
*   **Stan Integration**: If using Stan models (`DynamicModels.stan`), ensure you have a working Stan installation and understand its syntax for defining custom statistical models. The R scripts will likely call Stan through interfaces like `rstan`.
*   **Reproducibility**: Keep detailed records of the R scripts, model parameters, and random seeds used for simulations to ensure reproducibility of your results.

## Reference documentation

- [GitHub Repository Overview](./references/github_com_BenKearns_CureSim.md)
- [Dynamic Models Stan File](./references/github_com_BenKearns_CureSim_blob_main_DynamicModels.stan.md)
- [Fit Dynamic Models R Script](./references/github_com_BenKearns_CureSim_blob_main_Fit_DynamicModels.R.md)
- [Fit Models R Script](./references/github_com_BenKearns_CureSim_blob_main_Fit_Models.R.md)