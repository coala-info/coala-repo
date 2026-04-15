---
name: bioconductor-cytoglmm
description: This tool performs differential protein expression analysis for flow and mass cytometry data using generalized linear models and mixed models. Use when user asks to identify protein markers associated with experimental conditions, account for inter-subject heterogeneity, or perform bootstrapped GLM and GLMM analysis on single-cell cytometry data.
homepage: https://bioconductor.org/packages/release/bioc/html/CytoGLMM.html
---

# bioconductor-cytoglmm

name: bioconductor-cytoglmm
description: Differential protein expression analysis for flow and mass cytometry data using Generalized Linear Models (GLM) and Generalized Linear Mixed Models (GLMM). Use this skill to identify protein markers associated with experimental conditions while accounting for inter-subject heterogeneity and marker correlations in single-cell data.

## Overview

CytoGLMM provides a statistical framework for differential expression analysis in cytometry. It focuses on a specific cell type and uses regression strategies to handle the challenges of marker correlations and donor-to-donor variability. The package implements two main approaches:
1. **Bootstrapped GLM**: A generalized linear model to find protein patterns associated with a condition.
2. **GLMM**: A generalized linear mixed model that includes random effects to account for subject-specific variation, particularly useful in paired experimental designs.

## Workflow

### 1. Data Preparation and Transformation

Cytometry data should be transformed using a variance-stabilizing transformation, typically the inverse hyperbolic sine (`asinh`).

```r
library(CytoGLMM)

# Define markers of interest
protein_names <- c("marker1", "marker2", "marker3")

# Apply asinh transformation
# Use cofactor 5 for mass cytometry (CyTOF)
# Use cofactor 150 for flow cytometry
df <- dplyr::mutate_at(df, protein_names, function(x) asinh(x/5))
```

### 2. Bootstrapped GLM Analysis

Use `cytoglm` to predict the experimental condition from protein marker expressions. This function uses bootstrapping to estimate uncertainty.

```r
glm_fit <- cytoglm(df,
                   protein_names = protein_names,
                   condition = "condition_column",
                   group = "donor_column",
                   num_boot = 1000)

# View summary and plot results
summary(glm_fit)
plot(glm_fit)
```

### 3. GLMM Analysis (Mixed Effects)

Use `cytoglmm` when you have multiple samples per donor (e.g., paired treatment/control) to account for donor-specific random effects.

```r
glmm_fit <- cytoglmm(df,
                     protein_names = protein_names,
                     condition = "condition_column",
                     group = "donor_column")

# View summary and plot results
summary(glmm_fit)
plot(glmm_fit)
```

### 4. Interpreting Results

The `summary` function returns a tibble containing:
- `pvalues_unadj`: Raw p-values for each protein.
- `pvalues_adj`: Benjamini-Hochberg (BH) adjusted p-values.

To extract significant markers (e.g., FDR < 0.05):
```r
significant_markers <- summary(glmm_fit) |> 
  dplyr::filter(pvalues_adj < 0.05)
```

## Tips and Best Practices

- **Cell Type Selection**: CytoGLMM is designed to be run on a single cell type at a time. Subset your data to a specific population before running the analysis.
- **Computational Resources**: `cytoglm` uses bootstrapping and can be computationally intensive. Use the `num_cores` parameter to enable parallel processing.
- **Fixed Effects Scale**: Estimates are provided on the log-odds scale. A positive estimate indicates that higher marker expression is associated with the "treatment" or "positive" condition.
- **Paired Designs**: Always prefer `cytoglmm` for paired experimental designs as it provides higher statistical power by modeling the donor as a random effect.

## Reference documentation

- [CytoGLMM Workflow](./references/CytoGLMM.md)