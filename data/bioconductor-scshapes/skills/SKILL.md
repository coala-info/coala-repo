---
name: bioconductor-scshapes
description: scShapes models and identifies the distribution shapes of gene expression in single-cell RNA-seq data using a generalized linear model framework. Use when user asks to filter genes, perform Kolmogorov-Smirnov tests, fit discrete probability distributions, or identify differential distribution shapes between treatment conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/scShapes.html
---


# bioconductor-scshapes

## Overview

`scShapes` is an R package designed to go beyond simple differential expression by modeling the specific distribution "shape" of gene expression in single-cell RNA-seq (scRNA-seq) data. It uses a Generalized Linear Model (GLM) framework to fit four discrete distributions (P, NB, ZIP, ZINB) while accounting for sequencing depth (library size) and other covariates (e.g., cell types). This allows researchers to identify genes that undergo subtle distributional shifts—such as moving from a unimodal to a zero-inflated state—between treatment conditions.

## Workflow and Key Functions

### 1. Data Preparation and Filtering
The package expects a count matrix where rows are genes and columns are cells. It is recommended to filter out lowly expressed genes.

```r
library(scShapes)
library(BiocParallel)

# Filter genes: keep those expressed in at least 10% of cells
scData_filt <- filter_counts(counts_matrix, perc.zero = 0.1)
```

### 2. Preliminary Distribution Testing
Use the Kolmogorov-Smirnov (KS) test to identify genes that potentially belong to the ZINB family. This step requires library sizes (for offsets) and any relevant covariates.

```r
# Run KS test with parallel processing
scData_KS <- ks_test(
    counts = counts_matrix, 
    cexpr = covariates_df, 
    lib.size = library_size_vector, 
    BPPARAM = SnowParam(workers = 8, type = "SOCK")
)

# Select significant genes (default p-value < 0.01 with BH correction)
scData_KS_sig <- ks_sig(scData_KS)

# Subset original counts to significant genes
sig_counts <- counts_matrix[rownames(counts_matrix) %in% names(scData_KS_sig$genes), ]
```

### 3. Model Fitting and Selection
Fit the four candidate distributions (P, NB, ZIP, ZINB) to the filtered genes and select the best fit based on the Bayesian Information Criterion (BIC).

```r
# Fit the 4 models
scData_models <- fit_models(
    counts = sig_counts, 
    cexpr = covariates_df, 
    lib.size = library_size_vector, 
    BPPARAM = SnowParam(workers = 8, type = "SOCK")
)

# Calculate BIC and select model with least BIC
scData_bicvals <- model_bic(scData_models)
scData_least_bic <- lbic_model(scData_bicvals, sig_counts)
```

### 4. Goodness-of-Fit and Final Selection
Perform Likelihood Ratio Tests (LRT) to ensure model adequacy and confirm the presence of zero-inflation.

```r
# Test for model adequacy
scData_gof <- gof_model(
    scData_least_bic, 
    cexpr = covariates_df, 
    lib.size = library_size_vector, 
    BPPARAM = SnowParam(workers = 8, type = "SOCK")
)

# Identify the final distribution of best fit for each gene
scData_fit <- select_model(scData_gof)

# Extract model parameters (mu, size, pi)
scData_params <- model_param(scData_models, scData_fit)
```

### 5. Differential Distribution (Shape) Analysis
To compare two conditions (e.g., Control vs. Stimulated), run the pipeline for each condition independently, then compare the resulting distribution assignments.

```r
# Assuming 'distr_df' has columns 'CTRL' and 'STIM' with distribution names
# Identify genes changing shape between conditions
shape_changes <- change_shape(distr_df)

# shape_changes$genes_change_shape: Genes with different distributions
# shape_changes$genes_unimodal_to_zi: Genes shifting between unimodal and zero-inflated
```

## Tips for Success
- **Parallelization**: Always use `BiocParallel` (e.g., `SnowParam`) as fitting GLMs for thousands of genes is computationally intensive.
- **Library Size**: The package uses the log of library sizes as an offset in the GLM to normalize for sequencing depth. Ensure your `lib.size` vector matches the columns of your count matrix.
- **Covariates**: Include biological or technical factors (like cell type or batch) in the `cexpr` argument to improve model accuracy.

## Reference documentation
- [The vignette for running scShapes (Rmd)](./references/vignette_scShapes.Rmd)
- [The vignette for running scShapes (Markdown)](./references/vignette_scShapes.md)