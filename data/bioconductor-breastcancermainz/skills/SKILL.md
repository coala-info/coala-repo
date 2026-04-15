---
name: bioconductor-breastcancermainz
description: This package provides access to the Schmidt et al. (2008) breast cancer gene expression dataset containing clinical and microarray data for 200 node-negative patients. Use when user asks to load the MAINZ ExpressionSet, analyze metastasis-free survival in untreated breast cancer cohorts, or access clinical metadata and Affymetrix hgu133a expression profiles.
homepage: https://bioconductor.org/packages/release/data/experiment/html/breastCancerMAINZ.html
---

# bioconductor-breastcancermainz

name: bioconductor-breastcancermainz
description: Access and analyze the Schmidt et al. (2008) breast cancer gene expression dataset (MAINZ). Use this skill when you need to load, subset, or analyze the MAINZ clinical and microarray data (200 samples, Affymetrix hgu133a) for breast cancer research, specifically focusing on node-negative patients and immune system prognostic factors.

## Overview

The `breastCancerMAINZ` package is a Bioconductor ExperimentData package providing a curated `ExpressionSet` (eSet) from a landmark study by Schmidt et al. (2008). The dataset contains gene expression profiles for 200 breast cancer patients who did not receive systemic therapy after surgery. It is particularly valuable for studying metastasis-free survival (MFS) and the prognostic impact of metagenes related to proliferation, steroid hormone receptors, and B-cell/T-cell infiltration.

## Loading and Initializing Data

To use the dataset, you must load the package and the specific data object named `mainz`.

```r
# Load the necessary libraries
library(Biobase)
library(breastCancerMAINZ)

# Load the dataset
data(mainz)

# View the object summary
mainz
```

## Data Structure and Access

The `mainz` object is an `ExpressionSet`. Use standard `Biobase` methods to access its components:

- **Expression Data**: Access the normalized log2 intensity values.
  ```r
  exp_matrix <- exprs(mainz)
  # Dimensions: 22283 features x 200 samples
  ```
- **Phenotypic (Clinical) Data**: Access patient metadata, including survival time and ER status.
  ```r
  clinical_data <- pData(mainz)
  head(clinical_data)
  ```
- **Feature Data**: Access probe annotations for the Affymetrix hgu133a platform.
  ```r
  feature_info <- fData(mainz)
  ```

## Key Clinical Variables

The `pData(mainz)` contains several critical columns for survival analysis and stratification:
- `samplename`: Unique identifier.
- `er`: Estrogen receptor status (1 = positive, 0 = negative).
- `age`: Patient age at diagnosis.
- `size`: Tumor size.
- `grade`: Histological grade.
- `t.dmfs`: Time to distant metastasis-free survival (days).
- `e.dmfs`: Event indicator for distant metastasis (1 = event, 0 = censored).

## Typical Workflow: Survival Analysis

A common use case is evaluating the prognostic value of a specific gene or metagene using the `survcomp` or `survival` packages.

```r
library(survival)

# Example: Stratify by ER status and plot survival
surv_obj <- Surv(mainz$t.dmfs / 365, mainz$e.dmfs) # Convert days to years
fit <- survfit(surv_obj ~ er, data = pData(mainz))
plot(fit, col = c("red", "blue"), xlab = "Years", ylab = "Metastasis-free Survival")
```

## Usage Tips

- **Platform**: The data uses the `hgu133a` chip. If you need to map probes to Gene Symbols, use the `hgu133a.db` annotation package.
- **Untreated Cohort**: Remember that this specific cohort consists of patients who were **not** treated with systemic therapy (chemotherapy or hormone therapy), making it ideal for studying the natural history of the disease and pure prognostic markers.
- **Metagenes**: The original study emphasizes "metagenes" (clusters of co-regulated genes). You can recreate these by averaging the expression of genes associated with proliferation or B-cell infiltration.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)