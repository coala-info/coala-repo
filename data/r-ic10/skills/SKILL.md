---
name: r-ic10
description: R package ic10 (documentation from project home).
homepage: https://cran.r-project.org/web/packages/ic10/index.html
---

# r-ic10

name: r-ic10
description: Classify breast cancer samples into the 10 integrative clusters (iC10) using gene expression and/or copy number data. Use this skill when performing molecular subtyping of breast tumors based on the Ali HR et al. (2014) framework to identify genomic and transcriptomic drivers.

# r-ic10

## Overview
The `ic10` package implements the iC10 classifier for breast cancer, as described by Ali HR et al. (2014). It assigns tumors to one of ten integrative clusters based on their copy number and/or gene expression profiles. The package utilizes a PAM (Prediction Analysis of Microarrays) classifier trained on the METABRIC dataset.

## Installation
To install the package from CRAN:

```r
install.packages("ic10")
```

Note: This package depends on `iC10TrainingData` and the Bioconductor package `impute`. You may need to install these dependencies separately:

```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("impute", "iC10TrainingData"))
```

## Workflow

1.  **Data Preparation**: Prepare your gene expression matrix (rows as genes, columns as samples) and/or copy number data.
2.  **Feature Matching**: Ensure your data uses compatible gene identifiers (typically Entrez IDs or Gene Symbols) that match the training set.
3.  **Classification**: Run the `iC10` function to predict the clusters.
4.  **Results Extraction**: Access the predicted class assignments and the posterior probabilities for each sample.

## Main Functions

### iC10()
The primary function for sample classification. It can handle expression data alone, copy number data alone, or both combined.

```r
# Basic usage with expression data
library(ic10)
results <- iC10(x = my_expression_data)

# Usage with both expression and copy number data
results <- iC10(x = my_expression_data, y = my_copy_number_data)
```

### compare()
Used to compare the results of the iC10 classification with other classification schemes or clinical features.

## Tips for Success
- **Missing Data**: The classifier is robust to missing features; it will train a PAM classifier using only the features available in your dataset that overlap with the iC10 signature.
- **Data Normalization**: Ensure your expression data is appropriately normalized (e.g., log-transformed) before classification to match the training distribution.
- **Training Data**: The package automatically loads the necessary training models from the `iC10TrainingData` package.

## Reference documentation
- [iC10 Home Page](./references/home_page.md)