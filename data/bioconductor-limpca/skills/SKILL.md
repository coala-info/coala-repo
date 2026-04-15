---
name: bioconductor-limpca
description: bioconductor-limpca performs statistical analysis of multivariate data from multifactorial designs by combining general linear models with principal component analysis. Use when user asks to decompose variance into specific model effects, perform ASCA or APCA on -omics data, or visualize factor-specific patterns in complex experimental designs.
homepage: https://bioconductor.org/packages/release/bioc/html/limpca.html
---

# bioconductor-limpca

name: bioconductor-limpca
description: Statistical analysis of multivariate data from multifactorial designs using ASCA (ANOVA-Simultaneous Component Analysis), APCA (ANOVA-Principal Component Analysis), and ASCA-E. Use when analyzing -omics data (metabolomics, transcriptomics) with complex experimental designs to decompose variance into specific model effects and visualize them via PCA.

## Overview

The `limpca` package provides a framework for the analysis of multivariate data (like NMR spectra or gene expression matrices) originating from multifactorial experimental designs. It implements ASCA, APCA, and ASCA-E methods, which combine General Linear Models (GLM) with Principal Component Analysis (PCA) to isolate and visualize the variance associated with specific experimental factors and their interactions.

## Core Workflow

### 1. Data Preparation
Data must be formatted as an `lmpDataList` containing `outcomes` (matrix), `design` (data.frame), and `formula` (character).

```r
library(limpca)

# Create from scratch
my_data <- data2LmpDataList(
  outcomes = outcome_matrix, 
  design = design_df, 
  formula = "outcomes ~ FactorA * FactorB"
)

# Or from a SummarizedExperiment
# my_data <- data2LmpDataList(se_object, assay_name = "counts")
```

### 2. Exploratory Analysis
Before decomposition, use standard PCA and design visualization.

```r
# Visualize design balance
plotDesign(design = my_data$design, x = "FactorA", y = "FactorB")

# Initial PCA
resPCA <- pcaBySvd(my_data$outcomes)
pcaScreePlot(resPCA)
pcaScorePlot(resPCA, design = my_data$design, color = "FactorA")
```

### 3. Model Estimation
Generate the model matrix and decompose the outcomes into effect matrices.

```r
# 1. Generate model matrix (uses sum coding by default)
resModel <- lmpModelMatrix(my_data)

# 2. Compute effect matrices and variance percentages
resEffects <- lmpEffectMatrices(resModel)

# 3. Visualize variance contribution per effect
resEffects$varPercentagesPlot
```

### 4. Significance Testing
Use parametric bootstrap tests to determine the significance of each model term.

```r
resBootstrap <- lmpBootstrapTests(resEffects, nboot = 1000)
# View p-values
print(resBootstrap$resultsTable)
```

### 5. ASCA / APCA Decomposition
Apply PCA to the effect matrices to visualize factor-specific patterns.

```r
# Method can be "ASCA", "APCA", or "ASCA-E"
resASCA <- lmpPcaEffects(resEffects, method = "ASCA")

# Calculate contributions of PCs within effects
resContrib <- lmpContributions(resASCA)
resContrib$plotContrib
```

### 6. Visualization of Results
Visualize scores and loadings for specific effects.

```r
# 2D Score Plot for a specific factor
lmpScorePlot(resASCA, effectNames = "FactorA", color = "FactorA")

# 1D Loading Plot (useful for spectral data or ordered variables)
lmpLoading1dPlot(resASCA, effectNames = "FactorA", axes = 1)

# Effect Plot (visualize interactions or main effects on specific PCs)
lmpEffectPlot(resASCA, effectName = "FactorA:FactorB", x = "FactorA", z = "FactorB")
```

## Key Functions Reference

| Function | Purpose |
| :--- | :--- |
| `data2LmpDataList` | Formats data for the limpca pipeline. |
| `lmpModelMatrix` | Creates the GLM model matrix from the design. |
| `lmpEffectMatrices` | Estimates the model and calculates effect matrices. |
| `lmpBootstrapTests` | Performs significance testing for model effects. |
| `lmpPcaEffects` | Performs PCA on effect matrices (ASCA/APCA/ASCA-E). |
| `lmpScorePlot` | Plots PCA scores for specific effects. |
| `lmpLoading1dPlot` | Plots PCA loadings as a line (e.g., for NMR spectra). |
| `lmpEffectPlot` | Visualizes factor levels against PC scores (interaction plots). |

## Tips for Success
- **Unbalanced Designs**: `limpca` handles unbalanced designs using Type III sums of squares.
- **Aggregation**: If your design has technical replicates or a hierarchy not yet supported by mixed models in `limpca`, consider mean-aggregating observations per experimental unit (e.g., per aquarium or per subject) before analysis.
- **Scaling**: For transcriptomics or data with different units, scale the `outcomes` matrix (e.g., `scale(outcomes, center = TRUE, scale = TRUE)`) before creating the `lmpDataList`.

## Reference documentation
- [Analysis of the Trout dataset with limpca](./references/Trout.md)
- [Analysis of the UCH dataset with limpca](./references/UCH.md)
- [limpca Package Vignette](./references/limpca.md)