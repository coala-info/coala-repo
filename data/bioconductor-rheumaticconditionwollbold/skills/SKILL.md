---
name: bioconductor-rheumaticconditionwollbold
description: This package provides a normalized gene expression dataset from synovial membrane samples of patients with rheumatic conditions stored as an ExpressionSet object. Use when user asks to load the wollbold dataset, access rheumatic disease microarray data, or analyze gene expression in synovial fibroblasts.
homepage: https://bioconductor.org/packages/release/data/experiment/html/rheumaticConditionWOLLBOLD.html
---


# bioconductor-rheumaticconditionwollbold

name: bioconductor-rheumaticconditionwollbold
description: Access and analyze the Wollbold et al. (2009) rheumatic disease gene expression dataset. Use this skill when a user needs to load, subset, or perform exploratory data analysis on the 'wollbold' ExpressionSet, which contains normalized microarray data (Affymetrix hgu133plus2) from synovial membrane samples of patients with rheumatic conditions.

# bioconductor-rheumaticconditionwollbold

## Overview
The `rheumaticConditionWOLLBOLD` package is a Bioconductor ExperimentData package providing a normalized gene expression dataset from a study by Wollbold et al. (2009). The data is stored as an `ExpressionSet` object named `wollbold`, featuring 54,675 features (probesets) and 60 samples. The study focused on the regulation of the extra-cellular matrix (ECM) in rheumatoid arthritis (RA) and other rheumatic diseases, specifically looking at synovial fibroblasts stimulated by TGFB1 or TNFa.

## Loading the Data
To use the dataset, you must load the package and the data object. Since it is an `ExpressionSet`, the `Biobase` package is required for standard accessor functions.

```r
# Load the package
library(rheumaticConditionWOLLBOLD)
library(Biobase)

# Load the dataset
data(wollbold)

# Inspect the object
wollbold
```

## Data Structure and Accessors
The `wollbold` object follows the standard `eSet` structure. Use the following methods to extract specific components:

- **Expression Matrix**: Access the normalized (RMA) log2 expression values.
  ```r
  exp_matrix <- exprs(wollbold)
  # View first few rows and columns
  exp_matrix[1:5, 1:5]
  ```
- **Phenotype Data**: Access clinical information and sample metadata (e.g., disease state, stimulation conditions).
  ```r
  clinical_data <- pData(wollbold)
  head(clinical_data)
  ```
- **Feature Data**: Access probe annotations for the Affymetrix hgu133plus2 platform.
  ```r
  feature_info <- fData(wollbold)
  head(feature_info)
  ```
- **Experiment Metadata**: Access the study abstract and MIAME information.
  ```r
  abstract(wollbold)
  experimentData(wollbold)
  ```

## Common Workflows

### Filtering by Gene or Probe
To focus on specific genes related to the study (e.g., ECM formation or destruction like MMPs or Collagens), use the `featureNames` or subsetting capabilities:

```r
# Find specific probes (example: MMP1)
# Note: Requires mapping probe IDs to symbols if not already in fData
library(hgu133plus2.db)
# Example subsetting for the first 100 probes
subset_wollbold <- wollbold[1:100, ]
```

### Group Comparisons
The dataset is often used to compare different rheumatic conditions or stimulation effects. Check the columns in `pData(wollbold)` to identify grouping variables for differential expression analysis.

```r
# Check available variables
colnames(pData(wollbold))

# Example: Table of conditions
table(wollbold$condition) # Replace 'condition' with actual column name from pData
```

## Tips
- **Normalization**: The data is already normalized using the Robust Multi-Array (RMA) average method. No further initial normalization is required for standard analysis.
- **Platform**: The data uses the `hgu133plus2` annotation. For updated gene mapping, use the `hgu133plus2.db` Bioconductor annotation package.
- **Memory**: As an ExperimentData package, the object is loaded into memory. Ensure you have `Biobase` loaded to interact with the `ExpressionSet` effectively.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)