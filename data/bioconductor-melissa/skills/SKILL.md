---
name: bioconductor-melissa
description: Melissa performs Bayesian clustering and imputation of single-cell DNA methylation data to identify cell subtypes and fill in missing CpG states. Use when user asks to cluster single-cell methylomes, impute missing methylation values, or analyze local correlations in sparse methylation data.
homepage: https://bioconductor.org/packages/release/bioc/html/Melissa.html
---


# bioconductor-melissa

name: bioconductor-melissa
description: Bayesian clustering and imputation of single-cell methylomes. Use this skill when analyzing single-cell DNA methylation data to jointly cluster cells and impute missing CpG methylation states using the Melissa probabilistic model.

# bioconductor-melissa

## Overview

Melissa (Bayesian clustering and imputation of single cell methylomes) is an R package designed to handle the sparsity of single-cell methylation data. It uses a Generalized Linear Model (GLM) to capture local correlations and a mixture modeling approach for global similarities. It is particularly useful for identifying cell subtypes and filling in missing methylation values across genomic regions like promoters.

## Core Workflow

### 1. Data Preparation
The package requires methylation data in a specific format: `<chr> <start> <met_level>`.

```R
library(Melissa)

# Binarise raw Bismark coverage files if necessary
binarise_files(indir = "path/to/raw_met", outdir = "path/to/binarised")

# Create the Melissa data object
# anno_file: tab-delimited (chr, start, end, strand, id)
met_obj <- create_melissa_data_obj(
  met_dir = "path/to/binarised",
  anno_file = "promoters.bed",
  cov = 5 # Minimum CpG coverage per region
)
```

### 2. Filtering Regions
Filter regions to improve clustering performance and reduce noise.

```R
# Filter by CpG coverage (sets low coverage regions to NA)
filt_obj <- filter_by_cpg_coverage(met_obj, min_cpgcov = 10)

# Filter by cell coverage (keep regions present in at least 50% of cells)
filt_obj <- filter_by_coverage_across_cells(filt_obj, min_cell_cov_prcg = 0.5)

# Filter by variability (keep regions that distinguish cell types)
filt_obj <- filter_by_variability(filt_obj, min_var = 0.1)
```

### 3. Model Inference
Run the Variational Bayes (VB) algorithm to cluster cells.

```R
# Define basis functions (usually RBF)
basis_obj <- BPRMeth::create_rbf_object(M = 3)

# Run Melissa clustering
# X: methylation list from the data object
# K: number of clusters
result <- melissa(X = filt_obj$met, K = 2, basis = basis_obj, is_parallel = TRUE)

# Access results
clusters <- result$labels
responsibilities <- result$r_nk
mixing_proportions <- result$pi_k
```

### 4. Imputation
Predict missing methylation states for specific cells or directories.

```R
# Impute missing values in a directory of files
impute_met_files(
  met_dir = "path/to/cells",
  obj = result,
  anno_region = filt_obj$anno_region,
  outdir = "path/to/imputed_results"
)
```

### 5. Evaluation and Visualization
Evaluate performance if ground truth is available and visualize profiles.

```R
# Plot methylation profiles for a specific genomic region
plot_melissa_profiles(result, region = 1)

# Evaluate clustering if true labels are known
perf <- eval_cluster_performance(result, C_true = true_labels)
```

## Key Functions
- `melissa()`: Main function for clustering and parameter estimation using Variational Bayes.
- `create_melissa_data_obj()`: Constructs the primary data structure from methylation files and annotation.
- `filter_by_variability()`: Selects informative regions for clustering.
- `impute_met_files()`: Generates imputed methylation files with a new "predicted" column.
- `partition_dataset()`: Useful for cross-validation by splitting data into training and test sets.

## Reference documentation
- [Melissa Reference Manual](./references/reference_manual.md)