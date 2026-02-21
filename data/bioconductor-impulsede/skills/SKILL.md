---
name: bioconductor-impulsede
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/ImpulseDE.html
---

# bioconductor-impulsede

## Overview
ImpulseDE is an R package designed to detect differentially expressed (DE) genes in time course experiments. It utilizes the "impulse model," a parametric model that captures the two-step response (increase/decrease followed by a return to baseline or a new steady state) often seen in biological systems responding to environmental changes. It supports two main scenarios:
1. **1TK (Single Time Course):** Identifies genes changing significantly over time within one condition.
2. **2TK (Two Time Courses):** Identifies genes behaving differently between a case and a control condition over time.

## Data Requirements
Before running the analysis, ensure your data meets these criteria:
- **Expression Table:** Numeric matrix/data frame with genes in rows and samples in columns. Data must be normalized and log2-transformed.
- **Annotation Table:** Data frame with at least two columns:
    - `Time`: Numeric timestamps for each sample.
    - `Condition`: Character strings identifying the group (e.g., "case", "control").
- **Sample IDs:** Row names of the annotation table must match the column names of the expression table.
- **Constraints:** No missing values allowed. At least 6 time points are required for the 6-parameter impulse model. Genes with a coefficient of variation < 0.025 are automatically excluded from fitting.

## Core Workflow

### 1. Running Differential Expression Analysis
The primary function is `impulse_DE()`. It handles clustering, model fitting (to clusters and individual genes), bootstrapping for p-value estimation, and FDR correction.

```r
library(ImpulseDE)

# Scenario 1: Single Time Course (1TK)
impulse_results <- impulse_DE(
  expression_table = exp_data,
  annotation_table = annot_data,
  colname_time = "Time",
  colname_condition = "Condition",
  control_timecourse = FALSE
)

# Scenario 2: Case vs. Control (2TK)
impulse_results_2tk <- impulse_DE(
  expression_table = exp_data,
  annotation_table = annot_data,
  colname_time = "Time",
  colname_condition = "Condition",
  control_timecourse = TRUE,
  control_name = "control",
  case_name = "case" # Optional if only two conditions exist
)
```

**Key Parameters:**
- `n_iter`: Number of iterations for optimization (default 100).
- `n_randoms`: Number of randomizations for bootstrapping (default 50,000).
- `n_process`: Number of cores for parallelization.
- `Q_value`: FDR-adjusted p-value cutoff (default 0.01).

### 2. Interpreting Results
The output is a list containing:
- `impulse_fit_results`: Parameters for the fitted models and calculated impulse values.
- `DE_results`: 
    - `DE_genes`: Names of genes passing the Q-value threshold.
    - `pvals_and_flags`: Adjusted p-values and status flags for all genes.
- `clustering_results`: Gene-to-cluster assignments and cluster mean profiles.

### 3. Visualization
Use `plot_impulse()` to visualize the fits for specific genes.

```r
plot_impulse(
  gene_IDs = c("GENE1", "GENE2"),
  data_table = exp_data,
  data_annotation = annot_data,
  imp_fit_genes = impulse_results$impulse_fit_results,
  control_timecourse = FALSE # Set TRUE for 2TK
)
```

### 4. Value Imputation
To predict the expression value at a specific time point (e.g., time 60) not present in the original data, use `calc_impulse()` with the fitted parameters.

```r
# Extract parameters for a specific gene (first 6 columns are the parameters)
params <- impulse_results$impulse_fit_results$impulse_parameters_case["GENE1", 1:6]
predicted_val <- calc_impulse(params, 60)
```

## Tips for Success
- **Parallelization:** Always set `n_process` to match your available CPU cores to significantly speed up the bootstrapping step.
- **Filtering:** Pre-filter your expression matrix to remove lowly expressed or non-variable genes to reduce the computational burden.
- **Device Handling:** In interactive sessions, `new_device = TRUE` (default) opens a new window for every plot. Set to `FALSE` if plotting to a single PDF or notebook.

## Reference documentation
- [ImpulseDE Vignette (Rmd)](./references/ImpulseDE.Rmd)
- [ImpulseDE Vignette (Markdown)](./references/ImpulseDE.md)