---
name: bioconductor-snm
description: This tool performs supervised normalization of microarray data by modeling biological, adjustment, and intensity-dependent variables. Use when user asks to normalize single-channel or double-channel microarray data, remove batch effects while preserving biological signals, or perform supervised normalization on preprocessed data.
homepage: https://bioconductor.org/packages/release/bioc/html/snm.html
---


# bioconductor-snm

name: bioconductor-snm
description: Supervised Normalization of Microarrays (SNM). Use this skill to perform normalization of microarray data (single-channel, double-channel, or preprocessed) while accounting for biological variables of interest and removing systematic adjustment variables (batch effects, age, etc.) and intensity-dependent effects.

## Overview

The `snm` package provides a framework for supervised normalization. Unlike unsupervised methods, SNM explicitly models study-specific variables categorized into:
1.  **Biological Variables**: Factors of interest (e.g., treatment, disease status).
2.  **Adjustment Variables**: Systematic variation to be removed (e.g., batch, technician, age).
3.  **Intensity-Dependent Effects**: Non-linear effects (e.g., array or dye effects) modeled via splines.

The goal is to remove adjustment and intensity-dependent effects without biasing the biological signals.

## Basic Workflow

### 1. Prepare Input Data
The main function `snm()` requires four primary inputs:
*   `raw.dat`: A matrix of unnormalized data (probes in rows, arrays in columns).
*   `bio.var`: A model matrix (created via `model.matrix`) of biological factors.
*   `adj.var`: A model matrix of probe-specific adjustment variables (e.g., batch).
*   `int.var`: A data frame of intensity-dependent variables (e.g., array ID, dye).

### 2. Execute Normalization
```R
library(snm)

# Example: Single Channel Normalization
snm.obj <- snm(raw.dat = my_data, 
               bio.var = my_bio_model, 
               adj.var = my_adj_model, 
               int.var = my_int_df)
```

### 3. Key Parameters
*   `rm.adj`: Set to `FALSE` (default) if performing subsequent statistical testing. Set to `TRUE` for downstream clustering or network analysis.
*   `num.iter`: Number of iterations (default is 10). Check `iter.pi0s` in output for convergence.
*   `diagnose`: Set to `TRUE` to see diagnostic plots during iteration.

## Common Scenarios

### Single Channel (e.g., Affymetrix)
Typically involves an intercept and biological groups in `bio.var`, batch effects in `adj.var`, and array effects in `int.var`.

### Double Channel (e.g., Agilent)
Requires modeling both array and dye effects in `int.var`.
```R
# int.var for double channel often contains array and dye factors
int.var = data.frame(array = factor(rep(1:10, each=2)), 
                     dye = factor(rep(c("Cy3", "Cy5"), 10)))
```

### Preprocessed Data (e.g., RMA output)
If intensity-dependent effects were already removed, you can still use `snm` to handle probe-specific adjustment variables.
```R
# Set int.var to NULL if intensity effects are already handled
snm.obj <- snm(raw.dat = rma_data, 
               bio.var = bio_model, 
               adj.var = adj_model, 
               int.var = NULL,
               rm.adj = TRUE)
```

## Interpreting Results

The output object contains:
*   `norm.dat`: The normalized data matrix.
*   `pvalues`: P-values testing the association of biological variables with each probe (calculated after removing adjustment/intensity effects).
*   `pi0`: Estimated proportion of true null probes.
*   `plot(snm.obj)`: Generates diagnostic plots showing probe distribution, latent structure (PCA of residuals), estimated array effects, and p-value histograms.

## Tips for Success
*   **Model Specification**: Ensure `bio.var` and `adj.var` are correctly specified. If `adj.var` is `NULL`, an intercept is added automatically.
*   **Latent Structure**: If the diagnostic plot shows the first Principal Component explaining a large portion of variance, consider using Surrogate Variable Analysis (SVA) to identify missing adjustment variables.
*   **Weights**: Use the `weights` argument (0 or 1) to exclude specific probes (e.g., quality control failures) from influencing the intensity-dependent spline fit.

## Reference documentation
- [Bioconductor’s snm package](./references/snm.md)