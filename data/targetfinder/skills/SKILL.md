---
name: targetfinder
description: TargetFinder is a computational pipeline designed to predict enhancer-promoter interactions by leveraging one-dimensional genomic data, such as ChIP-seq assays and epigenetic modifications.
homepage: https://github.com/shwhalen/targetfinder
---

# targetfinder

## Overview

TargetFinder is a computational pipeline designed to predict enhancer-promoter interactions by leveraging one-dimensional genomic data, such as ChIP-seq assays and epigenetic modifications. It transforms the task of identifying 3D chromatin loops into a supervised learning problem, using features from the enhancer, the promoter, and the genomic window between them. Use this skill to analyze ENCODE cell lines or custom datasets where interaction labels are available to train models, identify key regulatory proteins, and screen functional genomics data for relevance to chromatin looping.

## Usage Guidelines

### Feature Configurations
TargetFinder supports three primary levels of genomic window analysis. For maximum predictive power, the EPW configuration is recommended:
*   **EP**: Features generated for the enhancer and promoter only.
*   **EEP**: Features for promoters and extended enhancers (+/- 3kb flanking).
*   **EPW**: Features for promoters, enhancers, and the entire genomic window between them.

### Data Formats
*   **training.h5**: Preferred for Python workflows due to high-speed loading via `pandas.read_hdf`.
*   **training.csv.gz**: Use for cross-compatibility with R or when HDF5 libraries are unavailable.
*   **.bed files**: Standard genomic coordinates for enhancers, promoters, and Transcription Start Sites (TSS).

### Feature Engineering
When training models, always drop non-predictive metadata columns to avoid data leakage and improve performance. The following columns should be excluded from the feature matrix:
*   Genomic coordinates: `enhancer_chrom`, `enhancer_start`, `enhancer_end`, `promoter_chrom`, `promoter_start`, `promoter_end`, `window_chrom`, `window_start`, `window_end`.
*   Metadata: `window_name`, `bin`, `label`.
*   Interaction proxies: `active_promoters_in_window`, `interactions_in_window`, `enhancer_distance_to_promoter`.

### Recommended Model Parameters
For Gradient Boosting (the primary method used in the TargetFinder paper), use the following `scikit-learn` configuration:
*   **Estimator**: `GradientBoostingClassifier`
*   **n_estimators**: 4000
*   **learning_rate**: 0.1
*   **max_depth**: 5
*   **max_features**: 'log2'

### Workflow Pattern
1.  **Load**: Import `training.h5` using Pandas.
2.  **Clean**: Set index to `['enhancer_name', 'promoter_name']` and drop the non-predictor list.
3.  **Validate**: Use `StratifiedKFold` (10-fold) with `f1` scoring to evaluate performance.
4.  **Analyze**: Extract `feature_importances_` to identify the most predictive epigenetic marks for the specific cell line.

## Expert Tips
*   **Window Importance**: Marks on the looping chromatin (the window between) are often more predictive than marks proximal to the enhancer or promoter alone.
*   **Cell Line Specificity**: TargetFinder is currently optimized for within-cell-line predictions. Do not attempt to apply a model trained on one cell line to a different cell line without specific normalization, as ChIP-seq variability limits generalization.
*   **Performance**: Training with 4000 estimators is computationally expensive. Use `n_jobs=-1` in cross-validation to utilize all available CPU cores.

## Reference documentation
- [TargetFinder README](./references/github_com_shwhalen_targetfinder.md)