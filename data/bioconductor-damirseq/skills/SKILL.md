---
name: bioconductor-damirseq
description: DaMiRseq provides a comprehensive pipeline for RNA-Seq data mining, normalization, and feature selection to build robust ensemble classification models. Use when user asks to normalize count data, remove batch effects using surrogate variable analysis, perform feature selection, or train ensemble learning models for sample classification.
homepage: https://bioconductor.org/packages/release/bioc/html/DaMiRseq.html
---


# bioconductor-damirseq

name: bioconductor-damirseq
description: Expert guidance for the DaMiRseq R/Bioconductor package. Use this skill to perform end-to-end RNA-Seq data mining, including data normalization, sample filtering, surrogate variable analysis (SVA) for batch effect removal, feature selection (PLS-based), and building robust ensemble classification models (Stacking).

# bioconductor-damirseq

## Overview
DaMiRseq (Data Mining for RNA-Seq) is a comprehensive pipeline designed to transform raw RNA-Seq count data into robust classification models. It addresses the "curse of dimensionality" by integrating data cleaning, normalization, and multi-step feature selection with ensemble learning techniques.

## Core Workflow

### 1. Data Import and Preparation
DaMiRseq utilizes the `SummarizedExperiment` class. If starting from raw tables, use `DaMiR.makeSE`.

```R
library(DaMiRseq)
# count_data: matrix of raw integer counts
# covariate_data: data.frame with a 'class' column and other variables
SE <- DaMiR.makeSE(count_data, covariate_data)
```

### 2. Preprocessing and Normalization
Filter low-expression and hyper-variant features, then normalize using Variance Stabilizing Transformation (VST) or rlog.

```R
# Filtering and VST normalization
data_norm <- DaMiR.normalization(SE, minCounts=10, fSample=0.7, hyper="yes", th.cv=3)

# Sample filtering based on correlation
data_filt <- DaMiR.sampleFilt(data_norm, th.corr=0.9)
```

### 3. Adjusting for Unwanted Variation (Batch Effects)
Identify and remove surrogate variables (sv) that may represent technical noise or confounding factors.

```R
# Identify SVs using the 'Fraction of Explained Variance' (fve) method
sv <- DaMiR.SV(data_filt, method="fve", th.fve=0.95)

# Visualize correlation between SVs and known covariates
DaMiR.corrplot(sv, colData(data_filt))

# Adjust data using selected number of SVs
data_adjust <- DaMiR.SVadjust(data_filt, sv, n.sv=4)
```

### 4. Feature Selection
Reduce the feature space to the most informative, non-redundant predictors.

```R
# Transpose and clean feature names
data_clean <- DaMiR.transpose(assay(data_adjust))

# Step A: PLS-based variable selection
data_reduced <- DaMiR.FSelect(data_clean, colData(data_adjust), th.corr=0.4)

# Step B: Remove highly correlated (redundant) features
data_red2 <- DaMiR.FReduct(data_reduced$data, th.corr=0.85)

# Step C: Rank features by importance (RReliefF)
df_importance <- DaMiR.FSort(data_red2, colData(data_adjust))

# Step D: Select top N predictors
final_features <- DaMiR.FBest(data_red2, ranking=df_importance, n.pred=5)
```

### 5. Classification and Prediction
Build an ensemble "meta-learner" using a weighted majority voting approach (RF, SVM, NB, LDA, LR, kNN, etc.).

```R
# Assess feature robustness via Bootstrap
Classification_res <- DaMiR.EnsembleLearning(final_features$data, 
                                             classes=colData(data_adjust)$class, 
                                             iter=100)

# Train a specific model for future predictions
ensl_model <- DaMiR.EnsL_Train(TR_set, cl_type=c("RF", "LR"))

# Predict on new samples
predictions <- DaMiR.EnsL_Predict(new_data, bestModel=ensl_model)
```

## Diagnostic Visualizations
Use `DaMiR.Allplot` at any stage to assess data quality via Heatmaps, MDS plots, and RLE boxplots.

```R
# Comprehensive QC plot
DaMiR.Allplot(data_adjust, colData(data_adjust))

# Feature importance plot
# (Generated automatically during DaMiR.FSort or via dotchart)
```

## Key Tips
- **Class Column**: The metadata must contain a column exactly named `class`.
- **Normalization Choice**: `vst` is significantly faster than `rlog` for large datasets.
- **Batch Correction**: Always check `DaMiR.corrplot` before adjusting. If an SV correlates strongly with your `class` variable, do not include it in `n.sv` to avoid over-correction.
- **Reproducibility**: Set a seed (`set.seed()`) before running `DaMiR.FSelect` and `DaMiR.EnsembleLearning` as they involve stochastic processes.

## Reference documentation
- [DaMiRseq](./references/DaMiRseq.md)