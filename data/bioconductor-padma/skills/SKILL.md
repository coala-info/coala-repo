---
name: bioconductor-padma
description: bioconductor-padma quantifies individualized multi-omic pathway deviation from a reference population using Multiple Factor Analysis. Use when user asks to calculate pathway deviation scores, identify aberrant multi-omic profiles, or visualize gene and omic-level drivers of pathway variation.
homepage: https://bioconductor.org/packages/release/bioc/html/padma.html
---

# bioconductor-padma

name: bioconductor-padma
description: Individualized multi-omic pathway deviation analysis using Multiple Factor Analysis (MFA). Use this skill to calculate pathway-centric scores of deviation for individuals relative to a population, identify aberrant multi-omic profiles, and visualize gene or omic-level drivers of deviation.

# bioconductor-padma

## Overview
The `padma` package implements a method to quantify how much an individual's multi-omic profile (e.g., RNA-seq, methylation, copy number alterations) deviates from a reference population for a specific biological pathway. It uses Multiple Factor Analysis (MFA) to create a consensus representation of multi-omic data, providing individualized pathway deviation scores and per-gene contribution metrics.

## Core Workflow

### 1. Data Preparation
`padma` requires multi-omic data where individuals are matched across assays. Data should be normalized, batch-corrected, and log-transformed if necessary.

The preferred input format is a `MultiAssayExperiment` (MAE) object. Alternatively, a named list of matrices (rows = features, cols = individuals) can be used.

```r
library(padma)
library(MultiAssayExperiment)

# Example: Creating a MultiAssayExperiment
# omics_list: list of matrices (rnaseq, methyl, cna, etc.)
# pheno_data: data.frame with row names matching column names of omics
mae <- MultiAssayExperiment(experiments = omics_list, colData = pheno_data)
```

### 2. Running the Analysis
Use the `padma()` function. You must specify a pathway, either by a recognized name from the built-in `msigdb` dataset or a custom vector of gene symbols.

```r
# Using a built-in pathway name
run_padma <- padma(mae, pathway_name = "c2_cp_BIOCARTA_D4GDI_PATHWAY")

# Using custom gene symbols
my_genes <- c("CASP3", "CASP8", "CASP9")
run_padma <- padma(mae, pathway_name = my_genes)
```

### 3. Accessing Results
The output is a `padmaResults` S4 object.

*   **Pathway Deviation Scores:** Individualized scores (higher = more aberrant).
    ```r
    scores <- assay(run_padma)
    ```
*   **Gene-Specific Deviation:** Contribution of each gene to the individual's score.
    ```r
    gene_scores <- gene_deviation_scores(run_padma)
    ```
*   **MFA Details:** Eigenvalues and contributions.
    ```r
    mfa_info <- MFA_results(run_padma)
    ```

### 4. Visualization
`padma` provides specialized plotting functions (supports both `ggplot2` and base R).

*   **Factor Map:** Visualize individuals in the consensus space.
    ```r
    factorMap(run_padma, dim_x = 1, dim_y = 2)
    ```
*   **Partial Factor Map:** Visualize how specific genes drive the deviation for a single individual.
    ```r
    factorMap(run_padma, partial_id = "Patient_ID_001")
    ```
*   **Omics Contribution:** See which omic layer (e.g., RNA vs Methylation) contributes most to the variance.
    ```r
    omicsContrib(run_padma)
    ```

## Advanced Options

### Reference vs. Supplementary Individuals
You can define a "Base" population to build the MFA consensus and project "Supplementary" individuals onto it. This is useful for comparing diseased individuals against a healthy reference.

```r
run_padma <- padma(mae, 
                   pathway_name = "PATHWAY_NAME",
                   base_ids = c("Normal1", "Normal2"), 
                   supp_ids = c("Tumor1", "Tumor2"))
```

### Missing Data
By default, `padma` uses mean imputation. For more sophisticated MFA-based imputation (via `missMDA`), set `impute = TRUE`.

```r
run_padma <- padma(mae, pathway_name = "PATHWAY_NAME",驻 impute = TRUE)
```

### Memory Management
For large-scale analyses (e.g., looping over many pathways), use `full_results = FALSE` to save space by only storing summary statistics.

```r
run_padma <- padma(mae, pathway_name = "PATHWAY_NAME", full_results = FALSE)
```

## Reference documentation
- [padma Quick-start guide](./references/padma.md)