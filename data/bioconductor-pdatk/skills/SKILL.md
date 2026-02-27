---
name: bioconductor-pdatk
description: This package provides a framework for survival analysis and risk prediction in pancreatic cancer using transcriptomic biomarkers. Use when user asks to perform survival analysis, build PCOSP models, conduct permutation testing, or compare molecular classifiers with clinical models.
homepage: https://bioconductor.org/packages/release/bioc/html/PDATK.html
---


# bioconductor-pdatk

name: bioconductor-pdatk
description: Expert guidance for the PDATK (Pancreatic Ductal Adenocarcinoma ToolKit) R package. Use this skill to perform survival analysis, build Pancreatic Cancer Overall Survival Predictor (PCOSP) models, conduct permutation testing (RLS/RGA models), and compare molecular classifiers with clinical models.

# bioconductor-pdatk

## Overview
PDATK is a Bioconductor package designed for estimating patient risk in Pancreatic Ductal Adenocarcinoma (PDAC) using transcriptomic biomarkers. It provides a standardized framework for survival analysis by wrapping molecular data and survival metadata into specialized S4 classes. The package facilitates the creation of ensemble classifiers (PCOSP), permutation-based validation, and meta-analysis comparisons between genomic signatures and clinical variables.

## Core Data Structures
The package relies on three primary S4 classes:
- **SurvivalExperiment**: Extends `SummarizedExperiment`. Requires `colData` columns for `survival_time` (days) and `event_occurred` (binary status).
- **CohortList**: A container for multiple `SurvivalExperiment` objects, often used to group training and validation cohorts.
- **SurvivalModel**: A class that holds training data, model parameters, and eventually the trained model, validation statistics, and validation data.

## Typical Workflow

### 1. Data Preparation
Load your data into `SurvivalExperiment` objects and group them into a `CohortList`.
```R
library(PDATK)
# Create SurvivalExperiment
se <- SurvivalExperiment(assays=SimpleList(rna=assay_matrix),
                         colData=clinical_df,
                         survival_time='os_days',
                         event_occurred='os_status')

# Create CohortList
cohorts <- CohortList(list(Study1=se1, Study2=se2), mDataTypes=c('rna_seq', 'rna_micro'))

# Pre-processing: Find common genes and drop non-informative patients
commonGenes <- findCommonGenes(cohorts)
cohorts <- subset(cohorts, subset=commonGenes)
cohorts <- dropNotCensored(cohorts)
```

### 2. Building and Training a PCOSP Model
The PCOSP model uses an ensemble of binary classifiers (KTSP) to predict survival.
```R
# Initialize model
pcosp_model <- PCOSP(training_cohorts, minDaysSurvived=365, randomSeed=1987)

# Train model (numModels should be >= 1000 for production)
trained_model <- trainModel(pcosp_model, numModels=15, minAccuracy=0.6)
```

### 3. Prediction and Validation
Apply the trained model to validation cohorts to generate risk scores and assess performance.
```R
# Predict risk scores (PCOSP_prob_good)
pred_cohorts <- predictClasses(validation_cohorts, model=trained_model)

# Validate and calculate statistics (AUC, D-index, C-index)
validated_model <- validateModel(trained_model, valData=pred_cohorts)

# Access statistics
stats <- validationStats(validated_model)
```

### 4. Model Comparison and Visualization
Compare the PCOSP model against clinical models or existing signatures (GeneFu).
```R
# Clinical Model
clin_model <- ClinicalModel(train_se, formula='prognosis ~ age + sex + grade')
trained_clin <- trainModel(clin_model)
val_clin <- validateModel(trained_clin, predictClasses(val_cohorts, model=trained_clin))

# Compare and Plot
comparison <- compareModels(validated_model, val_clin)
forestPlot(comparison, stat='concordance_index')
```

## Permutation Testing
To ensure model performance is better than random chance, use:
- **RLSModel**: Random Label Shuffling (shuffles prognosis labels).
- **RGAModel**: Random Gene Assignment (shuffles gene labels).
Use `densityPlotModelComparison()` to visualize the PCOSP model's performance against these null distributions.

## Pathway Analysis
Extract top features from a validated model and run Gene Set Enrichment Analysis:
```R
top_genes <- getTopFeatures(validated_model, numModels=10)
# Requires geneSets data.table (e.g., from msigdbr)
gsea_results <- runGSEA(validated_model, geneSets)
```

## Reference documentation
- [PCOSP: Pancreatic Cancer Overall Survival Predictor](./references/PCOSP_model_analysis.md)
- [An Introduction to PDATK Classes and Methods](./references/PDATK_introduction.md)
- [PCOSP Model Analysis Source](./references/PCOSP_model_analysis.Rmd)