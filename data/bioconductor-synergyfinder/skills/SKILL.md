---
name: bioconductor-synergyfinder
description: This tool analyzes and visualizes drug combination screening data to quantify drug-drug interactions and sensitivity. Use when user asks to calculate synergy scores using models like ZIP or Loewe, estimate combination sensitivity scores, or visualize dose-response landscapes for multi-drug combinations.
homepage: https://bioconductor.org/packages/release/bioc/html/synergyfinder.html
---


# bioconductor-synergyfinder

name: bioconductor-synergyfinder
description: Analysis and visualization of drug combination screening data using the synergyfinder R package. Use this skill when you need to calculate drug synergy scores (HSA, Bliss, Loewe, ZIP), estimate combination sensitivity (CSS, RI), or visualize dose-response landscapes for two-drug or higher-order drug combinations.

# bioconductor-synergyfinder

## Overview
The `synergyfinder` package is designed for the analysis of high-throughput drug combination screening data. It allows researchers to quantify drug-drug interactions through multiple synergy models and evaluate the clinical potential of combinations by calculating sensitivity scores. It supports both standard two-drug matrices and higher-order (3+ drugs) combinations, providing tools for baseline correction, statistical significance testing via bootstrapping, and multi-dimensional visualization.

## Core Workflow

### 1. Data Preparation
Input data must be a long-format data frame. Required columns include `block_id`, `drug1`, `drug2`, `conc1`, `conc2`, and `response` (% inhibition or % viability).

```r
library(synergyfinder)

# Load example data
data("mathews_screening_data")

# Reshape and pre-process
# data_type: "viability" or "inhibition"
res <- ReshapeData(
  data = mathews_screening_data,
  data_type = "viability",
  impute = TRUE,
  noise = TRUE,
  seed = 1
)
```

### 2. Calculating Synergy and Sensitivity
Synergy scores represent the excess effect over a reference model. Sensitivity scores (CSS) integrate efficacy and potency.

```r
# Calculate Synergy using all four models
res <- CalculateSynergy(
  data = res,
  method = c("ZIP", "HSA", "Bliss", "Loewe"),
  correct_baseline = "non"
)

# Calculate Sensitivity (CSS and RI)
res <- CalculateSensitivity(
  data = res,
  correct_baseline = "non"
)
```

### 3. Handling Replicates
If the input data contains replicates (detected by `block_id` and concentration pairs), use the `iteration` parameter in processing functions to enable bootstrapping for confidence intervals and p-values.

```r
res <- ReshapeData(data = my_data, iteration = 10)
res <- CalculateSynergy(data = res, method = "ZIP")
```

### 4. Visualization
The package provides several ways to visualize the interaction landscape.

*   **Dose-Response/Synergy Maps:**
    *   `Plot2DrugHeatmap(res, plot_block = 1, plot_value = "ZIP_synergy")`
    *   `Plot2DrugContour(res, plot_block = 1, plot_value = "response")`
    *   `Plot2DrugSurface(res, plot_block = 1, plot_value = "ZIP_synergy")`
*   **Synergy Barometer:** Compares all four synergy models for a specific dose point.
    *   `PlotBarometer(res, plot_block = 1, plot_concs = c(9.76, 50))`
*   **SS Plot:** Visualizes the Synergy-Sensitivity relationship to prioritize combinations.
    *   `PlotSensitivitySynergy(res, plot_synergy = "ZIP")`

## Higher-Order Combinations
For combinations of 3 or more drugs, `synergyfinder` uses dimension reduction (MDS) to visualize high-dimensional dose spaces.

```r
# Calculate synergy for 3+ drugs
res <- CalculateSynergy(res, method = "ZIP")

# Visualize using dimension reduction
PlotMultiDrugSurface(
  data = res,
  plot_block = 1,
  plot_value = "ZIP_synergy",
  distance_method = "mahalanobis"
)
```

## Key Functions and Parameters
- `ReshapeData`: Prepares the list object. Use `impute = TRUE` for missing values.
- `CalculateSynergy`: Reference models include "HSA", "Bliss", "Loewe", and "ZIP".
- `correct_baseline`: Options are "non", "part" (adjusts negative values), or "all".
- `plot_value`: Can be "response", "ZIP_synergy", "HSA_synergy", etc.

## Reference documentation
- [User tutorial of the SynergyFinder Plus](./references/User_tutorual_of_the_SynergyFinder_plus.md)