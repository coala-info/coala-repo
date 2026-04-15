---
name: bioconductor-maaslin2
description: MaAsLin2 performs multivariable statistical association analysis between clinical metadata and microbial features using linear models. Use when user asks to find associations between metadata and microbial features, perform statistical analysis on multi-omics data, or handle fixed and random effects in longitudinal microbiome studies.
homepage: https://bioconductor.org/packages/release/bioc/html/Maaslin2.html
---

# bioconductor-maaslin2

name: bioconductor-maaslin2
description: Statistical analysis of microbial multi-omics data using linear models. Use this skill to find multivariable associations between clinical metadata and microbial features (taxa, genes, pathways) in cross-sectional or longitudinal studies. It supports various normalization (TSS, CLR, CSS), transformation (LOG, LOGIT), and model types (LM, CPLM, NEGBIN, ZINB) while handling fixed and random effects.

# bioconductor-maaslin2

## Overview
MaAsLin2 (Microbiome Multivariable Association with Linear Models) is the gold standard for determining associations between metadata and microbial features. It is designed to handle the unique challenges of microbiome data, such as sparsity, compositionality, and non-normal distributions. It accommodates complex study designs including repeated measures and multiple covariates.

## Core Workflow

### 1. Data Preparation
MaAsLin2 requires two inputs:
- **Feature Data**: A data frame or file path. Rows are samples, columns are features (e.g., species abundances).
- **Metadata**: A data frame or file path. Rows are samples, columns are clinical/environmental variables.

Note: MaAsLin2 automatically handles sample overlapping and alignment between the two inputs.

### 2. Running the Analysis
The primary function is `Maaslin2()`.

```r
library(Maaslin2)

fit_data <- Maaslin2(
    input_data = "path/to/features.tsv",     # or data.frame
    input_metadata = "path/to/metadata.tsv", # or data.frame
    output = "output_directory",
    fixed_effects = c("diagnosis", "age"),   # variables of interest
    random_effects = c("subject_id"),        # for longitudinal/nested data
    normalization = "TSS",                   # TSS, CLR, CSS, TMM, or NONE
    transform = "LOG",                       # LOG, LOGIT, AST, or NONE
    analysis_method = "LM",                  # LM, CPLM, NEGBIN, or ZINB
    reference = c("diagnosis,nonIBD")        # set reference level for factors
)
```

### 3. Key Parameters
- `fixed_effects`: Character vector of column names in metadata to include as predictors.
- `random_effects`: Character vector of column names for random intercepts (e.g., subject IDs for repeated measures).
- `reference`: A string specifying the reference level for categorical variables (format: `"variable,level"`).
- `min_abundance` / `min_prevalence`: Filtering thresholds to remove rare/low-abundance features before analysis.
- `standardize`: Boolean (default TRUE). Scales continuous metadata to the same range.

## Interpreting Results
The function returns a list and writes files to the `output` directory:
- `all_results.tsv`: Contains coefficients, standard errors, p-values, and BH-corrected q-values for every association.
- `significant_results.tsv`: Filtered list based on the `max_significance` threshold (default q < 0.25).
- `heatmap.pdf`: Visual summary of significant associations.
- `features/`: Folder containing the data after normalization and transformation steps.

## Tips for Success
- **Categorical Variables**: Ensure categorical metadata are factors. Use the `reference` argument to ensure the "control" group is the baseline for coefficients.
- **Zero-Inflation**: If your data is extremely sparse, consider `analysis_method = "CPLM"` (Compound Poisson Linear Model) or `"ZINB"` (Zero-Inflated Negative Binomial).
- **Normalization**: For relative abundance data (compositional), `normalization = "TSS"` with `transform = "LOG"` is a common default, but `normalization = "CLR"` is often preferred for robust compositional analysis.

## Reference documentation
- [Maaslin2](./references/maaslin2.Rmd)