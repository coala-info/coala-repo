---
name: bioconductor-prince
description: bioconductor-prince is a computational pipeline for reconstructing protein-protein interaction networks from co-elution proteomics data using machine learning. Use when user asks to predict protein-protein interactions, reconstruct interactomes from co-elution profiles, or identify significantly co-eluting protein complexes.
homepage: https://bioconductor.org/packages/release/bioc/html/PrInCE.html
---

# bioconductor-prince

## Overview

PrInCE (Predicting Interactomes from Co-Elution) is a computational pipeline for reconstructing protein-protein interaction (PPI) networks from co-elution proteomics data. It uses a machine-learning approach to distinguish interacting from non-interacting protein pairs based on features derived directly from elution profiles, such as Pearson correlation, Euclidean distance, and Gaussian mixture model parameters. This approach minimizes bias toward known interactions and allows for the discovery of novel complexes.

## Core Workflow

The standard PrInCE workflow involves three main stages: data preprocessing (Gaussian fitting), feature calculation, and interaction prediction.

### 1. One-Step Analysis
For most users, the `PrInCE` function provides a complete end-to-end workflow.

```r
library(PrInCE)
data(scott) # Example co-elution matrix
data(gold_standard) # List of known complexes

# Predict interactions (returns a ranked list with precision scores)
set.seed(0)
interactions <- PrInCE(scott, gold_standard, cv_folds = 10)

# Filter for high-confidence interactions (e.g., 50% precision)
network <- threshold_precision(interactions, threshold = 0.5)
```

### 2. Step-by-Step Analysis
For large datasets or custom parameter tuning, run the pipeline manually.

#### A. Gaussian Mixture Modeling
Fit Gaussians to elution profiles to filter noise and enable "co-apex" feature calculation.
```r
# Build Gaussians (computationally intensive)
gaussians <- build_gaussians(scott, min_R_squared = 0.5, max_gaussians = 5)

# Filter the original matrix to keep only proteins with successful fits
filtered_scott <- scott[names(gaussians), ]
```

#### B. Feature Calculation
Calculate similarity metrics for every possible protein pair.
```r
# Generates features like Pearson R, Euclidean distance, and Co-peak scores
features <- calculate_features(filtered_scott, gaussians)

# If using multiple replicates, concatenate them:
# feat_list <- list(feat_rep1, feat_rep2)
# combined_features <- concatenate_features(feat_list)
```

#### C. Interaction Prediction
Train a classifier (Naive Bayes by default) using a gold standard.
```r
# Convert list of complexes to an adjacency matrix for the classifier
reference <- adjacency_matrix_from_list(gold_standard)

# Predict using a specific classifier (NB, SVM, RF, LR, or ensemble)
ppi_results <- predict_interactions(features, reference, classifier = "NB")
```

### 3. Identifying Known Complexes
To test if specific *known* complexes are significantly co-eluting (rather than predicting new ones):
```r
# Preprocess profiles
filtered <- filter_profiles(scott)
chromatograms <- clean_profiles(filtered)

# Calculate Z-scores for complexes based on internal correlation vs random null
z_scores <- detect_complexes(chromatograms, gold_standard)
significant_complexes <- z_scores[z_scores > 1.96] # p < 0.05
```

## Key Functions and Parameters

- `PrInCE()`: The wrapper function. Key arguments include `models` (number of ensemble classifiers), `cv_folds` (cross-validation folds), and `classifier`.
- `build_gaussians()`: Parameters like `min_consecutive` (default 5) and `min_R_squared` (default 0.5) control data stringency.
- `threshold_precision()`: Used to subset the results. Precision is the ratio of True Positives / (TP + FP) based on the gold standard.
- `adjacency_matrix_from_list()`: Essential for converting `list` format gold standards (like CORUM or Complex Portal) into the format required by the predictor.

## Tips for Success

- **Gold Standards**: Use high-quality complex databases like CORUM or the Complex Portal. PrInCE assumes intra-complex pairs are True Positives and inter-complex pairs are True Negatives.
- **Computational Time**: Gaussian fitting is slow. Use `build_gaussians` once and save the object, then pass it to `PrInCE(..., gaussians = my_gaussians)` to iterate on classifier settings quickly.
- **Missing Values**: PrInCE handles `NA`/`NaN` values by imputing single missing values and adding near-zero noise to others during the "cleaning" phase.
- **Replicates**: When using multiple replicates, ensure protein identifiers are consistent across all matrices before calling `concatenate_features`.

## Reference documentation
- [Interactome reconstruction from co-elution data with PrInCE](./references/intro-to-prince.md)
- [PrInCE Vignette Source](./references/intro-to-prince.Rmd)