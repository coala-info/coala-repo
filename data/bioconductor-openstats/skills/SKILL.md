---
name: bioconductor-openstats
description: OpenStats performs robust and scalable statistical analysis of high-throughput phenotypic data using linear mixed models, reference range plus, and Fisher's exact test. Use when user asks to preprocess phenotypic datasets, identify abnormal phenotypes in experimental data, or perform statistical modeling on large-scale mouse phenotyping datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/OpenStats.html
---

# bioconductor-openstats

name: bioconductor-openstats
description: Robust and scalable statistical analysis of high-throughput phenotypic data. Use when analyzing experimental data (e.g., mouse phenotyping) to identify abnormal phenotypes using Linear Mixed Models (MM), Reference Range Plus (RR), or Fisher's Exact Test (FE).

## Overview

OpenStats is designed for the analysis of phenotypic data, providing a standardized pipeline from data cleaning to statistical reporting. It is particularly optimized for large-scale datasets like those from the International Mouse Phenotyping Consortium (IMPC). The package operates in three main layers:
1. **Preprocessing**: Terminology unification and data cleaning via `OpenStatsList`.
2. **Analysis**: Statistical modeling via `OpenStatsAnalysis` supporting Mixed Models (continuous), Reference Range Plus (continuous with many controls), and Fisher's Exact Test (categorical).
3. **Reporting**: Exporting results to R lists or JSON via `OpenStatsReport`.

## Data Preprocessing

Before analysis, data must be wrapped in an `OpenStatsList` object. This function unifies column names to a standard nomenclature: `Genotype` (mandatory), `Sex`, `Batch`, `LifeStage`, and `Weight`.

```r
library(OpenStats)

# Create OpenStatsList object
os_list <- OpenStatsList(
  dataset = my_data,
  testGenotype = "experimental",
  refGenotype = "control",
  dataset.colname.genotype = "genotype_column",
  dataset.colname.sex = "sex_column",
  dataset.colname.batch = "date_column",
  dataset.colname.weight = "weight_column",
  debug = FALSE
)

# Inspect the data
summary(os_list)
plot(os_list)
```

## Statistical Analysis

The `OpenStatsAnalysis` function serves as the central hub for all statistical frameworks.

### 1. Linear Mixed Models (MM)
Used for continuous data where "Batch" (e.g., date of experiment) is treated as a random effect.

```r
mm_results <- OpenStatsAnalysis(
  OpenStatsList = os_list,
  method = "MM",
  MM_fixed = data_point ~ Genotype + Sex + Weight,
  MM_random = ~ 1 | Batch
)
```

### 2. Reference Range Plus (RR)
Used for continuous data when there are many controls (n > 60). It classifies data as "low", "normal", or "high" based on the control distribution.

```r
rr_results <- OpenStatsAnalysis(
  OpenStatsList = os_list,
  method = "RR",
  RR_formula = data_point ~ Genotype + Sex,
  RR_prop = 0.95 # Central proportion considered 'normal'
)
```

### 3. Fisher's Exact Test (FE)
Used for categorical data to compare proportions between genotypes.

```r
fe_results <- OpenStatsAnalysis(
  OpenStatsList = os_list,
  method = "FE",
  FE_formula = category_variable ~ Genotype + Sex
)
```

## Reporting and Visualization

OpenStats provides specialized functions to summarize and export results.

- **Summary**: `summary(analysis_object)` provides a human-readable table of p-values and effect sizes.
- **Visualization**: `plot(analysis_object)` generates diagnostic plots (e.g., Residual vs Fitted for MM, or Mosaic plots for FE/RR).
- **Export**: `OpenStatsReport` creates a detailed list or JSON object suitable for automated pipelines.

```r
# Generate a JSON report
json_report <- OpenStatsReport(
  object = mm_results,
  JSON = TRUE,
  pretty = TRUE
)

# Split analysis by a variable (e.g., Sex-specific effects)
split_effects <- OpenStatsComplementarySplit(
  object = mm_results,
  variables = "Sex"
)
```

## Reference documentation
- [OpenStats](./references/OpenStats.md)