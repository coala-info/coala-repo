---
name: bioconductor-breastcancermainz
description: This tool provides access to the Schmidt et al. (2008) breast cancer gene expression dataset containing microarray data for 200 node-negative patients. Use when user asks to load the MAINZ cohort, analyze metastasis-free survival data, or access Affymetrix hgu133a expression profiles for breast cancer research.
homepage: https://bioconductor.org/packages/release/data/experiment/html/breastCancerMAINZ.html
---


# bioconductor-breastcancermainz

name: bioconductor-breastcancermainz
description: A specialized skill for accessing and analyzing the Schmidt et al. (2008) breast cancer gene expression dataset (MAINZ). Use this skill when a user needs to load, subset, or perform bioinformatic analysis on the MAINZ cohort, which contains microarray data (Affymetrix hgu133a) for 200 node-negative breast cancer patients.

# bioconductor-breastcancermainz

## Overview

The `breastCancerMAINZ` package is a Bioconductor experiment data package providing an `ExpressionSet` (eSet) object named `mainz`. This dataset represents a study of 200 breast cancer patients who were not treated by systemic therapy after surgery. It is particularly useful for research involving prognostic motifs, proliferation-associated genes, and the role of the immune system (B-cell and T-cell infiltration) in metastasis-free survival.

## Data Access and Loading

To use this dataset, you must load the package and the data object explicitly.

```r
# Load the package
library(breastCancerMAINZ)

# Load the dataset into the environment
data(mainz)

# View the object summary
mainz
```

## Working with the ExpressionSet

The `mainz` object is a standard Bioconductor `ExpressionSet`. You can interact with it using the following methods:

### 1. Expression Data
Access the normalized gene expression matrix (22,283 features x 200 samples).
```r
exp_matrix <- exprs(mainz)
# Example: View first 5 rows and columns
exp_matrix[1:5, 1:5]
```

### 2. Phenotypic (Clinical) Data
Access patient metadata, including survival information and clinical markers.
```r
clinical_data <- pData(mainz)
head(clinical_data)

# Common columns include:
# samplename, dataset, series, id, title, outcome, 
# age, size, grade, er, pgr, her2, brca.mutation, 
# t.rfs, e.rfs, t.os, e.os, etc.
```

### 3. Feature Metadata
Access information about the Affymetrix hgu133a platform probes.
```r
feature_info <- fData(mainz)
head(feature_info)
```

### 4. Experiment Metadata
Retrieve the study abstract and MIAME (Minimum Information About a Microarray Experiment) details.
```r
abstract(mainz)
experimentData(mainz)
```

## Typical Workflow: Survival Analysis

A common use case for this dataset is validating a prognostic gene signature using the metastasis-free survival data provided in the phenotype metadata.

```r
library(Biobase)
library(survival)

# Extract survival time and event
surv_time <- pData(mainz)$t.rfs  # Time to relapse/metastasis
surv_event <- pData(mainz)$e.rfs # Event indicator

# Example: Compare survival based on ER status
surv_fit <- survfit(Surv(surv_time, surv_event) ~ er, data = pData(mainz))
plot(surv_fit, col = c("red", "blue"), lty = 1:2)
legend("bottomleft", legend = c("ER-", "ER+"), col = c("red", "blue"), lty = 1:2)
```

## Usage Tips
- **Platform**: The data uses the `hgu133a` annotation. If you need to map probes to Gene Symbols, use the `hgu133a.db` package.
- **Patient Cohort**: Note that these 200 patients were node-negative and did not receive systemic therapy, making this dataset ideal for studying the natural progression of the disease and endogenous prognostic markers.
- **Metagenes**: The original study focused on "metagenes" for proliferation and B-cell/T-cell infiltration. You can recreate these by averaging the expression of genes within those specific biological clusters.

## Reference documentation

- [Gene expression dataset published by Schmidt et al. [2008] (MAINZ)](./references/reference_manual.md)