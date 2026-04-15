---
name: bioconductor-breastcancertransbig
description: This package provides access to the TRANSBIG breast cancer gene expression dataset containing microarray data and clinical metadata for 198 node-negative patients. Use when user asks to load the transbig ExpressionSet, perform survival analysis on breast cancer patients, or validate prognostic gene signatures.
homepage: https://bioconductor.org/packages/release/data/experiment/html/breastCancerTRANSBIG.html
---

# bioconductor-breastcancertransbig

name: bioconductor-breastcancertransbig
description: Access and analyze the TRANSBIG breast cancer gene expression dataset (Desmedt et al., 2007). Use this skill to load the 'transbig' ExpressionSet, which includes microarray data (Affymetrix hgu133a), clinical metadata for 198 node-negative patients, and probe annotations for breast cancer research and survival analysis.

# bioconductor-breastcancertransbig

## Overview
The `breastCancerTRANSBIG` package is a Bioconductor experiment data package. It provides a specific dataset from a multicenter independent validation study published by Desmedt et al. (2007). The data is encapsulated in an `ExpressionSet` object, making it compatible with standard Bioconductor workflows for transcriptomics, such as `limma`, `genefu`, and `survcomp`.

The dataset consists of 198 samples from lymph node-negative (N-) breast cancer patients who were systemically untreated. It is primarily used for validating prognostic signatures (like the 76-gene signature) and performing survival analysis.

## Loading the Dataset
To use the data, you must load the library and then use the `data()` function to bring the `transbig` object into your environment.

```r
# Load the package
library(breastCancerTRANSBIG)

# Load the dataset
data(transbig)

# View the object summary
transbig
```

## Data Structure and Access
The `transbig` object is an `ExpressionSet`. You can access its components using standard `Biobase` accessor functions:

- **Expression Data**: Access the log-transformed (if applicable) or raw intensity matrix.
  ```r
  exp_matrix <- exprs(transbig)
  # Rows are probes (22,283), columns are samples (198)
  ```

- **Phenotypic Data (Clinical)**: Access patient metadata, including survival time, event status, and clinical risk factors.
  ```r
  clinical_data <- pData(transbig)
  head(clinical_data)
  ```

- **Feature Data (Annotations)**: Access information about the Affymetrix hgu133a probes.
  ```r
  feature_info <- fData(transbig)
  ```

- **Metadata**: Access study information and the abstract.
  ```r
  experimentData(transbig)
  abstract(transbig)
  ```

## Common Workflows

### 1. Survival Analysis Preparation
The clinical data in `transbig` is often used for survival modeling. You can extract time-to-event data:
```r
library(survival)
# Example: Extracting distant metastasis-free survival (DMFS)
# Note: Column names may vary; check colnames(pData(transbig))
surv_time <- pData(transbig)$t.dmfs
surv_event <- pData(transbig)$e.dmfs
```

### 2. Gene-Specific Analysis
To look at the expression of a specific probe across samples:
```r
# Get expression for a specific probe (e.g., ESR1/ER)
probe_id <- "205225_at" 
er_expression <- exprs(transbig)[probe_id, ]
```

### 3. Integration with genefu
This dataset is frequently used with the `genefu` package to calculate breast cancer subtypes (PAM50, SCMOD2) or risk scores:
```r
library(genefu)
# Example: Subtyping or signature validation
# Requires mapping Affy IDs to Gene Symbols
```

## Tips
- **Platform**: The data uses the `hgu133a` platform. Ensure your probe mapping or annotation packages (`hgu133a.db`) match this.
- **Normalization**: The data is provided as processed by the original authors; check `experimentData(transbig)` for specific preprocessing details if you intend to perform differential expression.
- **Patient Cohort**: Remember that this cohort consists of **node-negative, systemically untreated** patients, which is a specific clinical context for prognosis.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)