---
name: bioconductor-roc
description: This R package performs Receiver Operating Characteristic analysis to evaluate classification performance for continuous markers and binary outcomes. Use when user asks to create ROC curves, calculate AUC or partial AUC, and rank genes or features based on classification performance.
homepage: https://bioconductor.org/packages/release/bioc/html/ROC.html
---

# bioconductor-roc

name: bioconductor-roc
description: Specialized R package for Receiver Operating Characteristic (ROC) analysis, particularly for DNA microarray data. Use this skill when you need to create ROC curves, calculate Area Under the Curve (AUC), or compute partial AUC (pAUC) from continuous marker data and binary outcomes. It is specifically useful for ranking genes or features based on classification performance.

## Overview

The `ROC` package provides S4 classes and functions to evaluate the performance of classification procedures. It transforms continuous markers (like gene expression levels) into dichotomous interpretations based on varying thresholds. The core of the package is the `rocc` class and the `rocdemo.sca` function, which handles scalar markers.

## Core Workflow

### 1. Data Preparation
The package requires two main inputs:
- **Truth**: A vector of binary indicators (0/1) representing the actual state.
- **Data**: A vector of continuous marker values (e.g., expression levels).

### 2. Creating an ROC Object
Use `rocdemo.sca` to create an instance of the `rocc` class. You must provide a diagnostic rule function.

```r
library(ROC)

# Define a standard diagnostic rule (marker >= threshold)
# dxrule.sca is provided by the package
# roc_obj <- rocdemo.sca(truth = state_vector, data = marker_vector, rule = dxrule.sca)
```

### 3. Calculating Performance Metrics
Once the ROC object is created, you can extract specific statistics:

- **AUC**: Total Area Under the Curve using a trapezoidal rule.
- **pAUC**: Partial Area Under the Curve up to a specific false positive rate (FPR).
- **ROC(t)**: Sensitivity at a specific false positive rate `t`.

```r
# Calculate total AUC
auc_val <- AUC(roc_obj)

# Calculate partial AUC up to FPR of 0.1
pauc_val <- pAUC(roc_obj, 0.1)

# Get sensitivity at FPR 0.3
sens_at_0.3 <- ROC(roc_obj, 0.3)
```

### 4. Integration with Biobase (Microarrays)
When working with `ExpressionSet` objects, you can apply ROC analysis across many features (genes) simultaneously using `esApply`.

```r
library(Biobase)
data(sample.ExpressionSet)

# Example: Calculate AUC for the first 50 genes
# Assuming 'sex' is the binary phenotype in phenoData
myauc <- function(x) {
  dx <- as.numeric(sample.ExpressionSet$sex) - 1
  AUC(rocdemo.sca(truth = dx, data = x, rule = dxrule.sca))
}

allAUCs <- esApply(sample.ExpressionSet[1:50,], 1, myauc)
# Identify the gene with the highest AUC
top_gene <- names(sort(allAUCs, decreasing = TRUE)[1])
```

## Advanced Functions
- **AUCi / pAUCi**: Use the R `integrate()` function for more accurate (though slower) area calculations compared to the default trapezoidal method.
- **Resampling**: To assess uncertainty in gene rankings, perform bootstrap resampling on the columns (samples) of the ExpressionSet and recalculate AUCs.

## Reference documentation

- [Notes on ROC package](./references/ROCnotes.md)