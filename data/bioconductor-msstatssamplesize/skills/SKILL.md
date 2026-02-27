---
name: bioconductor-msstatssamplesize
description: MSstatsSampleSize performs power analysis and sample size estimation for high-dimensional mass spectrometry-based proteomics experiments. Use when user asks to estimate protein-specific variance from preliminary data, simulate proteomics datasets, or determine the required number of biological replicates for classification accuracy and hypothesis testing.
homepage: https://bioconductor.org/packages/3.10/bioc/html/MSstatsSampleSize.html
---


# bioconductor-msstatssamplesize

name: bioconductor-msstatssamplesize
description: Expert guidance for using the MSstatsSampleSize R package to design optimal high-dimensional mass spectrometry-based proteomics experiments. Use this skill when you need to estimate variance from preliminary data, simulate proteomics datasets with varying sample sizes, and determine the required number of biological replicates for either classification (predictive accuracy) or hypothesis testing (power analysis).

# bioconductor-msstatssamplesize

## Overview

MSstatsSampleSize is an R package designed for power analysis and sample size estimation in proteomics experiments. It supports two primary experimental goals:
1. **Classification**: Determining the sample size needed to achieve a specific predictive accuracy using machine learning classifiers (e.g., Random Forest, SVM).
2. **Hypothesis Testing**: Determining the sample size needed to detect a specific fold change with defined power and False Discovery Rate (FDR).

The workflow typically starts with a preliminary dataset used to estimate protein-specific variance, followed by data simulation and performance evaluation.

## Core Workflow

### 1. Data Preparation and Variance Estimation
The package requires a protein abundance matrix (proteins in rows, samples in columns) and an annotation data frame.

```r
library(MSstatsSampleSize)

# Data: rows=proteins, cols=samples
# Annotation: columns 'BioReplicate' and 'Condition'
variance_estimation <- estimateVar(data = protein_matrix, 
                                   annotation = annotation_df)

# Visualize mean-variance relationship
meanSDplot(variance_estimation)
```

### 2. Simulating Datasets
Simulate new datasets based on the variance parameters estimated from the preliminary data.

```r
simulated_datasets <- simulateDataset(
    data = protein_matrix,
    annotation = annotation_df,
    num_simulations = 10,
    expected_FC = "data", # or a named vector of fold changes
    samples_per_group = 50,
    protein_proportion = 1.0 # use all proteins
)

# Validate simulation quality via PCA
designSampleSizePCAplot(simulated_datasets)
```

### 3. Sample Size for Classification
Evaluate how predictive accuracy changes with sample size.

```r
# 1. Run classification on a specific simulation set
classification_results <- designSampleSizeClassification(
    simulations = simulated_datasets,
    classifier = "rf", # options: rf, nnet, svmLinear, logreg, naive_bayes
    parallel = TRUE
)

# 2. Compare multiple sample sizes
list_samples <- c(10, 25, 50, 100)
results_list <- list()

for(i in seq_along(list_samples)) {
    sims <- simulateDataset(..., samples_per_group = list_samples[i])
    results_list[[i]] <- designSampleSizeClassification(sims)
}

# 3. Plot results
designSampleSizeClassificationPlots(data = results_list, 
                                    list_samples_per_group = list_samples)
```

### 4. Sample Size for Hypothesis Testing
Calculate the number of replicates required to detect specific fold changes.

```r
hp_results <- designSampleSizeHypothesisTestingPlot(
    data = protein_matrix,
    annotation = annotation_df,
    desired_FC = "data", # or c(1.25, 1.75)
    FDR = 0.05,
    power = 0.9
)
```

## Key Functions and Parameters

- `estimateVar`: Fits a linear model to estimate mean abundance (`mu`) and standard deviation (`sigma`) per protein.
- `simulateDataset`: 
    - `expected_FC`: Use `"data"` to use observed differences or provide a named vector (e.g., `c(control=1, disease=1.5)`).
    - `list_diff_proteins`: Required if providing a numeric `expected_FC` to specify which proteins are changing.
- `designSampleSizeClassification`: Reports `mean_predictive_accuracy` and `mean_feature_importance`.
- `designSampleSizeHypothesisTestingPlot`: Returns a data frame with `numSample` requirements for various `desiredFC` levels.

## Reference documentation
- [MSstatsSampleSize : A package for optimal design of high-dimensional MS-based proteomics experiment](./references/MSstatsSampleSize.md)