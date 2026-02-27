---
name: bioconductor-structtoolbox
description: This tool provides a framework for the pre-processing and statistical analysis of metabolomics and other omics datasets using class-based model objects. Use when user asks to clean omics data, perform multivariate analysis like PCA or PLS-DA, apply machine learning models, or create reproducible statistical workflows in R.
homepage: https://bioconductor.org/packages/release/bioc/html/structToolbox.html
---


# bioconductor-structtoolbox

name: bioconductor-structtoolbox
description: Data (pre-)processing and analysis of metabolomics and other omics datasets using the struct and structToolbox R packages. Use this skill for workflows involving univariate/multivariate statistics, machine learning (PCA, PLS, SVM), and omics data cleaning (filtering, normalization, imputation) within the Statistics in R Using Class-based Templates (struct) framework.

## Overview

The `structToolbox` package provides a suite of data analysis tools for metabolomics and proteomics, built on the `struct` framework. It uses a class-based approach where every step (e.g., PCA, t-test, normalization) is a "model" object. These models can be chained into "model sequences" to create reproducible workflows.

## Core Concepts

### DatasetExperiment Objects
The primary data container. It is a transposed version of `SummarizedExperiment` (samples in rows, features in columns).
- `D$data`: The measurement matrix.
- `D$sample_meta`: Sample metadata (e.g., group labels).
- `D$variable_meta`: Feature metadata (e.g., annotations).

### Model Objects
Models represent statistical or processing methods.
- **Creation**: `P = PCA(number_components = 5)`
- **Parameters**: Access/set via `$` notation: `P$number_components = 2`
- **Application**: Use `model_apply(model, dataset)` for a single step, or `model_train` and `model_predict` for training/testing workflows.

### Model Sequences
Chain multiple steps using the `+` operator.
```R
# Define a sequence
M = mean_centre() + PCA(number_components = 2)
# Apply the sequence
M = model_apply(M, D)
# Access specific model in sequence
pca_model = M[2]
```

## Typical Workflows

### 1. Data Pre-processing
Common steps for MS or NMR data:
```R
M = pqn_norm(qc_label='QC', factor_name='Type') +
    knn_impute(neighbours=5) +
    glog_transform(qc_label='QC', factor_name='Type') +
    rsd_filter(rsd_threshold=20, factor_name='Type')
D_processed = model_apply(M, D)
```

### 2. Multivariate Analysis (PCA/PLS)
```R
# PCA
M = mean_centre() + PCA(number_components = 2)
M = model_apply(M, D)

# PLS-DA
M = autoscale() + PLSDA(number_components = 2, factor_name = 'class')
M = model_apply(M, D)
```

### 3. Validation (Iterators)
Use `*` to combine iterators (cross-validation, permutations) with models.
```R
# 5-fold Cross-validation
XCV = kfold_xval(folds=5, factor_name='class') * 
      (mean_centre() + PLSDA(factor_name='class'))
XCV = run(XCV, D, balanced_accuracy())

# Permutation testing
P = permutation_test(number_of_permutations=100, factor_name='class') *
    (mean_centre() + PLSDA(factor_name='class'))
P = run(P, D, balanced_accuracy())
```

### 4. Visualization (Charts)
Charts are objects that take models as input.
```R
# PCA Scores Plot
C = pca_scores_plot(factor_name='class', ellipse='none')
chart_plot(C, M[2])

# PLS-DA ROC Curve
C = plsda_roc_plot(factor_name='class')
chart_plot(C, pls_model)
```

## Advanced Filtering
To use a statistical test as a filter, use `seq_in` and `seq_fcn` to pass significant feature names to a `filter_by_name` object:
```R
M = kw_rank_sum(alpha=0.05, factor_names='Batch', predicted='significant') +
    filter_by_name(mode='exclude', dimension='variable', seq_in='names', 
                   names='placeholder', seq_fcn=function(x){return(x$significant)})
```

## Tips for Success
- **Indexing**: In a `model_seq`, use `M[i]` to access the i-th model's outputs or parameters.
- **Predicted Slot**: Use `predicted(M)` to retrieve the primary output (usually a `DatasetExperiment`) from a model or sequence.
- **Ontology**: Use `ontology(model)` to see standardized definitions for the method and its parameters.
- **ggplot2**: `chart_plot` returns a ggplot object, allowing for further customization (e.g., `+ ggtitle("My Plot")`).

## Reference documentation
- [Data analysis of metabolomics and other omics datasets using the structToolbox](./references/data_analysis_omics_using_the_structtoolbox.md)