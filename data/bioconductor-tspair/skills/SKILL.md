---
name: bioconductor-tspair
description: The bioconductor-tspair package implements the Top Scoring Pair classifier to identify pairs of genes whose relative expression levels distinguish between two biological classes. Use when user asks to identify top scoring gene pairs, calculate rank-based classification rules, or predict sample classes based on relative gene expression.
homepage: https://bioconductor.org/packages/3.5/bioc/html/tspair.html
---

# bioconductor-tspair

## Overview

The `tspair` package implements the Top Scoring Pair (TSP) classifier. A TSP is a pair of genes where the comparison of their relative expression values (is Gene A > Gene B?) provides the maximum difference in probability between two classes (e.g., healthy vs. diseased). This rank-based approach is highly robust to normalization artifacts and platform differences, making it ideal for clinical biomarkers and diagnostic development.

## Core Workflow

### 1. Data Preparation
The package accepts either a standard expression matrix (genes in rows, samples in columns) or a Bioconductor `ExpressionSet` object.

```R
library(tspair)
data(tspdata) # Example data: dat (matrix), grp (labels), eSet1 (ExpressionSet)
```

### 2. Calculating the Top Scoring Pair
Use `tspcalc` to identify the gene pair(s) with the highest score.

```R
# Using a matrix and group vector
tsp_obj <- tspcalc(dat, grp)

# Using an ExpressionSet and a column index from pData
tsp_obj <- tspcalc(eSet1, 1)

# View results
print(tsp_obj)
```
The "Score" represents $|Pr(X > Y | Class 1) - Pr(X > Y | Class 2)|$. If multiple pairs tie for the top score, a secondary tie-breaker based on rank differences is automatically applied.

### 3. Visualization and Summary
Visualize the separation between classes and understand the decision rule.

```R
# Plot the expression of Gene 1 vs Gene 2
tspplot(tsp_obj)

# View the decision rule and contingency table
summary(tsp_obj, printall=TRUE)
```

### 4. Significance Testing
To determine if the observed TSP score is statistically significant (not just due to the high dimensionality of the data), use a permutation test.

```R
# B is the number of permutations
out <- tspsig(dat, grp, B=50, seed=12345)
print(out$p)
```

### 5. Prediction
Apply a calculated TSP model to new data. The function automatically matches gene names (row names or featureNames).

```R
# Predict classes for new data (matrix or ExpressionSet)
predictions <- predict(tsp_obj, newData)
```

## Advanced Usage: Cross-Validation

To estimate the generalization error of the TSP *approach* (rather than a specific pair), you must wrap the calculation in a loop:

```R
narrays <- ncol(dat)
results <- logical(narrays)

for(i in 1:narrays){
  # Train on all but one
  train_tsp <- tspcalc(dat[,-i], grp[-i])
  # Predict the left-out sample
  pred <- predict(train_tsp, dat)[i]
  results[i] <- (pred == grp[i])
}

cv_error <- mean(!results)
```

## Tips for Success
- **Binary Phenotypes Only**: `tspair` is designed specifically for two-class problems.
- **Gene Names**: Ensure your data matrices have unique row names, as `predict()` relies on these to find the TSP genes in new datasets.
- **Interpretation**: If `summary()` shows `GeneA < GeneB` is TRUE for Class 1, then that is your classification rule.

## Reference documentation
- [Bioconductor tspair Manual](./references/tsp.md)