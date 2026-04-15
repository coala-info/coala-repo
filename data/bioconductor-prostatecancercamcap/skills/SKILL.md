---
name: bioconductor-prostatecancercamcap
description: This tool provides access to the Cambridge prostate cancer dataset containing transcriptomics, copy number alterations, and clinical metadata for 482 samples. Use when user asks to load the CamCap cohort data, analyze prostate cancer subgroups, or perform survival analysis using biochemical relapse and Gleason score metadata.
homepage: https://bioconductor.org/packages/release/data/experiment/html/prostateCancerCamcap.html
---

# bioconductor-prostatecancercamcap

name: bioconductor-prostatecancercamcap
description: Access and utilize the Cambridge (CamCap) prostate cancer dataset. Use this skill to load the Ross-Adams et al. (2015) cohort data, which includes transcriptomics, copy number alterations (CNA), and clinical metadata for 482 samples (259 men) used for integrative clustering and risk stratification.

## Overview

The `prostateCancerCamcap` package is a Bioconductor data experiment package providing a processed ExpressionSet object named `camcap`. This dataset represents a significant discovery and validation cohort for primary prostate cancer, featuring integrated genomics (mRNA expression and CNA) linked to clinical outcomes like biochemical relapse (BCR) and Gleason scores.

The data is primarily used for:
- Studying prostate cancer subgroups (iCluster groups 1-5).
- Analyzing expression quantitative trait loci (eQTL).
- Validating prognostic signatures in prostate cancer.

## Loading the Data

To use the dataset, load the library and the specific data object:

```r
library(prostateCancerCamcap)

# Load the ExpressionSet object
data(camcap)

# Inspect the object
camcap
```

## Working with the Dataset

The `camcap` object is an `ExpressionSet`. You can interact with it using standard Biobase methods.

### Accessing Clinical Metadata
The phenotype data contains critical clinical variables including Gleason score, iCluster group, and biochemical relapse status.

```r
library(Biobase)

# Extract clinical data
clinical_data <- pData(camcap)

# View available columns
colnames(clinical_data)

# Key columns:
# - iCluster: Integrative clustering group (clust1 to clust5)
# - Gleason: Pathological Gleason score
# - BCR: Biochemical relapse status (Y/N)
# - TotalTime: Time to BCR (months)
# - PSA: PSA at diagnosis
```

### Accessing Expression Data
To retrieve the processed transcriptomics matrix:

```r
exp_matrix <- exprs(camcap)
```

## Typical Workflow: Survival Analysis

A common use case for this data is performing survival analysis based on the provided iCluster groups or specific gene expression.

```r
library(survival)

# Prepare data for survival analysis
pd <- pData(camcap)
pd$BCR_numeric <- ifelse(pd$BCR == "Y", 1, 0)
pd$TotalTime <- as.numeric(pd$TotalTime)

# Fit survival curve by iCluster
fit <- survfit(Surv(TotalTime, BCR_numeric) ~ iCluster, data = pd)
plot(fit, col = 1:5, main = "BCR-free Survival by iCluster")
legend("bottomleft", levels(factor(pd$iCluster)), col = 1:5, lty = 1)
```

## Data Processing Notes
- **iCluster Groups**: These were determined via integrative clustering of CNA and transcriptomics.
- **Missing Values**: Clinical data uses `NA` for unknown or non-applicable values (e.g., "N/A" or "unknown" in the original GEO source were cleaned during package creation).
- **Gleason Scores**: These are factored and ordered (e.g., "6=3+3", "7=3+4", etc.).

## Reference documentation

- [prostateCancerCamcap](./references/prostateCancerCamcap.md)