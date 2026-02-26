---
name: maaslin3
description: MaAsLin 3 is a statistical framework for microbiome association discovery that simultaneously tests for feature abundance and prevalence while accounting for compositional data. Use when user asks to perform multivariable association testing, model random effects for repeated measures, or identify microbial biomarkers associated with specific metadata.
homepage: https://github.com/biobakery/maaslin3
---


# maaslin3

## Overview

MaAsLin 3 (Microbiome Multivariable Associations with Linear Models) is a statistical framework designed for meta-omic association discovery. It improves upon its predecessor by simultaneously testing for feature abundance (quantitative levels) and prevalence (presence/absence) while correcting for the compositional nature of microbiome data. It is the primary tool for epidemiological studies requiring complex modeling, such as random effects for repeated measures, interaction terms, or specific handling of ordered predictors.

## Installation

MaAsLin 3 is available via BiocManager in R or through Bioconda.

```r
# R installation
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("biobakery/maaslin3")
```

```bash
# Conda installation
conda install bioconda::maaslin3
```

## Input Data Requirements

MaAsLin 3 requires two primary inputs, typically as tab-delimited files:

1.  **Feature Abundance Table**: Per-sample feature abundances (taxonomy, genes, etc.). Zeros should be included. Data can be relative abundances or counts.
2.  **Metadata Table**: Per-sample metadata (age, gender, treatment, etc.).

**Note**: Samples do not need to be in the same order; MaAsLin 3 automatically aligns them and removes samples missing from either file.

## Command Line Usage

MaAsLin 3 can be executed via the command line using the `MaAsLin3.R` script (if available in your path) or as an R function.

### Basic CLI Pattern
```bash
MaAsLin3.R \
    --input_data features.tsv \
    --input_metadata metadata.tsv \
    --output output_folder \
    --formula "fixed_effect1 + fixed_effect2 + (1|random_effect)"
```

### Specifying Models
MaAsLin 3 supports two ways to define the statistical model:

*   **Formula (Recommended)**: Uses `lme4` syntax.
    *   Fixed effects: `variable1 + variable2`
    *   Random effects: `(1|subject_id)`
    *   Interactions: `variable1 * variable2`
*   **Vectors**: Use specific flags for different effect types:
    *   `--fixed_effects "age,gender"`
    *   `--random_effects "subject_id"`

## Expert Tips and Best Practices

### 1. Account for Sequencing Depth
Because MaAsLin 3 identifies prevalence (presence/absence) associations, sequencing depth (total reads) should be included as a covariate. Deeper sequencing increases the likelihood of detecting rare features, which can lead to spurious correlations if not controlled.

### 2. Handling Categorical Variables
If using categorical variables, MaAsLin 3 tests each level against a reference level (the first factor level).
*   **In R**: Set factor levels using `factor(metadata$var, levels = c("Ref", "Level1", ...))`.
*   **In CLI**: Use the syntax `variable,reference` (e.g., `--reference "disease,healthy;diet,control"`). Avoid spaces between the variable and the level.

### 3. Special Predictor Types
MaAsLin 3 introduces specific wrappers for the formula to handle complex data types:
*   `ordered(variable)`: For ordinal data (e.g., stages of a disease).
*   `group(variable)`: For group-level predictors.
*   `strata(variable)`: To perform stratified analysis (only one strata variable allowed).

### 4. Interpreting Coefficients
*   **Abundance Models**: A coefficient (coef) represents a $2^{coef}$ fold change in relative abundance per unit change of the metadatum.
*   **Prevalence Models**: A coefficient represents the change in log-odds of the feature being present per unit change of the metadatum.

### 5. Output Analysis
*   `all_results.tsv`: Contains coefficients, p-values, and FDR-corrected q-values.
*   `pval_individual` vs `pval_joint`: Use `pval_joint` to see if a metadatum is associated with a feature through *either* abundance or prevalence.

## Reference documentation
- [MaAsLin 3 GitHub Repository](./references/github_com_biobakery_maaslin3.md)
- [MaAsLin 3 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_maaslin3_overview.md)