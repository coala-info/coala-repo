---
name: bioconductor-methped
description: This tool classifies pediatric brain tumors into nine subtypes using DNA methylation data and a Random Forest algorithm. Use when user asks to classify pediatric brain tumor subtypes, predict tumor categories from Illumina 450k beta values, or calculate conditional probabilities for brain tumor diagnostics.
homepage: https://bioconductor.org/packages/release/bioc/html/MethPed.html
---


# bioconductor-methped

## Overview

The `MethPed` package is a specialized tool for classifying pediatric brain tumors into nine distinct subtypes using DNA methylation data. It utilizes a Random Forest algorithm trained on a refined set of 900 highly predictive CpG sites (predictors). The classifier accepts beta values from Illumina 450k arrays and provides conditional probabilities for each tumor subtype, allowing for nuanced diagnostic support.

## Core Workflow

### 1. Data Preparation

MethPed requires input data as **beta values** (ranging from 0 to 1). The package supports three data classes:
*   **ExpressionSet**: Standard Bioconductor container.
*   **Matrix**: Probes in rows, samples in columns.
*   **Data.frame**: One column must contain probe IDs (TargetID); other columns are samples.

```R
library(MethPed)

# Load example data
data(MethPed_sample)

# Check for missing values (NAs) - MethPed requires complete data for the 900 predictors
missing_info <- checkNA(MethPed_sample)
print(missing_info)
```

### 2. Handling Missing Values

If `checkNA` reveals missing beta values, you must impute them before classification. The `impute` package (Bioconductor) is the recommended tool.

```R
if (!requireNamespace("impute", quietly = TRUE)) BiocManager::install("impute")
library(impute)

# Example: Imputing a matrix
# Note: If using ExpressionSet, extract matrix first via Biobase::exprs()
beta_matrix <- Biobase::exprs(MethPed_sample)
imputed_data <- impute.knn(beta_matrix)$data
```

### 3. Running the Classifier

The `MethPed` function is the primary interface.

```R
# Run with conditional probabilities (default)
myClassification <- MethPed(MethPed_sample, prob = TRUE)

# Run for binary classification (returns 1 for the highest probability group, 0 otherwise)
myClassification_bin <- MethPed(MethPed_sample, prob = FALSE)

# View results
summary(myClassification)
```

### 4. Interpreting Results

The output object (class `methped`) contains:
*   `$predictions`: A matrix of probabilities (or binary indicators) for the 9 tumor subtypes (DIPG, Ependymoma, ETMR, GBM, MB_Gr3, MB_Gr4, MB_SHH, MB_WNT, PiloAstro).
*   `$probes_missing`: List of the 900 internal predictors not found in your dataset.
*   `$oob_err.rate`: The out-of-bag error rate for the classification.

### 5. Visualization

You can quickly visualize the distribution of probabilities across subtypes using the S3 plot method.

```R
# Generate a barplot of probabilities
plot(myClassification)
```

## Utility Functions

*   `data(MethPed_900probes)`: Loads the list of CpG sites used by the classifier.
*   `probeMis(myClassification)`: Returns the names of the 900 predictor probes missing from the input data.
*   `checkNA(data)`: Returns a summary of missing values per sample and missing probe names.

## Reference documentation

- [MethPed A DNA Methylation Classifier Tool for the Identification of Pediatric Brain Tumor Subtypes](./references/MethPed-vignette.md)