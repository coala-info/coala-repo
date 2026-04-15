---
name: bioconductor-classifyr
description: ClassifyR provides a standardized framework for cross-validated classification, feature selection, and performance evaluation of high-dimensional biological data in R. Use when user asks to run cross-validation pipelines, integrate multi-omics data, compare different classifiers, evaluate model performance with ROC plots, or identify differential distribution features.
homepage: https://bioconductor.org/packages/release/bioc/html/ClassifyR.html
---

# bioconductor-classifyr

name: bioconductor-classifyr
description: Expert guidance for using the ClassifyR Bioconductor package for cross-validated classification, feature selection, and performance evaluation of high-dimensional biological data. Use this skill when performing supervised machine learning workflows in R, specifically for: (1) Running cross-validation pipelines (k-fold, repeated, or leave-k-out), (2) Integrating multi-omics data (MultiAssayExperiment), (3) Comparing different classifiers (SVM, Random Forest, DLDA, etc.), (4) Evaluating model performance with ROC plots and accuracy metrics, or (5) Identifying differential distribution (DD) or variability (DV) features.

# bioconductor-classifyr

## Overview
ClassifyR is a robust R framework designed for the classification of biological data. It standardizes the machine learning pipeline into four stages: data transformation, feature selection, model training, and prediction. Its primary strength lies in its ability to handle complex cross-validation schemes and integrate multiple data sources (multi-view learning) while providing specialized methods for detecting changes in means (DM), variability (DV), and distribution (DD).

## Core Workflows

### 1. Quick Start with crossValidate
The `crossValidate` function is the primary entry point for most users. It handles feature selection and classification in a single call.

```r
library(ClassifyR)
data(asthma) # Loads 'measurements' and 'classes'

# Set seed for reproducibility
set.seed(123)

# 5-fold cross-validation with a Support Vector Machine
result <- crossValidate(measurements, classes, 
                        classifier = "SVM",
                        nFolds = 5, 
                        nRepeats = 2)

# Visualize performance
performancePlot(result)
```

### 2. Multi-view Data Integration
ClassifyR supports integrating different assay types (e.g., Proteomics and Transcriptomics) using the `multiViewMethod` argument.

```r
# Using a list of data frames
measurementsList <- list(Assay1 = df1, Assay2 = df2)
result <- crossValidate(measurementsList, classes, 
                        multiViewMethod = "merge",
                        classifier = "Random Forest")

# Plot performance by assay
performancePlot(result, characteristicsList = list(x = "Assay Name"))
```

### 3. Fine-grained Control with runTests
For advanced workflows, use `runTests` with `CrossValParams` and `ModellingParams`.

```r
# Define CV parameters (e.g., 100 permutations, 5-fold)
cvParams <- CrossValParams(permutations = 100, nFolds = 5)

# Define Modelling parameters (e.g., t-test selection + DLDA classifier)
modParams <- ModellingParams(
    selectParams = SelectParams("differentMeans"),
    trainParams = TrainParams("DLDA")
)

result <- runTests(measurements, classes, cvParams, modParams)
```

## Performance Evaluation and Visualization

### Performance Metrics
Calculate specific metrics like Balanced Accuracy or AUC using `calcCVperformance`.

```r
result <- calcCVperformance(result, metric = "Balanced Accuracy")
performance(result)
```

### Visualization Tools
*   **ROC Curves**: `ROCplot(resultsList)` compares multiple models.
*   **Feature Selection**: `rankingPlot(result)` shows consistency of selected features across folds.
*   **Sample Error**: `samplesMetricMap(resultsList)` identifies specific samples that are consistently misclassified.
*   **Feature Distribution**: `plotFeatureClasses(measurements, classes, "GeneName")` visualizes the separation of classes for a specific feature.

## Key Parameters and Options
*   **Classifiers**: "SVM", "Random Forest", "DLDA", "kNN", "naiveBayes", "elasticNet".
*   **Selection Methods**: "differentMeans" (t-test/ANOVA), "limma", "edgeR", "KL" (Kullback-Leibler), "KS" (Kolmogorov-Smirnov).
*   **Parallelization**: Use the `nCores` argument in `crossValidate` or pass `BiocParallel` parameters to `CrossValParams`.

## Tips for Success
*   **Reproducibility**: Always set a random seed before running cross-validation.
*   **Data Types**: While matrices and data frames are supported, `MultiAssayExperiment` is recommended for multi-omics projects.
*   **Class Imbalance**: ClassifyR defaults to downsampling the majority class. Adjust this in `ModellingParams(balancing = "downsample")`.
*   **Feature Selection**: If `nFeatures` is not specified, the package typically defaults to the top 20 features.

## Reference documentation
- [ClassifyR](./references/ClassifyR.md)
- [DevelopersGuide](./references/DevelopersGuide.md)