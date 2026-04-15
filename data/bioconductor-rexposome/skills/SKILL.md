---
name: bioconductor-rexposome
description: This package provides a comprehensive framework for loading, preprocessing, and analyzing exposome data to study the relationship between environmental exposures and health outcomes. Use when user asks to load and coordinate exposure datasets, perform data quality checks, visualize exposure correlations, or conduct exposome-wide association studies (ExWAS).
homepage: https://bioconductor.org/packages/release/bioc/html/rexposome.html
---

# bioconductor-rexposome

name: bioconductor-rexposome
description: Comprehensive analysis of exposome data, including data loading, preprocessing, visualization, and association studies (ExWAS). Use when analyzing environmental exposures and their relationship with health outcomes using the R package rexposome. Supports both standard and multiple-imputed datasets.

# bioconductor-rexposome

## Overview
The `rexposome` package provides a framework for the analysis of the "exposome"—the measure of all lifetime exposures and their relation to health. It utilizes an S4 class called `ExposomeSet` to coordinate three types of data: exposure measurements, exposure descriptions (families), and subject phenotypes/outcomes.

## Typical Workflow

### 1. Data Loading
The package requires three coordinated datasets:
- **Exposures**: Matrix with individuals as rows and exposures as columns.
- **Description**: Metadata for exposures, defining "Family" groups.
- **Phenotypes**: Health outcomes and covariates for the same individuals.

```r
library(rexposome)

# From CSV files
exp <- readExposome(
  exposures = "exposures.csv",
  description = "description.csv",
  phenotype = "phenotypes.csv",
  exposures.samCol = "idnum",
  description.expCol = "Exposure",
  description.famCol = "Family",
  phenotype.samCol = "idnum"
)

# From data.frames
exp <- loadExposome(exposures = ee, description = dd, phenotype = pp, description.famCol = "Family")

# From a single combined table
exp <- loadExposome_plain(file = "data.csv", exposure.columns = c(2:10), phenotype.columns = c(11:15))
```

### 2. Pre-processing and Exploration
Before analysis, evaluate data quality and distributions.

- **Missing Data**: Use `tableMissings(exp, set = "exposures")` and `plotMissings(exp)`.
- **Normality**: Check distributions with `normalityTest(exp)` and visualize with `plotHistogram(exp, select = "ExposureName", show.trans = TRUE)`.
- **Standardization**: Essential for PCA. Use `standardize(exp, method = "normal")` (or "robust").
- **Imputation**: Use `imputation(exp)` for simple imputation or see the Multiple Imputation section.

### 3. Exposome Characterization
- **Visualization**: `plotFamily(exp, family = "all")` or group by phenotype: `plotFamily(exp, family = "Metals", group = "sex")`.
- **Correlation**: `exp_cr <- correlation(exp)`; visualize with `plotCorrelation(exp_cr, type = "circos")`.
- **PCA/FAMD**: `exp_pca <- pca(exp)`; visualize with `plotPCA(exp_pca, set = "all")`.
- **Clustering**: Group individuals by exposure profiles using `clustering(exp, method = hclust_func, cmethod = cutree_func)`.

### 4. Association Studies (ExWAS)
`rexposome` supports three main association approaches:

- **ExWAS (Univariate)**: Tests each exposure individually against an outcome.
  ```r
  # Gaussian for continuous, binomial for dichotomous
  res <- exwas(exp, formula = blood_pre ~ sex + age, family = "gaussian")
  plotExwas(res)
  ```
- **Inverse ExWAS**: Models exposure as the dependent variable.
  ```r
  res_inv <- invExWAS(exp, formula = ~ flu + sex)
  ```
- **Multivariate (Variable Selection)**: Uses Elastic Net to find a group of relevant exposures.
  ```r
  res_mew <- mexwas(exp, phenotype = "blood_pre", family = "gaussian")
  plotExwas(res_mew)
  ```

## Multiple Imputation
When using `mice` for multiple imputations, data must be converted to an `imExposomeSet`.

1.  Combine exposures and phenotypes into one data.frame.
2.  Run `mice` to create a `mids` object.
3.  Format the long-format data.frame to include `.imp` and `.id` columns.
4.  Load using `loadImputed()`:
    ```r
    ex_imp <- loadImputed(data = imputed_df, description = desc_df)
    ```
5.  Run `exwas(ex_imp, ...)` to perform pooled association tests.

## Tips for Success
- **ID Matching**: Ensure individual identifiers match exactly across the three input tables.
- **Family Column**: The "Family" column in the description file is critical for all grouping and visualization functions.
- **Effective Tests**: `exwas` automatically calculates the Threshold for Effective Tests (TEF) based on exposure correlations to adjust for multiple testing. Access it via `tef(res)`.

## Reference documentation
- [Exposome Data Analysis](./references/exposome_data_analysis.md)
- [Multiple Imputation Data Analysis](./references/mutiple_imputation_data_analysis.md)