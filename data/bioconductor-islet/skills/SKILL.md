---
name: bioconductor-islet
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ISLET.html
---

# bioconductor-islet

name: bioconductor-islet
description: Individual-specific and cell-type-specific deconvolution and differential expression analysis. Use when analyzing bulk sequencing or microarray data with known cell type proportions to: (1) Infer subject-specific reference panels, (2) Perform cell-type-specific differential expression (csDE) analysis for mean (intercept) or change-rate (slope) differences, or (3) Improve cell deconvolution accuracy using personalized profiles.

# bioconductor-islet

## Overview

ISLET (Individual-Specific ceLl typE referencing Tool) is an R package designed for deconvolution when multiple observations or temporal measurements are available for the same subject. Unlike traditional methods that assume a single shared reference panel, ISLET estimates subject-specific and cell-type-specific reference panels using an Expectation-Maximization (EM) algorithm. It also provides robust testing for cell-type-specific differential expression (csDE) in both baseline levels (intercept) and rates of change (slope) over time or age.

## Data Requirements

ISLET requires data formatted as a `SummarizedExperiment` object. The structure of `colData` is strictly enforced:

1.  **Column 1**: Group status (e.g., "case" vs "ctrl").
2.  **Column 2**: Subject IDs (mapping samples to individuals).
3.  **Column 3 (for Slope tests)**: Continuous covariate (e.g., age or time).
4.  **Remaining Columns**: Cell type proportions (must sum to 1).

**Note**: Subjects must be sorted so that repeated measurements for the same individual are contiguous.

## Typical Workflows

### 1. Individual-Specific Reference Deconvolution

To estimate the underlying gene expression profiles for each cell type within each individual:

```r
library(ISLET)

# 1. Prepare data (Standard Intercept model)
# Assumes reference panel is stable across time points for a subject
input_data <- dataPrep(dat_se = your_se_object)

# 2. Solve for individual-specific panels
res_sol <- isletSolve(input = input_data)

# 3. Extract results
case_profiles <- caseEst(res_sol) # List of matrices (one per cell type)
ctrl_profiles <- ctrlEst(res_sol)
```

### 2. Testing for Cell-Type-Specific Differential Expression (csDE)

To identify genes where the expression in a specific cell type differs between groups:

```r
# Use the same prepared input from dataPrep
res_test <- isletTest(input = input_data)

# Result is a matrix of p-values (Genes x Cell Types)
head(res_test)
```

### 3. Slope Testing (Longitudinal/Age Analysis)

To test if the rate of change in cell-type-specific expression differs between groups:

```r
# 1. Prepare data using the slope-specific function
# Requires the 3rd column of colData to be the time/age covariate
slope_input <- dataPrepSlope(dat_se = your_se_object)

# 2. Run the test
age_test <- isletTest(input = slope_input)
```

### 4. Improving Cell Proportions (imply)

The `imply` workflow uses personalized reference profiles to refine initial cell type proportion estimates (e.g., those from CIBERSORT):

```r
# 1. Prepare data for imply
imply_input <- implyDataPrep(sim_se = your_se_object)

# 2. Run the refinement
result <- imply(imply_input)

# 3. Access improved proportions
refined_props <- result$imply.prop
personalized_refs <- result$p.ref
```

## Tips for Success

*   **Parallel Computing**: ISLET uses `BiocParallel`. Ensure your environment supports parallel backends for large datasets.
*   **Input Values**: ISLET works with raw counts (without library size batch effects) or normalized values like TPM.
*   **Subject Sorting**: Always ensure your `SummarizedExperiment` is sorted by `subject_ID` before calling `dataPrep`.
*   **Missing Values**: The EM algorithm treats subject-specific panels as missing values to be estimated; ensure your bulk data does not have excessive actual `NA` values in the expression matrix.

## Reference documentation

- [Individual-specific and cell-type-specific deconvolution using ISLET](./references/ISLET.md)