---
name: bioconductor-scclassify
description: scClassify is a Bioconductor package for the automated classification of cell types in single-cell RNA-seq data using an ensemble learning framework. Use when user asks to classify cell types in query datasets, train custom classification models from reference data, or perform integrated training and prediction across multiple similarity metrics.
homepage: https://bioconductor.org/packages/release/bioc/html/scClassify.html
---

# bioconductor-scclassify

## Overview

`scClassify` is a Bioconductor package designed for accurate cell type classification of single-cell RNA-seq data. It utilizes an ensemble learning framework that combines multiple feature selection methods and similarity metrics. It is particularly effective for taking advantage of well-annotated reference datasets to identify cell types in new, unannotated query datasets.

## Core Workflows

### 1. Data Preparation
`scClassify` requires log-transformed (size-factor normalized) expression matrices where rows are genes and columns are cells. It is recommended to use sparse matrices (`dgCMatrix`) for memory efficiency.

```r
library(scClassify)
# Convert to sparse matrix if necessary
exprsMat <- as(exprsMat, "dgCMatrix")
```

### 2. Using Pretrained Models
If you have a `scClassifyTrainModel` object (either from the package's data or a previous training session), use `predict_scClassify` to annotate a query dataset.

```r
# Load a pretrained model (example)
data("trainClassExample_xin")

# Predict cell types
pred_res <- predict_scClassify(exprsMat_test = query_mat,
                               trainRes = trainClassExample_xin,
                               algorithm = "WKNN",
                               features = c("limma"),
                               similarity = c("pearson", "spearman"),
                               prob_threshold = 0.7,
                               verbose = TRUE)

# Access results (e.g., for pearson metric)
predictions <- pred_res$pearson_WKNN_limma$predRes
```

### 3. Integrated Training and Prediction
The `scClassify()` function performs both training on a reference dataset and prediction on query datasets in a single call.

```r
scClassify_res <- scClassify(exprsMat_train = ref_mat,
                             cellTypes_train = ref_labels,
                             exprsMat_test = list(query = query_mat),
                             tree = "HOPACH",
                             algorithm = "WKNN",
                             selectFeatures = c("limma"),
                             similarity = c("pearson", "cosine"),
                             weighted_ensemble = TRUE,
                             returnList = FALSE)

# Access ensemble results
ensemble_labels <- scClassify_res$testRes$query$ensembleRes$cellTypes
```

### 4. Training a Custom Model
To build a reusable model from a reference dataset, use `train_scClassify`.

```r
trainClass <- train_scClassify(exprsMat_train = ref_mat,
                               cellTypes_train = ref_labels,
                               selectFeatures = c("limma", "BI"),
                               returnList = FALSE)

# Inspect the model
features(trainClass)
plotCellTypeTree(cellTypeTree(trainClass))
```

## Key Parameters and Options

*   **Similarity Metrics**: Supports `pearson`, `spearman`, `cosine`, `jaccard`, etc.
*   **Feature Selection**: Common methods include `limma` (differential expression) and `BI` (bimodal distribution).
*   **Algorithms**: `WKNN` (Weighted K-Nearest Neighbors) is the standard classification algorithm used.
*   **Ensemble Weighting**: By default (`weighted_ensemble = TRUE`), base classifiers are weighted by their accuracy on the training data.
*   **Unassigned Cells**: Cells that do not meet the `prob_threshold` (default 0.7) are labeled as "unassigned".

## Interpreting Results

The output of prediction functions is typically a list. For ensemble runs, the `ensembleRes` slot contains the final aggregated predictions. If multiple similarity metrics were used without ensemble weighting, you can access individual results via names like `pearson_WKNN_limma`.

## Reference documentation

- [Performing scClassify using pretrained model](./references/pretrainedModel.md)
- [scClassify Model Building and Prediction](./references/scClassify.md)