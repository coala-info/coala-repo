---
name: bioconductor-gaprediction
description: This tool predicts gestational age from DNA methylation data using Lasso-regression models. Use when user asks to estimate gestational age in days, predict pregnancy duration from CpG beta values, or identify required CpG sites for methylation analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/GAprediction.html
---


# bioconductor-gaprediction

name: bioconductor-gaprediction
description: Predicts gestational age (in days from conception) using DNA methylation data from Illumina HumanMethylation450 arrays. Use this skill when analyzing blood-based CpG beta values to estimate pregnancy duration using Lasso-regression models.

# bioconductor-gaprediction

## Overview

The `GAprediction` package provides a specialized Lasso-regression model for estimating gestational age based on DNA methylation patterns in blood samples. It is specifically designed for data from Illumina HumanMethylation450 arrays. The package translates CpG beta values (ranging from 0 to 1) into a predicted number of days from conception.

## Core Workflow

### 1. Data Preparation
The input must be a matrix or data frame where columns are CpG sites (named with Illumina identifiers like "cg00153101") and rows are samples.
- **Values**: Must be beta values between 0 and 1.
- **Missing Data**: The specific CpGs required for the model cannot contain `NA` values.

### 2. Identifying Required CpG Sites
To check which CpG sites are necessary for the prediction models, use `extractSites()`:

```r
# Get sites for the default model (one standard error)
needed_cpgs <- extractSites(type = "se")

# Get sites for the minimum lambda model
all_cpgs <- extractSites(type = "all")
```

### 3. Predicting Gestational Age
Use the `predictGA()` function to perform the estimation.

```r
library(GAprediction)

# Assuming 'mlmatr' is your data frame of beta values
# Default model (type = "se") is recommended as it uses fewer CpGs
predictions <- predictGA(mlmatr, type = "se")

# View results (returns a data frame with a 'GA' column in days)
head(predictions)
```

## Model Options

- `type = "se"` (Default): Uses a penalty parameter (lambda) within one standard error of the minimum. This model is more parsimonious (requires fewer CpG sites) while maintaining comparable accuracy.
- `type = "all"`: Uses the minimum lambda. This may provide slightly improved statistical predictions but requires a larger set of CpG sites to be present in the input data.

## Usage Tips

- **Input Compliance**: Ensure your CpG identifiers match the Illumina HumanMethylation450 array nomenclature exactly.
- **Interpretation**: The output is "Gestational Age" in days from conception. Note that in clinical settings, this is a statistical estimation based on DNA methylation patterns, not a direct measurement.
- **Data Cleaning**: Before running `predictGA`, subset your methylation matrix to the required sites and handle any missing values (imputation or removal) specifically for those sites.

## Reference documentation

- [GAprediction](./references/GAprediction.md)