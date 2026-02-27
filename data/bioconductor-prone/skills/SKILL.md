---
name: bioconductor-prone
description: PRONE evaluates and compares multiple normalization methods for proteomics data within the R Bioconductor framework. Use when user asks to load proteomics data into SummarizedExperiment objects, apply simultaneous normalization techniques, perform TMT batch correction, or evaluate normalization performance through comparative visualization and differential expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/PRONE.html
---


# bioconductor-prone

name: bioconductor-prone
description: Expert guidance for the PRONE R package (Proteomics Normalization Evaluator). Use this skill when performing proteomics data analysis in R, specifically for loading data into SummarizedExperiment objects, preprocessing, comparing multiple normalization methods (including TMT batch correction like IRS), performing imputation, and conducting differential expression analysis with comparative visualization.

# bioconductor-prone

## Overview

PRONE (Proteomics Normalization Evaluator) is a Bioconductor package designed for the comprehensive evaluation of normalization methods in proteomics workflows (LFQ and TMT). Its primary strength lies in its ability to apply multiple normalization techniques simultaneously to a single `SummarizedExperiment` object, allowing for side-by-side qualitative and quantitative comparison of how different normalization strategies affect downstream biological signals and differential expression results.

## Core Workflow

### 1. Data Loading
PRONE uses the `SummarizedExperiment` class. Use `load_data()` to initialize the object.

```r
library(PRONE)

# data: protein intensities; md: metadata
# Note: md must have a "Column" column matching sample names in data
se <- load_data(data, md, 
                protein_column = "Protein.IDs", 
                gene_column = "Gene.names", 
                batch_column = "Pool",        # Optional: for TMT batches
                ref_samples = ref_samples,    # Optional: for IRS normalization
                condition_column = "Group")
```

### 2. Preprocessing and Imputation
Clean the data by removing low-quality samples or proteins and handling missing values.

```r
# Remove samples manually if needed
se <- remove_samples_manually(se, "Label", c("Sample_A", "Sample_B"))

# Imputation (Mixed KNN for MAR and left-shifted Gaussian for MNAR)
se <- impute_se(se, ain = NULL) # ain=NULL processes all assays
```

### 3. Comparative Normalization
Apply multiple methods at once. Use the `combination_pattern` to chain basic normalization with batch correction (e.g., Internal Reference Scaling - IRS).

```r
# List available methods
get_normalization_methods()

# Apply multiple methods
se_norm <- normalize_se(se, 
                        methods = c("RobNorm", "Median", "IRS_on_RobNorm", "IRS_on_Median"), 
                        combination_pattern = "_on_")
```

### 4. Evaluation of Normalization
Evaluate which method best reduces technical bias while preserving biological variation.

*   **Visual Inspection**: `plot_boxplots()`, `plot_densities()`, and `plot_PCA()`.
*   **Intragroup Variation**: `plot_intragroup_correlation()`, `plot_intragroup_PCV()`, `plot_intragroup_PEV()`, and `plot_intragroup_PMAD()`.

```r
# Compare PCV reduction relative to log2 data
plot_intragroup_PCV(se_norm, ain = NULL, diff = TRUE)
```

### 5. Differential Expression (DE) Analysis
Run DE analysis across all normalization assays to see how method choice impacts results.

```r
# 1. Specify comparisons (Condition-Control)
comparisons <- c("Disease-Healthy")

# 2. Run DE using limma, DEqMS, or ROTS
de_res <- run_DE(se = se_norm, 
                 comparisons = comparisons,
                 DE_method = "limma", 
                 alpha = 0.05, 
                 logFC_up = 1)

# 3. Visualize DE overlaps (Upset plot)
plot_upset_DE(de_res, ain = NULL, plot_type = "stacked")
```

### 6. Functional Enrichment
Interpret the biological relevance of DE proteins using `gprofiler2` integration.

```r
enrich_res <- plot_intersection_enrichment(se, de_res, 
                                           comparison = "Disease-Healthy",
                                           id_column = "Gene.Names", 
                                           organism = "hsapiens", 
                                           source = "KEGG")
```

## Tips for Success
*   **Assay Management**: Use `names(assays(se_norm))` to keep track of the normalization versions stored in your object.
*   **TMT Reference Samples**: When working with TMT, use `remove_reference_samples(se_norm)` after normalization but before DE analysis.
*   **Subsetting**: If evaluation shows certain methods perform poorly, use `subset_SE_by_norm()` to keep only the promising ones for downstream steps.
*   **Thresholds**: Use `apply_thresholds(de_res, ...)` to update significance criteria without re-running the entire DE pipeline.

## Reference documentation
- [Getting started with PRONE](./references/PRONE.md)
- [Preprocessing Tutorial](./references/Preprocessing.md)
- [Imputation Tutorial](./references/Imputation.md)
- [Normalization Tutorial](./references/Normalization.md)
- [Differential Expression Tutorial](./references/Differential_Expression.md)
- [Spike-In Tutorial](./references/Spike_In_Data.md)