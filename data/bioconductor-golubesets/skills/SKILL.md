---
name: bioconductor-golubesets
description: This package provides access to the landmark Golub et al. (1999) leukemia gene expression dataset in ExpressionSet format. Use when user asks to load the Golub ALL/AML dataset, access leukemia gene expression samples for machine learning, or perform differential expression analysis on classic cancer datasets.
homepage: https://bioconductor.org/packages/release/data/experiment/html/golubEsets.html
---

# bioconductor-golubesets

name: bioconductor-golubesets
description: Access and utilize the Golub et al. (1999) leukemia gene expression dataset. Use this skill when you need to load, analyze, or demonstrate machine learning and statistical methods on the classic ALL/AML dataset (Affymetrix Hgu6800 chips, 7129 genes) provided in ExpressionSet format.

# bioconductor-golubesets

## Overview
The `golubEsets` package provides the landmark dataset from Golub et al. (1999), "Molecular Classification of Cancer: Class Discovery and Class Prediction by Gene Expression Monitoring." It contains gene expression data for 72 patients with either Acute Lymphoblastic Leukemia (ALL) or Acute Myeloid Leukemia (AML). The data is structured as `ExpressionSet` objects, making it compatible with standard Bioconductor workflows for differential expression and classification.

## Data Loading and Objects
The package contains three primary datasets. Note that the original names (e.g., `golubMerge`) are deprecated in favor of CamelCase versions.

*   **Golub_Merge**: The combined dataset of all 72 samples (47 ALL, 25 AML).
*   **Golub_Train**: The initial training set (38 samples: 27 ALL, 11 AML).
*   **Golub_Test**: The independent test set (34 samples: 20 ALL, 14 AML).

### Loading Data
```R
library(golubEsets)

# Load the combined dataset
data(Golub_Merge)

# Inspect the ExpressionSet
Golub_Merge
```

## Workflow and Usage

### 1. Accessing Expression Data and Metadata
Since the data is in `ExpressionSet` format, use `Biobase` methods to extract information.

```R
library(Biobase)

# Extract expression matrix (7129 features x 72 samples)
exp_matrix <- exprs(Golub_Merge)

# Extract sample metadata (phenoData)
metadata <- pData(Golub_Merge)

# View available covariates
colnames(metadata)
```

### 2. Key Covariates
The `pData` contains 11 covariates. The most critical for analysis are:
*   `ALL.AML`: Factor indicating the leukemia type (ALL or AML).
*   `T.B.cell`: For ALL patients, specifies T-cell or B-cell lineage.
*   `BM.PB`: Source of the sample (Bone Marrow or Peripheral Blood).
*   `Gender`: Patient gender.
*   `FAB`: French-American-British classification.

### 3. Basic Analysis Example
A common task is identifying differentially expressed genes between ALL and AML.

```R
# Simple comparison of means for a specific probe
all_indices <- which(Golub_Merge$ALL.AML == "ALL")
aml_indices <- which(Golub_Merge$ALL.AML == "AML")

# Example: First probe
t.test(exprs(Golub_Merge)[1, all_indices], exprs(Golub_Merge)[1, aml_indices])
```

## Tips and Best Practices
*   **Deprecated Names**: Always prefer `Golub_Merge`, `Golub_Train`, and `Golub_Test` over the lowercase versions to avoid deprecation warnings.
*   **Feature IDs**: The features are Affymetrix Hgu6800 probe IDs. To map these to Gene Symbols, you may need the `hu6800.db` annotation package.
*   **Preprocessing**: The data in this package has been "transformed slightly" from the original source. If you require raw CEL files or specific normalization (like RMA), you may need to look for the `ALL` package or original repositories, as `golubEsets` provides processed `ExpressionSet` objects.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)