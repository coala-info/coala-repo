---
name: bioconductor-all
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ALL.html
---

# bioconductor-all

name: bioconductor-all
description: Access and analyze the ALL (Acute Lymphoblastic Leukemia) data package from Bioconductor. Use this skill when you need to load the ALL dataset, explore its phenoData (clinical variables), or perform initial data filtering and classification tasks on this specific leukemia gene expression study.

# bioconductor-all

## Overview

The `ALL` package provides a classic Bioconductor `ExpressionSet` containing microarray data from 128 samples of patients with Acute Lymphoblastic Leukemia (ALL). The data includes 12,625 features (Affymetrix hgu95av2) and 21 clinical variables. It is a foundational dataset used for demonstrating bioinformatics workflows, differential expression, and machine learning in R.

## Loading the Data

To begin working with the dataset, load the library and the data object:

```r
library(ALL)
data(ALL)
# View a summary of the ExpressionSet
show(ALL)
```

## Exploring Phenotypic Data

The `phenoData` contains critical clinical metadata such as diagnosis, molecular biology, and remission status.

```r
# Access the clinical metadata
clinical_data <- pData(ALL)

# Summary of clinical variables
summary(clinical_data)

# Common variables of interest:
# ALL$BT: Type and stage of the disease (e.g., B, B1, B2, T, T1, etc.)
# ALL$mol.biol: Molecular biology (e.g., BCR/ABL, NEG, ALL1/AF4)
# ALL$sex: Patient gender
# ALL$age: Patient age
```

## Data Filtering and Pre-processing

A common workflow involves filtering genes based on variability (Coefficient of Variation) to reduce noise before analysis.

```r
# Calculate Coefficient of Variation (CV) for each gene
cv_values <- apply(exprs(ALL), 1, function(x) sd(x) / mean(x))

# Filter for genes with CV between 0.08 and 0.18
selected_genes <- cv_values > 0.08 & cv_values < 0.18
fALL <- ALL[selected_genes, ]

# Resulting ExpressionSet is smaller (e.g., ~3841 features)
show(fALL)
```

## Basic Analysis Workflow

### Preparing for Machine Learning
To use the expression data in standard R modeling functions (like `rpart` or `randomForest`), transpose the expression matrix and append the target class.

```r
# Create a data frame with genes as columns and samples as rows
analysis_df <- data.frame(t(exprs(fALL)), class = ALL$BT)
```

### Classification Example
Using the `rpart` package to build a decision tree to classify the disease stage based on gene expression:

```r
library(rpart)
# Fit a recursive partitioning model
tree_model <- rpart(class ~ ., data = analysis_df)

# Visualize the tree
plot(tree_model)
text(tree_model)
```

## Tips
- **Annotation**: The data uses the `hgu95av2` platform. Use the `hgu95av2.db` package if you need to map probe IDs to gene symbols.
- **Subsetting**: You can subset the `ExpressionSet` easily using standard R syntax: `ALL[, ALL$mol.biol %in% c("BCR/ABL", "NEG")]` to compare specific molecular subtypes.

## Reference documentation

- [Intro to ALL data for Bioc monograph](./references/ALLintro.md)