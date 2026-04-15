---
name: bioconductor-mapredictdsc
description: This package implements a classification pipeline for Affymetrix microarray data that automates preprocessing, feature selection, and model evaluation. Use when user asks to perform binary classification on CEL files, compare combinations of normalization and machine learning methods, or calculate IMPROVER diagnostic performance metrics.
homepage: https://bioconductor.org/packages/release/bioc/html/maPredictDSC.html
---

# bioconductor-mapredictdsc

name: bioconductor-mapredictdsc
description: Classification pipeline for Affymetrix microarray data based on the IMPROVER Diagnostic Signature Challenge. Use this skill to perform automated preprocessing, feature selection, and classification using combinations of methods (RMA, GCRMA, MAS5; t-test, Wilcoxon; LDA, SVM, kNN) and to evaluate model performance using metrics like BCM, CCEM, and AUPR.

# bioconductor-mapredictdsc

## Overview

The `maPredictDSC` package implements a robust classification pipeline designed for Affymetrix expression data. It is particularly effective for binary classification tasks where raw `.CEL` files are available. The package automates the exploration of multiple combinations of preprocessing techniques, feature ranking methods, and classifiers. It uses cross-validation on training data to determine the optimal number of features and provides tools for "wisdom of crowds" model aggregation.

## Core Workflow

### 1. Data Preparation
You must provide a data frame (typically named `ano`) that maps CEL files to their groups. One group must be labeled `"Test"` for samples requiring prediction.

```r
# Example annotation structure
# files: GSM123.CEL.gz, group: AC
# files: GSM456.CEL.gz, group: SCC
# files: lung_1.CEL, group: Test
```

### 2. Building Models with `predictDSC`
The `predictDSC` function is the primary interface. It iterates through specified combinations of methods.

```r
library(maPredictDSC)

modlist <- predictDSC(
  ano = anoLC, 
  celfile.path = "path/to/cel/files",
  annotation = "hgu133plus2.db", 
  preprocs = c("rma", "gcrma"),      # Options: rma, gcrma, mas5
  filters = c("mttest", "ttest"),    # Options: mttest, ttest, wilcoxon
  classifiers = c("LDA", "kNN"),     # Options: LDA, SVM, kNN
  CVP = 2,                           # Number of cross-validation partitions
  NF = 4,                            # Max number of features to consider
  FCT = 1.0                          # Fold change threshold
)
```

### 3. Evaluating Performance
If the ground truth for test samples is known (as a matrix/data frame `gs`), use `perfDSC` to calculate IMPROVER metrics:
- **AUC**: Area Under the Curve
- **AUPR**: Area Under the Precision-Recall Curve
- **BCM**: Belief Confusion Metric
- **CCEM**: Correct Class Enrichment Metric

```r
# Evaluate a single model from the list
perf <- perfDSC(pred = modlist[["rma_ttest_LDA"]]$predictions, gs = gsLC)

# Rank all models by training AUC
trainingAUC <- sort(unlist(lapply(modlist, "[[", "best_AUC")), decreasing = TRUE)
```

### 4. Model Aggregation
To improve robustness, aggregate the predictions of the top-performing models.

```r
# Aggregate top 3 models
best3_names <- names(trainingAUC)[1:3]
agg_preds <- aggregateDSC(modlist[best3_names])

# Evaluate aggregated performance
perf_agg <- perfDSC(agg_preds, gsLC)
```

## Tips and Constraints
- **Feature Naming**: The package adds an "F" prefix to Affymetrix probe IDs (e.g., `F225214_at`) because certain classifiers (like LDA) do not support variable names starting with numbers.
- **Binary Classification**: This package is specifically designed for 2-class problems.
- **Memory/Time**: Running all 27 combinations (3 preprocs x 3 filters x 3 classifiers) can be computationally intensive. Start with a subset (e.g., `rma`, `mttest`, `LDA`) to verify the pipeline.
- **Fold Change Threshold (FCT)**: If `FCT > 1.0`, genes with low fold change are excluded. If too few genes meet the criteria, the threshold is automatically ignored to ensure `NF` features are selected.

## Reference documentation
- [maPredictDSC](./references/maPredictDSC.md)