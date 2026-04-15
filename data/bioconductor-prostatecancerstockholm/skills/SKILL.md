---
name: bioconductor-prostatecancerstockholm
description: This package provides access to the Stockholm prostate cancer validation cohort data from the Ross-Adams et al. (2015) study for transcriptomic and clinical analysis. Use when user asks to load the GSE70769 dataset, access prostate cancer clinical metadata, or perform survival analysis on biochemical relapse and iCluster risk groups.
homepage: https://bioconductor.org/packages/release/data/experiment/html/prostateCancerStockholm.html
---

# bioconductor-prostatecancerstockholm

name: bioconductor-prostatecancerstockholm
description: Access and analyze the Stockholm prostate cancer validation cohort data from the Ross-Adams et al. (2015) study. Use this skill to load the GSE70769 dataset, which includes transcriptomics and clinical metadata such as Gleason scores, biochemical relapse (BCR), and iCluster risk groups.

# bioconductor-prostatecancerstockholm

## Overview

The `prostateCancerStockholm` package is a Bioconductor data experiment package. It provides the Stockholm validation cohort data used in the study "Integration of copy number and transcriptomics provides risk stratification in prostate cancer" (Ross-Adams et al., 2015). The dataset consists of an `ExpressionSet` containing transcriptomic profiles and detailed clinical follow-up for prostate cancer patients.

## Data Access and Loading

To use the dataset, load the package and call the `stockholm` data object:

```r
library(prostateCancerStockholm)

# Load the ExpressionSet object
data(stockholm)

# View the object summary
stockholm
```

## Working with the Data

The `stockholm` object is an `ExpressionSet`. You can interact with it using standard Biobase methods.

### Accessing Clinical Metadata

The phenotypic data contains critical clinical variables for risk stratification:

```r
# Extract clinical data frame
clinical_data <- pData(stockholm)

# View available columns
colnames(clinical_data)
```

Key clinical columns include:
- `Gleason`: Gleason score.
- `iCluster`: Integrative clustering group (1-5) determined by Ross-Adams et al.
- `BCR`: Biochemical relapse status (1 = relapse, 0 = no relapse).
- `Time`: Time to biochemical relapse (months).
- `PSA`: PSA levels at diagnosis.
- `ECE`: Extra capsular extension.
- `PSM`: Positive surgical margins.
- `PathStage`: Pathological stage.
- `FollowUpTime`: Total follow-up time in months.

### Accessing Expression Data

To retrieve the processed transcriptomic data:

```r
# Get the expression matrix
expression_matrix <- exprs(stockholm)

# View first few rows and columns
expression_matrix[1:5, 1:5]
```

## Typical Workflow: Survival Analysis

A common use case for this dataset is validating risk groups (like iCluster) using survival analysis on biochemical relapse (BCR).

```r
library(survival)

# Prepare data for survival analysis
pd <- pData(stockholm)
# Ensure Time and BCR are numeric
pd$Time <- as.numeric(pd$Time)
pd$BCR <- as.numeric(pd$BCR)

# Fit survival curve based on iCluster groups
fit <- survfit(Surv(Time, BCR) ~ iCluster, data = pd)

# Plot the results
plot(fit, col = 1:5, lty = 1, main = "BCR-free Survival by iCluster")
legend("bottomleft", legend = levels(factor(pd$iCluster)), col = 1:5, lty = 1)
```

## Data Cleaning Notes

The data in this package has been pre-processed from GEO (GSE70769). Missing values are represented as `NA`. If performing custom analysis, ensure that factors like `Gleason` or `iCluster` are correctly leveled, as they may be stored as characters initially.

## Reference documentation

- [prostateCancerStockholm](./references/prostateCancerStockholm.md)