---
name: bioconductor-grridge
description: The GRridge package performs adaptive group-regularized ridge regression for high-dimensional data by incorporating external co-data to estimate group-specific penalties. Use when user asks to perform group-regularized ridge regression, incorporate co-data into predictive models, create feature partitions, or select relevant features from high-dimensional biological datasets.
homepage: https://bioconductor.org/packages/3.8/bioc/html/GRridge.html
---

# bioconductor-grridge

## Overview

The `GRridge` package implements adaptive group-regularized ridge regression. It is designed for high-dimensional data (like DNA methylation or RNA-seq) where external information about the features—referred to as **co-data**—is available. By grouping features based on this co-data, the package estimates group-specific penalties, allowing more relevant feature groups to contribute more to the model.

## Core Workflow

### 1. Data Preparation
The package requires a primary data matrix (features in rows, samples in columns) and a response vector (binary, continuous, or survival).

```R
library(GRridge)
data(dataFarkas)
# datcenFarkas: matrix of features
# respFarkas: factor/vector of response
```

### 2. Creating Partitions (Co-data)
Partitions define how features are grouped.
- **Categorical co-data:** Use `CreatePartition()` on a factor.
- **Continuous co-data:** Use `CreatePartition()` on a numeric vector (e.g., standard deviations) to create rank-based groups.
- **Overlapping groups:** Use `matchGeneSets()` for pathways where a gene may belong to multiple sets.

```R
# Categorical partition
part1 <- CreatePartition(CpGannFarkas)

# Numeric partition (e.g., by SD)
sds <- apply(datcenFarkas, 1, sd)
part2 <- CreatePartition(sds, decreasing=FALSE, uniform=TRUE, grsize=5000)

# Combine into a list
partitions <- list(cpg=part1, sds=part2)
```

### 3. Model Fitting
The `grridge()` function fits the model. It automatically detects the regression type (linear, logistic, or survival).

```R
# monotone=TRUE enforces that penalties follow the order of the groups
monotone_settings <- c(FALSE, TRUE) 

grModel <- grridge(datcenFarkas, respFarkas, partitions, 
                   monotone = monotone_settings,
                   comparelasso = TRUE)
```

### 4. Validation and Feature Selection
- **Cross-validation:** Use `grridgeCV()` to assess performance (AUC/ROC).
- **Feature Selection:** Enable `selectionEN=TRUE` in the `grridge()` call to perform post-hoc selection via a group-weighted Elastic Net.

```R
# 10-fold Cross-validation
cvResults <- grridgeCV(grModel, datcenFarkas, respFarkas, outerfold=10)

# Access selected features (if selectionEN=TRUE was used)
selected_indices <- grModel$resEN$whichEN
```

## Advanced Features

### Merging Groups
If a partition has too many groups (e.g., thousands of pathways), use `mergeGroups()` to cluster them into a smaller, more stable number of groups based on data-driven hierarchical clustering.

```R
merged <- mergeGroups(highdimdata = datStd, initGroups = gseTF, maxGroups = 5)
new_partition <- merged$newGroups
```

### Partition Selection
If multiple co-data sources are available, `PartitionsSelection()` uses a forward-selection procedure based on cross-validated likelihood to determine which partitions actually improve the model.

```R
optPart <- PartitionsSelection(datStd, resp, partitions = partitionsWurdinger, optl = 160.5)
# Use optPart$ordPar to subset your partitions list
```

## Tips for Success
- **Standardization:** GRridge can learn whether feature variance should impact penalties. If you don't standardize, consider using a monotone constraint on a partition based on feature standard deviations.
- **Computational Efficiency:** For large datasets, pre-calculate the global lambda (`optl`) or use a subset of data to find it before running the full `grridge()` or `grridgeCV()` functions.
- **Response Types:** Ensure `resp` is a factor for logistic regression, numeric for linear, and a `Surv` object for survival analysis.

## Reference documentation
- [GRridge](./references/GRridge.md)