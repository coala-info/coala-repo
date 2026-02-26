---
name: bioconductor-ledpred
description: This tool predicts cis-regulatory modules by building Support Vector Machine models based on genomic features like transcription factor binding sites and NGS signals. Use when user asks to map features to genomic coordinates, optimize SVM parameters, perform recursive feature elimination, or evaluate the performance of regulatory element prediction models.
homepage: https://bioconductor.org/packages/release/bioc/html/LedPred.html
---


# bioconductor-ledpred

name: bioconductor-ledpred
description: Predictive modeling of cis-regulatory modules (CRMs) using Support Vector Machines (SVM). Use this skill when analyzing DNA sequences to predict regulatory potential based on transcription factor binding sites (TFBS), NGS signals, or other genomic features.

## Overview

LedPred is a Bioconductor package designed to map genomic features to sequences and build SVM-based models to identify regulatory elements like enhancers. It provides a complete workflow including feature extraction via a REST server, SVM parameter optimization (C and gamma), recursive feature elimination (RFE), and model evaluation using ROC and Precision-Recall curves.

## Typical Workflow

### 1. Data Preparation and Feature Mapping
The package uses `mapFeaturesToCRMs` to create a training matrix. This function typically connects to a REST server to process BED files (genomic coordinates), PSSMs (TF matrices), and NGS data (BigWig/Bed).

```r
library(LedPred)

# Define paths to genomic data
pos_bed <- "path/to/positive_regions.bed"
neg_bed <- "path/to/negative_regions.bed"
pssm_file <- "path/to/tf_matrices.txt"

# Map features to create training set
# Note: Requires active internet connection for the REST API
crm_feature_list <- mapFeaturesToCRMs(
  URL = 'http://ifbprod.aitorgonzalezlab.org/map_features_to_crms.php',
  positive.bed = pos_bed,
  negative.bed = neg_bed,
  pssm = pssm_file,
  genome = "dm3"
)
crm_features <- crm_feature_list$crm.features
```

### 2. Parameter Optimization
Use `mcTune` to find the optimal cost (C) and gamma parameters for the SVM kernel (linear or radial).

```r
cost_vector <- c(1, 3, 10)
gamma_vector <- c(1, 3, 10)

tuning_obj <- mcTune(
  data = crm_features, 
  ranges = list(cost = cost_vector, gamma = gamma_vector), 
  kernel = 'linear'
)

best_c <- tuning_obj$e1071.tune.obj$best.parameters$cost
best_g <- tuning_obj$e1071.tune.obj$best.parameters$gamma
```

### 3. Feature Selection
Rank features using Recursive Feature Elimination (RFE) and determine the optimal number of features using Cohen's Kappa.

```r
# Rank features by importance
ranking <- rankFeatures(
  data = crm_features, 
  cost = best_c, 
  gamma = best_g, 
  kernel = 'linear'
)

# Determine optimal number of features
nb_tuner <- tuneFeatureNb(
  data = crm_features, 
  feature.ranking = ranking, 
  kernel = 'linear', 
  cost = best_c, 
  gamma = best_g
)
best_nb <- nb_tuner$best.feature.nb
```

### 4. Model Creation and Evaluation
Build the final model and evaluate its performance using cross-validation.

```r
# Create the SVM model
final_model <- createModel(
  data = crm_features, 
  cost = best_c, 
  gamma = best_g, 
  feature.ranking = ranking, 
  feature.nb = best_nb
)

# Evaluate performance (generates ROC/PR plots)
performance <- evaluateModelPerformance(
  data = crm_features, 
  feature.ranking = ranking, 
  feature.nb = best_nb, 
  cost = best_c, 
  gamma = best_g
)
```

### 5. Scoring New Sequences
Apply the trained model to score unknown genomic regions.

```r
# Score new data matrix
predictions <- scoreData(
  data = unknown_feature_matrix, 
  model = final_model, 
  score.file = "predictions.tab"
)
```

## Automated Workflow
The `LedPred` function can run the entire pipeline (tuning, ranking, and model creation) in a single call if the feature matrix is already prepared.

```r
full_results <- LedPred(
  data = crm_features, 
  ranges = list(cost = c(1, 10), gamma = c(1, 10)), 
  kernel = "linear"
)
```

## Tips and Best Practices
- **Scaling**: The package internally scales features by dividing by the Euclidean length of the feature vector to handle the different ranges of PSSM scores and binary NGS signals.
- **Kernel Selection**: Use `linear` for simpler datasets or when feature weights are needed for interpretation. Use `radial` for complex, non-linear relationships.
- **Feature Weights**: You can extract feature weights from the model to see which TFs are most predictive of your CRMs.
- **Negative Set**: If a negative BED file is not provided, the package can generate one by shuffling positive coordinates.

## Reference documentation
- [LedPred](./references/LedPred.md)