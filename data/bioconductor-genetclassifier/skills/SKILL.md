---
name: bioconductor-genetclassifier
description: This tool builds multi-class SVM classifiers and associated gene networks from gene expression data to identify class-specific gene signatures. Use when user asks to build SVM classifiers, rank genes by differential expression, select gene signatures, estimate generalization error, visualize gene networks, or predict the class of new transcriptomic samples.
homepage: https://bioconductor.org/packages/release/bioc/html/geNetClassifier.html
---


# bioconductor-genetclassifier

name: bioconductor-genetclassifier
description: Build multi-class SVM classifiers and associated gene networks from gene expression data. Use this skill to rank genes by differential expression (Parametric Empirical Bayes), select optimal gene signatures via cross-validation, estimate generalization error, and visualize gene networks for specific biological states or diseases.

## Overview
The `geNetClassifier` package provides a comprehensive workflow for transcriptomic data classification. It identifies gene signatures that characterize specific classes (e.g., disease subtypes), builds a Support Vector Machine (SVM) classifier, and constructs gene networks based on mutual information and co-expression. It is particularly effective for multi-class problems where "NotAssigned" calls are preferred over low-certainty assignments.

## Core Workflow

### 1. Data Preparation
The package requires an `ExpressionSet` with normalized intensity values (raw scale, not logarithmic).

```R
library(geNetClassifier)
library(leukemiasEset)
data(leukemiasEset)

# Example: Use a subset for training
trainSamples <- c(1:10, 13:22, 25:34, 37:46, 49:58)
esetTrain <- leukemiasEset[, trainSamples]
```

### 2. Running the Main Classifier
The `geNetClassifier()` function executes the full pipeline: ranking, selection, and network construction.

```R
# Basic execution
leukemiasClassifier <- geNetClassifier(
  eset = esetTrain, 
  sampleLabels = "LeukemiaType", 
  plotsName = "my_analysis",
  buildClassifier = TRUE,
  calculateNetwork = TRUE
)

# Advanced: Estimate Generalization Error (takes longer)
leukemiasClassifier <- geNetClassifier(
  eset = esetTrain, 
  sampleLabels = "LeukemiaType",
  estimateGError = TRUE,
  geneLabels = geneSymbols  # Optional mapping to Gene Symbols
)
```

### 3. Exploring Results
The output is a `GeNetClassifierReturn` object containing several slots:

*   **Gene Ranking**: `leukemiasClassifier@genesRanking`
*   **Selected Genes**: `leukemiasClassifier@classificationGenes`
*   **SVM Model**: `leukemiasClassifier@classifier`
*   **Networks**: `leukemiasClassifier@genesNetwork`

```R
# Get top 10 genes for each class
getRanking(getTopRanking(leukemiasClassifier@genesRanking, 10))

# View details of classification genes for a specific class
genesDetails(leukemiasClassifier@classificationGenes)$AML
```

### 4. Querying New Samples
Use `queryGeNetClassifier()` to predict the class of unknown samples.

```R
# Query with default assignment thresholds
queryResult <- queryGeNetClassifier(leukemiasClassifier, leukemiasEset[, testSamples])

# Access predictions and probabilities
queryResult$class
queryResult$probabilities

# Adjusting stringency (minProbAssignCoeff and minDiffAssignCoeff)
# Set to 0 to force assignment of all samples
queryResult_forced <- queryGeNetClassifier(leukemiasClassifier, 
                                           leukemiasEset[, testSamples], 
                                           minProbAssignCoeff=0, 
                                           minDiffAssignCoeff=0)
```

## Visualization Functions

*   **Significant Genes**: `plot(leukemiasClassifier@genesRanking)` - Shows posterior probability distribution.
*   **Expression Profiles**: `plotExpressionProfiles(eset, genes, sampleLabels="Class")` - Plots gene expression across samples.
*   **Discriminant Power**: `plotDiscriminantPower(leukemiasClassifier)` - Visualizes how much a gene contributes to class separation.
*   **Gene Networks**: `plotNetwork(leukemiasClassifier@genesNetwork$AML)` - Plots the class-specific network.

## Key Parameters
*   `lpThreshold`: Posterior probability threshold for gene significance (default 0.95).
*   `maxGenesTrain`: Maximum genes to explore per class during training (default 100).
*   `minProbAssignCoeff`: Multiplier for random probability to set assignment threshold.
*   `minDiffAssignCoeff`: Multiplier for random probability to set difference threshold between top two classes.

## Reference documentation
- [geNetClassifier Vignette](./references/geNetClassifier-vignette.md)