---
name: bioconductor-switchbox
description: This tool trains and validates K-Top-Scoring-Pair (KTSP) classifiers to build rank-based binary models from high-throughput data. Use when user asks to build rank-based classifiers, identify top-scoring gene pairs, or predict biological groups using normalization-robust decision rules.
homepage: https://bioconductor.org/packages/release/bioc/html/switchBox.html
---

# bioconductor-switchbox

name: bioconductor-switchbox
description: Training and validating K-Top-Scoring-Pair (KTSP) classifiers using the switchBox R package. Use this skill when you need to build rank-based binary classifiers from high-throughput data (like gene expression) that are robust to normalization and based on simple decision rules (feature A > feature B).

# bioconductor-switchbox

## Overview

The `switchBox` package implements the K-Top-Scoring-Pair (KTSP) algorithm, a rank-based classification method. It identifies pairs of features (e.g., genes) where the relative ordering (which one is higher) consistently differs between two biological groups. This approach is highly robust to data normalization because it relies on the rank of features rather than absolute expression values.

## Core Workflow

### 1. Data Preparation
The package expects a numeric matrix `inputMat` (features in rows, samples in columns) and a factor `phenoGroup` representing the two classes.

```R
library(switchBox)
data(trainingData) # Loads matTraining and trainingGroup
# trainingGroup should be a factor with two levels
```

### 2. Training a KTSP Classifier
Use `SWAP.Train.KTSP` to identify the optimal pairs.

```R
# Basic training with default Wilcoxon filtering
classifier <- SWAP.Train.KTSP(matTraining, trainingGroup, krange=c(3:15))

# Training with no filtering (uses all features - computationally intensive)
classifier <- SWAP.Train.KTSP(matTraining, trainingGroup, FilterFunc=NULL)

# Training with restricted pairs (e.g., based on prior biological knowledge)
# somePairs is a 2-column matrix of feature names
classifier <- SWAP.Train.KTSP(matTraining, trainingGroup, RestrictedPairs=somePairs)
```

### 3. Custom Filtering
You can define custom functions to pre-filter features before pair selection. The function must accept `phenoGroup` and `inputMat`.

```R
# Example: T-test based filtering
topRttest <- function(situation, data, quant = 0.75) {
  out <- apply(data, 1, function(x) t.test(x ~ situation)$statistic)
  names(out[ abs(out) > quantile(abs(out), quant) ])
}

classifier <- SWAP.Train.KTSP(matTraining, trainingGroup, FilterFunc=topRttest, quant=0.9)
```

### 4. Classification and Prediction
Use `SWAP.KTSP.Classify` to predict classes for new samples.

```R
# Predict on test data using majority voting (default)
predictions <- SWAP.KTSP.Classify(matTesting, classifier)

# Predict using a custom decision rule (e.g., requiring a higher threshold of votes)
predictions <- SWAP.KTSP.Classify(matTesting, classifier, 
                                  DecisionFunc = function(x) sum(x) > 5.5)
```

### 5. Statistics and Scores
To inspect the performance of individual pairs or calculate scores:

```R
# Get individual TSP votes and aggregate statistics
stats <- SWAP.KTSP.Statistics(matTraining, classifier)
# stats$comparisons shows the TRUE/FALSE for each pair
# stats$statistics shows the final score per sample

# Calculate signed scores for all possible pairs
scores <- SWAP.CalculateSignedScore(matTraining, trainingGroup, FilterFunc=NULL)
```

## Key Functions

- `SWAP.Train.KTSP`: Main training function. Parameters include `krange` (number of pairs to try), `FilterFunc` (feature selection), and `disjoint` (if TRUE, each feature appears in only one pair).
- `SWAP.KTSP.Classify`: Applies a trained model to new data.
- `SWAP.Filter.Wilcoxon`: The default filtering method.
- `SWAP.CalculateSignedScore`: Computes the $s_{ij}$ score for pairs, defined as $P(X_i < X_j | C_1) - P(X_i < X_j | C_2)$.

## Tips for Success

- **Factor Levels**: Ensure your phenotype variable is a factor. The first level is typically treated as the "baseline" or class 0.
- **Tie Handling**: If your data has many ties (identical values), set `handleTies = TRUE` in the training function.
- **Disjoint Pairs**: By default, `disjoint = TRUE` is used to ensure the classifier is robust and not dominated by a single highly variable feature.
- **Deprecated Functions**: Avoid `KTSP.Train` and `KTSP.Classify`; use the `SWAP.*` prefixed versions instead.

## Reference documentation
- [switchBox](./references/switchBox.md)