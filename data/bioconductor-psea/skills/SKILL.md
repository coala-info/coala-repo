---
name: bioconductor-psea
description: This tool performs Population-Specific Expression Analysis to deconvolve gene expression profiles from mixed tissue samples using marker-based linear regression. Use when user asks to estimate cell-type-specific expression changes, resolve confounding effects of tissue composition, or perform expression deconvolution without physical cell sorting.
homepage: https://bioconductor.org/packages/3.5/bioc/html/PSEA.html
---

# bioconductor-psea

name: bioconductor-psea
description: Perform Population-Specific Expression Analysis (PSEA) to deconvolve gene expression profiles from mixed tissue samples. Use this skill when you need to estimate cell-type-specific expression changes using marker-based linear regression, especially in cases where physical cell sorting is not possible.

# bioconductor-psea

## Overview

PSEA (Population-Specific Expression Analysis) is an R package designed to resolve the confounding effects of tissue composition in differential expression studies. It uses linear regression to model the expression of a target gene as a function of "reference signals"—the expression levels of genes known to be specific to particular cell populations (e.g., neurons, astrocytes). This allows for the identification of cell-type-specific expression changes even when the relative abundance of those cells varies across samples.

## Core Workflow

### 1. Data Preparation
Load the package and your expression data (typically a matrix where rows are probesets/genes and columns are samples).

```r
library(PSEA)
# expression: matrix of expression values
# groups: vector of 0s (control) and 1s (disease/condition)
```

### 2. Generating Reference Signals
Identify marker genes specific to each cell population. Use the `marker` function to average these signals into a single reference measure for that population.

```r
# Define list of probesets for a specific cell type
neuron_probesets <- list(c("221805_at", "221801_x_at"), "201313_at")
# Calculate reference signal
neuron_ref <- marker(expression, neuron_probesets)
```

### 3. Creating Interaction Regressors
To test for group-specific differences (e.g., Disease vs. Control), create interaction terms between the reference signals and the group indicator.

```r
neuron_diff <- groups * neuron_ref
```

### 4. Deconvolution of Individual Transcripts
Model a specific gene's expression using linear regression (`lm`).

```r
# Model expression in control group only
model_ctrl <- lm(expression["target_gene",] ~ neuron_ref + astro_ref, subset=which(groups==0))

# Model expression across both groups to find cell-type specific changes
model_all <- lm(expression["target_gene",] ~ neuron_ref + neuron_diff)
summary(model_all)
```
*   **Coefficient of `neuron_ref`**: Normalized expression in the control group.
*   **Coefficient of `neuron_diff`**: The difference in expression in the disease group.
*   **Fold Change**: `(coef(neuron_ref) + coef(neuron_diff)) / coef(neuron_ref)`.

### 5. Automated Profile Deconvolution
For large-scale analysis, use `lmfitst` to fit multiple models and select the best one based on AIC.

```r
# 1. Create model matrix
model_mat <- fmm(cbind(neuron_ref, astro_ref, oligo_ref), groups)

# 2. Enumerate possible model subsets
model_sub <- em_quantvg(c(2,3,4), tnv=3, ng=2)

# 3. Fit all models and select best
models <- lmfitst(t(expression), model_mat, model_sub)

# 4. Extract results
coeffs <- coefmat(models[[2]], as.character(1:ncol(model_mat)))
pvals <- pvalmat(models[[2]], as.character(1:ncol(model_mat)))
```

## Visualization
Use `crplot` (Component-plus-residual plot) to visualize the dependence of a gene's expression on a specific cell-type reference signal.

```r
# Simple CR plot
crplot(model_all, "neuron_ref")

# CR plot highlighting group differences
crplot(model_all, "neuron_ref", g="neuron_diff")
```

## Tips for Success
*   **Marker Selection**: The accuracy of PSEA depends heavily on the specificity of the marker genes used for reference signals.
*   **Intercept Check**: A high intercept relative to average expression may indicate that the model is missing a significant cell population or that the markers are not sufficiently specific.
*   **Model Selection**: Use `AIC` or `Adjusted R-squared` (via `slt`) to filter for transcripts that are well-explained by the cell-population models.

## Reference documentation
- [PSEA](./references/PSEA.md)