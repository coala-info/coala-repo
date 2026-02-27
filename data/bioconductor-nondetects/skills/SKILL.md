---
name: bioconductor-nondetects
description: This package models and imputes non-detect readings in qPCR threshold cycle data using a statistical framework. Use when user asks to handle undetermined Ct values, impute missing qPCR data, or model non-detects to avoid bias in differential expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/nondetects.html
---


# bioconductor-nondetects

name: bioconductor-nondetects
description: Methods to model and impute non-detects in qPCR data. Use this skill when analyzing qPCR threshold cycle (Ct) values that contain "undetermined" or missing readings (non-detects) to avoid bias introduced by simple substitution (e.g., replacing non-detects with 40).

# bioconductor-nondetects

## Overview

The `nondetects` package provides a statistical framework for handling non-detects in qPCR data. Instead of treating non-detects as missing at random or replacing them with an arbitrary maximum Ct value (which biases differential expression estimates), this package models the probability of a non-detect as a function of the underlying expression level. It uses an Expectation-Maximization (EM) algorithm to impute Ct values for non-detects based on a generative model.

## Core Workflow

### 1. Data Preparation
The package works with `qPCRset` objects (from the `HTqPCR` package). Ensure your data includes feature categories where non-detects are labeled as "Undetermined".

```r
library(nondetects)
library(HTqPCR)

# Load example data
data(oncogene2013)

# Optional: Normalize data (e.g., deltaCt) before or after imputation
# Note: The qpcrImpute function typically runs on raw Ct values
```

### 2. Imputing Non-detects
The primary function is `qpcrImpute`. It models the relationship between the observed Ct values and the probability of a non-detect.

```r
# Basic imputation
imputed_data <- qpcrImpute(oncogene2013, 
                           groupVars = c("sampleType", "treatment"), 
                           outform = "Multy", 
                           numsam = 5)

# Parameters:
# groupVars: Columns in pData(obj) defining experimental groups/replicates
# outform: "Multy" returns a list of imputed qPCRset objects; "Single" returns one
# vary_model: If TRUE, allows the missing data relationship to vary by group
# add_noise: If TRUE, adds random error to imputed values to represent uncertainty
```

### 3. Downstream Analysis
After imputation, you can treat the resulting `qPCRset` objects as standard qPCR data for normalization and differential expression analysis (e.g., using `limma` or `HTqPCR`).

```r
# Access the first imputed dataset
single_set <- imputed_data[[1]]

# Normalize the imputed data
norm_set <- normalizeCtData(single_set, norm = "deltaCt", deltaCt.genes = "Becn1")

# Check feature categories to see which values were imputed
table(featureCategory(norm_set))
```

## Key Functions

- `qpcrImpute`: The main engine for EM-based imputation of non-detects.
- `showGroupMethods`: Displays the grouping variables used in the model.

## Tips for Success

- **Replicates**: The imputation model relies on biological or technical replicates defined in `groupVars` to estimate the distribution of expression.
- **Multiple Imputation**: Setting `numsam > 1` and `outform = "Multy"` allows for multiple imputation. Analyzing several imputed datasets and pooling results is more statistically robust than using a single "best" imputation.
- **Convergence**: The function prints log-likelihood values during iterations. Ensure the model converges (values stabilize) for reliable results.
- **Normalization**: While you can impute raw data, ensure that any control genes used for subsequent normalization do not themselves contain non-detects, as this will propagate imputation uncertainty to all other genes.

## Reference documentation

- [Non-detects in qPCR data: methods to model and impute non-detects in the results](./references/nondetects.md)