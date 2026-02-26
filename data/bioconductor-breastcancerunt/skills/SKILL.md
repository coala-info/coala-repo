---
name: bioconductor-breastcancerunt
description: This package provides access to the Sotiriou et al. (2007) breast cancer gene expression dataset as a Bioconductor ExpressionSet. Use when user asks to load the UNT dataset, access breast cancer microarray data with clinical metadata, or analyze gene expression profiles related to histologic grade and prognosis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/breastCancerUNT.html
---


# bioconductor-breastcancerunt

name: bioconductor-breastcancerunt
description: Access and analyze the breast cancer gene expression dataset published by Sotiriou et al. (2007), provided as a Bioconductor ExpressionSet (eSet). Use this skill when a user needs to load, subset, or analyze the 'unt' dataset, which includes microarray data (Affymetrix hgu133a/hgu133b), clinical metadata, and gene annotations for 137 breast cancer samples.

## Overview

The `breastCancerUNT` package is a data experiment package containing the "UNT" (Untreated) breast cancer dataset. It provides an `ExpressionSet` object named `unt` which integrates gene expression profiles with clinical outcomes and sample annotations. This dataset is particularly noted for its focus on histologic grade and the development of the Gene Expression Grade Index (GGI) to improve prognosis in grade 2 tumors.

## Data Loading and Initial Inspection

To use the dataset, you must load the package and the data object:

```r
library(breastCancerUNT)
library(Biobase)

# Load the dataset
data(unt)

# Inspect the ExpressionSet object
unt
```

## Accessing Components

The `unt` object is a standard Bioconductor `ExpressionSet`. Use the following methods to access specific data types:

### 1. Expression Data
Contains the normalized gene expression values.
```r
# Get expression matrix (44928 features x 137 samples)
exp_matrix <- exprs(unt)
exp_matrix[1:5, 1:5]
```

### 2. Phenotypic (Clinical) Data
Contains patient metadata such as age, tumor size, nodes, estrogen receptor (ER) status, and histologic grade.
```r
# Get clinical metadata
clinical_data <- pData(unt)
head(clinical_data)

# Check available clinical variables
colnames(clinical_data)
```

### 3. Feature (Annotation) Data
Contains probe information and gene symbols.
```r
# Get probe annotations
feature_info <- fData(unt)
head(feature_info)
```

### 4. Metadata and Experiment Info
```r
# Show the platform used (Affymetrix hgu133a/hgu133b)
annotation(unt)

# Show the study abstract
abstract(unt)
```

## Common Workflows

### Filtering by Clinical Status
You can subset the dataset based on clinical variables, such as Estrogen Receptor (ER) status or Histologic Grade.

```r
# Subset for ER-positive samples only
unt_er_pos <- unt[, pData(unt)$er == 1]

# Subset for Grade 1 vs Grade 3 for differential expression analysis
unt_g13 <- unt[, pData(unt)$grade %in% c(1, 3)]
```

### Integration with Survival Analysis
The dataset is often used with the `survcomp` or `genefu` packages for survival modeling.

```r
# Example: Extracting survival time and event status
surv_time <- pData(unt)$t.rfs   # Time to relapse-free survival
surv_event <- pData(unt)$e.rfs  # Event indicator
```

## Usage Tips
- **Platform**: The data combines hgu133a and hgu133b chips. Ensure your downstream analysis accounts for this if mapping to specific probe sets.
- **Missing Values**: Always check for `NA` values in clinical columns (like `grade` or `node`) before performing statistical tests.
- **Gene Symbols**: Use `fData(unt)` to map Affy IDs to Gene Symbols for biological interpretation.

## Reference documentation
- [breastCancerUNT Reference Manual](./references/reference_manual.md)