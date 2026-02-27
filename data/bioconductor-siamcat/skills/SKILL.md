---
name: bioconductor-siamcat
description: SIAMCAT is an R package for the statistical analysis of microbiome data and the construction of machine learning models to find associations between microbial communities and host phenotypes. Use when user asks to preprocess microbiome data, perform association testing, detect confounders, or train and evaluate machine learning models for cross-study meta-analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/SIAMCAT.html
---


# bioconductor-siamcat

## Overview
SIAMCAT is an R package designed for the statistical analysis of microbiome data, specifically focusing on finding associations between microbial communities and host phenotypes. It provides a modular pipeline for data preprocessing, association testing, and the construction of machine learning models. A key strength of SIAMCAT is its focus on robust evaluation, including tools for confounder detection and cross-study meta-analysis.

## Core Workflow

### 1. Data Ingestion and Object Creation
The `siamcat` object is the central data structure. You can initialize it from R matrices or a `phyloseq` object.

```R
library(SIAMCAT)

# From matrices
sc.obj <- siamcat(feat=feat_matrix, meta=metadata_df, label='Group', case='Disease')

# From phyloseq
sc.obj <- siamcat(phyloseq=physeq_obj, label='Condition', case='CRC')
```

### 2. Preprocessing
Always filter and normalize features before downstream analysis. SIAMCAT expects relative abundances.

```R
# Filter by abundance and prevalence
sc.obj <- filter.features(sc.obj, filter.method='abundance', cutoff=0.001)
sc.obj <- filter.features(sc.obj, filter.method='prevalence', cutoff=0.05)

# Normalize (log.std is recommended for ML)
sc.obj <- normalize.features(sc.obj, norm.method='log.std', norm.param=list(log.n0=1e-06))
```

### 3. Association Testing and Confounder Analysis
Check for features significantly associated with the label and identify potential metadata confounders (e.g., age, BMI, or study site).

```R
# Statistical associations
sc.obj <- check.associations(sc.obj, log.n0=1e-06, alpha=0.05)
association.plot(sc.obj, fn.plot='assoc.pdf')

# Confounder check
check.confounders(sc.obj, fn.plot='confounders.pdf')
```

### 4. Machine Learning Pipeline
SIAMCAT implements a rigorous ML workflow including data splitting, model training, and evaluation.

```R
# 1. Split data (use 'inseparable' for repeated measures/blocked CV)
sc.obj <- create.data.split(sc.obj, num.folds=5, num.resample=2)

# 2. Train model (e.g., LASSO)
sc.obj <- train.model(sc.obj, method='lasso')

# 3. Predict and Evaluate
sc.obj <- make.predictions(sc.obj)
sc.obj <- evaluate.predictions(sc.obj)

# 4. Visualize
model.evaluation.plot(sc.obj, fn.plot='eval.pdf')
model.interpretation.plot(sc.obj, fn.plot='interpret.pdf')
```

## Advanced Workflows

### Holdout Testing
To apply a model trained on one dataset to an external holdout dataset:
1. Use `norm_params(trained_obj)` to perform "frozen" normalization on the holdout data.
2. Pass the trained object to `make.predictions(siamcat=trained_obj, siamcat.holdout=holdout_obj)`.

### Meta-analysis
When working with multiple studies:
- Use `check.associations` on individual study objects to compare effect sizes (Generalized Fold Change) via heatmaps.
- Use blocked cross-validation (`inseparable='Study'`) if training on a merged dataset to prevent information leakage.

## Tips for Success
- **Relative Abundances**: Ensure input features are relative abundances (0 to 1). Use `prop.table(as.matrix(feat), 2)` if starting with counts.
- **ML Pitfalls**: Avoid "supervised feature selection" outside of the cross-validation loop. Use the `perform.fs=TRUE` argument in `train.model` to perform nested feature selection correctly.
- **Sample IDs**: Ensure `rownames(metadata)` exactly match `colnames(features)`.

## Reference documentation
- [Confounder Analysis](./references/SIAMCAT_confounder.md)
- [Holdout Testing](./references/SIAMCAT_holdout.md)
- [Meta-analysis Workflow](./references/SIAMCAT_meta.md)
- [Machine Learning Pitfalls](./references/SIAMCAT_ml_pitfalls.md)
- [Data Input Formats](./references/SIAMCAT_read-in.md)
- [Main Package Vignette](./references/SIAMCAT_vignette.md)